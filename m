Return-Path: <i_p_a_u_l@yahoo.com>
Message-ID: <20040816122111.9620.qmail@web50209.mail.yahoo.com>
Date: Mon, 16 Aug 2004 05:21:11 -0700 (PDT)
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [Bluez-users] Need help with PAND between 2  linux boxes
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1092657474.4375.137.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1963010345-1092658871=:9447"
List-ID: <bluez-users.lists.sourceforge.net>

--0-1963010345-1092658871=:9447
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> show us the content of /etc/bluetooth/hcid.conf and
> the output of
> "hciconfig -a".
> 

And from the other side:
 hciconfig -a
hci0:   Type: USB
        BD Address: 00:20:E0:73:EB:F7 ACL MTU: 192:8 
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:224 acl:0 sco:0 events:28 errors:0
        TX bytes:609 acl:0 sco:0 commands:22 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: ACCEPT MASTER 
        Name: 'r50p-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1
(0x1) LMP Subver: 0x222
        Manufacturer: Cambridge Silicon Radio (10)




		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
--0-1963010345-1092658871=:9447
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
ZTsKCgkjIFBhaXJpbmcgbW9kZQoJIyAgIG5vbmUgIC0gUGFpcmluZyBkaXNh
YmxlZAoJIyAgIG11bHRpIC0gQWxsb3cgcGFpcmluZyB3aXRoIGFscmVhZHkg
cGFpcmVkIGRldmljZXMKCSMgICBvbmNlICAtIFBhaXIgb25jZSBhbmQgZGVu
eSBzdWNjZXNzaXZlIGF0dGVtcHRzCglwYWlyaW5nIG11bHRpOwoKCSMgUElO
IGhlbHBlcgoJcGluX2hlbHBlciAvdXNyL2Jpbi9ibHVlcGluOwoJI2RidXNf
cGluX2hlbHBlcjsKCgkjIEEgZGJ1cyBQSU4gZGFlbW9uIGNhbiBiZSBmb3Vu
ZCBhdAoJIyBmdHA6Ly9mdHAuaGFuZGhlbGRzLm9yZy9wdWIvcHJvamVjdHMv
Z3BlL3NvdXJjZS9ibHVlei1waW4tMC4yMC50YXIuZ3oKfQoKIyBEZWZhdWx0
IHNldHRpbmdzIGZvciBIQ0kgZGV2aWNlcwpkZXZpY2UgewoJIyBMb2NhbCBk
ZXZpY2UgbmFtZQoJIyAgICVkIC0gZGV2aWNlIGlkCgkjICAgJWggLSBob3N0
IG5hbWUKCW5hbWUgIiVoLSVkIjsKCgkjIExvY2FsIGRldmljZSBjbGFzcwoJ
Y2xhc3MgMHgxMjAxMDQ7CgoJIyBEZWZhdWx0IHBhY2tldCB0eXBlCgkjcGt0
X3R5cGUgREgxLERNMSxIVjE7CgoJIyBJbnF1aXJ5IGFuZCBQYWdlIHNjYW4K
CWlzY2FuIGVuYWJsZTsgcHNjYW4gZW5hYmxlOwoKCSMgRGVmYXVsdCBsaW5r
IG1vZGUKCSMgICBub25lICAgLSBubyBzcGVjaWZpYyBwb2xpY3kgCgkjICAg
YWNjZXB0IC0gYWx3YXlzIGFjY2VwdCBpbmNvbWluZyBjb25uZWN0aW9ucwoJ
IyAgIG1hc3RlciAtIGJlY29tZSBtYXN0ZXIgb24gaW5jb21pbmcgY29ubmVj
dGlvbnMsCgkjICAgICAgICAgICAgZGVueSByb2xlIHN3aXRjaCBvbiBvdXRn
b2luZyBjb25uZWN0aW9ucwoJIwoJI2xtIGFjY2VwdCxtYXN0ZXI7CgkjCgls
bSBhY2NlcHQsbWFzdGVyOwoKCSMgRGVmYXVsdCBsaW5rIHBvbGljeQoJIyAg
IG5vbmUgICAgLSBubyBzcGVjaWZpYyBwb2xpY3kKCSMgICByc3dpdGNoIC0g
YWxsb3cgcm9sZSBzd2l0Y2gKCSMgICBob2xkICAgIC0gYWxsb3cgaG9sZCBt
b2RlCgkjICAgc25pZmYgICAtIGFsbG93IHNuaWZmIG1vZGUKCSMgICBwYXJr
ICAgIC0gYWxsb3cgcGFyayBtb2RlCgkjCgkjbHAgaG9sZCxzbmlmZjsKCSMK
CWxwIGhvbGQsc25pZmYscGFyayxyc3dpdGNoOwoKCSMgQXV0aGVudGljYXRp
b24gYW5kIEVuY3J5cHRpb24KCWF1dGggZGlzYWJsZTsKCWVuY3J5cHQgZGlz
YWJsZTsKfQo=

--0-1963010345-1092658871=:9447--
