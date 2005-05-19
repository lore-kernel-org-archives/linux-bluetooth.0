Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Subject: RE: [Bluez-devel] Rebuild the Kernel?
Message-ID: <C02F8682928AE540A048CD0B1E073C5C01046EBD@ES21SNLNT.srn.sandia.gov>
From: "Mclean, Stephen" <smclean@sandia.gov>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/alternative;
 boundary="----_=_NextPart_001_01C55C9C.B67C7A19"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 19 May 2005 12:00:58 -0600

This is a multi-part message in MIME format.

------_=_NextPart_001_01C55C9C.B67C7A19
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hello,=20
=20
Did this message post to the mailing list?
=20
Additional information I found is when I didn't modify the hcid.conf
confile and just ran /etc/init.d/bluetooth start I got the same message
that I wrote earlier.
=20
What are my options here?
=20
Rebuild the kernel with the appropriate patch?  If so, what patch?
=20
Get the latest packages of BlueZ and install it on my PDA using GPE 2.6?

=20
Any recommendations?
=20
Thanks
=20
Stephen
=20
=20

________________________________

From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Mclean,
Stephen
Sent: Wednesday, May 18, 2005 2:39 PM
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Rebuild the Kernel?



Hello,=20

I'm using GPE 2.6 for my PDA which is an iPAQ 5400.  I have no idea what
version of bluetooth comes with GPE 2.6.  Bluetooth starts up properly.
I wanted to get familiar with the configuration settings (hcid.conf) of
bluetooth and I edited some configuration settings(I backed up the
original file to be safe).  I saved the new configuration file and
rebooted the PDA.  I no longer see the bluetooth icon in GPE anymore.
So I try to start it manually using "/etc/init.d/bluetooth start".  I
receive a message saying this:

        Starting Bluetooth subsystem: hcid sdpdCan't open HIDP control
socket: Invalid argument hidd rfcomm.=20

I tried replaced the modified hcid.conf file with the file that I
originally backed up.  However, this didn't solve my problem.  I still
couldn't start the bluetooth service.  I searched the archives for a
solution and I found this email.

http://sourceforge.net/mailarchive/message.php?msg_id=3D9550822
<http://sourceforge.net/mailarchive/message.php?msg_id=3D9550822> =20

Does this mean that I need to re-compile the kernel?  Do I just
re-compile the kernel with the latest patch and then it should work?

Thanks=20

Stephen=20


------_=_NextPart_001_01C55C9C.B67C7A19
Content-Type: text/html;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Rebuild the Kernel?</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2627" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Hello, </FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Did this message post to the mailing=20
list?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Additional information I found is when I didn't =
modify the=20
hcid.conf confile and just ran /etc/init.d/bluetooth start I got the =
same=20
message that I wrote earlier.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>What are my options here?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Rebuild the kernel with the appropriate =
patch?&nbsp; If so,=20
what patch?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Get the latest packages of BlueZ and install it =
on my PDA=20
using GPE 2.6?&nbsp;</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Any recommendations?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Thanks</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Stephen</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D849185717-19052005><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> =
bluez-devel-admin@lists.sourceforge.net=20
[mailto:bluez-devel-admin@lists.sourceforge.net] <B>On Behalf Of =
</B>Mclean,=20
Stephen<BR><B>Sent:</B> Wednesday, May 18, 2005 2:39 PM<BR><B>To:</B>=20
bluez-devel@lists.sourceforge.net<BR><B>Subject:</B> [Bluez-devel] =
Rebuild the=20
Kernel?<BR></FONT><BR></DIV>
<DIV></DIV><!-- Converted from text/rtf format -->
<P><FONT face=3D"Courier New" size=3D2>Hello, </FONT></P>
<P><FONT face=3D"Courier New" size=3D2>I'm using GPE 2.6 for my PDA =
which is an iPAQ=20
5400.&nbsp; I have no idea what version of bluetooth comes with GPE =
2.6.&nbsp;=20
Bluetooth starts up properly.&nbsp; I wanted to get familiar with the=20
configuration settings (hcid.conf) of bluetooth and I edited some =
configuration=20
settings(I backed up the original file to be safe).&nbsp; I saved the =
new=20
configuration file and rebooted the PDA.&nbsp; I no longer see the =
bluetooth=20
icon in GPE anymore.&nbsp; So I try to start it manually using=20
"/etc/init.d/bluetooth start".&nbsp; I receive a message saying =
this:</FONT></P>
<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT face=3D"Courier New" =

size=3D2>Starting Bluetooth subsystem: hcid sdpdCan't open HIDP control =
socket:=20
Invalid argument hidd rfcomm. </FONT></P>
<P><FONT face=3D"Courier New" size=3D2>I tried replaced the modified =
hcid.conf file=20
with the file that I originally backed up.&nbsp; However, this didn't =
solve my=20
problem.&nbsp; I still couldn't start the bluetooth service.&nbsp; I =
searched=20
the archives for a solution and I found this email.</FONT></P>
<P><A=20
href=3D"http://sourceforge.net/mailarchive/message.php?msg_id=3D9550822">=
<U><FONT=20
face=3D"Courier New" color=3D#0000ff=20
size=3D2>http://sourceforge.net/mailarchive/message.php?msg_id=3D9550822<=
/FONT></U></A>=20
</P>
<P><FONT face=3D"Courier New" size=3D2>Does this mean that I need to =
re-compile the=20
kernel?&nbsp; Do I just re-compile the kernel with the latest patch and =
then it=20
should work?</FONT></P>
<P><FONT face=3D"Courier New" size=3D2>Thanks</FONT> </P>
<P><FONT face=3D"Courier New" size=3D2>Stephen</FONT> </P></BODY></HTML>

------_=_NextPart_001_01C55C9C.B67C7A19--



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
