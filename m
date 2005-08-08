Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TRJWPF1SM9E1UBZJJMWC"
Message-Id: <20050808115620.EEB243BF@arbetsmyra.dyndns.org>
Subject: [Bluez-devel] bccmd patch, find connection handle by bdaddr
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
Date: Mon, 8 Aug 2005 13:55:05 +0200


--------------Boundary-00=_TRJWPF1SM9E1UBZJJMWC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Subject: 


Hi
I've got a whole bunch of little enhancement patches to the bccmd, 
pskey and l2ping utils. Marcel, as you wished earlier I'm posting them 
small and separate. The one attached makes bccmd able to find a ACL 
connection handle itself, instead of require user to provide it on 
commandline. I'm using it in a cmd_keylen() patch (which I post when 
this one gets applied).

Regards
/Ronny



--------------Boundary-00=_TRJWPF1SM9E1UBZJJMWC
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="bccmd-handle.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bccmd-handle.diff"

SW5kZXg6IHV0aWxzL3Rvb2xzL2JjY21kLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3Qv
Ymx1ZXovdXRpbHMvdG9vbHMvYmNjbWQuYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4zCmRpZmYg
LXUgLXAgLXIxLjMgYmNjbWQuYwotLS0gdXRpbHMvdG9vbHMvYmNjbWQuYwkzIEp1bCAyMDA1IDEz
OjEzOjE3IC0wMDAwCTEuMworKysgdXRpbHMvdG9vbHMvYmNjbWQuYwk4IEF1ZyAyMDA1IDExOjQ0
OjQ1IC0wMDAwCkBAIC0zNSw2ICszNSw3IEBACiAjaW5jbHVkZSA8c3RkbGliLmg+CiAjaW5jbHVk
ZSA8Z2V0b3B0Lmg+CiAjaW5jbHVkZSA8c3lzL3NvY2tldC5oPgorI2luY2x1ZGUgPHN5cy9pb2N0
bC5oPgogCiAjaW5jbHVkZSA8Ymx1ZXRvb3RoL2JsdWV0b290aC5oPgogI2luY2x1ZGUgPGJsdWV0
b290aC9oY2kuaD4KQEAgLTQyLDYgKzQzLDQxIEBACiAKICNpbmNsdWRlICJjc3IuaCIKIAorCisv
Ly0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KKy8vIEZpbmRzIHRoZSBBQ0wgaGFuZGxlIChvciAtMSBvbiBlcnJvcikgZm9yIGEKKy8v
IGV4aXN0aW5nIGNvbm5lY3Rpb24gdG8gcmVtb3RlIDxiZGFkZHI+LgorLy8tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCitpbnQzMl90
IGZpbmRfY29ubl9oYW5kbGUoaW50IGRkLCBiZGFkZHJfdCAqYmRhZGRyKSB7CisJc3RydWN0IGhj
aV9jb25uX2luZm9fcmVxICpjb25SZXE7CisJaW50MzJfdCBoYW5kbGUgPSAtMTsKKwkKKwljb25S
ZXEgPSBtYWxsb2Moc2l6ZW9mKHN0cnVjdCBoY2lfY29ubl9pbmZvX3JlcSkgKyAKKwkJc2l6ZW9m
KHN0cnVjdCBoY2lfY29ubl9pbmZvKSk7CisJaWYoIWNvblJlcSkgeworCQlwZXJyb3IoIkNhbid0
IGdldCBtZW0iKTsKKwkJZ290byBvdXQ7CisJfQorCQorCWJhY3B5KCZjb25SZXEtPmJkYWRkciwg
YmRhZGRyKTsKKwljb25SZXEtPnR5cGUgPSBBQ0xfTElOSzsKKwlpZiAoaW9jdGwoZGQsIEhDSUdF
VENPTk5JTkZPLCAodW5zaWduZWQgbG9uZykgY29uUmVxKSA8IDApIHsKKwkJcGVycm9yKCJDb3Vs
ZG4ndCBnZXQgY29ubmVjdGlvbiBpbmZvIik7CisJCWdvdG8gb3V0OworCX0KKwlpZihiYWNtcChi
ZGFkZHIsICZjb25SZXEtPmJkYWRkcik9PTApIHsKKwkJaGFuZGxlPWNvblJlcS0+Y29ubl9pbmZv
LT5oYW5kbGU7CisJfSBlbHNlIHsKKwkJZnByaW50ZihzdGRlcnIsICJOb3QgY29ubmVjdGVkIik7
CisJfQorCQorb3V0OgorCWZyZWUoY29uUmVxKTsKKwlyZXR1cm4gaGFuZGxlOworfQorCisKKwog
c3RhdGljIGludCBjbWRfa2V5bGVuKGludCBkZCwgaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIHsK
IAl1aW50OF90IGJ1Zls4XTsK

--------------Boundary-00=_TRJWPF1SM9E1UBZJJMWC--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
