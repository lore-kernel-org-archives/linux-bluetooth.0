Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY102-W357F1F6D724BF053F4A9D1F09A0@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 22 Oct 2007 15:02:34 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Device Not Initing Properly
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1808688638=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1808688638==
Content-Type: multipart/alternative;
	boundary="_0136c0d6-f12e-4774-bc0c-7192e87f903c_"

--_0136c0d6-f12e-4774-bc0c-7192e87f903c_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
Another problem I've been having recently is with the chips not initing pro=
perly, more precisely, hci0 wont init properly. I've got this same issue on=
 several systems with different sets of BT chips, so I think I can probably=
 rule out any type of hardware based issue. When I boot the system the devi=
ces will work perfectly for an amount of time, then out of the blue (no pun=
 intended) hci0 will fall to 'down' and I can't get him to come back up. Ev=
en after a software reboot, or a system 'reset' performed by the main syste=
m boards watchdog, the chip still stays down, like so:
hci0:   Type: USB        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU=
: 0:0        DOWN         RX bytes:0 acl:0 sco:0 events:0 errors:0        T=
X bytes:27 acl:0 sco:0 commands:9 errors:0
hci1:   Type: USB        BD Address: 00:80:98:C4:51:DE ACL MTU: 310:10 SCO =
MTU: 64:8        UP RUNNING PSCAN
        RX bytes:2805 acl:0 sco:0 events:153 errors:0        TX bytes:2396 =
acl:0 sco:0 commands:144 errors:0
=20
However, if I completely disconnect the systems power supply from the inlet=
, and reconnect it a second or so later then the chip will come back to lif=
e, again only for a certain amount of time before going down again. This is=
 on an embedded system so being able to disconnect the power isn't really a=
n option for us.
=20
I have also noticed that whilst the chip is down, every few seconds the hci=
config will return the following, stating that its attempting to init the c=
hip, this is performed by a script I've build on the system to run 'hciconf=
ig hci up' in the event the chip goes down every 10 seconds or so to try an=
d bring it up again:
=20
hci0:   Type: USB        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU=
: 0:0        DOWN INIT RUNNING        RX bytes:0 acl:0 sco:0 events:0 error=
s:0        TX bytes:27 acl:0 sco:0 commands:9 errors:0
hci1:   Type: USB        BD Address: 00:80:98:C4:51:DE ACL MTU: 310:10 SCO =
MTU: 64:8        UP RUNNING PSCAN         RX bytes:2805 acl:0 sco:0 events:=
153 errors:0        TX bytes:2396 acl:0 sco:0 commands:144 errors:0
=20
However the chip will still remain in the down position. This would suggest=
 to me that the chip is definitely connected and visible to system, its obv=
iously just throwing errors when trying to initialize. I'm not quite sure w=
hy this is however, is there any advice you can offer? or perhaps some diag=
nostics suggestions to give us a little more information as to the root of =
the problem?
=20
I took the liberty of running hcidump for a few minutes just to see if it t=
hrew anything interesting, but its giving some very simple output:
=20
voyage:~# hcidump -i hci0HCI sniffer - Bluetooth packet analyzer ver 1.39de=
vice: hci0 snap_len: 1028 filter: 0xffffffff< HCI Command: Read Local Suppo=
rted Features (0x04|0x0003) plen 0< HCI Command: Read Local Supported Featu=
res (0x04|0x0003) plen 0< HCI Command: Read Local Supported Features (0x04|=
0x0003) plen 0< HCI Command: Read Local Supported Features (0x04|0x0003) pl=
en 0< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0< HCI =
Command: Read Local Supported Features (0x04|0x0003) plen 0< HCI Command: R=
ead Local Supported Features (0x04|0x0003) plen 0< HCI Command: Read Local =
Supported Features (0x04|0x0003) plen 0
=20
We're running a debian based build running kernel 2.6.17 and blue-z 3.12. T=
hanks guys, I really appreciate your time and help.
=20
Robert
_________________________________________________________________
100=92s of Music vouchers to be won with MSN Music
https://www.musicmashup.co.uk=

--_0136c0d6-f12e-4774-bc0c-7192e87f903c_
Content-Type: text/html; charset="Windows-1252"
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
<body class=3D'hmmessage'>Hello Guys,<BR>
&nbsp;<BR>
Another problem I've been having recently is with the chips not initing pro=
perly, more precisely, hci0 wont init properly. I've got this same issue on=
 several systems with different sets of BT chips, so I&nbsp;think I can pro=
