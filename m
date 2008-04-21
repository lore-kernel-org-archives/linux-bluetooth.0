Return-Path: <cyrus@holtmann.org>
Date: Sun, 20 Apr 2008 21:06:56 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <480A5877.4080201@powercraft.nl>
Message-ID: <alpine.LNX.1.00.0804201637170.29306@nge2.ngu.pk>
References: <48092EF6.3090603@powercraft.nl> <48093316.3070906@powercraft.nl>
	<alpine.LNX.1.00.0804190011000.27696@nge2.ngu.pk>
	<480A5877.4080201@powercraft.nl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1287590132-580024538-1208740017=:29306"
Subject: Re: [Bluez-users] Samsung WEP210 Bluetooth Headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1287590132-580024538-1208740017=:29306
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII


On Sat, 19 Apr 2008, Jelle de Jong wrote:

-> So, I tried to get it working for a other 4 hours, but I can't get it to
-> work. Please help me, how can I get the device fully working, what am I
-> doing wrong here?
-> 
-> Please take a look at the logs i attached in the mail, i hope this gives
-> enough information for a advanced bluez users to tell me what is wrong.

Several things stand out.

1.)

First is your kernel version. Seems to be a 2.5.24.x. If you are using an 
SCO-only headset, the 2.6.24.x kernels will not work with it. You must either 
patch the kernel, or upgrade to an ESCO-able headset. This is the issue with 
mine. I use the patch that was on this list to patch my 2.6.24.4. The device's 
features should mention eSCO.


-> snapshot of my syslog >>
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: Bluetooth HCI daemon
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: HCI dev 0 registered
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: Starting SDP server
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: Unix socket created: 12
-> Apr 19 21:55:55 debian-eeepc hidd[2333]: Bluetooth HID daemon
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: Registered manager
-> path:/org/bluez/audio
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: Registering service
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: Unable to execute
-> /usr/lib/bluetooth/bluetoothd-service-audio

2). The file, and format of those files above is not used anymore. Now, the 
audio service is a plugin: /usr/lib/bluetooth/plugins/libaudio.so
There are no more  *.service files in /etc/bluetooth like audio.service.


-> Apr 19 21:55:55 debian-eeepc hcid[2330]: HCI dev 0 up
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: Device hci0 has been added
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: Starting security manager 0
-> Apr 19 21:55:55 debian-eeepc hcid[2330]: Device hci0 has been activated
-> Apr 19 21:56:53 debian-eeepc hcid[2330]: link_key_request
-> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
-> Apr 19 21:56:55 debian-eeepc hcid[2330]: pin_code_request
-> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
-> Apr 19 21:56:55 debian-eeepc hcid[2330]: link_key_notify
-> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
-> Apr 19 21:56:57 debian-eeepc hcid[2330]: link_key_request
-> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
-> Apr 19 21:56:58 debian-eeepc hcid[2330]: Access denied: Not authorized

3.) The pin setup you used I think is old, too. The users on this list seem to 
use some graphical utility, but myself I've always just used auth-agent and 
passkey-agent from the bluez-utils src tarball.

passkey-agent --default (pin number) (remote device address) &
auth-agent &

-> Apr 19 21:56:59 debian-eeepc hcid[2330]: link_key_notify
-> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
-> Apr 19 21:57:18 debian-eeepc hcid[2330]: Audio API: received
-> BT_GETCAPABILITIES_REQ
-> Apr 19 21:57:18 debian-eeepc hcid[2330]: Audio API: sending
-> BT_GETCAPABILITIES_RSP
-> Apr 19 21:57:18 debian-eeepc hcid[2330]: Audio API: received
-> BT_SETCONFIGURATION_REQ
-> Apr 19 21:57:18 debian-eeepc hcid[2330]: config sco - device =
-> 20:07:09:15:A9:5A access_mode = 2
-> Apr 19 21:57:20 debian-eeepc hcid[2330]: link_key_request
-> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
-> Apr 19 21:57:22 debian-eeepc kernel: Bluetooth: SCO (Voice Link) ver 0.5
-> Apr 19 21:57:22 debian-eeepc kernel: Bluetooth: SCO socket layer initialized
-> Apr 19 21:57:24 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet
-> for unknown connection handle 43
-> Apr 19 21:57:55 debian-eeepc last message repeated 10158 times
-> Apr 19 21:58:02 debian-eeepc last message repeated 2576 times
-> Apr 19 21:58:02 debian-eeepc hcid[2330]: connect(): Connection timed out


