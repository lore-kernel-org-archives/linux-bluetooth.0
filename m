Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAmncgVuxvCkGbCcdT7ASEUAEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01C49CD0.EAD4ED10"
Subject: [Bluez-users] ACPI Linux for Toshiba Satellite Pro M10
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
Date: Fri, 17 Sep 2004 16:10:48 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01C49CD0.EAD4ED10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear developers,
I tried to activate the bluetooth-module which runs under windows xp =
without
trubbles.
=20
The things I have done
Installing dmabt
drwxrwxr-x  2  973 1101   192 Jun 11  2002 .

drwxr-xr-x  3 root root   192 Sep 17 13:59 ..

-rw-rw-r--  1  973 1101 18007 Jun  7  2002 LICENSE

-rw-rw-r--  1  973 1101   318 Jun  7  2002 Makefile

-rw-rw-r--  1  973 1101   651 Mar 13  2002 README-0.01.1.txt

-rw-rw-r--  1  973 1101  6195 Jun  8  2002 dmabt.c

-rw-rw-r--  1  973 1101  4359 Jun  5  2002 dmabt.c.orig

=20

linux:~/bluetooth/dmabt-0.2 # make

gcc -O2  -s  dmabt.c   -o dmabt

=20

linux:~/bluetooth/dmabt-0.2 # make install

install -Ds dmabt /usr/local/bin/dmabt

install -d /usr/local/doc/dmabt && install -m a=3Dr,u+w LICENSE README*
/usr/local/doc/dmabt

=20

alias char-major-10-181 toshiba written into /etc/modules.conf

=20

mknod -m 666 /dev/toshiba c 10 181=20

=20

modprobe toshiba_acpi
modprobe hci_usb
=20
But then I got this error-message:
linux:~/bluetooth/dmabt-0.2 # dmabt

Can't access Toshiba device /dev/toshiba.

=20

linux:~/bluetooth/dmabt-0.2 # cd /dev

=20

linux:/dev # dir t*

crw-------  1 root root  36,  16 Apr  6 15:27 tap0

crw-------  1 root root  36,  17 Apr  6 15:27 tap1

crw-------  1 root root  36,  18 Apr  6 15:27 tap2

crw-------  1 root root  10, 168 Apr  6 15:27 tcldrv

crw-rw----  1 root root  30,  36 Apr  6 15:27 tcp

crw-------  1 root root  10, 131 Apr  6 15:27 temperature

crw-rw-rw-  1 root root  10, 181 Sep 17 12:30 toshiba

=20

All seems to be available, but the bluetooth doesn't work. The Tosh-Keys =
for
brightness and so one are working.

=20

What is to do???

=20

ciao, ciao

Peter


------=_NextPart_000_0003_01C49CD0.EAD4ED10
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Nachricht</TITLE>

