Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <19c2b3920602010218m5da411ek@mail.gmail.com>
From: rangzen <lipare@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: [micro-howto] Ericsson K700i as hid device (hidd options)
In-Reply-To: <pan.2006.02.01.09.16.29.862248@wikidev.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15226_25214531.1138789095908"
References: <pan.2006.01.30.19.35.06.850476@wikidev.net>
	 <19c2b3920601310536l77bdc32ay@mail.gmail.com>
	 <pan.2006.02.01.09.16.29.862248@wikidev.net>
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
Date: Wed, 1 Feb 2006 11:18:15 +0100

------=_Part_15226_25214531.1138789095908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

No device, etc. All work

Feb  1 10:50:55 lef hcid[17602]: pin_code_request (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)
Feb  1 10:50:56 lef hcid[17602]: link_key_notify (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)
Feb  1 10:50:56 lef hidd[17606]: New HID device 00:16:20:2E:4F:08 ()
Feb  1 10:50:56 lef hal.hotplug[17653]: DEVPATH is not set (subsystem input=
)
Feb  1 10:50:57 lef input.agent[17660]:      evdev: already loaded
Feb  1 10:50:57 lef input.agent[17670]:      evdev: already loaded
Feb  1 10:50:57 lef input.agent[17654]:      tsdev: already loaded
Feb  1 10:50:57 lef input.agent[17654]:      mousedev: already loaded
Feb  1 10:50:57 lef input.agent[17654]:      evdev: already loaded
Feb  1 10:50:57 lef input.agent[17657]:      evdev: already loaded
Feb  1 10:51:09 lef hal.hotplug[17839]: DEVPATH is not set (subsystem input=
)

Connect again :

Feb  1 10:52:05 lef hcid[17602]: link_key_request (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)

And the phone display "Connection failed"
I delete the device in the phone, connect again :

Feb  1 10:54:52 lef hcid[17602]: pin_code_request (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)
Feb  1 10:54:53 lef hcid[17602]: link_key_notify (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)

And now, it fails ...

Remove all in /var/lib and not in the phone

Feb  1 10:57:22 lef hcid[17602]: link_key_request (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)
Feb  1 10:57:28 lef hcid[17602]: pin_code_request (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)
Feb  1 10:57:28 lef hcid[17602]: link_key_notify (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)

Failed.

Remove all in /var/lib/bluetooth and in the phone :

Feb  1 10:59:05 lef hcid[17602]: pin_code_request (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)
Feb  1 10:59:05 lef hcid[17602]: link_key_notify (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)

Failed.

Remove all in /var/lib/bluetooth and in the phone and restart service :

Feb  1 11:00:15 lef hidd[17606]: Exit
Feb  1 11:00:15 lef sdpd[17604]: terminating...
Feb  1 11:00:15 lef hcid[17602]: Exit.
Feb  1 11:00:16 lef hcid[18334]: Bluetooth HCI daemon
Feb  1 11:00:16 lef sdpd[18336]: Bluetooth SDP daemon
Feb  1 11:00:16 lef hidd[18338]: Bluetooth HID daemon
Feb  1 11:00:16 lef hcid[18334]: Starting security manager 0
Feb  1 11:00:38 lef hcid[18334]: pin_code_request (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)
Feb  1 11:00:39 lef hcid[18334]: link_key_notify (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)

Failed.

Stop services, rm /var/lib/, remove device in the phone, start the service =
:

Feb  1 11:01:23 lef hidd[18338]: Exit
Feb  1 11:01:23 lef sdpd[18336]: terminating...
Feb  1 11:01:23 lef hcid[18334]: Exit.
Feb  1 11:02:38 lef hcid[18518]: Bluetooth HCI daemon
Feb  1 11:02:38 lef hcid[18518]: Starting security manager 0
Feb  1 11:02:38 lef sdpd[18522]: Bluetooth SDP daemon
Feb  1 11:02:38 lef hidd[18524]: Bluetooth HID daemon
Feb  1 11:02:52 lef hcid[18518]: pin_code_request (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)
Feb  1 11:02:52 lef hcid[18518]: link_key_notify (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)

