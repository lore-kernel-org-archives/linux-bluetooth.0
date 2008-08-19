Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Aug 2008 00:02:26 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <48A5C79D.3090007@gmail.com>
Message-ID: <alpine.LNX.1.10.0808182106580.32359@nge2.ngu.pk>
References: <b7bab9650808101623h1b9ca61fhe4725368c4987e0d@mail.gmail.com>
	<d89ddf300808110209k46949860n3c525a7dd7e7b341@mail.gmail.com>
	<48A401B2.1070705@gmail.com> <48A5C79D.3090007@gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1287618291-538639127-1219118547=:32502"
Subject: Re: [Bluez-users] bluetooth tethering to at&t phone issues
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

---1287618291-538639127-1219118547=:32502
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII


On Fri, 15 Aug 2008, Xamindar wrote:

-> Does anyone know how to set up bluetooth pan the *new* way? As in not using
-> the old daemon? I searched the blues wiki and found that I need to create a
-> /etc/bluetooth/network.conf file but it fails to explain what to do after
-> that. All else I could find was dbus info on setting it up which suggests
-> there should he a program or script out there to do this. Does anyone know?

With pand? I'm not aware of an old daemon, just the current 'pand' that is 
still in the sources. The subject of this message talks of tethering, which is 
with rfcomm & pppd or dund calling pppd itself. I started to play around with 
the file called ppporc, too, but still not sure what it does exactly. Anyway, 
with pand you need to know the side of the connection you are on, and if the 
serving side, whether you want to do NAP or GN. I did write scripts for this, 
local - not meant for other systems but you can get an idea of from them. Hope 
this is what you meant, if not, maybe others can make use of the scripts at 
least.

(See files attached, 1-4)


An odd thing is, when I use --role NAP, I get the interface created under the 
[GN] block of the network.conf file. Yet the sdp record also says "NAP". The 
/etc/bluetooth/nap-service I start by hand; not sure if it would auto-exec if 
another pand client was looking for a NAP service.



network.conf

[General]
Disable=
DisableSecurity=false
Interface=hci0

[PANU Role]
Interface=bnep%d
Script=/etc/bluetooth/panu-client

[GN Role]
Interface=pan0
Script=/etc/bluetooth/nap-service

[NAP Role]
Interface=pan1
Script=/etc/bluetooth/nap-service




