Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: Brad Midgley <bmidgley@xmission.com>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: some btsco hacks
In-Reply-To: <427EF21A.7040908@xmission.com>
Message-ID: <Pine.LNX.4.63.0505100012240.9768@block>
References: <Pine.LNX.4.62.0505052044560.10038@block> <427A8B7F.1010105@xmission.com>
 <Pine.LNX.4.62.0505062220440.10201@block> <427EF21A.7040908@xmission.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1576235455-1115676878=:9768"
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
Date: Tue, 10 May 2005 00:14:38 +0200 (CEST)

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1576235455-1115676878=:9768
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > Back references to what/where?
> backrefs are parts of the regexp surrounded by (). the matching expression is
> remembered and can be placed in the command string, by \0 \1 etc it turns out.
> I figured them out & noted in the docs.
Ah, I see - I had overlooked that part of the code.

> In keeping with \0 \1 for backrefs in the regexp and \p for pid, the headset
> state should be \s instead of %d. Would you be willing to make that change (or
> I could)?
No problem, see attached patch.

Another question: has anyone experienced the same problem as I have
(the microphone input sometimes generates only noise) or is that 
strictly a bug of my headset?

Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCf+DS7CzyshGvatgRAmBVAKDfFJndw9pvwYxeENUCDj7gVyTLhwCfXBBS
LXVG5Iht3y0zFJp7REc3VeE=
=r6pM
-----END PGP SIGNATURE-----
--0-1576235455-1115676878=:9768
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0505100014380.9768@block>
Content-Description: 
Content-Disposition: attachment; filename=diff

ZGlmZiAtdSAtcjEuMjUgYnRzY28uYw0KLS0tIGJ0c2NvLmMJOSBNYXkgMjAw
NSAwNDo1NzoyOSAtMDAwMAkxLjI1DQorKysgYnRzY28uYwk5IE1heSAyMDA1
IDIyOjExOjQzIC0wMDAwDQpAQCAtNzEzLDEwICs3MTMsNyBAQA0KIAkJCQkJ
CQlpbnQgc3Vic3RsID0gMDsNCiAJCQkJCQkJDQogCQkJCQkJCXN1YnN0ID0g
TlVMTDsNCi0JCQkJCQkJDQotCQkJCQkJCS8vIGFkZCB0aGUgY3VycmVudCBz
Y28gbW9kZSB0byB0aGUgY29tbWFuZCBzdHJpbmcNCi0JCQkJCQkJc3lzYnVm
ID0gbWFsbG9jKHN0cmxlbihhcmdzKSsxKTsNCi0JCQkJCQkJc3ByaW50Zihz
eXNidWYsYXJncyxzY29fbW9kZSk7DQorCQkJCQkJCXN5c2J1ZiA9IHN0cmR1
cChhcmdzKTsNCiAJCQkJCQkJDQogCQkJCQkJCWZvcihpID0gMDsgc3lzYnVm
W2ldOyBpKyspIHsNCiAJCQkJCQkJCWlmKChzeXNidWZbaV0gPT0gJ1xcJykg
JiYgKHN5c2J1ZltpICsgMV0gPj0gJzAnKSAmJiAoc3lzYnVmW2kgKyAxXSA8
PSAnOScpKSB7DQpAQCAtNzMwLDYgKzcyNywxMCBAQA0KIAkJCQkJCQkJCXN1
YnN0ID0gbWFsbG9jKDExKTsgLyogRm9yIHBvdGVudGlhbGx5IDMyLWJpdCBQ
SURzICovDQogCQkJCQkJCQkJc3Vic3RsID0gc25wcmludGYoc3Vic3QsIDEx
LCAiJWkiLCBnZXRwaWQoKSk7DQogCQkJCQkJCQl9DQorCQkJCQkJCQlpZigo
c3lzYnVmW2ldID09ICdcXCcpICYmIChzeXNidWZbaSArIDFdID09ICdzJykp
IHsNCisJCQkJCQkJCQlzdWJzdCA9IG1hbGxvYygxMSk7IC8qIHNhbWUgYXMg
YWJvdmUsIGZvciBTQ08gbW9kZSAqLw0KKwkJCQkJCQkJCXN1YnN0bCA9IHNu
cHJpbnRmKHN1YnN0LCAxMSwgIiVkIiwgc2NvX21vZGUpOw0KKwkJCQkJCQkJ
fQ0KIAkJCQkJCQkJaWYoc3Vic3QgIT0gTlVMTCkgew0KIAkJCQkJCQkJCXN5
c2J1ZiA9IHJlYWxsb2Moc3lzYnVmLCBzdHJsZW4oc3lzYnVmKSArIHN1YnN0
bCAtIDEpOw0KIAkJCQkJCQkJCW1lbW1vdmUoc3lzYnVmICsgaSArIHN1YnN0
bCwgc3lzYnVmICsgaSArIDIsIHN0cmxlbihzeXNidWYpIC0gaSAtIDEpOw0K

--0-1576235455-1115676878=:9768--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
