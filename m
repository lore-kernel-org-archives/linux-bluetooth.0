Return-Path: <cyrus@holtmann.org>
Message-ID: <258e79980804201354l7d3aac0bx795f1f5e3533449d@mail.gmail.com>
Date: Sun, 20 Apr 2008 22:54:07 +0200
From: "simone malacarne" <s.malacarne@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <258e79980804201348m13d574a7t924676eded86b291@mail.gmail.com>
MIME-Version: 1.0
References: <mailman.350.1208724257.4128.gnome-bluetooth@lists.usefulinc.com>
	<258e79980804201348m13d574a7t924676eded86b291@mail.gmail.com>
Subject: [Bluez-users] Bluetooth Mouse and kbd looses connection after some
	time of inactivity
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have a logitech dinovo bluetooth mouse and keyboard on a Ubuntu 64bit box.

  I can pair both easily using the tray applet, and they both work
  flawlessly initially.
  However, after some time of inactivity (Not using one mouse for some
  time, Going away from the System, etc) the connection is lost and
  won't be re-established, even after moving the mouse constantly.
  In bluetooth manager i can see the both devices are still listed like
 connected.

  To make them work again i have to manual disconnect them. After that i
  can move the mouse and click the kbd and they reconnect immediatly.

  Kernel version is 2.6.24.16 (also have this problem in 2.6.22).

  dmesg on start

  [   66.156089] Bluetooth: L2CAP ver 2.9
  [   66.156096] Bluetooth: L2CAP socket layer initialized
  [   66.299190] Bluetooth: RFCOMM socket layer initialized
  [   66.299208] Bluetooth: RFCOMM TTY layer initialized
  [   66.299211] Bluetooth: RFCOMM ver 1.8
  [   66.885416] Clocksource tsc unstable (delta = -93161992 ns)
  [   67.022432] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
  [   67.027342] input: Logitech MX900 Mouse as
  /devices/pci0000:00/0000:00:02.0/usb1/1-10/1-10.2/1-10.2:1.0/hci0/acl000761141705/input/input6
  [  270.807586] input: Logitech diNovo Keyboard as
  /devices/pci0000:00/0000:00:02.0/usb1/1-10/1-10.2/1-10.2:1.0/hci0/acl000761152050/input/input7

  and on reconnect

  [ 3705.268599] input: Logitech MX900 Mouse as
  /devices/pci0000:00/0000:00:02.0/usb1/1-10/1-10.2/1-10.2:1.0/hci0/acl000761141705/input/input9
  [ 3713.785242] input: Logitech diNovo Keyboard as
  /devices/pci0000:00/0000:00:02.0/usb1/1-10/1-10.2/1-10.2:1.0/hci0/acl000761152050/input/input10

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
