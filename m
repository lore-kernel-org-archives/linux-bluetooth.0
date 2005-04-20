Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <e9a6e82b050420074245382ddd@mail.gmail.com>
From: Stefan Magdalinski <smagdali@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1858_8515069.1114008130708"
Subject: [Bluez-users] Bluez + 6630 rfcomm was working, suddenly died.
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
Date: Wed, 20 Apr 2005 15:42:10 +0100

------=_Part_1858_8515069.1114008130708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I had bluez + ubuntu hoary making a ppp connection over bluetooth to
my 6630, just fine for a few days, by following the instructions here:

http://www.teaparty.net/technotes/blue-gprs.html

and then suddenly it broke.

now, when I do
'pppd call gprs', it just returns, the phone never prompts me to
accept the connection, and no connection is made.

it seems to be communicating:

 rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 clean
root@stefvaio:~ # pppd call gprs
root@stefvaio:~ # rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
root@stefvaio:~ # rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
root@stefvaio:~ # rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
root@stefvaio:~ # rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
root@stefvaio:~ # rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
root@stefvaio:~ # rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
root@stefvaio:~ # rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
root@stefvaio:~ # rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 disconnecting [tty-attached]
root@stefvaio:~ # rfcomm show
rfcomm0: 00:12:62:DC:EA:63 channel 1 closed
root@stefvaio:~ #

but it doesn't seem able to make the connection anymore

I did a couple of things (overexcited by the ease with which I got it
working), that might have caused this.

I tried to re-pair the phone with the laptop, because I wanted to
change the name of the phone.  So I deleted the pairing on the phone,
and then the /etc/bluetooth/link_key . Now when I re-pair, it finds
the device, but just hangs with 'waiting for stefvaio-0', and then
'says unable to pair' . The phone still works fine with another
machine running OSX (and I realise you can change the name without
re-pairing. woe is me)

so it looks like pairing is the cause of the problem.

How do I re-pair the phone with my laptop, short of reinstalling everything=
?=20

where should I  be looking for further diagnostics?

I also changed my hcid.conf to try and get my palm sync working too,
so that may have caused the problem.

I have attached the hcid.conf in case it's glaringly obvious.

This is a shame. I've waited *years* for my phone to become a decent
access device, and then after a weekend I've broken it.

------=_Part_1858_8515069.1114008130708
Content-Type: application/octet-stream; name="hcid.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid.conf"

IwojIEhDSSBkYWVtb24gY29uZmlndXJhdGlvbiBmaWxlLgojCiMgJElkOiBoY2lkLmNvbmYsdiAx
LjQgMjAwNC8wNC8yOSAyMDoxNDoyMSBob2x0bWFubiBFeHAgJAojCgojIEhDSWQgb3B0aW9ucwpv
cHRpb25zIHsKCSMgQXV0b21hdGljYWxseSBpbml0aWFsaXplIG5ldyBkZXZpY2VzCglhdXRvaW5p
dCB5ZXM7CgoJIyBTZWN1cml0eSBNYW5hZ2VyIG1vZGUKCSMgICBub25lIC0gU2VjdXJpdHkgbWFu
YWdlciBkaXNhYmxlZAoJIyAgIGF1dG8gLSBVc2UgbG9jYWwgUElOIGZvciBpbmNvbWluZyBjb25u
ZWN0aW9ucwoJICAgdXNlciAtIEFsd2F5cyBhc2sgdXNlciBmb3IgYSBQSU4KCSMKCXNlY3VyaXR5
IGF1dG87CgoJIyBQYWlyaW5nIG1vZGUKCSMgICBub25lICAtIFBhaXJpbmcgZGlzYWJsZWQKCSMg
ICBtdWx0aSAtIEFsbG93IHBhaXJpbmcgd2l0aCBhbHJlYWR5IHBhaXJlZCBkZXZpY2VzCgkjICAg
b25jZSAgLSBQYWlyIG9uY2UgYW5kIGRlbnkgc3VjY2Vzc2l2ZSBhdHRlbXB0cwoJcGFpcmluZyBt
dWx0aTsKCgkjIFBJTiBoZWxwZXIKCSNwaW5faGVscGVyIC91c3IvYmluL2JsdWV6LXBpbjsKCXBp
bl9oZWxwZXIgL3Vzci9sb2NhbC9iaW4vcGluaGVscGVyLnNoOwoJIyBELUJ1cyBQSU4gaGVscGVy
CgkjZGJ1c19waW5faGVscGVyOwp9CgojIERlZmF1bHQgc2V0dGluZ3MgZm9yIEhDSSBkZXZpY2Vz
CmRldmljZSB7CgkjIExvY2FsIGRldmljZSBuYW1lCgkjICAgJWQgLSBkZXZpY2UgaWQKCSMgICAl
aCAtIGhvc3QgbmFtZQoJbmFtZSAiJWgtJWQiOwoKCSMgTG9jYWwgZGV2aWNlIGNsYXNzCgljbGFz
cyAweDEwMDsKCgkjIERlZmF1bHQgcGFja2V0IHR5cGUKCSNwa3RfdHlwZSBESDEsRE0xLEhWMTsK
CgkjIElucXVpcnkgYW5kIFBhZ2Ugc2NhbgoJaXNjYW4gZW5hYmxlOyBwc2NhbiBlbmFibGU7CgoJ
IyBEZWZhdWx0IGxpbmsgbW9kZQoJIyAgIG5vbmUgICAtIG5vIHNwZWNpZmljIHBvbGljeSAKCSMg
ICBhY2NlcHQgLSBhbHdheXMgYWNjZXB0IGluY29taW5nIGNvbm5lY3Rpb25zCgkjICAgbWFzdGVy
IC0gYmVjb21lIG1hc3RlciBvbiBpbmNvbWluZyBjb25uZWN0aW9ucywKCSMgICAgICAgICAgICBk
ZW55IHJvbGUgc3dpdGNoIG9uIG91dGdvaW5nIGNvbm5lY3Rpb25zCgkjCgkjbG0gYWNjZXB0LG1h
c3RlcjsKCSMKCWxtIGFjY2VwdDsKCgkjIERlZmF1bHQgbGluayBwb2xpY3kKCSMgICBub25lICAg
IC0gbm8gc3BlY2lmaWMgcG9saWN5CgkjICAgcnN3aXRjaCAtIGFsbG93IHJvbGUgc3dpdGNoCgkj
ICAgaG9sZCAgICAtIGFsbG93IGhvbGQgbW9kZQoJIyAgIHNuaWZmICAgLSBhbGxvdyBzbmlmZiBt
b2RlCgkjICAgcGFyayAgICAtIGFsbG93IHBhcmsgbW9kZQoJIwoJI2xwIGhvbGQsc25pZmY7Cgkj
CglscCByc3dpdGNoLGhvbGQsc25pZmYscGFyazsKCgkjIEF1dGhlbnRpY2F0aW9uIGFuZCBFbmNy
eXB0aW9uCglhdXRoIGVuYWJsZTsKCSNlbmNyeXB0IGVuYWJsZTsKfQo=
------=_Part_1858_8515069.1114008130708--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
