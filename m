Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4003BEF4.4030501@nue.et-inf.uni-siegen.de>
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: subscritions@nx14.com
Cc: bluez-users@lists.sourceforge.net
References: <E1AgFm8-0001K3-6Y@sc8-sf-list2.sourceforge.net>
In-Reply-To: <E1AgFm8-0001K3-6Y@sc8-sf-list2.sourceforge.net>
Content-Type: multipart/mixed;
 boundary="------------000901020509080501030205"
Subject: [Bluez-users] Re: PIN problems
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
Date: Tue, 13 Jan 2004 10:48:36 +0100

This is a multi-part message in MIME format.
--------------000901020509080501030205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stuart,

> Hi, I'm trying to setup the PIN for my Bluetooth Phone but when i run
> the command in the How-to i get this error. What dont i have
> installed right?
> 
> [root@longhorn root]# bluepin /etc/bluetooth/pin Nokia7650 Traceback
> (most recent call last): File "/bin/bluepin", line 39, in ? class
> Dialog(GtkDialog): NameError: name 'GtkDialog' is not defined

Make sure you have GTK installed. In case you have SuSE, the following 
packages need to be present on the SuSE 9.0 box (which are
normally not installed):

- python-gtk (bindings)
- python-numeric

Similar package requirements may apply with other distributions.

If your're still seeing problems then (and/or you have SuSE or Gentoo), 
try the attached 'bluepin' script (replace the 'bluepin' script in /bin/).


Hope this helps,

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

--------------000901020509080501030205
Content-Type: text/plain;
 name="bluepin"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluepin"

#!/usr/bin/python
#
# Bluetooth PIN helper
# Written by Maxim Krasnyansky <maxk@qualcomm.com>
# Minor changes (for SuSE 9.0) by Michael Schmidt 
# <schmidt@nue.et-inf.uni-siegen.de>
#
import sys, os, string, popen2

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
		self.set_position(1)
		
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

--------------000901020509080501030205--




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
