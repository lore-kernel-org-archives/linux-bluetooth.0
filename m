Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FE5D72B.2000108@nue.et-inf.uni-siegen.de>
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------000705020804060002060907"
Subject: [Bluez-users] bluepin with SuSE 9.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 21 Dec 2003 18:23:55 +0100

This is a multi-part message in MIME format.
--------------000705020804060002060907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I think I have a working 'bluepin' script (the one which is responsible 
for the PIN entry GUI during pairing) for SuSE 9.0, which hopefully 
addresses all the problems several folks have suffered from in the last 
weeks. The Script is attached to this note.

I have made the following changes to the script from 
http://bluez.sourceforge.net/download/bluepin:

- moved the "import gtk" statement behind the "set_display ()" call
   (as this is the case in the current script in cvs).
- replaced the "if arg[i][0] != '-' and i==1:" line with
   "if i==1 and arg[i][0] == ':':"
   (as proposed by Jean-Marc Autexier
    http://www.autexier.de/jmau/linux/Bluetooth.html
    and others)

Furthermore, the following packages need to be present on the SuSE 9.0 
box (which are normally not installed):

- python-gtk (bindings)
- python-numeric

These changes may apply accordingly to earlier versions of SuSE Linux, 
too (I have observed similar problems with 'bluepin' in SuSE 8.x, too).


Maybe someone out of the BlueZ community may put this script on his web 
site for the public (my institute home page won't live very much longer).


Cheers,

Michael


-- 
=================================================
Michael Schmidt
-------------------------------------------------
Institute for Data Communications Systems
University of Siegen, Germany
-------------------------------------------------
http:   www.nue.et-inf.uni-siegen.de/~schmidt/
e-mail: schmidt@nue.et-inf.uni-siegen.de
mobile: +49 179 7810214
=================================================


--------------000705020804060002060907
Content-Type: text/plain;
 name="bluepin"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluepin"

#!/usr/bin/python
#
# Bluetooth PIN helper
# Written by Maxim Krasnyansky <maxk@qualcomm.com>
#
import sys, os, string, popen2
#import gtk

# X Display initialization.
# Find running X Server and parse it's arguments.
# Set enviroment variables DISPLAY and XAUTHORITY
# using info extracted from X Server args.
#
def set_display():
	disp = ":0"
	auth = ""
	proc = "-C X -C XFree86"
	ps   = "/bin/ps " + proc + " --format args --no-headers"

	r,w = popen2.popen2(ps)
	arg = string.split(r.read())
	for i in range(1, len(arg)):
#		if arg[i][0] != '-' and i==1:
		if i==1 and arg[i][0] == ':':
			disp = arg[i]
		elif arg[i] == "-auth":
			auth = arg[i+1]
			break

	os.environ['DISPLAY']    = disp 
	os.environ['XAUTHORITY'] = auth

# Set X display before initializing GTK
set_display()

import gtk

# Dialog Class
DLG_OK = 1
DLG_CANCEL = 2
class Dialog(gtk.Dialog):
	result = DLG_CANCEL 
	args = {}
	def __init__(self, modal=False, mesg=None, args = {}):
		gtk.Dialog.__init__(self)
		self.args = args
		self.set_modal(modal)
		self.set_size_request(400, -1)
		#self.set_usize(400, 0)
		#self.set_position(300,300)
		
		self.connect("destroy", self.quit)
		self.connect("delete_event", self.quit)

		self.action_area.set_border_width(2)

		ok = gtk.Button("Accept")
		ok.connect("clicked", self.ok)
		self.action_area.pack_start(ok, padding = 20)
		ok.show()

		cl = gtk.Button("Reject")
		cl.connect("clicked", self.cancel)
		self.action_area.pack_start(cl, padding = 20)
		cl.show()

		if mesg:
			msg = gtk.Label(mesg)
			msg.set_text(mesg)
			self.vbox.pack_start(msg, padding = 10)
			msg.show()

		self.ents = []
		for k in self.args.keys():
			hbox = gtk.HBox()
			hbox.set_border_width(5)
			self.vbox.pack_start(hbox)
			hbox.show()

			l = gtk.Label(k)
			e = gtk.Entry()
			l.set_text( k )
			e.set_text( self.args[k] )
			e.connect("key_press_event", self.key_press)
			hbox.pack_start(l, padding = 10, expand = False)
			hbox.pack_start(e)
			l.show()
			e.show()

			self.ents.append( (k, e) )

		self.ents[0][1].grab_focus()

	def key_press(self, entry, event):
		if event.keyval == gtk.keysyms.Return:
			entry.emit_stop_by_name("key_press_event")
			self.ok()
		elif event.keyval == gtk.keysyms.Escape:
			entry.emit_stop_by_name("key_press_event")
			self.cancel()

	def ok(self, *args):
		self.result = DLG_OK 
		for e in self.ents:
			k = e[0]
			self.args[k] = e[1].get_text() 
		self.quit()

	def cancel(self, *args):
		self.result = DLG_CANCEL 
		self.quit()

	def quit(self, *args):
		self.hide()
		self.destroy()
		gtk.mainquit()

def dialog(title, mesg, args, modal = False):
	dlg = Dialog(args = args, mesg = mesg, modal = modal)
	dlg.set_title(title)
	dlg.show()
	gtk.mainloop()
	return dlg.result

def main(*args):
	if len(sys.argv) < 2:
		print "ERR"
		sys.exit()
	
	dir    = sys.argv[1]
	bdaddr = sys.argv[2]

	if len(sys.argv) > 3:
		name = sys.argv[3]
	else:
		name = ""

	title = "Bluetooth PIN Code"

	# Bluetooth spec recommends automatic strong random PIN generation.
	# So eventually we should implement that. 
	pin = { "PIN": "" }

	if dir == "out":
		mesg = "Outgoing connection to "
	else:
		mesg = "Incoming connection from "
	
	mesg = mesg + name + "[" + bdaddr + "]"

	if dialog(title, mesg, pin) == DLG_OK:
		pin["PIN"] = string.strip(pin["PIN"])

		if len(pin["PIN"]) >= 4 and len(pin["PIN"]) <=16:
			print "PIN:" + pin["PIN"]
		else:
			print "ERR"
	else:
		print "ERR"

#
main()

--------------000705020804060002060907--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
