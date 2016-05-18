console.log("testing");


//RUN visual changes LATER. EVENT DRIVEN PROGRAMMING. WAITS FOR EVENT, THEN CHANGES IT.
function addPinkBorder(event) {
	console.log(event);
	event.target.style.border = "2px solid pink";
}

var els = document.getElementsByTagName('h1');
var el = els[0]
el.addEventListener("click", addPinkBorder);