Failed.

Remove device in the phone, stop bluetooth on the phone, stop service, rm
/var/lib, start service :

Feb  1 11:05:35 lef hidd[18524]: Exit
Feb  1 11:05:35 lef sdpd[18522]: terminating...
Feb  1 11:05:35 lef hcid[18518]: Exit.
Feb  1 11:05:58 lef hcid[18721]: Bluetooth HCI daemon
Feb  1 11:05:58 lef hcid[18721]: Starting security manager 0
Feb  1 11:05:58 lef sdpd[18725]: Bluetooth SDP daemon
Feb  1 11:05:58 lef hidd[18727]: Bluetooth HID daemon
Feb  1 11:06:20 lef hcid[18721]: pin_code_request (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)
Feb  1 11:06:20 lef hcid[18721]: link_key_notify (sba=3D00:0A:94:02:56:9A,
dba=3D00:16:20:2E:4F:08)

Failed.

I've a "one shot" bluetooth device :D


2006/2/1, Gabriel Wicke <lists@wikidev.net>:
>
> On Tue, 31 Jan 2006 14:36:16 +0100, rangzen wrote:
>
> > Still doesn't work for me with a K750i :/
> >
> > rm all in /var/lib/bluetooth/
> > no device in the phone
> >
> > All works fine :)
> >
> > But now the device is registred in the phone and the "local" device is
> in
> > /var/lib/bluetooth
> > I try again and :
> >
> > # /usr/local/sbin/hcidump -X -V
> > HCI sniffer - Bluetooth packet analyzer ver 1.29
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> >> HCI Event: Connect Request (0x04) plen 10
> >     bdaddr 00:16:20:2E:4F:08 class 0x520204 type ACL
> > < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> >     bdaddr 00:16:20:2E:4F:08 role 0x00
> >     Role: Master
> >> HCI Event: Command Status (0x0f) plen 4
> >     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> >> HCI Event: Role Change (0x12) plen 8
> >     status 0x00 bdaddr 00:16:20:2E:4F:08 role 0x00
> >     Role: Master
> >> HCI Event: Link Key Request (0x17) plen 6
> >     bdaddr 00:16:20:2E:4F:08
> > < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> >     bdaddr 00:16:20:2E:4F:08 key 7D2DBC19D998316AE9DB5D9645707E08
> >> HCI Event: Command Complete (0x0e) plen 10
> >     Link Key Request Reply (0x01|0x000b) ncmd 1
> >     status 0x00 bdaddr 00:16:20:2E:4F:08
> >> HCI Event: Connect Complete (0x03) plen 11
> >     status 0x00 handle 42 bdaddr 00:16:20:2E:4F:08 type ACL encrypt 0x0=
1
> > < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> >     handle 42 policy 0x0f
> >     Link policy: RSWITCH HOLD SNIFF PARK
> >> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> >     bdaddr 00:16:20:2E:4F:08 mode 1
> >> HCI Event: Command Complete (0x0e) plen 6
> >     Write Link Policy Settings (0x02|0x000d) ncmd 1
> >     status 0x00 handle 42
> > < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> >     handle 42 ptype 0xcc18
> >     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> >> HCI Event: Command Status (0x0f) plen 4
> >     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> >> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> >     status 0x00 handle 42 ptype 0xff1e
> >     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3
> 3-DH5
> >> HCI Event: Max Slots Change (0x1b) plen 3
> >     handle 42 slots 5
> >> HCI Event: Disconn Complete (0x05) plen 4
> >     status 0x00 handle 42 reason 0x13
> >     Reason: Remote User Terminated Connection
> >
> > :/
> > The phone display "Connection failed"
>
> Do you get any messages in /var/log/syslog from hidd?
>
> --
> Gabriel
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



--
libert=E9 - partage - respect
freedom - share - respect

------=_Part_15226_25214531.1138789095908
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

