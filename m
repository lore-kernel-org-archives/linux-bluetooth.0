Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY114-W400A60A0890B62845C2FA3D7960@phx.gbl>
From: Mikael Bengtsson <micke_b.b@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 26 Oct 2007 08:22:14 +0200
In-Reply-To: <BAY114-W26F43C8D90463DC89CF35DD7A30@phx.gbl>
References: <BAY114-W266FADABD770552606A55AD7AF0@phx.gbl>
	<BAY114-W26F43C8D90463DC89CF35DD7A30@phx.gbl>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Problem detecting closed connection
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1168588220=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1168588220==
Content-Type: multipart/alternative;
	boundary="_55ce0705-b3ba-4924-b2aa-6795e84cdfb2_"

--_55ce0705-b3ba-4924-b2aa-6795e84cdfb2_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello!
=20
Am I the only one that have a problem detecting a closed connection? I made=
 workaround in which a thread periodically issues ECHO_REQ with L2CAP to a =
connected device. If the device doesn't answer within a few seconds the con=
nection is considered down. Unfortunately, this method doesn't always work =
as it seems. Sometimes there is no reply from the connected device. It coul=
d be that the SCO messages "drowns" the reply. What I would like to do, is =
to use ordinary recv, and if equal to 0, the connection is broken, but it d=
oesn't seem to work. The application just stops and waits on recv, which, i=
n the RFCOMM case, never returns.=20
=20
The BlueZ I'm using is 2.15 which is running on an Intel Xscale PXA255.
=20
-Mikael
> From: micke_b.b@hotmail.com> To: bluez-devel@lists.sourceforge.net> Date:=
 Mon, 15 Oct 2007 10:54:24 +0200> Subject: Re: [Bluez-devel] Problem detect=
ing closed connection> > > I have an example of this problem. The following=
 code snippet show a thread that controls a SCO connection. > > > ...> do> =
{> poll_result =3D poll(ufds, 1, 1000);> printf("Hello\n");> if (poll_resul=
t =3D=3D -1)> {> printf("Device got POLL-ERROR\n");> }> else if (poll_resul=
t =3D=3D 0)> {> printf("Timeout\n");> }> else if (ufds[0].revents & POLLIN)=
> {> memset(buffer, 0, sizeof(buffer));> bytes_read =3D read(ufds[0].fd, bu=
ffer, sizeof(buffer));> printf("bytes_read =3D=3D %d\n", bytes_read);> if (=
bytes_read =3D=3D 0)> exit(1);> ....> }> } while (poll_result> 0);> > Since=
 this is a SCO connection, the read operation will always return 60 bytes e=
very 3.75 ms. I observe that "Hello" and "bytes_read =3D=3D %60" is written=
 which is correct. When i switch off the slave, "Hello" and "bytes_read =3D=
 60" will continue for about 20 about seconds. This is also correct since i=
t may take that long for a connection to be disconnected. After this, only =
the text "Hello" is written. However, I expected that the timeout event als=
o should occur, that is, poll_result should have returned 0, or that the te=
xt "bytes_read =3D=3D 0" should occur, and in that case the program should =
end. But the program prints "Hello" endlessly. Why doesn't this work?> > I'=
m thinking of doing a thread with low level checks on the connections, I ha=
ve two SCO and three ACL connections. This thread may check the connections=
 periodically, but I don't have a clue what low level functions in BlueZ I =
should use.> > I used hcitool to check what happened with a connection when=
 switching off a slave. This program detected a closed connection after abo=
ut 20 seconds. Maybe I could use something from that program?> > -Mikael> _=
_______________________________> From: micke_b.b@hotmail.com> To: bluez-dev=
el@lists.sourceforge.net> Date: Wed, 3 Oct 2007 10:40:08 +0200> Subject: [B=
luez-devel] Problem detecting closed connection> > Hello!> > I have a probl=
em detecting a device that has closed it's connection.> > The software I'm =
developing sends and receives data through sockets to a slave device. When =
I switch of the slave device I expect that send and receive should return t=
he value 0, as in ordinary sockets programming for TCP and UDP sockets. But=
 instead send happily always returns a value which is bigger than 0. Why? S=
houldn't Bluetooth sockets behave the same way as ordinary sockets? I have =
a quite old Bluez, version 2.15. Is there another way of detecting closed c=
onnections?> > Regards:> -Mikael> > ________________________________> Expre=
ss yourself instantly with MSN Messenger! MSN Messenger> > ________________=
_________________________________________________> Express yourself instant=
ly with MSN Messenger! Download today it's FREE!> http://messenger.msn.clic=
k-url.com/go/onm00200471ave/direct/01/> -----------------------------------=
--------------------------------------> This SF.net email is sponsored by: =
Splunk Inc.> Still grepping through log files to find problems? Stop.> Now =
Search log events and configuration files using AJAX and a browser.> Downlo=
ad your FREE copy of Splunk now >> http://get.splunk.com/> ________________=
_______________________________> Bluez-devel mailing list> Bluez-devel@list=
s.sourceforge.net> https://lists.sourceforge.net/lists/listinfo/bluez-devel
_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/=

--_55ce0705-b3ba-4924-b2aa-6795e84cdfb2_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
<BR>Hello!<BR>
&nbsp;<BR>
Am I the only one that have a problem detecting a closed connection? I made=
 workaround in which a thread periodically issues ECHO_REQ with L2CAP to a =
connected device. If the device doesn't answer within a few seconds the con=
nection is considered down. Unfortunately, this method doesn't always work =
as it seems. Sometimes there is no&nbsp;reply from the connected device. It=
 could be that the SCO messages "drowns" the reply. What I would like to do=