bably rule out any type of hardware based&nbsp;issue. When I boot the syste=
m the devices will work perfectly for an amount of time, then out of the bl=
ue (no pun intended)&nbsp;hci0 will fall to 'down' and I can't get him to c=
ome back up. Even after a software&nbsp;reboot, or a system&nbsp;'reset'&nb=
sp;performed by the&nbsp;main system boards&nbsp;watchdog, the chip still s=
tays down, like so:<BR>
<BR>hci0:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<BR>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; RX bytes:0 acl:0 <FONT face=3D"">sco:0</FONT> events:0 errors:0<BR>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:27 acl:0 <FONT face=3D""=
>sco:0</FONT> commands:9 errors:0<BR>
hci1:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B=
D Address: 00:80:98:C4:51:DE ACL MTU: 310:10 SCO MTU: 64:8<BR>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:2805 acl:0 sco:0 events=
:153 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:2396 a=
cl:0 sco:0 commands:144 errors:0<BR>
&nbsp;<BR>
However, if I completely disconnect the systems power supply from the inlet=
, and reconnect it a second or so later&nbsp;then the chip will come back t=
o life, again only for a certain amount of time before going down again. Th=
is is on an embedded system so being able to disconnect the power isn't rea=
lly an option for us.<BR>
&nbsp;<BR>
I have also noticed that whilst the chip is down, every few seconds the hci=
config will return the following, stating that its attempting to init the c=
hip, this is&nbsp;performed&nbsp;by a script I've build on the system to ru=
n 'hciconfig hci up' in the event the chip goes down every 10 seconds or so=
 to try and bring it up again:<BR>
&nbsp;<BR>
hci0:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B=
D Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<BR>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DOWN INIT RUNNING<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; RX bytes:0 acl:0 <FONT face=3D"">sco:0</FONT> events:0 error=
s:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:27 acl:0 <FONT f=
ace=3D"">sco:0</FONT> commands:9 errors:0<BR>
hci1:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B=
D Address: 00:80:98:C4:51:DE ACL MTU: 310:10 SCO MTU: 64:8<BR>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN&nbsp;<BR>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; RX bytes:2805 acl:0 sco:0 events:153 errors:0<BR>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:2396 acl:0 sco:0 commands=
:144 errors:0<BR>
&nbsp;<BR>
However the chip will still remain in the down position. This would suggest=
 to me that the chip is definitely connected and visible to system, its obv=
iously just throwing errors when trying to initialize. I'm not quite sure w=
hy this is however, is there any advice you can offer? or perhaps some diag=
nostics suggestions to give us a little more information as to the root of =
the problem?<BR>
&nbsp;<BR>
I took the liberty of running hcidump for a few minutes just to see if it t=
hrew anything interesting, but its giving some very simple output:<BR>
&nbsp;<BR>
voyage:~# hcidump -i hci0<BR>HCI sniffer - Bluetooth packet analyzer ver 1.=
39<BR>device: hci0 snap_len: 1028 filter: 0xffffffff<BR>&lt; HCI Command: R=
ead Local Supported Features (0x04|0x0003) plen 0<BR>&lt; HCI Command: Read=
 Local Supported Features (0x04|0x0003) plen 0<BR>&lt; HCI Command: Read Lo=
cal Supported Features (0x04|0x0003) plen 0<BR>&lt; HCI Command: Read Local=
 Supported Features (0x04|0x0003) plen 0<BR>&lt; HCI Command: Read Local Su=
pported Features (0x04|0x0003) plen 0<BR>&lt; HCI Command: Read Local Suppo=
rted Features (0x04|0x0003) plen 0<BR>&lt; HCI Command: Read Local Supporte=
d Features (0x04|0x0003) plen 0<BR>&lt; HCI Command: Read Local Supported F=
eatures (0x04|0x0003) plen 0<BR>
&nbsp;<BR>
We're running a debian based build running kernel 2.6.17 and blue-z 3.12. T=
hanks guys, I really appreciate your time and help.<BR>
&nbsp;<BR>
Robert<BR><br /><hr />The next generation of MSN Hotmail has arrived -  <a =
href=3D'http://www.newhotmail.co.uk' target=3D'_new'>Windows Live Hotmail</=
a></body>
</html>=

--_0136c0d6-f12e-4774-bc0c-7192e87f903c_--


--===============1808688638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1808688638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1808688638==--