You'll need the bridge-utils for brctl, they're on sourceforge.net 
(http://bridge.sourceforge.net/). Some of the syntax is likely Zsh-specific, 
probably [ ${status} = "0" ] is. If re-writing for other shells you'll need a 
way to get the error codes of commands. I don't use these scripts a whole lot, 
so likely there are bugs; I leave the debugging to whomever. I saw an 
"RTnetlink answers: File exists" error today, but it's harmless. You'll also 
need something to handle pairing.


10: pan0: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc noqueue 
state UNKNOWN
     link/ether e2:1a:fc:f3:45:9f brd ff:ff:ff:ff:ff:ff
     inet 192.168.20.1/24 brd 192.168.20.255 scope global pan0

Service Name: Network Access Point
Service Description: BlueZ PAN Service
Service Provider: BlueZ PAN
Service RecHandle: 0x10005
Service Class ID List:
   "Network Access Point" (0x1116)
Protocol Descriptor List:
   "L2CAP" (0x0100)
     PSM: 15
   "BNEP" (0x000f)
     Version: 0x0100
     SEQ16: 800 806
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
Profile Descriptor List:
   "Network Access Point" (0x1116)
     Version: 0x0100



Remove the bridge later:

ip link set pan0 down
brctl delbr pan0


-> Or is this a closely guarded secret that only the bluez devs know about?

Yes. And now that you know, you can't be allowed to leave here alive. ;)


---1287618291-538639127-1219118547=:32502
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=ifup-pan0
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LNX.1.10.0808190002260.32502@nge2.ngu.pk>
Content-Description: ifup-pan0
Content-Disposition: attachment; filename=ifup-pan0

IyEvYmluL3pzaA0KIyMNCiMjIEF1dG9tYXRpY2FsbHkgYWRkIGJuZXAncyAo
dGhhdCdzIFBBTlUgY2xpZW50cyB0byB5b3UpDQojIyB0byB0aGUgcGFuMCBi
cmlkZ2UuIFRoaXMgc2NyaXB0IHdpbGwgZ2V0IGNhbGxlZCBieSBwYW5kDQoj
IyB3aXRoIGFyZ3M6DQojIw0KIyMgMD0gc2NyaXB0IG5hbWUgMSA9IGRldmlj
ZSAobGlrZSBibmVwTikgYW5kIGFyZzIgPSBjb25uZWN0aW9uIEJUIGFkZHJl
c3MNCiMjDQojIyBBc3N1bWVkOg0KIyMJMS4gYmx1ZXRvb3RoIHJ1bm5pbmcN
CiMjCTIuIHBhbjAgYnJpZGdlIGlzIGFkZHJlc3NlZCBhbmQgcm91dGVkIGNv
cnJlY3RseSANCiMjICAgICAgICAgKGRvbmUgaW4gcGFudS1jbGllbnQgc2Ny
aXB0KQ0KIyMJMy4gcGFuMCBzaG91bGQgYmUgdXAsIGJ1dCB3ZSBjYW4gInVw
IiBpdCBhZ2FpbiB3aXRob3V0IGhhcm0NCg0KIyBBbm5vdW5jZQ0KZWNobyAi
WytdIEFkZGluZyBjbGllbnQgJDIgdG8gYnJpZGdlIHBhbjAgdmlhIGRldmlj
ZSAkMSAuIg0KDQojIHBhbjAgZXhpc3RzIHdoZW4gYmx1ZXRvb3RoIHN1YnN5
c3RlbSBzdGFydHMgYXV0b21hZ2ljYWxseQ0KIyB3ZSBvbmx5IG5lZWQgYWRk
IGNsaWVudHMgdG8gaXQgYW5kIG1ha2Ugc3VyZSBpdCdzIGNvbmZpZ3VyZWQg
cmlnaHQNCiMgU1RQPyBJZiB5b3UgaGF2ZSBvdGhlciBicmlkZ2VzIGFzIHdl
bGwsIHlvdSBtaWdodCB3YW50IHRvIHR1cm4gb24gU1RQIGhlcmUuDQpicmN0
bCBhZGRpZiBwYW4wICQxDQppcCBsaW5rIHNldCAkMSB1cA0KDQojIExvZyBv
dXIgc3RhdHVzIA0KaWYgWyAke3N0YXR1c30gPSAiMCIgXTsgdGhlbg0KCSMg
T0ssIG5vIGVycm9ycw0KCWVjaG8gIlsrXSBBZGRlZCAkMiB0byBwYW4wIHZp
YSAkMSINCglsb2dnZXIgLXAgZGFlbW9uLmluZm8gLXQgcGFuZCAtLSAiQWRk
ZWQgJDIgdG8gcGFuMCB2aWEgJDEiDQplbHNlDQoJIyBFcnJvcnMuIFVzdWFs
bHkgdGhpcyBpcyBiZWNhdXNlIGJuZXAwIGhhcyBzb21ldGhpbmcgd3Jvbmcg
d2l0aCBpdA0KCWVjaG8gIlstXSBFcnJvciBhZGRpbmcgY2xpZW50ICQyIHRv
IHBhbjAgb24gJDEiDQoJbG9nZ2VyIC1wIGRhZW1vbi5lcnJvciAtdCBwYW5k
IC0tICJFcnJvciBhZGRpbmcgY2xpZW50ICQyIHRvIHBhbjAgb24gJDEiDQoJ
DQoJIyBJbmRpY2F0ZSBleGl0LXdpdGgtZmFpbHVyZSANCglleGl0IDENCmZp
DQoNCg==

---1287618291-538639127-1219118547=:32502
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=panu-client
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LNX.1.10.0808190002261.32502@nge2.ngu.pk>
Content-Description: panu-client
Content-Disposition: attachment; filename=panu-client

IyEvYmluL3pzaA0KIyMNCiMjDQojIyBTY3JpcHQgdG8gY29ubmVjdCB0aGlz
IG1hY2hpbmUgdmlhIGJsdWV0b290aA0KIyMgYXMgYSBQQU5VIGNsaWVudCB0
byBhbm90aGVyIHN5c3RlbSBydW5uaW5nIHRoZSANCiMjIFBBTiAoTkFQL0dO
KSBzZXJ2aWNlLiBJdCB3aWxsIGNyZWF0ZSBhIGJyaWRnZQ0KIyMgYW5kIGFk
ZCBpbnRlcmZhY2VzIHRvIGl0Lg0KIyMNCiMjIE5lZWRlZCB0b29sczoNCiMj
ICAgaXByb3V0ZTINCiMjICAgYnJpZGdlLXV0aWxzDQojIyAgIGJsdWV6LXV0
aWxzL2xpYnMNCiMjDQojIyBOb3RlOiBTb21lIHNoZWxsIGNvbnN0cnVjdHMg
bWlnaHQgYmUgWnNoIHNwZWNpZmljLg0KIyMgICAgICAgSSBkZW55IHRoZSBl
eGlzdGFuY2Ugb2YgYmFzaC4NCg0KIyBDYWxsIHRoZSBwYW5kIGRhZW1vbiB0
byBzZWFyY2ggYmx1ZXRvb3RoIGFpcnNwYWNlIGZvciBhIFBBTiANCiMgcnVu
bmluZyB0aGUgTkFQIHNlcnZpY2UuIFJlY29yZCBQSUQuIEVuY3J5cHQvc2Vj
dXJlIHByb2JhYmx5DQojIHJlcXVpcmVzIHBhc3NrZXkvYXV0aCBhZ2VudHMg
dG8gYmUgcnVubmluZyBvbiBib3RoIHNpZGVzIGFuZA0KIyBib3RoIHBhbmQn
cyB0byBoYXZlIHRob3NlIHBhcmFtZXRlcnMgc2VsZWN0ZWQuDQpwYW5kIC0t
c2VhcmNoIC0tYXV0b3phcCAtLXJvbGUgUEFOVSAtLXNlcnZpY2UgTkFQICAt
LXBpZGZpbGUgL3Zhci9ydW4vcGFuZC5waWQgLS1kZXZ1cCAvZXRjL2JsdWV0
b290aC9pZnVwLXBhbjAgLS1kZXZkb3duIC9ldGMvYmx1ZXRvb3RoL2lmZG93
bi1wYW4wDQoNCmlmIFsgJHtzdGF0dXN9IC1lcSAiMCIgXTsgdGhlbiANCiAg
ICAjIFdlIGZvdW5kIHRoZSBzZXJ2aWNlDQogICAgZWNobyAnWytdIE5BUCBz
ZXJ2aWNlIGxvY2F0ZWQgYW5kIGNvbm5lY3Rpb24gbWFkZS4gJw0KICAgIGVj
aG8gJyAgICBQcm9jZWVkaW5nIHdpdGggbmV0d29yay1sYXllciBjb25maWd1
cmF0aW9uLicNCg0KICAgICMgQ3JlYXRlIGFuIGVtcHR5IGJyaWRnZS4gVGhl
IHN3aXRjaCAtLWRldnVwIC9ldGMvYmx1ZXRvb3RoL2lmdXAtcGFuMA0KICAg
ICMgd2lsbCBhZGQgdGhlIGFjdHVhbCBpbnRlcmZhY2VzIGludG8gdGhlIGJy
aWRnZS4NCiAgICAjIElmIHBhbjAgYWxyZWFkeSBoYXMgaGFkIHRoaXMgYWRk
cmVzcyBhZGRlZCBiZWZvcmUsIHlvdSdsbCBnZXQgYSANCiAgICAjIFJUTkVU
TElOSyBhbnN3ZXJzOiBmaWxlIGV4aXN0cyBlcnJvciwgd2hpY2ggaXMgaGFy
bWxlc3MgaW4gdGhpcyBjYXNlLg0KICAgIGlwIGFkZHIgYWRkIDE5Mi4xNjgu
MjAuMi8yNCBicm9hZGNhc3QgKyBkZXYgcGFuMCANCiAgICBpcCBsaW5rIHNl
dCBwYW4wIHVwICAgICANCg0KICAgICMgQWN0aXZhdGUgU1RQPyBUaGlzIHdp
bGwgbWFrZSBpbml0aWFsIGNvbm5lY3Rpb25zIHRha2UgYSBiaXQgbG9uZ2Vy
Lg0KICAgICMgUHJvYmFibHkgb25seSBuZWVkZWQgd2hlbiB5b3UgYXJlIGRl
YWxpbmcgd2l0aCBtb3JlIHRoYW4gb25lIGJyaWRnZQ0KICAgICMgdG9nZXRo
ZXIuDQogICAgI2JyY3RsIHN0cCBwYW4wIG9uICAgICAgICAgDQoNCiAgICAj
IERlZmF1bHQgcm91dGU/IElmIHRoZXJlJ3Mgbm90IG9uZSwgYWRkIGl0Lg0K
ICAgICMgQW5vdGhlciBvcHRpb24gaXMgdG8gYWx3YXlzIHJlcGxhY2UgaXQs
IGJ1dCB0aGF0IG1pZ2h0IG5vdCBiZQ0KICAgICMgZGVzaXJhYmxlIGluIG1h
bnkgaW5zdGFuY2VzLg0KICAgIGlmICEgaXAgcm91dGUgc2hvdyB8IGdyZXAg
LXEgImRlZmF1bHQiOyB0aGVuDQoJZWNobyAnWytdIE5vIGRlZmF1bHQgcm91
dGUgbGlzdGVkIG9uIHRoaXMgc3lzdGVtLiAnDQoJZWNobyAnICAgIFdpbGwg
dHJ5IHRvIGFzc2lnbiBwYW4wIGFzIGRlZmF1bHQuJw0KCWlwIHJvdXRlIGFk
ZCBkZWZhdWx0IGRldiBwYW4wDQogICAgZmkNCmVsc2UNCiAgICAjIE5vIE5B
UCBzZXJ2aWNlLCBubyBjb25uZWN0aW9uLCBldGMuIE5vIGx1Y2suDQogICAg
ZWNobyAnWy1dIE5vIE5BUCBzZXJ2aWNlLCBmYWlsZWQgQlQgY29ubmVjdGlv
biwgb3IgcGxhaW4tb3V0Jw0KICAgIGVjaG8gJyAgICBmYWlsZWQgZm9yIHNv
bWUgcmVhc29uIG9yIGFub3RoZXIuICcNCiAgICANCiAgICAjIEluZGljYXRl
IGZhaWx1cmUgb24gZXhpdA0KICAgIGV4aXQgMQ0KZmkNCg0K

---1287618291-538639127-1219118547=:32502
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=ifdown-pan0
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LNX.1.10.0808190002262.32502@nge2.ngu.pk>
Content-Description: ifdown-pan0
Content-Disposition: attachment; filename=ifdown-pan0

IyEvYmluL3pzaA0KIyMNCiMjIFJlbW92ZSBpbnRlcmZhY2VzIGZyb20gdGhl
IHBhbjAgYnJpZGdlLg0KIyMgQXJnczoNCiMjIDA9IHNjcmlwdCBuYW1lIDEg
PSBkZXZpY2UgKGxpa2UgYm5lcE4pIGFuZCBhcmcyID0gY29ubmVjdGlvbiBC
VCBhZGRyZXNzDQojIw0KDQojIEFubm91bmNlDQplY2hvICJbK10gUmVtb3Zp
bmcgY2xpZW50ICQyIGZyb20gYnJpZGdlIHBhbjAgYXQgZGV2aWNlICQxIC4i
DQoNCmJyY3RsIGRlbGlmIHBhbjAgJDENCmlwIGxpbmsgc2V0ICQxIGRvd24N
Cg0KIyBMb2cgb3VyIHN0YXR1cyANCmlmIFsgJHtzdGF0dXN9ID0gIjAiIF07
IHRoZW4NCgkjIE9LLCBubyBlcnJvcnMNCgllY2hvICJbK10gUmVtb3ZlZCAk
MiBmcm9tIHBhbjAgYXQgJDEiDQoJbG9nZ2VyIC1wIGRhZW1vbi5pbmZvIC10
IHBhbmQgLS0gIlJlbW92ZWQgJDIgZnJvbSBwYW4wIGF0ICQxIg0KZWxzZQ0K
CSMgRXJyb3JzLiBVc3VhbGx5IHRoaXMgaXMgYmVjYXVzZSBibmVwMCBoYXMg
c29tZXRoaW5nIHdyb25nIHdpdGggaXQNCgllY2hvICJbLV0gRXJyb3IgcmVt
b3ZpbmcgY2xpZW50ICQyIGZyb20gcGFuMCBvbiAkMSINCglsb2dnZXIgLXAg
ZGFlbW9uLmVycm9yIC10IHBhbmQgLS0gIkVycm9yIHJlbW92aW5nIGNsaWVu
dCAkMiBmcm9tIHBhbjAgb24gJDEiDQoJDQoJIyBJbmRpY2F0ZSBleGl0LXdp
dGgtZmFpbHVyZSANCglleGl0IDENCmZpDQoNCg==

---1287618291-538639127-1219118547=:32502
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=nap-service
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LNX.1.10.0808190002263.32502@nge2.ngu.pk>
Content-Description: nap-service
Content-Disposition: attachment; filename=nap-service

IyEvYmluL3pzaA0KIyMNCiMjIFNjcmlwdCB0byBzZXQgdXAgYSBQQU4gTkFQ
IHNlcnZpY2UgYW5kIGdldCBpdCByZWFkeQ0KIyMgdG8gdGFrZSBjb25uZWN0
aW5nIGNsaWVudHMuDQojIw0KIyMgQXNzdW1lZDoNCiMjCTEuIHBhbiBicmlk
Z2VzIGV4aXN0IChhZGRlZCBieSBibHVldG9vdGggc3Vic3lzdGVtIGN1cnJl
bnRseSkNCiMjIAkyLiBwYW4gYnJpZGdlcyB3aWxsIHVzZSBwYW4wID0gMTky
LjE2OC4yMC4wLzI0IHN1Ym5ldCAgDQojIwkgICANCg0KDQojIFRoZSBibHVl
dG9vdGggYWRkcmVzcyBvZiB0aGUgc3lzdGVtJ3MgYWRhcHRlciAoaGNpMCkN
CmhjaV9kZXZpY2U9IjAwOjBBOjNBOjdDOkJFOkE1Ig0KDQojIEFubm91bmNl
DQplY2hvICdbK10gSW5pdGlhbGl6aW5nIEJsdWV0b290aCBOZXR3b3JrIEFj
Y2VzcyBQb2ludCBzZXJ2aWNlLicNCg0KIyBOb3cgZXhlYyB0aGUgYWN0dWFs
IGRhZW1vbi4gTWFrZSBzdXJlLCBpZiBydW5uaW5nIHRoaXMgc2NyaXB0IHNl
dmVyYWwNCiMgdGltZXMsIHRoZXJlIGlzIG9ubHkgb25lIE5BUCBzZXJ2aWNl
LiBJIGZvdW5kIHRoYXQgd2hlbiBwYW5kIGV4aXRzIA0KIyBzb21ldGltZXMs
IGl0IGRpZCBub3QgY2xlYXIgb3V0IHRoZSBOQVAgc2VydmljZSBmcm9tIFNE
UC4gWW91IG1heQ0KIyBuZWVkIHRvIGRlbGV0ZSB0aGVtIGJ5IGhhbmQsIGJ5
IHRoZWlyIFNlcnZpY2UgUmVjb3JkOg0KIyAgICBTZXJ2aWNlIFJlY0hhbmRs
ZTogMHgxMDAwMSAgDQojICAgIHNkcHRvb2wgZGVsIDB4MTAwMDENCiMgd291
bGQgZGVsZXRlIHRoZSBzZXJ2aWNlIHJlZ2lzdGVyZWQgd2l0aCAweDEwMDAx
IGFzIGl0cyBSZWNIYW5kbGUuDQpwYW5kIC0tZGV2aWNlICRoY2lfZGV2aWNl
IC0tbGlzdGVuIC0tcm9sZSBOQVAgLS1tYXN0ZXIgLS1waWRmaWxlIC92YXIv
cnVuL3BhbmQucGlkIC0tZGV2dXAgL2V0Yy9ibHVldG9vdGgvaWZ1cC1wYW4w
IC0tZGV2ZG93biAvZXRjL2JsdWV0b290aC9pZmRvd24tcGFuMA0KIA0KaWYg
WyAke3N0YXR1c30gLWVxICIwIiBdOyB0aGVuDQoJIyBDb21tYW5kIHN1Y2Nl
c3NmdWwuIFByb2NlZWQuDQoJZWNobyAnWytdIENvbm5lY3RlZC4gTkFQIHNl
cnZpY2Ugc3RhcnRlZC4gJw0KDQoJIyBNYWtlIHN1cmUgcGFuMCBpcyBmb3J3
YXJkaW5nIHRyYWZmaWMgZm9yIG91ciBjbGllbnRzDQoJc3lzY3RsIC13IG5l
dC5pcHY0LmNvbmYucGFuMC5mb3J3YXJkaW5nPTENCg0KCSMgQWRkIGFuIGFk
ZHJlc3MgYW5kIGJyb2FkY2FzdCB0byBwYW4wDQoJaXAgYWRkciBhZGQgMTky
LjE2OC4yMC4yLzI0IGJyb2FkY2FzdCArIGRldiBwYW4wDQoNCgkjIE1hcmsg
aXQgZHluYW1pYywgYmVjYXVzZSBpdCBpcyB0YWtpbmcvcmVtb3ZpbmcgY2xp
ZW50cyBvbiB0aGUgZmx5DQoJaXAgbGluayBzZXQgcGFuMCBkeW5hbWljIG9u
DQoNCgkjIFVzZSBTVFAgb24gcGFuMD8NCgkjYnJjdGwgc3RwIHBhbjAgb24N
Cg0KCSMgVXAgaXQuIFRoaXMgc2hvdWxkIGFkZCB0aGUgcm91dGUgZm9yIGl0
IHRvbw0KCSMgKDE5Mi4xNjguMjAuMC8yNCBkZXYgcGFuMCAgcHJvdG8ga2Vy
bmVsICBzY29wZSBsaW5rICBzcmMgMTkyLjE2OC4yMC4xMCkNCglpcCBsaW5r
IHNldCBwYW4wIHVwDQplbHNlDQoJIyBGYWlsZWQgdG8gZ2V0IHBhbmQgc2V0
IHVwLg0KCWVjaG8gJ1stXSBGYWlsZWQgdG8gc2V0IHVwIE5BUCBzZXJ2aWNl
LicNCglleGl0IDENCmZpDQoNCg==

---1287618291-538639127-1219118547=:32502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
---1287618291-538639127-1219118547=:32502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

---1287618291-538639127-1219118547=:32502--