<META content=3D"MSHTML 6.00.2800.1458" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D587270114-17092004>Dear=20
developers,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D587270114-17092004>I =
tried to activate=20
the bluetooth-module which runs under windows xp without=20
trubbles.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D587270114-17092004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D587270114-17092004>The =
things I have=20
done</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D587270114-17092004><STRONG>Installing=20
dmabt</STRONG></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D587270114-17092004>
<DIV><SPAN class=3D623385012-17092004>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>drwxrwxr-x<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>2<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>973 1101<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>192 Jun 11<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>2002 .</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>drwxr-xr-x<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>3 =
root root<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>192 Sep 17 13:59 =
..</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>-rw-rw-r--<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>1<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>973 1101 18007 Jun<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>7<SPAN style=3D"mso-spacerun: =
yes">&nbsp;=20
</SPAN>2002 LICENSE</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>-rw-rw-r--<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>1<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>973 1101<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>318 Jun<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>7<SPAN style=3D"mso-spacerun: =
yes">&nbsp;=20
</SPAN>2002 Makefile</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>-rw-rw-r--<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>1<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>973 1101<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>651 Mar 13<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>2002 =
README-0.01.1.txt</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>-rw-rw-r--<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>1<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>973 1101<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>6195 Jun<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>8<SPAN style=3D"mso-spacerun: =
yes">&nbsp;=20
</SPAN>2002 dmabt.c</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>-rw-rw-r--<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>1<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>973 1101<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>4359 Jun<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>5<SPAN style=3D"mso-spacerun: =
yes">&nbsp;=20
</SPAN>2002 dmabt.c.orig</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><?xml:namespace =
prefix =3D o ns =3D=20
"urn:schemas-microsoft-com:office:office" /><o:p><FONT face=3DArial=20
size=3D2>&nbsp;</FONT></o:p></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>linux:~/bluetooth/dmabt-0.2 # make</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial =
size=3D2>gcc=20
-O2<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>-s<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>dmabt.c<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>-o dmabt</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><o:p><FONT =
face=3DArial=20
size=3D2>&nbsp;</FONT></o:p></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>linux:~/bluetooth/dmabt-0.2 # make install</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial =
size=3D2>install=20
-Ds dmabt /usr/local/bin/dmabt</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial =
size=3D2>install=20
-d /usr/local/doc/dmabt &amp;&amp; install -m a=3Dr,u+w LICENSE README*=20
/usr/local/doc/dmabt</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2></FONT>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D623385012-17092004><FONT face=3DArial size=3D2><STRONG>alias =
char-major-10-181=20
toshiba</STRONG>&nbsp;<SPAN class=3D587270114-17092004>written=20
into</SPAN>&nbsp;/etc/modules.conf</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D623385012-17092004><FONT face=3DArial =
size=3D2></FONT></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D623385012-17092004><FONT face=3DArial size=3D2><SPAN=20
class=3D623385012-17092004><FONT face=3DArial size=3D2><STRONG>mknod -m =
666=20
/dev/toshiba c 10 181 </STRONG></FONT></SPAN></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D623385012-17092004><FONT face=3DArial size=3D2><SPAN=20
class=3D623385012-17092004><STRONG></STRONG></SPAN></FONT></SPAN>&nbsp;</=
P><SPAN=20
class=3D623385012-17092004><FONT><SPAN class=3D623385012-17092004>
<DIV><SPAN class=3D623385012-17092004><FONT face=3DArial =
size=3D2><STRONG>modprobe=20
toshiba_acpi</STRONG></FONT></SPAN></DIV>
<DIV><SPAN class=3D623385012-17092004><FONT face=3DArial =
size=3D2><STRONG>modprobe=20
hci_usb</STRONG></FONT></SPAN></DIV>
<DIV><SPAN class=3D623385012-17092004><STRONG><FONT face=3DArial=20
size=3D2></FONT></STRONG></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D623385012-17092004><SPAN =
class=3D587270114-17092004><FONT=20
face=3DArial size=3D2>But then I got this =
error-message:</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D623385012-17092004><SPAN class=3D587270114-17092004>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2>linux:~/bluetooth/dmabt-0.2 # dmabt</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial =
size=3D2>Can't=20
access Toshiba device /dev/toshiba.</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2></FONT>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>linux:~/bluetooth/dmabt-0.2 # cd /dev</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><o:p><FONT =
face=3D"Times New Roman"=20
size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>linux:/dev # dir t*</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>crw-------<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>1 =
root root<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>36,<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>16 Apr<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>6 15:27 tap0</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>crw-------<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>1 =
root root<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>36,<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>17 Apr<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>6 15:27 tap1</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>crw-------<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>1 =
root root<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>36,<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>18 Apr<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>6 15:27 tap2</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>crw-------<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>1 =
root root<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>10, 168 Apr<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>6 15:27 tcldrv</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>crw-rw----<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>1 =
root root<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>30,<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>36 Apr<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>6 15:27 tcp</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>crw-------<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>1 =
root root<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>10, 131 Apr<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>6 15:27 temperature</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>crw-rw-rw-<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>1 =
root root<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>10, 181 Sep 17 12:30 =
toshiba</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt">&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D587270114-17092004><FONT face=3DArial size=3D2>All seems to be =
available, but=20
the bluetooth doesn't work. The Tosh-Keys for brightness and so one are=20
working.</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D587270114-17092004><FONT face=3DArial =
size=3D2></FONT></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D587270114-17092004><FONT face=3DArial size=3D2>What is to=20
do???</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D587270114-17092004><FONT face=3DArial =
size=3D2></FONT></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D587270114-17092004>ciao, ciao</SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D587270114-17092004>Peter</SPAN></P></SPAN></SPAN></DIV></SPAN></F=
ONT></SPAN></SPAN></DIV></SPAN></FONT></DIV></BODY></HTML>

------=_NextPart_000_0003_01C49CD0.EAD4ED10--




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
