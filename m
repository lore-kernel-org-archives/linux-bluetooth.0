Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <C02F8682928AE540A048CD0B1E073C5C01046D04@ES21SNLNT.srn.sandia.gov>
From: "Mclean, Stephen" <smclean@sandia.gov>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/alternative;
 boundary="----_=_NextPart_001_01C55BF2.10D4264B"
Subject: [Bluez-devel] Rebuild the Kernel?
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
Date: Wed, 18 May 2005 15:39:26 -0600

This is a multi-part message in MIME format.

------_=_NextPart_001_01C55BF2.10D4264B
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

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

Does this mean that I need to re-compile the kernel?  Do I just
re-compile the kernel with the latest patch and then it should work?

Thanks

Stephen

------_=_NextPart_001_01C55BF2.10D4264B
Content-Type: text/html;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7232.36">
<TITLE>Rebuild the Kernel?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">Hello, </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I'm using GPE 2.6 for my PDA =
which is an iPAQ 5400.&nbsp; I have no idea what version of bluetooth =
comes with GPE 2.6.&nbsp; Bluetooth starts up properly.&nbsp; I wanted =
to get familiar with the configuration settings (hcid.conf) of bluetooth =
and I edited some configuration settings(I backed up the original file =
to be safe).&nbsp; I saved the new configuration file and rebooted the =
PDA.&nbsp; I no longer see the bluetooth icon in GPE anymore.&nbsp; So I =
try to start it manually using &quot;/etc/init.d/bluetooth =
start&quot;.&nbsp; I receive a message saying this:</FONT></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">Starting Bluetooth subsystem: hcid sdpdCan't open =
HIDP control socket: Invalid argument hidd rfcomm. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I tried replaced the modified =
hcid.conf file with the file that I originally backed up.&nbsp; However, =
this didn't solve my problem.&nbsp; I still couldn't start the bluetooth =
service.&nbsp; I searched the archives for a solution and I found this =
email.</FONT></P>

<P><A =
HREF=3D"http://sourceforge.net/mailarchive/message.php?msg_id=3D9550822">=
<U><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">http://sourceforge.net/mailarchive/message.php?msg_id=3D9550822</FON=
T></U></A>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Does this mean that I need to =
re-compile the kernel?&nbsp; Do I just re-compile the kernel with the =
latest patch and then it should work?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Thanks</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Stephen</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C55BF2.10D4264B--



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
