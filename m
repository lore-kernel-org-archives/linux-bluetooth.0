Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bmidgley@users.sourceforge.net, bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.62.0505052044560.10038@block>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1260567505-1115319494=:10038"
Subject: [Bluez-devel] some btsco hacks
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
Date: Thu, 5 May 2005 20:58:14 +0200 (CEST)

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1260567505-1115319494=:10038
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello everyone,

I finally got time to investigate the issues with my headset. Sometimes
after SCO connection establishment, the microphone produces only noise,
and a reconnect is necessary to fix this. The attached patch is against
btsco.c v1.22 from CVS, and does two things:

1. installs a handler for SIGUSR2 which automatically disconnects the
   SCO channel when connected and reconnects it after a short delay

2. allows the command string in .btscorc to contain '%d', which will
   be replaced with the current SCO connection status (0 or 1) upon
   command execution.

1. may be not really useful to most people - as mentioned, my headset
is obviously somewhat buggy and needs a kind of reset sometimes, which
this patch provides (actually, I wrote a shell script which samples
1 second of audio data from the headset, runs it through gzip to determine
whether it's noise and sends SIGUSR2 accordingly - talk about evil hacks ;)

2. was included because I want certain actions to happen only when
the connection is established, and not when it's shutting down.

Brad: if you think this could be useful otherwise, then feel free to 
include the patch into CVS.

Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCemzI7CzyshGvatgRArpWAJ4g4j5sgUjj3ulgVwxORICyjYdyHgCg5qpr
gE4T1Cniprq057+KD2i79kE=
=jha8
-----END PGP SIGNATURE-----
--0-1260567505-1115319494=:10038
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0505052058140.10038@block>
Content-Description: 
Content-Disposition: attachment; filename=diff

ZGlmZiAtdSAtcjEuMjIgYnRzY28uYw0KLS0tIGJ0c2NvLmMJMyBNYXkgMjAw
NSAxNTozNzoxMiAtMDAwMAkxLjIyDQorKysgYnRzY28uYwk1IE1heSAyMDA1
IDE4OjQ2OjE0IC0wMDAwDQpAQCAtODAsNyArODAsNyBAQA0KIAljaGFyICpj
bWQ7DQogfTsNCiANCi1zdGF0aWMgdm9sYXRpbGUgaW50IHRlcm1pbmF0ZSA9
IDAsIHJpbmcgPSAwLCBodXBwZWQgPSAwOw0KK3N0YXRpYyB2b2xhdGlsZSBp
bnQgdGVybWluYXRlID0gMCwgcmluZyA9IDAsIGh1cHBlZCA9IDAsIHJlY29u
bmVjdCA9IDA7DQogc3RhdGljIGludCB2ZXJib3NlID0gMDsNCiANCiBzdGF0
aWMgdm9pZCBzaWdfdGVybShpbnQgc2lnKQ0KQEAgLTk4LDYgKzk4LDExIEBA
DQogCWh1cHBlZCA9IDE7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIHNpZ191c3Io
aW50IHNpZykNCit7DQorCXJlY29ubmVjdCA9IDE7DQorfQ0KKw0KIHN0YXRp
YyBpbnQgcmZjb21tX2Nvbm5lY3QoYmRhZGRyX3QgKiBzcmMsIGJkYWRkcl90
ICogZHN0LCB1aW50OF90IGNoYW5uZWwpDQogew0KIAlzdHJ1Y3Qgc29ja2Fk
ZHJfcmMgYWRkcjsNCkBAIC01NzMsNiArNTc4LDkgQEANCiAJc2Euc2FfaGFu
ZGxlciA9IHNpZ19yaW5nOw0KIAlzaWdhY3Rpb24oU0lHVVNSMSwgJnNhLCBO
VUxMKTsNCiANCisJc2Euc2FfaGFuZGxlciA9IHNpZ191c3I7DQorCXNpZ2Fj
dGlvbihTSUdVU1IyLCAmc2EsIE5VTEwpOw0KKw0KIAlzYS5zYV9oYW5kbGVy
ID0gc2lnX2h1cDsNCiAJc2lnYWN0aW9uKFNJR0hVUCwgJnNhLCBOVUxMKTsN
CiANCkBAIC03MDQsNyArNzEyLDExIEBADQogCQkJCQkJCWludCBzdWJzdGwg
PSAwOw0KIAkJCQkJCQkNCiAJCQkJCQkJc3Vic3QgPSBOVUxMOw0KLQkJCQkJ
CQlzeXNidWYgPSBzdHJkdXAoYXJncyk7DQorCQkJCQkJCQ0KKwkJCQkJCQkv
LyBhZGQgdGhlIGN1cnJlbnQgc2NvIG1vZGUgdG8gdGhlIGNvbW1hbmQgc3Ry
aW5nDQorCQkJCQkJCXN5c2J1ZiA9IG1hbGxvYyhzdHJsZW4oYXJncykrMSk7
DQorCQkJCQkJCXNwcmludGYoc3lzYnVmLGFyZ3Msc2NvX21vZGUpOw0KKwkJ
CQkJCQkNCiAJCQkJCQkJZm9yKGkgPSAwOyBzeXNidWZbaV07IGkrKykgew0K
IAkJCQkJCQkJaWYoKHN5c2J1ZltpXSA9PSAnXFwnKSAmJiAoc3lzYnVmW2kg
KyAxXSA+PSAnMCcpICYmIChzeXNidWZbaSArIDFdIDw9ICc5JykpIHsNCiAJ
CQkJCQkJCQltYXRjaCA9IHN5c2J1ZltpICsgMV0gLSAnMCc7DQpAQCAtODA0
LDYgKzgxNiw0MCBAQA0KIA0KIAkJfQ0KIA0KKwkJLy8gbWVhbiBsaXR0bGUg
aGFjayB0byBhbGxvdyBmb3IgYSBzaWduYWwtdHJpZ2dlcmVkIHJlY29ubmVj
dA0KKwkJLy8gZm9yY2UgZGlzY29ubmVjdGlvbiBvZiB0aGUgY2hhbm5lbCAo
aWYgY29ubmVjdGVkKQ0KKwkJaWYgKHJlY29ubmVjdCA9PSAxKSB7DQorCQkJ
aWYgKHNjb19tb2RlID09IENPTk5FQ1RFRCkgew0KKwkJCQlmb3JjZV9zY28g
PSAgMDsNCisJCQkJcmVjb25uZWN0ID0gLTE7DQorCQkJfSBlbHNlIHJlY29u
bmVjdCA9IDA7DQorCQl9IA0KKwkJDQorCQlpZigoKCFkcl91c2FnZSAmJiAo
Zm9yY2Vfc2NvICE9IDEpKSB8fCAoZm9yY2Vfc2NvID09IDApKSAmJiAoc2Nv
X21vZGUgPT0gQ09OTkVDVEVEKSkgew0KKwkJCWlmKHZlcmJvc2UpIHsNCisJ
CQkJcHJpbnRmKCJkcml2ZXIgaXMgbm90IGluIHVzZVxuIik7DQorCQkJCWZm
bHVzaChzdGRvdXQpOw0KKwkJCX0NCisJCQkvKiBjbG9zZSBidF9zY28gYXVk
aW8gaGFuZGxlICovDQorCQkJYnRfc2NvX3NldF9mZChoYW5kbGUsIC0xKTsN
CisJCQkvKiBkaXNjb25uZWN0IFNDTyBzdHJlYW0gKi8NCisJCQljbG9zZShz
ZCk7DQorCQkJaWYodmVyYm9zZSkgew0KKwkJCQlwcmludGYoImRpc2Nvbm5l
Y3RlZCBTQ08gY2hhbm5lbFxuIik7DQorCQkJCWZmbHVzaChzdGRvdXQpOw0K
KwkJCX0NCisJCQkNCisJCQlzY29fbW9kZSA9IE5PVF9DT05ORUNURUQ7DQor
CQl9DQorDQorCQkvLyBpZiBhIHJlY29ubmVjdCBoYXMgYmVlbiByZXF1ZXN0
ZWQsIGZvcmNlIA0KKwkJLy8gdGhlIHNjbyBjaGFubmVsIHRvIGJlIGFjcXVp
cmVkIGFnYWluDQorCQlpZiAocmVjb25uZWN0ID09IC0xKSB7DQorCQkJZm9y
Y2Vfc2NvID0gMTsNCisJCQlyZWNvbm5lY3QgPSAwOw0KKwkJCXNsZWVwKDMp
Ow0KKwkJfQ0KKw0KIAkJaWYoKChkcl91c2FnZSAmJiAoZm9yY2Vfc2NvICE9
IDApKSB8fCAoZm9yY2Vfc2NvID09IDEpKSAmJiAoc2NvX21vZGUgPT0gTk9U
X0NPTk5FQ1RFRCkpIHsNCiAJCQlpZih2ZXJib3NlKSB7DQogCQkJCXByaW50
ZigiZHJpdmVyIGlzIGluIHVzZVxuIik7DQpAQCAtODI1LDI0ICs4NzEsNiBA
QA0KIAkJCQl9DQogCQkJCXNjb19tb2RlID0gQ09OTkVDVEVEOw0KIAkJCX0N
Ci0JCQkNCi0JCX0NCi0JCWlmKCgoIWRyX3VzYWdlICYmIChmb3JjZV9zY28g
IT0gMSkpIHx8IChmb3JjZV9zY28gPT0gMCkpICYmIChzY29fbW9kZSA9PSBD
T05ORUNURUQpKSB7DQotCQkJaWYodmVyYm9zZSkgew0KLQkJCQlwcmludGYo
ImRyaXZlciBpcyBub3QgaW4gdXNlXG4iKTsNCi0JCQkJZmZsdXNoKHN0ZG91
dCk7DQotCQkJfQ0KLQkJCS8qIGNsb3NlIGJ0X3NjbyBhdWRpbyBoYW5kbGUg
Ki8NCi0JCQlidF9zY29fc2V0X2ZkKGhhbmRsZSwgLTEpOw0KLQkJCS8qIGRp
c2Nvbm5lY3QgU0NPIHN0cmVhbSAqLw0KLQkJCWNsb3NlKHNkKTsNCi0JCQlp
Zih2ZXJib3NlKSB7DQotCQkJCXByaW50ZigiZGlzY29ubmVjdGVkIFNDTyBj
aGFubmVsXG4iKTsNCi0JCQkJZmZsdXNoKHN0ZG91dCk7DQotCQkJfQ0KLQkJ
CQ0KLQkJCXNjb19tb2RlID0gTk9UX0NPTk5FQ1RFRDsNCi0JCQkNCiAJCX0N
CiAJCQ0KIAkJaWYgKHJpbmcpIHsNCg==

--0-1260567505-1115319494=:10038--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