No device, etc. All work<br>
<br>
Feb&nbsp; 1 10:50:55 lef hcid[17602]: pin_code_request (sba=3D00:0A:94:02:5=
6:9A, dba=3D00:16:20:2E:4F:08)<br>
Feb&nbsp; 1 10:50:56 lef hcid[17602]: link_key_notify (sba=3D00:0A:94:02:56=
:9A, dba=3D00:16:20:2E:4F:08)<br>
Feb&nbsp; 1 10:50:56 lef hidd[17606]: New HID device 00:16:20:2E:4F:08 ()<b=
r>
Feb&nbsp; 1 10:50:56 lef hal.hotplug[17653]: DEVPATH is not set (subsystem =
input)<br>
Feb&nbsp; 1 10:50:57 lef input.agent[17660]:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evdev: already loaded<br>
Feb&nbsp; 1 10:50:57 lef input.agent[17670]:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evdev: already loaded<br>
Feb&nbsp; 1 10:50:57 lef input.agent[17654]:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tsdev: already loaded<br>
Feb&nbsp; 1 10:50:57 lef input.agent[17654]:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mousedev: already loaded<br>
Feb&nbsp; 1 10:50:57 lef input.agent[17654]:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evdev: already loaded<br>
Feb&nbsp; 1 10:50:57 lef input.agent[17657]:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evdev: already loaded<br>
Feb&nbsp; 1 10:51:09 lef hal.hotplug[17839]: DEVPATH is not set (subsystem =
input)<br>
<br>
Connect again :<br>
<br>
Feb&nbsp; 1 10:52:05 lef hcid[17602]: link_key_request (sba=3D00:0A:94:02:5=
6:9A, dba=3D00:16:20:2E:4F:08)<br>
<br>
And the phone display &quot;Connection failed&quot;<br>
I delete the device in the phone, connect again :<br>
<br>
Feb&nbsp; 1 10:54:52 lef hcid[17602]: pin_code_request (sba=3D00:0A:94:02:5=
6:9A, dba=3D00:16:20:2E:4F:08)<br>
Feb&nbsp; 1 10:54:53 lef hcid[17602]: link_key_notify (sba=3D00:0A:94:02:56=
:9A, dba=3D00:16:20:2E:4F:08)<br>
<br>
And now, it fails ...<br>
<br>
Remove all in /var/lib and not in the phone<br>
<br>
Feb&nbsp; 1 10:57:22 lef hcid[17602]: link_key_request (sba=3D00:0A:94:02:5=
6:9A, dba=3D00:16:20:2E:4F:08)<br>
Feb&nbsp; 1 10:57:28 lef hcid[17602]: pin_code_request (sba=3D00:0A:94:02:5=
6:9A, dba=3D00:16:20:2E:4F:08)<br>
Feb&nbsp; 1 10:57:28 lef hcid[17602]: link_key_notify (sba=3D00:0A:94:02:56=
:9A, dba=3D00:16:20:2E:4F:08)<br>
<br>
Failed.<br>
<br>
Remove all in /var/lib/bluetooth and in the phone :<br>
<br>
Feb&nbsp; 1 10:59:05 lef hcid[17602]: pin_code_request (sba=3D00:0A:94:02:5=
6:9A, dba=3D00:16:20:2E:4F:08)<br>
Feb&nbsp; 1 10:59:05 lef hcid[17602]: link_key_notify (sba=3D00:0A:94:02:56=
:9A, dba=3D00:16:20:2E:4F:08)<br>
<br>
Failed.<br>
<br>
Remove all in /var/lib/bluetooth and in the phone and restart service :<br>
<br>
Feb&nbsp; 1 11:00:15 lef hidd[17606]: Exit<br>
Feb&nbsp; 1 11:00:15 lef sdpd[17604]: terminating...<br>
Feb&nbsp; 1 11:00:15 lef hcid[17602]: Exit.<br>
Feb&nbsp; 1 11:00:16 lef hcid[18334]: Bluetooth HCI daemon<br>
Feb&nbsp; 1 11:00:16 lef sdpd[18336]: Bluetooth SDP daemon<br>
Feb&nbsp; 1 11:00:16 lef hidd[18338]: Bluetooth HID daemon<br>
Feb&nbsp; 1 11:00:16 lef hcid[18334]: Starting security manager 0<br>
Feb&nbsp; 1 11:00:38 lef hcid[18334]: pin_code_request (sba=3D00:0A:94:02:5=
6:9A, dba=3D00:16:20:2E:4F:08)<br>
Feb&nbsp; 1 11:00:39 lef hcid[18334]: link_key_notify (sba=3D00:0A:94:02:56=
:9A, dba=3D00:16:20:2E:4F:08)<br>
<br>
Failed.<br>
<br>
Stop services, rm /var/lib/, remove device in the phone, start the service =
:<br>
<br>
Feb&nbsp; 1 11:01:23 lef hidd[18338]: Exit<br>
Feb&nbsp; 1 11:01:23 lef sdpd[18336]: terminating...<br>
Feb&nbsp; 1 11:01:23 lef hcid[18334]: Exit.<br>
Feb&nbsp; 1 11:02:38 lef hcid[18518]: Bluetooth HCI daemon<br>
Feb&nbsp; 1 11:02:38 lef hcid[18518]: Starting security manager 0<br>
Feb&nbsp; 1 11:02:38 lef sdpd[18522]: Bluetooth SDP daemon<br>
Feb&nbsp; 1 11:02:38 lef hidd[18524]: Bluetooth HID daemon<br>
Feb&nbsp; 1 11:02:52 lef hcid[18518]: pin_code_request (sba=3D00:0A:94:02:5=
6:9A, dba=3D00:16:20:2E:4F:08)<br>
Feb&nbsp; 1 11:02:52 lef hcid[18518]: link_key_notify (sba=3D00:0A:94:02:56=
:9A, dba=3D00:16:20:2E:4F:08)<br>
<br>
Failed.<br>
<br>
Remove device in the phone, stop bluetooth on the phone, stop service, rm /=
var/lib, start service :<br>
<br>
Feb&nbsp; 1 11:05:35 lef hidd[18524]: Exit<br>
Feb&nbsp; 1 11:05:35 lef sdpd[18522]: terminating...<br>
Feb&nbsp; 1 11:05:35 lef hcid[18518]: Exit.<br>
Feb&nbsp; 1 11:05:58 lef hcid[18721]: Bluetooth HCI daemon<br>
Feb&nbsp; 1 11:05:58 lef hcid[18721]: Starting security manager 0<br>
Feb&nbsp; 1 11:05:58 lef sdpd[18725]: Bluetooth SDP daemon<br>
Feb&nbsp; 1 11:05:58 lef hidd[18727]: Bluetooth HID daemon<br>
Feb&nbsp; 1 11:06:20 lef hcid[18721]: pin_code_request (sba=3D00:0A:94:02:5=
6:9A, dba=3D00:16:20:2E:4F:08)<br>
Feb&nbsp; 1 11:06:20 lef hcid[18721]: link_key_notify (sba=3D00:0A:94:02:56=
:9A, dba=3D00:16:20:2E:4F:08)<br>
<br>
Failed.<br>
<br>I've a &quot;one shot&quot; bluetooth device :D<br>
<br>
<br><div><span class=3D"gmail_quote">2006/2/1, Gabriel Wicke &lt;<a href=3D=
"mailto:lists@wikidev.net" target=3D"_blank" onclick=3D"return top.js.OpenE=
xtLink(window,event,this)">lists@wikidev.net</a>&gt;:</span><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

