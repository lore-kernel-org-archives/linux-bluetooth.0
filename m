Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sebastiano Vigna <vigna@dsi.unimi.it>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-l4DmYVx89OVH0ws4m60G"
Message-Id: <1119525688.17872.4.camel@sliver.usr.dsi.unimi.it>
Mime-Version: 1.0
Subject: [Bluez-users] Connecting to a Nokia 6021
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
Date: Thu, 23 Jun 2005 13:21:28 +0200


--=-l4DmYVx89OVH0ws4m60G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I hope someone can help me. I have a brand new Nokia 6021 and I've been
able to set up everything--I can ping the phone, etc. However, when I
try to register the phone with my PC, everything hangs. The last output
of hcidump is

< ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 28 00 01 00                                    .(...
> ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 329 max_retrans 0 credits 0
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 28 00 01 00                                    .(...
> HCI Event: PIN Code Request (0x16) plen 6
  0000: 10 26 00 70 13 00                                 .&.p..


And them the phone times out. The interesting point is that if you look at the included hcid.conf,
I have a pin helper of my own, containing:

#!/bin/bash
echo "Request $(date)" >>/tmp/req
echo "PIN:112358"

This is never called by the stack.

I couldn't find any log anywhere to find out what's happening, so I'm
really stuck.
-- 
Ciao,

                                        seba

--=-l4DmYVx89OVH0ws4m60G
Content-Disposition: attachment; filename=hcid.conf
Content-Type: text/plain; name=hcid.conf; charset=UTF-8
Content-Transfer-Encoding: base64

Iw0KIyBIQ0kgZGFlbW9uIGNvbmZpZ3VyYXRpb24gZmlsZS4NCiMNCiMgJElkOiBoY2lkLmNvbmYs
diAxLjcgMjAwNC8xMi8xMyAxNDoxNjowMyBob2x0bWFubiBFeHAgJA0KIw0KDQojIEhDSWQgb3B0
aW9ucw0Kb3B0aW9ucyB7DQoJIyBBdXRvbWF0aWNhbGx5IGluaXRpYWxpemUgbmV3IGRldmljZXMN
CglhdXRvaW5pdCB5ZXM7DQoNCgkjIFNlY3VyaXR5IE1hbmFnZXIgbW9kZQ0KCSMgICBub25lIC0g
U2VjdXJpdHkgbWFuYWdlciBkaXNhYmxlZA0KCSMgICBhdXRvIC0gVXNlIGxvY2FsIFBJTiBmb3Ig
aW5jb21pbmcgY29ubmVjdGlvbnMNCgkjICAgdXNlciAtIEFsd2F5cyBhc2sgdXNlciBmb3IgYSBQ
SU4NCgkjDQoJc2VjdXJpdHkgdXNlcjsNCg0KCSMgUGFpcmluZyBtb2RlDQoJIyAgIG5vbmUgIC0g
UGFpcmluZyBkaXNhYmxlZA0KCSMgICBtdWx0aSAtIEFsbG93IHBhaXJpbmcgd2l0aCBhbHJlYWR5
IHBhaXJlZCBkZXZpY2VzDQoJIyAgIG9uY2UgIC0gUGFpciBvbmNlIGFuZCBkZW55IHN1Y2Nlc3Np
dmUgYXR0ZW1wdHMNCglwYWlyaW5nIG11bHRpOw0KDQoJIyBQSU4gaGVscGVyDQoJcGluX2hlbHBl
ciAvdXNyL2xvY2FsL2Jpbi9ibHVlcGluOw0KDQoJIyBELUJ1cyBQSU4gaGVscGVyDQoJZGJ1c19w
aW5faGVscGVyOw0KfQ0KDQojIERlZmF1bHQgc2V0dGluZ3MgZm9yIEhDSSBkZXZpY2VzDQpkZXZp
Y2Ugew0KCSMgTG9jYWwgZGV2aWNlIG5hbWUNCgkjICAgJWQgLSBkZXZpY2UgaWQNCgkjICAgJWgg
LSBob3N0IG5hbWUNCgluYW1lICIlaC0lZCI7DQoNCgkjIExvY2FsIGRldmljZSBjbGFzcw0KCSNj
bGFzcyAweDEyMDEwNDsNCgljbGFzcyAweDEwMDsNCg0KCSMgRGVmYXVsdCBwYWNrZXQgdHlwZQ0K
CSNwa3RfdHlwZSBESDEsRE0xLEhWMTsNCg0KCSMgSW5xdWlyeSBhbmQgUGFnZSBzY2FuDQoJaXNj
YW4gZW5hYmxlOyBwc2NhbiBlbmFibGU7DQoNCgkjIERlZmF1bHQgbGluayBtb2RlDQoJIyAgIG5v
bmUgICAtIG5vIHNwZWNpZmljIHBvbGljeSANCgkjICAgYWNjZXB0IC0gYWx3YXlzIGFjY2VwdCBp
bmNvbWluZyBjb25uZWN0aW9ucw0KCSMgICBtYXN0ZXIgLSBiZWNvbWUgbWFzdGVyIG9uIGluY29t
aW5nIGNvbm5lY3Rpb25zLA0KCSMgICAgICAgICAgICBkZW55IHJvbGUgc3dpdGNoIG9uIG91dGdv
aW5nIGNvbm5lY3Rpb25zDQoJbG0gYWNjZXB0Ow0KDQoJIyBEZWZhdWx0IGxpbmsgcG9saWN5DQoJ
IyAgIG5vbmUgICAgLSBubyBzcGVjaWZpYyBwb2xpY3kNCgkjICAgcnN3aXRjaCAtIGFsbG93IHJv
bGUgc3dpdGNoDQoJIyAgIGhvbGQgICAgLSBhbGxvdyBob2xkIG1vZGUNCgkjICAgc25pZmYgICAt
IGFsbG93IHNuaWZmIG1vZGUNCgkjICAgcGFyayAgICAtIGFsbG93IHBhcmsgbW9kZQ0KCWxwIHJz
d2l0Y2gsaG9sZCxzbmlmZixwYXJrOw0KDQoJIyBBdXRoZW50aWNhdGlvbiBhbmQgRW5jcnlwdGlv
biAoU2VjdXJpdHkgTW9kZSAzKQ0KCSNhdXRoIGVuYWJsZTsNCgkjZW5jcnlwdCBlbmFibGU7DQp9
DQo=


--=-l4DmYVx89OVH0ws4m60G--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
