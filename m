Return-Path: <cyrus@holtmann.org>
From: Pradeep Vivekanandan <vivekanandanp@hcl.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Reg: Help need on RegisterPlayer in simpleagent python script on
 bluez 5.7
Date: Mon, 17 Feb 2014 17:59:28 +0000
Message-ID: <A4B1A1B79EB08444A5B867A4254F4B8840918949@chn-hclt-mbs05.HCLT.CORP.HCL.IN>
Content-Type: text/html; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">Hi,<br>
<br>
I am running the bluetoothd in bluez 5.7.<br>
<br>
I have execute test folder scripts i python.<br>
<br>
For getting metadata information i run simple-player python script.<br>
<br>
But i got the below error could please help on that how to get metadata inf=
ormation.<br>
error:<br>
<font color=3D"3366FF">File &quot;./simple-player&quot;, line 149, in &lt;m=
odule&gt;<br>
&nbsp;&nbsp;&nbsp; media.RegisterPlayer(dbus.ObjectPath(path), player.prope=
rties)<br>
&nbsp; File &quot;/usr/lib/python2.7/dist-packages/dbus/proxies.py&quot;, l=
ine 70, in __call__<br>
&nbsp;&nbsp;&nbsp; return self._proxy_method(*args, **keywords)<br>
&nbsp; File &quot;/usr/lib/python2.7/dist-packages/dbus/proxies.py&quot;, l=
ine 145, in __call__<br>
&nbsp;&nbsp;&nbsp; **keywords)<br>
&nbsp; File &quot;/usr/lib/python2.7/dist-packages/dbus/connection.py&quot;=
, line 651, in call_blocking<br>
&nbsp;&nbsp;&nbsp; message, timeout)<br>
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Me=
thod &quot;RegisterPlayer&quot; with signature &quot;oa{sv}&quot; on interf=
ace &quot;org.bluez.Media1&quot; doesn't exist</font><br>
<br>
Also I could not found&nbsp; the method RegisterPlayer&nbsp; in org.bluez.M=
edia1 using d-feet.<br>
<br>
Thanks and Regards,<br>
Pradeep V</div>
<span style=3D"FONT-FAMILY: 'Arial','sans-serif'; COLOR: gray; FONT-SIZE: 7=
.5pt; mso-fareast-font-family: 'Times New Roman'">
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><br><br><font style=3D"F=
ONT-FAMILY: 'Arial','sans-serif'; COLOR: gray; FONT-SIZE: 9px">::DISCLAIMER=
::<br>---------------------------------------------------------------------=
---------------------------------------------------------------------------=
----</font></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><font style=3D"FONT-FAMI=
LY: 'Arial','sans-serif'; COLOR: gray; FONT-SIZE: 11px">The contents of thi=
s e-mail and any attachment(s) are confidential and intended for the named =
recipient(s) only.<br>E-mail transmission is not guaranteed to be secure or=
 error-free as information could be intercepted, corrupted, <br>lost, destr=
oyed, arrive late or incomplete, or may contain viruses in transmission. Th=
e e mail and its contents <br>(with or without referred errors) shall there=
fore not attach any liability on the originator or HCL or its affiliates. <=
br>Views or opinions, if any, presented in this email are solely those of t=
he author and may not necessarily reflect the <br>views or opinions of HCL =
or its affiliates. Any form of reproduction, dissemination, copying, disclo=
sure, modification, <br>distribution and / or publication of this message w=
ithout the prior written consent of authorized representative of <br>HCL is=
 strictly prohibited. If you have received this email in error please delet=
e it and notify the sender immediately. <br>Before opening any email and/or=
 attachments, please check them for viruses and other defects.</font></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><font style=3D"FONT-FAMI=
LY: 'Arial','sans-serif'; COLOR: gray; FONT-SIZE: 11px">-------------------=
---------------------------------------------------------------------------=
------------------------------------------------------</font></span></P></b=
ody>
</html>
