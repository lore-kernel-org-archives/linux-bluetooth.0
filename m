Return-Path: <i_p_a_u_l@yahoo.com>
Message-ID: <20040816121411.26419.qmail@web50203.mail.yahoo.com>
Date: Mon, 16 Aug 2004 05:14:11 -0700 (PDT)
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [Bluez-users] Need help with PAND between 2  linux boxes
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1092657474.4375.137.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1653152341-1092658451=:9587"
List-ID: <bluez-users.lists.sourceforge.net>

--0-1653152341-1092658451=:9587
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> show us the content of /etc/bluetooth/hcid.conf and
> the output of
> "hciconfig -a".

Hi Marcel,

Here is the info:
 hciconfig -a
hci0:   Type: USB
        BD Address: 00:20:E0:75:21:DA ACL MTU: 192:8 
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:200 acl:0 sco:0 events:26 errors:0
        TX bytes:621 acl:0 sco:0 commands:22 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: ACCEPT MASTER 
        Name: 't41-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1
(0x1) LMP Subver: 0x222
        Manufacturer: Cambridge Silicon Radio (10)




	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
--0-1653152341-1092658451=:9587
Content-Type: application/octet-stream; name="hcid.conf"
Content-Transfer-Encoding: base64
Content-Description: hcid.conf
Content-Disposition: attachment; filename="hcid.conf"

IwojIEhDSSBkYWVtb24gY29uZmlndXJhdGlvbiBmaWxlLgojCiMgJElkOiBo
Y2lkLmNvbmYsdiAxLjMgMjAwMi8wNy8xOCAxODoxMjo0NiBtYXhrIEV4cCAk
CiMKCiMgSENJZCBvcHRpb25zCm9wdGlvbnMgewoJIyBBdXRvbWF0aWNhbGx5
IGluaXRpYWxpemUgbmV3IGRldmljZXMKCWF1dG9pbml0IHllczsKCgkjIFNl
Y3VyaXR5IE1hbmFnZXIgbW9kZQoJIyAgIG5vbmUgLSBTZWN1cml0eSBtYW5h
Z2VyIGRpc2FibGVkCgkjICAgYXV0byAtIFVzZSBsb2NhbCBQSU4gZm9yIGlu
Y29taW5nIGNvbm5lY3Rpb25zCgkjICAgdXNlciAtIEFsd2F5cyBhc2sgdXNl
ciBmb3IgYSBQSU4KCSMKIwlzZWN1cml0eSBhdXRvOwoJc2VjdXJpdHkgbm9u
ZTsKCSMgUGFpcmluZyBtb2RlCgkjICAgbm9uZSAgLSBQYWlyaW5nIGRpc2Fi
bGVkCgkjICAgbXVsdGkgLSBBbGxvdyBwYWlyaW5nIHdpdGggYWxyZWFkeSBw
YWlyZWQgZGV2aWNlcwoJIyAgIG9uY2UgIC0gUGFpciBvbmNlIGFuZCBkZW55
IHN1Y2Nlc3NpdmUgYXR0ZW1wdHMKCXBhaXJpbmcgbXVsdGk7CgoJIyBQSU4g
aGVscGVyCglwaW5faGVscGVyIC91c3IvYmluL2JsdWVwaW47CgkjZGJ1c19w
aW5faGVscGVyOwoKCSMgQSBkYnVzIFBJTiBkYWVtb24gY2FuIGJlIGZvdW5k
IGF0CgkjIGZ0cDovL2Z0cC5oYW5kaGVsZHMub3JnL3B1Yi9wcm9qZWN0cy9n
cGUvc291cmNlL2JsdWV6LXBpbi0wLjIwLnRhci5negp9CgojIERlZmF1bHQg
c2V0dGluZ3MgZm9yIEhDSSBkZXZpY2VzCmRldmljZSB7CgkjIExvY2FsIGRl
dmljZSBuYW1lCgkjICAgJWQgLSBkZXZpY2UgaWQKCSMgICAlaCAtIGhvc3Qg
bmFtZQoJbmFtZSAiJWgtJWQiOwoKCSMgTG9jYWwgZGV2aWNlIGNsYXNzCglj
bGFzcyAweDEyMDEwNDsKCgkjIERlZmF1bHQgcGFja2V0IHR5cGUKCSNwa3Rf
dHlwZSBESDEsRE0xLEhWMTsKCgkjIElucXVpcnkgYW5kIFBhZ2Ugc2NhbgoJ
aXNjYW4gZW5hYmxlOyBwc2NhbiBlbmFibGU7CgoJIyBEZWZhdWx0IGxpbmsg
bW9kZQoJIyAgIG5vbmUgICAtIG5vIHNwZWNpZmljIHBvbGljeSAKCSMgICBh
Y2NlcHQgLSBhbHdheXMgYWNjZXB0IGluY29taW5nIGNvbm5lY3Rpb25zCgkj
ICAgbWFzdGVyIC0gYmVjb21lIG1hc3RlciBvbiBpbmNvbWluZyBjb25uZWN0
aW9ucywKCSMgICAgICAgICAgICBkZW55IHJvbGUgc3dpdGNoIG9uIG91dGdv
aW5nIGNvbm5lY3Rpb25zCgkjCgkjbG0gYWNjZXB0LG1hc3RlcjsKCSMKCWxt
IGFjY2VwdCxtYXN0ZXI7CgoJIyBEZWZhdWx0IGxpbmsgcG9saWN5CgkjICAg
bm9uZSAgICAtIG5vIHNwZWNpZmljIHBvbGljeQoJIyAgIHJzd2l0Y2ggLSBh
bGxvdyByb2xlIHN3aXRjaAoJIyAgIGhvbGQgICAgLSBhbGxvdyBob2xkIG1v
ZGUKCSMgICBzbmlmZiAgIC0gYWxsb3cgc25pZmYgbW9kZQoJIyAgIHBhcmsg
ICAgLSBhbGxvdyBwYXJrIG1vZGUKCSMKCSNscCBob2xkLHNuaWZmOwoJIwoJ
bHAgaG9sZCxzbmlmZixwYXJrLHJzd2l0Y2g7CgoJIyBBdXRoZW50aWNhdGlv
biBhbmQgRW5jcnlwdGlvbgoJYXV0aCBkaXNhYmxlOwoJZW5jcnlwdCBkaXNh
YmxlOwp9Cg==

--0-1653152341-1092658451=:9587--