Here...

-> Apr 19 21:58:02 debian-eeepc hcid[2330]: config failed
-> Apr 19 21:58:02 debian-eeepc hcid[2330]: Audio API: sending
-> BT_SETCONFIGURATION_RSP
-> Apr 19 21:58:02 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet
-> for unknown connection handle 43
-> Apr 19 21:58:33 debian-eeepc last message repeated 10090 times
-> Apr 19 21:59:23 debian-eeepc last message repeated 16726 times

...and here, look like the message I used to get about the SCO/eSCO problem 
with 2.6.24 kernels. I'm not 100% sure that's what this is, but it looks 
similar.

I'll attach setup info and the previously posted esco patch, if you find you 
do need it. Other than these things mentioned here, I'm not sure what the 
problem could be.



---1287590132-580024538-1208740017=:29306
Content-Type: TEXT/plain; name=bt-example.txt
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LNX.1.00.0804202106560.29306@nge2.ngu.pk>
Content-Description: bt-example.txt
Content-Disposition: attachment; filename=bt-example.txt

DQpibHVlei1maXJtd2FyZS0xLjINCmJsdWV6LWhjaWR1bXAtMS40MQ0KYmx1
ZXotbGlicy0zLjMwDQpibHVlei11dGlscy0zLjMwDQoNCg0KIyB0cmVlIC1h
IC91c3IvbGliL2JsdWV0b290aCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCi91c3IvbGliL2JsdWV0b290aA0KYC0tIHBsdWdpbnMNCiAgICB8
LS0gbGliYXVkaW8uc28NCiAgICB8LS0gbGliaW5wdXQuc28NCiAgICB8LS0g
bGlibmV0d29yay5zbw0KICAgIGAtLSBsaWJzZXJpYWwuc28NCg0KMSBkaXJl
Y3RvcnksIDQgZmlsZXMNCg0KDQojIHRyZWUgLWEgL2V0Yy9ibHVldG9vdGgg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KL2V0Yy9ibHVl
dG9vdGgNCnwtLSBhdWRpby5jb25mDQp8LS0gaGNpZC5jb25mDQp8LS0gaWZk
b3duLXBhbjANCnwtLSBpZnVwLXBhbjANCnwtLSBpbml0LXBhbjANCnwtLSBu
ZXR3b3JrLmNvbmYNCnwtLSBwYW51LWNsaWVudA0KYC0tIHJmY29tbS5jb25m
DQoNCjAgZGlyZWN0b3JpZXMsIDggZmlsZXMNCg0KDQoNCg0KDQoNCiMjIEFs
c2EgU291bmQgQ29uZmlnDQojIw0KIyMgRXh0cmEgY29uZmlndXJhdGlvbnMg
Zm9yIEFsc2ENCiMjICgvZXRjL2Fzb3VuZC5jb25mKQ0KIyMNCg0KcGNtLm9z
cyB7DQogICAgICAgIHR5cGUgb3NzDQogICAgICAgIGRldmljZSAvZGV2L2Rz
cA0KfQ0KDQpwY20uYmx1ZXRvb3RoIHsNCiAgICAgICAgdHlwZSBibHVldG9v
dGgNCiAgICAgICAgZGV2aWNlICIwMDoxQTo0NTowMTpGOTo0MiINCn0NCg0K
cGNtLmJ0X3NsYXZlIHsNCiAgICAgICAgdHlwZSBwbHVnDQogICAgICAgIHNs
YXZlIHsNCiAgICAgICAgICAgICAgICBwY20gImJsdWV0b290aCINCiAgICAg
ICAgfQ0KfQ0KDQoNCg0KDQojIC9ldGMvYmx1ZXRvb3RoL2hjaWQuY29uZiAg
ICAgICAgICAgICAgICAgICAgICAgICANCiMNCiMgSENJIGRhZW1vbiBjb25m
aWd1cmF0aW9uIGZpbGUuDQojDQoNCiMgSENJZCBvcHRpb25zDQpvcHRpb25z
IHsNCiAgICAgICAgIyBBdXRvbWF0aWNhbGx5IGluaXRpYWxpemUgbmV3IGRl
dmljZXMNCiAgICAgICAgYXV0b2luaXQgeWVzOw0KDQogICAgICAgICMgU2Vj
dXJpdHkgTWFuYWdlciBtb2RlDQogICAgICAgICMgICBub25lIC0gU2VjdXJp
dHkgbWFuYWdlciBkaXNhYmxlZA0KICAgICAgICAjICAgYXV0byAtIFVzZSBs
b2NhbCBQSU4gZm9yIGluY29taW5nIGNvbm5lY3Rpb25zDQogICAgICAgICMg
ICB1c2VyIC0gQWx3YXlzIGFzayB1c2VyIGZvciBhIFBJTg0KICAgICAgICAj
DQogICAgICAgIHNlY3VyaXR5IHVzZXI7DQoNCiAgICAgICAgIyBQYWlyaW5n
IG1vZGUNCiAgICAgICAgIyAgIG5vbmUgIC0gUGFpcmluZyBkaXNhYmxlZA0K
ICAgICAgICAjICAgbXVsdGkgLSBBbGxvdyBwYWlyaW5nIHdpdGggYWxyZWFk
eSBwYWlyZWQgZGV2aWNlcw0KICAgICAgICAjICAgb25jZSAgLSBQYWlyIG9u
Y2UgYW5kIGRlbnkgc3VjY2Vzc2l2ZSBhdHRlbXB0cw0KICAgICAgICBwYWly
aW5nIG11bHRpOw0KfQ0KDQojIERlZmF1bHQgc2V0dGluZ3MgZm9yIEhDSSBk
ZXZpY2VzDQpkZXZpY2Ugew0KICAgICAgICAjIExvY2FsIGRldmljZSBuYW1l
DQogICAgICAgICMgICAlZCAtIGRldmljZSBpZA0KICAgICAgICAjICAgJWgg
LSBob3N0IG5hbWUNCiAgICAgICAgbmFtZSAiWyVoXSAvIEJUIERldmljZSAl
ZCI7DQoNCiAgICAgICAgIyBMb2NhbCBkZXZpY2UgY2xhc3MgKHNlZSBoY2lk
LmNvbmYgbWFucGFnZSkNCiAgICAgICAgIyAweDAwMDEwMCA9IENvbXB1dGVy
LCB1bnNwZWMuDQogICAgICAgICMgMHgwMjAxMDAgPSBOZXR3b3JraW5nIENv
bXB1dGVyLCB1bnNwZWMuDQogICAgICAgIGNsYXNzIDB4MDIwMTA4Ow0KDQog
ICAgICAgICMgRGVmYXVsdCBwYWNrZXQgdHlwZQ0KICAgICAgICBwa3RfdHlw
ZSBESDEsRE0xLEhWMTsNCg0KICAgICAgICAjIElucXVpcnkgYW5kIFBhZ2Ug
c2Nhbg0KICAgICAgICBpc2NhbiBlbmFibGU7IHBzY2FuIGVuYWJsZTsNCg0K
ICAgICAgICAjIERlZmF1bHQgbGluayBtb2RlDQogICAgICAgICMgICBub25l
ICAgLSBubyBzcGVjaWZpYyBwb2xpY3kNCiAgICAgICAgIyAgIGFjY2VwdCAt
IGFsd2F5cyBhY2NlcHQgaW5jb21pbmcgY29ubmVjdGlvbnMNCiAgICAgICAg
IyAgIG1hc3RlciAtIGJlY29tZSBtYXN0ZXIgb24gaW5jb21pbmcgY29ubmVj
dGlvbnMsDQogICAgICAgICMgICAgICAgICAgICBkZW55IHJvbGUgc3dpdGNo
IG9uIG91dGdvaW5nIGNvbm5lY3Rpb25zDQogICAgICAgIGxtIGFjY2VwdDsN
Cg0KICAgICAgICAjIERlZmF1bHQgbGluayBwb2xpY3kNCiAgICAgICAgIyAg
IG5vbmUgICAgLSBubyBzcGVjaWZpYyBwb2xpY3kNCiAgICAgICAgIyAgIHJz
d2l0Y2ggLSBhbGxvdyByb2xlIHN3aXRjaA0KICAgICAgICAjICAgaG9sZCAg
ICAtIGFsbG93IGhvbGQgbW9kZQ0KICAgICAgICAjICAgc25pZmYgICAtIGFs
bG93IHNuaWZmIG1vZGUNCiAgICAgICAgIyAgIHBhcmsgICAgLSBhbGxvdyBw
YXJrIG1vZGUNCiAgICAgICAgbHAgcnN3aXRjaCxob2xkLHNuaWZmLHBhcms7
DQoNCn0NCg0KDQoNCiMgaGNpdG9vbCBzY2FuDQoNClNjYW5uaW5nIC4uLg0K
ICAgICAgICAwMDoxQTo0NTowMTpGOTo0MiAgICAgICBKYWJyYSBCVDEzNQ0K
DQojIHBhc3NrZXktYWdlbnQgLS1kZWZhdWx0IDAwMDAgMDA6MUE6NDU6MDE6
Rjk6NDIgJg0KDQpbMV0gNDU2OQ0KIyBhdXRoLWFnZW50Jg0KDQpbMl0gNDU3
MA0KDQojIGhjaXRvb2wgaW5mbyAwMDoxQTo0NTowMTpGOTo0Mg0KDQpSZXF1
ZXN0aW5nIGluZm9ybWF0aW9uIC4uLg0KICAgICAgICBCRCBBZGRyZXNzOiAg
MDA6MUE6NDU6MDE6Rjk6NDINCiAgICAgICAgTE1QIFZlcnNpb246IDIuMCAo
MHgzKSBMTVAgU3VidmVyc2lvbjogMHhiZmENCiAgICAgICAgTWFudWZhY3R1
cmVyOiBDYW1icmlkZ2UgU2lsaWNvbiBSYWRpbyAoMTApDQogICAgICAgIEZl
YXR1cmVzOiAweGZjIDB4ZmUgMHgwYiAweDAwIDB4MDggMHgwOCAweDAwIDB4
MDANCiAgICAgICAgICAgICAgICA8ZW5jcnlwdGlvbj4gPHNsb3Qgb2Zmc2V0
PiA8dGltaW5nIGFjY3VyYWN5PiA8cm9sZSBzd2l0Y2g+DQogICAgICAgICAg
ICAgICAgPGhvbGQgbW9kZT4gPHNuaWZmIG1vZGU+IDxSU1NJPiA8Y2hhbm5l
bCBxdWFsaXR5PiA8U0NPIGxpbms+DQogICAgICAgICAgICAgICAgPEhWMiBw
YWNrZXRzPiA8SFYzIHBhY2tldHM+IDx1LWxhdyBsb2c+IDxBLWxhdyBsb2c+
IDxDVlNEPg0KICAgICAgICAgICAgICAgIDxwYWdpbmcgc2NoZW1lPiA8dHJh
bnNwYXJlbnQgU0NPPiA8QUZIIGNhcC4gc2xhdmU+DQogICAgICAgICAgICAg
ICAgPEFGSCBjYXAuIG1hc3Rlcj4NCg0KKE5vIGVTQ08gbWVudGlvbmVkIGFi
b3ZlLCBvbmx5IDxTQ08gbGluaz4gYW5kIDx0cmFuc3BhcmVudCBTQ08+ICkN
Cg0KDQpBcHIgMjAgMTY6NDA6MTIgYXRyMiBrZXJuZWw6IHVzYiAxLTE6IG5l
dyBmdWxsIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcNCnVoY2lfaGNkIGFuZCBh
ZGRyZXNzIDMNCkFwciAyMCAxNjo0MDoxMiBhdHIyIGtlcm5lbDogdXNiIDEt
MTogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQ0KQXBy
IDIwIDE2OjQwOjE5IGF0cjIgaGNpZFs0NTI0XTogQmx1ZXRvb3RoIEhDSSBk
YWVtb24NCkFwciAyMCAxNjo0MDoyMCBhdHIyIGhjaWRbNDUyNF06IEhDSSBk
ZXYgMCByZWdpc3RlcmVkDQpBcHIgMjAgMTY6NDA6MjAgYXRyMiBoY2lkWzQ1
MjRdOiBTdGFydGluZyBTRFAgc2VydmVyDQpBcHIgMjAgMTY6NDA6MjAgYXRy
MiBoY2lkWzQ1MjRdOiBDcmVhdGlvbiBvZiBpbm90aWZ5IGNvbnRleHQgZmFp
bGVkDQpBcHIgMjAgMTY6NDA6MjAgYXRyMiBrZXJuZWw6IHBhbjA6IERyb3Bw
aW5nIE5FVElGX0ZfVUZPIHNpbmNlIG5vDQpORVRJRl9GX0hXX0NTVU0gZmVh
dHVyZS4NCkFwciAyMCAxNjo0MDoyMCBhdHIyIGhjaWRbNDUyNF06IFJlZ2lz
dGVyZWQgbWFuYWdlciBwYXRoOi9vcmcvYmx1ZXovbmV0d29yaw0KQXByIDIw
IDE2OjQwOjIwIGF0cjIgaGNpZFs0NTI0XTogUmVnaXN0ZXJlZCBzZXJ2ZXIN
CnBhdGg6L29yZy9ibHVlei9uZXR3b3JrL25hcA0KQXByIDIwIDE2OjQwOjIw
IGF0cjIgaGNpZFs0NTI0XTogUmVnaXN0ZXJlZCBzZXJ2ZXINCnBhdGg6L29y
Zy9ibHVlei9uZXR3b3JrL2duDQpBcHIgMjAgMTY6NDA6MjAgYXRyMiBoY2lk
WzQ1MjRdOiBSZWdpc3RlcmVkIHNlcnZlcg0KcGF0aDovb3JnL2JsdWV6L25l
dHdvcmsvcGFudQ0KQXByIDIwIDE2OjQwOjIwIGF0cjIgaGNpZFs0NTI0XTog
UmVnaXN0ZXJpbmcgc2VydmljZQ0KQXByIDIwIDE2OjQwOjIwIGF0cjIgaGNp
ZFs0NTI0XTogUmVnaXN0ZXJlZCBtYW5hZ2VyIHBhdGg6L29yZy9ibHVlei9z
ZXJpYWwNCkFwciAyMCAxNjo0MDoyMCBhdHIyIGhjaWRbNDUyNF06IFJlZ2lz
dGVyaW5nIHNlcnZpY2UNCkFwciAyMCAxNjo0MDoyMCBhdHIyIGhjaWRbNDUy
NF06IFJlZ2lzdGVyZWQgaW5wdXQgbWFuYWdlcg0KcGF0aDovb3JnL2JsdWV6
L2lucHV0DQpBcHIgMjAgMTY6NDA6MjAgYXRyMiBoY2lkWzQ1MjRdOiBSZWdp
c3RlcmluZyBzZXJ2aWNlDQpBcHIgMjAgMTY6NDA6MjAgYXRyMiBoY2lkWzQ1
MjRdOiBVbml4IHNvY2tldCBjcmVhdGVkOiAxNw0KQXByIDIwIDE2OjQwOjIw
IGF0cjIgaGNpZFs0NTI0XTogUmVnaXN0ZXJlZCBtYW5hZ2VyIHBhdGg6L29y
Zy9ibHVlei9hdWRpbw0KQXByIDIwIDE2OjQwOjIwIGF0cjIgaGNpZFs0NTI0
XTogUmVnaXN0ZXJpbmcgc2VydmljZQ0KQXByIDIwIDE2OjQwOjIwIGF0cjIg
aGNpZFs0NTI0XTogSENJIGRldiAwIHVwDQpBcHIgMjAgMTY6NDA6MjAgYXRy
MiBoY2lkWzQ1MjRdOiBEZXZpY2UgaGNpMCBoYXMgYmVlbiBhZGRlZA0KQXBy
IDIwIDE2OjQwOjIwIGF0cjIgaGNpZFs0NTI0XTogU3RhcnRpbmcgc2VjdXJp
dHkgbWFuYWdlciAwDQpBcHIgMjAgMTY6NDA6MjAgYXRyMiBoY2lkWzQ1MjRd
OiBEZXZpY2UgaGNpMCBoYXMgYmVlbiBhY3RpdmF0ZWQNCg0KQXByIDIwIDE5
OjM1OjE3IGF0cjIgaGNpZFs0NTI0XTogRGVmYXVsdCBwYXNza2V5IGFnZW50
ICg6MS4xLC9vcmcvYmx1ZXovcGFzc2tleV9hZ2VudF80NTY5KSByZWdpc3Rl
cmVkDQpBcHIgMjAgMTk6MzU6MjIgYXRyMiBoY2lkWzQ1MjRdOiBEZWZhdWx0
IGF1dGhvcml6YXRpb24gYWdlbnQgKDoxLjIsLy9vcmcvYmx1ZXovYXV0aF9h
Z2VudF80NTcwKSByZWdpc3RlcmVkDQoNCg0KKE1heWJlIGRlcHJlc3MgdGhl
IGhlYWRzZXQgYnV0dG9uLCBsaXN0ZW4gZm9yIHRoZSBiZWVwDQogdGhhdCBz
YXlzIGl0J3MgY29ubmVjdGVkIHRvIHRoZSBjb21wdXRlciwgaWYgeW91ciBo
ZWFkc2V0DQogd29ya3MgbGlrZSB0aGlzLikNCg0KDQpzb3ggLXQgbXAzIC9z
b21lL2ZpbGUubXAzIC10IGFsc2EgcGNtLmJsdWV0b290aA0KDQoNCg0KSSBu
b3RpY2VkIG9uIG15IG5vLXNvdW5kY2FyZCBzeXN0ZW0gdGhpcyB3b3VsZG4n
dCB3b3JrLiBCb3RoIHN5c3RlbXMNCmhhdmUgdGhlIHNhbWUgc2V0dXAsIGJ1
dCBvbmx5IHRoZSBvbmUgd2l0aCB0aGUgc291bmRjYXJkIHdvcmtzIGZvcg0K
Ymx1ZXRvb3RoIGF1ZGlvLiBTZWVtcyBsaWtlIGl0IHdvdWxkIHdvcmsgZm9y
IGJvdGgsIGFzIHRoZXkgYm90aA0KaGF2ZSBBbHNhLiBPbiB0aGUgbm8tc291
bmRjYXJkIG1hY2hpbmUgSSB1c2VkIHRoZSBkdW1teSBjYXJkIGRyaXZlcg0K
YnV0IGl0IGRpZG4ndCBtYWtlIGFueSBkaWZmZXJlbmNlIGZvciBibHVldG9v
dGguIFJlZ3VsYXIgc291bmQgDQpvdXRwdXQgZGlkIHdvcmsgdG8gdGhlIGR1
bW15IGRyaXZlciAobG9va3MgbGlrZSBzb3VuZCBpcyBwbGF5aW5nLCANCmJ1
dCBubyBzb3VuZCBkdWUgdG8gbm8gcmVhbCBjYXJkKS4NCg0KIA0KDQo=

