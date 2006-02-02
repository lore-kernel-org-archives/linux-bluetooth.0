Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6278E.6EC46D29"
Message-ID: <06CCEA2EB1B80A4A937ED59005FA8551880482@svits26.main.ad.rit.edu>
From: "Christopher E Piggott" <cepasp@rit.edu>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Why does rfcomm cause a repairing?
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
Date: Wed, 1 Feb 2006 19:20:12 -0500

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6278E.6EC46D29
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am setting up bluez on an embedded Geode system.  The system is pretty
small; only a 64MB flash disk.
=20
What I want is to have rfcomm listening for incoming connections from my
Dell Axim.  When it gets a connection, a separate program I wrote will
spit out NMEA-0183 messages over that rfcomm.
=20
I do this:
    start hcid
    start sdpd
    sdptool add SP
=20
    Have the handheld scan for bluetooth devices.  it finds it.
    Have it connect.  It works and it sees the serial device
=20
    rfcomm listen 0 1
=20
    go back to the axim and tell it to connect to COM7 which is the
virtual device it mapped to the server I just set up
=20
What happens next is weird (at least to me).  First, my server now
attempts to RE-PAIR to my handheld.  It says that the computer wants to
connect to me, and it prompts me for the PIN again.  Why would it do
this, when we have already paired?
=20
Then, I enter the PIN.  After a little while the rfcomm listener
disconnects, and the pairing fails.  I go back on my axim to the
bluetooth config and it doesn't think it's paired any more.
=20
Meanwhile, there is still a set of files in /var/lib/bluetooth under the
ID of my handheld, including linkkeys and names.
=20
What is going wrong?
=20
--Chris
=20

------_=_NextPart_001_01C6278E.6EC46D29
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D170371300-02022006>I am =
setting up=20
bluez on an embedded Geode system.&nbsp; The system is pretty small; =
only a 64MB=20
flash disk.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D170371300-02022006>What I =
want is to=20
have rfcomm listening for incoming connections from my Dell Axim.&nbsp; =
When it=20
gets a connection, a separate program I wrote will spit out NMEA-0183 =
messages=20
over that rfcomm.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D170371300-02022006>I do=20
this:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D170371300-02022006>&nbsp;&nbsp;&nbsp;=20
start hcid</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D170371300-02022006>&nbsp;&nbsp;&nbsp;=20
start sdpd</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D170371300-02022006>&nbsp;&nbsp;&nbsp;=20
sdptool add SP</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D170371300-02022006>&nbsp;&nbsp;&nbsp;=20
Have the handheld scan for bluetooth devices.&nbsp; it finds=20
it.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D170371300-02022006>&nbsp;&nbsp;&nbsp;=20
Have it connect.&nbsp; It works and it sees the serial=20
device</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D170371300-02022006>&nbsp;&nbsp;&nbsp;=20
rfcomm listen 0 1</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D170371300-02022006>&nbsp;&nbsp;&nbsp;=20
go back to the axim and tell it to connect to COM7 which is the virtual =
device=20
it mapped to the server I just set up</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D170371300-02022006>What =
happens next is=20
weird (at least to me).&nbsp; First, my server now attempts to RE-PAIR =
to my=20
handheld.&nbsp; It says that the computer wants to connect to me, and it =
prompts=20
me for the PIN again.&nbsp; Why would it do this, when we have already=20
paired?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D170371300-02022006>Then, =
I enter the=20
PIN.&nbsp; After a little while the rfcomm listener disconnects, and the =
pairing=20
fails.&nbsp; I go back on my axim to the bluetooth config and it doesn't =
think=20
it's paired any more.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D170371300-02022006>Meanwhile, there is=20
still a set of files in /var/lib/bluetooth under the ID of my handheld,=20
including linkkeys and names.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D170371300-02022006>What =
is going=20
wrong?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006>--Chris</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D170371300-02022006></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6278E.6EC46D29--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
