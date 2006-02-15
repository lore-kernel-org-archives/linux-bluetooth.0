Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <bd72c4b0602141948w3bacbf30q49f933551f56b40a@mail.gmail.com>
From: Gareth Bradley <gareth.bradley.nz@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20331_7650452.1139975301112"
Subject: [Bluez-users] SCO syncronization taking down USB dongle
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 14 Feb 2006 15:48:21 -1200

------=_Part_20331_7650452.1139975301112
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello. I am currently writing code for voice connections using a Motorla
HS850 headset and the BlueZ stack on a Intrinsyc Cerf 255PXA board (a small
form mobile PC). I can currently make successful SCO connections to the
headset, but they sometimes crash, and take the whole USB dongle with it.
(Running 'hciconfig hci0 up' fixes it).

Here is the crash printout:
usb.c: USB disconnect on device 2
Receive failed: Broken pipe
hub.c: USB new device connect on bus1/2, assigned device number 3

I have a stream of incoming voice (from a Windows PDA) which is buffered. I
read from the SCO connection stream (and consistently get 48 byte packets),
and write in an amount from the receive buffer into the headset. This coice
connection works fine.

I've tried using FD_ZERO, FD_SET and FD_ISSET before all read and writes,
but still to no avail. I am able to get it to crash within a minute if I
deliberately write data chunks slightly out with the amount read from the
device (read 48, then write 47, or 46, or 49...).

I notice that flow (and error) control appear on the Todo list, but is ther=
e
some way to guard against the whole dongle being taken down?

------=_Part_20331_7650452.1139975301112
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello. I am currently writing code for voice connections using a
Motorla HS850 headset and the BlueZ stack on a Intrinsyc Cerf 255PXA
board (a small form mobile PC). I can currently make successful SCO
connections to the headset, but they sometimes crash, and take the
whole USB dongle with it. (Running 'hciconfig hci0 up' fixes it).<br>
<br>
Here is the crash printout:<br>
usb.c: USB disconnect on device 2<br>
Receive failed: Broken pipe<br>
hub.c: USB new device connect on bus1/2, assigned device number 3<br>
<br>
I have a stream of incoming voice (from a Windows PDA) which is
buffered. I read from the SCO connection stream (and consistently get
48 byte packets), and write in an amount from the receive buffer into
the headset. This coice connection works fine.<br>
<br>
I've tried using FD_ZERO, FD_SET and FD_ISSET before all read and
writes, but still to no avail. I am able to get it to crash within a
minute if I deliberately write data chunks slightly out with the amount rea=
d from
the device (read 48, then write 47, or 46, or 49...).<br>
<br>
I notice that flow (and error) control appear on the Todo list, but is
there some way to guard against the whole dongle being taken down?<br>
<br>

------=_Part_20331_7650452.1139975301112--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