, is to use ordinary recv, and if equal to 0, the connection is broken, but=
 it doesn't seem to work. The application just stops and waits on recv, whi=
ch, in the RFCOMM case, never returns.&nbsp;<BR>
&nbsp;<BR>
The BlueZ I'm using is 2.15 which is running on an Intel Xscale PXA255.<BR>
&nbsp;<BR>
-Mikael<BR>
<BR>&gt; From: micke_b.b@hotmail.com<BR>&gt; To: bluez-devel@lists.sourcefo=
rge.net<BR>&gt; Date: Mon, 15 Oct 2007 10:54:24 +0200<BR>&gt; Subject: Re: =
[Bluez-devel] Problem detecting closed connection<BR>&gt; <BR>&gt; <BR>&gt;=
 I have an example of this problem. The following code snippet show a threa=
d that controls a SCO connection. <BR>&gt; <BR>&gt; <BR>&gt; ...<BR>&gt; do=
<BR>&gt; {<BR>&gt; poll_result =3D poll(ufds, 1, 1000);<BR>&gt; printf("Hel=
lo\n");<BR>&gt; if (poll_result =3D=3D -1)<BR>&gt; {<BR>&gt; printf("Device=
 got POLL-ERROR\n");<BR>&gt; }<BR>&gt; else if (poll_result =3D=3D 0)<BR>&g=
t; {<BR>&gt; printf("Timeout\n");<BR>&gt; }<BR>&gt; else if (ufds[0].revent=
s &amp; POLLIN)<BR>&gt; {<BR>&gt; memset(buffer, 0, sizeof(buffer));<BR>&gt=
; bytes_read =3D read(ufds[0].fd, buffer, sizeof(buffer));<BR>&gt; printf("=
bytes_read =3D=3D %d\n", bytes_read);<BR>&gt; if (bytes_read =3D=3D 0)<BR>&=
gt; exit(1);<BR>&gt; ....<BR>&gt; }<BR>&gt; } while (poll_result&gt; 0);<BR=
>&gt; <BR>&gt; Since this is a SCO connection, the read operation will alwa=
ys return 60 bytes every 3.75 ms. I observe that "Hello" and "bytes_read =
=3D=3D %60" is written which is correct. When i switch off the slave, "Hell=
o" and "bytes_read =3D 60" will continue for about 20 about seconds. This i=
s also correct since it may take that long for a connection to be disconnec=
ted. After this, only the text "Hello" is written. However, I expected that=
 the timeout event also should occur, that is, poll_result should have retu=
rned 0, or that the text "bytes_read =3D=3D 0" should occur, and in that ca=
se the program should end. But the program prints "Hello" endlessly. Why do=
esn't this work?<BR>&gt; <BR>&gt; I'm thinking of doing a thread with low l=
evel checks on the connections, I have two SCO and three ACL connections. T=
his thread may check the connections periodically, but I don't have a clue =
what low level functions in BlueZ I should use.<BR>&gt; <BR>&gt; I used hci=
tool to check what happened with a connection when switching off a slave. T=
his program detected a closed connection after about 20 seconds. Maybe I co=
uld use something from that program?<BR>&gt; <BR>&gt; -Mikael<BR>&gt; _____=
___________________________<BR>&gt; From: micke_b.b@hotmail.com<BR>&gt; To:=
 bluez-devel@lists.sourceforge.net<BR>&gt; Date: Wed, 3 Oct 2007 10:40:08 +=
0200<BR>&gt; Subject: [Bluez-devel] Problem detecting closed connection<BR>=
&gt; <BR>&gt; Hello!<BR>&gt; <BR>&gt; I have a problem detecting a device t=
hat has closed it's connection.<BR>&gt; <BR>&gt; The software I'm developin=
g sends and receives data through sockets to a slave device. When I switch =
of the slave device I expect that send and receive should return the value =
0, as in ordinary sockets programming for TCP and UDP sockets. But instead =
send happily always returns a value which is bigger than 0. Why? Shouldn't =
Bluetooth sockets behave the same way as ordinary sockets? I have a quite o=
ld Bluez, version 2.15. Is there another way of detecting closed connection=
s?<BR>&gt; <BR>&gt; Regards:<BR>&gt; -Mikael<BR>&gt; <BR>&gt; _____________=
___________________<BR>&gt; Express yourself instantly with MSN Messenger! =
MSN Messenger<BR>&gt; <BR>&gt; ____________________________________________=
_____________________<BR>&gt; Express yourself instantly with MSN Messenger=
! Download today it's FREE!<BR>&gt; http://messenger.msn.click-url.com/go/o=
nm00200471ave/direct/01/<BR>&gt; ------------------------------------------=
-------------------------------<BR>&gt; This SF.net email is sponsored by: =
Splunk Inc.<BR>&gt; Still grepping through log files to find problems? Stop=
.<BR>&gt; Now Search log events and configuration files using AJAX and a br=
owser.<BR>&gt; Download your FREE copy of Splunk now &gt;&gt; http://get.sp=
lunk.com/<BR>&gt; _______________________________________________<BR>&gt; B=
luez-devel mailing list<BR>&gt; Bluez-devel@lists.sourceforge.net<BR>&gt; h=
ttps://lists.sourceforge.net/lists/listinfo/bluez-devel<BR><BR><br /><hr />=
Express yourself instantly with MSN Messenger! <a href=3D'http://clk.atdmt.=
com/AVE/go/onm00200471ave/direct/01/' target=3D'_new'>MSN Messenger</a></bo=
dy>
</html>=

--_55ce0705-b3ba-4924-b2aa-6795e84cdfb2_--


--===============1168588220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1168588220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1168588220==--