On Tue, 31 Jan 2006 14:36:16 +0100, rangzen wrote:<br><br>&gt; Still doesn'=
t work for me with a K750i :/<br>&gt;<br>&gt; rm all in /var/lib/bluetooth/=
<br>&gt; no device in the phone<br>&gt;<br>&gt; All works fine :)<br>&gt;
<br>&gt; But now the device is registred in the phone and the &quot;local&q=
uot; device is in<br>&gt; /var/lib/bluetooth<br>&gt; I try again and :<br>&=
gt;<br>&gt; # /usr/local/sbin/hcidump -X -V<br>&gt; HCI sniffer - Bluetooth=
 packet analyzer ver=20
1.29<br>&gt; device: hci0 snap_len: 1028 filter: 0xffffffff<br>&gt;&gt; HCI=
 Event: Connect Request (0x04) plen 10<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bdad=
dr 00:16:20:2E:4F:08 class 0x520204 type ACL<br>&gt; &lt; HCI Command: Acce=
pt Connection Request (0x01|0x0009) plen 7
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 role 0x00<br>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp; Role: Master<br>&gt;&gt; HCI Event: Command Status=
 (0x0f) plen 4<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Accept Connection Request (0=
x01|0x0009) status 0x00 ncmd 1<br>&gt;&gt; HCI Event: Role Change (0x12) pl=
en 8
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:20:2E:4F:08 role =
0x00<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Role: Master<br>&gt;&gt; HCI Event: Li=
nk Key Request (0x17) plen 6<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr 00:16:2=
0:2E:4F:08<br>&gt; &lt; HCI Command: Link Key Request Reply (0x01|0x000b) p=
len 22
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 key 7D2DBC19D9983=
16AE9DB5D9645707E08<br>&gt;&gt; HCI Event: Command Complete (0x0e) plen 10<=
br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Link Key Request Reply (0x01|0x000b) ncmd 1=
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:20:2E:4F:08
<br>&gt;&gt; HCI Event: Connect Complete (0x03) plen 11<br>&gt;&nbsp;&nbsp;=
&nbsp;&nbsp; status 0x00 handle 42 bdaddr 00:16:20:2E:4F:08 type ACL encryp=
t 0x01<br>&gt; &lt; HCI Command: Write Link Policy Settings (0x02|0x000d) p=
len 4<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; handle 42 policy 0x0f
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>&g=
t;&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>&gt;&nb=
sp;&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 mode 1<br>&gt;&gt; HCI Event=
: Command Complete (0x0e) plen 6<br>

