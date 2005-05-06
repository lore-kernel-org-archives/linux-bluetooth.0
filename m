Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bmidgley@xmission.com, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: some btsco hacks
In-Reply-To: <427A8B7F.1010105@xmission.com>
Message-ID: <Pine.LNX.4.62.0505062220440.10201@block>
References: <Pine.LNX.4.62.0505052044560.10038@block> <427A8B7F.1010105@xmission.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="0-531350743-1115412678=:10201"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 6 May 2005 22:52:53 +0200 (CEST)

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-531350743-1115412678=:10201
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: <Pine.LNX.4.62.0505062251281.10201@block>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Brad,

I noticed that there was a small bug left in my patch (the value of
force_sco was overwritten when a reconnect was requested). This small
additional patch should fix that.

> could you give me some examples from your .btscorc?

Well, my .btscorc currently looks like this:

AT\+CKPD=200
sco-toggle on off
AT\+CKPD=200
system /home/echtler/bin/headset %d &

> do you know what the syntax of 'back references' is in .btscorc?
Back references to what/where?

Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCe9ks7CzyshGvatgRAkoxAKDxCwtRZKTHSujGXyrqRdaNEL43/wCfbPjd
D0q3ebE9/sMYojjLzaZFMug=
=4Wfl
-----END PGP SIGNATURE-----
--0-531350743-1115412678=:10201
Content-Type: TEXT/PLAIN; charset=us-ascii; name=diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0505062251180.10201@block>
Content-Description: 
Content-Disposition: attachment; filename=diff

ZGlmZiAtdSAtcjEuMjQgYnRzY28uYw0KLS0tIGJ0c2NvLmMJNSBNYXkgMjAw
NSAyMToxNTozMCAtMDAwMAkxLjI0DQorKysgYnRzY28uYwk2IE1heSAyMDA1
IDIwOjUwOjIwIC0wMDAwDQpAQCAtNDYwLDcgKzQ2MCw3IEBADQogCXVpbnQx
Nl90IHNjb19oYW5kbGUsIHNjb19tdHUsIHZzOw0KIAljaGFyIGxpbmVbMTAw
XTsNCiAJaW50IGxhc3Rfdm9sdW1lc1syXTsNCi0JaW50IGRyX3VzYWdlLCBm
b3JjZV9zY287DQorCWludCBkcl91c2FnZSwgZm9yY2Vfc2NvLCBmb3JjZV9v
bGQ7DQogDQogCS8vIHNjb19tb2RlIGlzIG91ciBydW5uaW5nIG1vZGUuIDAg
PT4gbm90IGNvbm5lY3QsIDEgPT4gY29ubmVjdGVkDQogCS8vIHNlZSBOT1Rf
Q09OTkVDVEVELENPTk5FQ1RFRCA6KQ0KQEAgLTYyNCw2ICs2MjQsNyBAQA0K
IAl9DQogCWRyX3VzYWdlID0gaW5mb2J1Zi5wbGF5YmFja19jb3VudCB8fCBp
bmZvYnVmLmNhcHR1cmVfY291bnQ7DQogCWZvcmNlX3NjbyA9IC0xOw0KKwlm
b3JjZV9vbGQgPSAtMTsNCiAJDQogCWlmIChmb3JrKQ0KIAkJZGFlbW9uKDAs
IDApOw0KQEAgLTgxOCwxMiArODE5LDEwIEBADQogDQogCQkvLyBtZWFuIGxp
dHRsZSBoYWNrIHRvIGFsbG93IGZvciBhIHNpZ25hbC10cmlnZ2VyZWQgcmVj
b25uZWN0DQogCQkvLyBmb3JjZSBkaXNjb25uZWN0aW9uIG9mIHRoZSBjaGFu
bmVsIChpZiBjb25uZWN0ZWQpDQotCQlpZiAocmVjb25uZWN0ID09IDEpIHsN
Ci0JCQlpZiAoc2NvX21vZGUgPT0gQ09OTkVDVEVEKSB7DQotCQkJCWZvcmNl
X3NjbyA9ICAwOw0KLQkJCQlyZWNvbm5lY3QgPSAtMTsNCi0JCQl9IGVsc2Ug
cmVjb25uZWN0ID0gMDsNCi0JCX0gDQorCQlpZiAocmVjb25uZWN0ICYmIChz
Y29fbW9kZSA9PSBDT05ORUNURUQpKSB7DQorCQkJZm9yY2Vfb2xkID0gZm9y
Y2Vfc2NvOw0KKwkJCWZvcmNlX3NjbyA9IDA7DQorCQl9IGVsc2UgcmVjb25u
ZWN0ID0gMDsNCiAJCQ0KIAkJaWYoKCghZHJfdXNhZ2UgJiYgKGZvcmNlX3Nj
byAhPSAxKSkgfHwgKGZvcmNlX3NjbyA9PSAwKSkgJiYgKHNjb19tb2RlID09
IENPTk5FQ1RFRCkpIHsNCiAJCQlpZih2ZXJib3NlKSB7DQpAQCAtODQ0LDkg
Kzg0Myw4IEBADQogDQogCQkvLyBpZiBhIHJlY29ubmVjdCBoYXMgYmVlbiBy
ZXF1ZXN0ZWQsIGZvcmNlIA0KIAkJLy8gdGhlIHNjbyBjaGFubmVsIHRvIGJl
IGFjcXVpcmVkIGFnYWluDQotCQlpZiAocmVjb25uZWN0ID09IC0xKSB7DQor
CQlpZiAocmVjb25uZWN0KSB7DQogCQkJZm9yY2Vfc2NvID0gMTsNCi0JCQly
ZWNvbm5lY3QgPSAwOw0KIAkJCXNsZWVwKDMpOw0KIAkJfQ0KIA0KQEAgLTg3
Miw2ICs4NzAsMTIgQEANCiAJCQkJc2NvX21vZGUgPSBDT05ORUNURUQ7DQog
CQkJfQ0KIAkJfQ0KKw0KKwkJLy8gcmVzdG9yZSBvcmlnaW5hbCBwcm9ncmFt
IHN0YXR1cw0KKwkJaWYgKHJlY29ubmVjdCkgew0KKwkJCWZvcmNlX3NjbyA9
IGZvcmNlX29sZDsNCisJCQlyZWNvbm5lY3QgPSAwOw0KKwkJfQ0KIAkJDQog
CQlpZiAocmluZykgew0KIAkJCXdyaXRlKHJkLCAiXHJcblJJTkdcclxuIiwg
OCk7DQo=

--0-531350743-1115412678=:10201--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