---1287590132-580024538-1208740017=:29306
Content-Type: APPLICATION/x-gzip; name=bt-headset-kernel.patch.gz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LNX.1.00.0804202106561.29306@nge2.ngu.pk>
Content-Description: bt-headset-kernel.patch.gz
Content-Disposition: attachment; filename=bt-headset-kernel.patch.gz

H4sICPwM0EcAA2J0LTEuMi1oZWFkc2V0cy5wYXRjaACNkFFPgzAQx5/hU5wv
BgKFUhQnyyaJ8cHM6IMfoGFQB4G0y2iJxvjdbTtRN2OyvvT+vbvf/a8IIehb
rl4RibKIpDFnMl73ikkhZBM3VUvZyLiMqkjs2o1DMJ4hTBDJICH5RZanWYSn
AwG+xtgNguBE5jHuKifpH1xRAErSJA1nENg7uYSicMExoJqNtBdV5zU68ucu
6PdKcA4LMGkT0qYcGl0kOrWl69JWhsBGtNQmOyrftiyEc6PXdVnXO01BTvsC
3pnp9rVwNkIKUNwMmrvBryS8a+lQqmbwDdOjvQM6LBZw93z7RB/uH1c+3MAU
Q/7zrrkGdZL3f31rgPG2962FxaHll6sDU7aY9QOzdUcLfth/tGuapkGWUg1m
WZiQTcnr3kAp7VmSUSlotVV2731Ku3E/ATE4g0xdAgAA

---1287590132-580024538-1208740017=:29306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
---1287590132-580024538-1208740017=:29306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

---1287590132-580024538-1208740017=:29306--