&gt;&nbsp;&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd =
1<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x00 handle 42<br>&gt; &lt; HCI Co=
mmand: Change Connection Packet Type (0x01|0x000f) plen 4<br>&gt;&nbsp;&nbs=
p;&nbsp;&nbsp; handle 42 ptype 0xcc18<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Packe=
t type: DM1 DM3 DM5 DH1 DH3 DH5
<br>&gt;&gt; HCI Event: Command Status (0x0f) plen 4<br>&gt;&nbsp;&nbsp;&nb=
sp;&nbsp; Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1<br=
>&gt;&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>&gt;&n=
bsp;&nbsp;&nbsp;&nbsp; status 0x00 handle 42 ptype 0xff1e
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1=
 2-DH3 2-DH5 3-DH1 3-DH3 3-DH5<br>&gt;&gt; HCI Event: Max Slots Change (0x1=
b) plen 3<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; handle 42 slots 5<br>&gt;&gt; HCI=
 Event: Disconn Complete (0x05) plen 4
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x00 handle 42 reason 0x13<br>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br>&gt;<b=
r>&gt; :/<br>&gt; The phone display &quot;Connection failed&quot;<br><br>Do=
 you get any messages in /var/log/syslog from hidd?
<br><br>--<br>Gabriel<br><br><br><br>--------------------------------------=
-----------------<br>This SF.net email is sponsored by: Splunk Inc. Do you =
grep through log files<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Downloa=
d the new AJAX search engine that makes
<br>searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&n=
bsp;DOWNLOAD SPLUNK!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dln=
k&amp;kid=3D103432&amp;bid=3D230486&amp;dat=3D121642" target=3D"_blank" onc=
lick=3D"return top.js.OpenExtLink(window,event,this)">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D103432&amp;bid=3D230486=
&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-users mail=
ing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net" target=3D"=
_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">Bluez-user=
s@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)=
">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquot=
e></div><br><br clear=3D"all"><br>-- <br>libert=E9 - partage - respect<br>f=
reedom - share - respect


------=_Part_15226_25214531.1138789095908--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
