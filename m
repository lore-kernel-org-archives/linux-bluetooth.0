Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Nathaniel McCallum <npmccallum@asbury.edu>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-F4yeIqn6r8czQB1x70RY"
Message-Id: <1124383820.2312.3.camel@vacation.asbury.edu>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] hcid/dbus crasher fix
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
Date: Thu, 18 Aug 2005 12:50:20 -0400


--=-F4yeIqn6r8czQB1x70RY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch corrects a crasher bug when using hcid with dbus.

I'm still having a problem even after this bug, hcid just exits with
exitstatus 1 (but at least it doesn't crash).  Any ideas?

BTW, I'm not subscribed to the list, so please CC me in any responses.

Nathaniel

--=-F4yeIqn6r8czQB1x70RY
Content-Disposition: attachment; filename=bluez-utils-2.19-segfault.patch
Content-Type: text/x-patch; name=bluez-utils-2.19-segfault.patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtTnJ1IGJsdWV6LXV0aWxzLTIuMTkub3JpZy9oY2lkL2RidXMuYyBibHVlei11dGlscy0y
LjE5L2hjaWQvZGJ1cy5jDQotLS0gYmx1ZXotdXRpbHMtMi4xOS5vcmlnL2hjaWQvZGJ1cy5jCTIw
MDUtMDgtMDYgMDc6MTQ6MDAuMDAwMDAwMDAwIC0wNDAwDQorKysgYmx1ZXotdXRpbHMtMi4xOS9o
Y2lkL2RidXMuYwkyMDA1LTA4LTE4IDEyOjM2OjAzLjAwMDAwMDAwMCAtMDQwMA0KQEAgLTIyNCw5
ICsyMjQsMTMgQEANCiAJREJ1c01lc3NhZ2VJdGVyIGl0ZXI7DQogI2VuZGlmDQogCWNoYXIgbG9j
YWxfYWRkclsxOF0sIHBlZXJfYWRkclsxOF07DQorCWNoYXIgKipsb2NhbF9hZGRyX3RtcCwgKipw
ZWVyX2FkZHJfdG1wLCAqKm5hbWVfdG1wOw0KIA0KIAliYTJzdHIobG9jYWwsIGxvY2FsX2FkZHIp
Ow0KIAliYTJzdHIocGVlciwgcGVlcl9hZGRyKTsNCisJbG9jYWxfYWRkcl90bXAgPSAmbG9jYWxf
YWRkcjsNCisJcGVlcl9hZGRyX3RtcCA9ICZwZWVyX2FkZHI7DQorCW5hbWVfdG1wID0gJm5hbWU7
DQogDQogCW1lc3NhZ2UgPSBkYnVzX21lc3NhZ2VfbmV3X3NpZ25hbCgiL29yZy9ibHVlei9EZXZB
Z2VudCIsDQogCQkJCSJvcmcuYmx1ZXouRGV2QWdlbnQiLCAiUmVtb3RlTmFtZSIpOw0KQEAgLTIz
Nyw5ICsyNDEsOSBAQA0KIA0KICNpZmRlZiBIQVZFX0RCVVNfTUVTU0FHRV9BUFBFTkRfQVJHUw0K
IAlkYnVzX21lc3NhZ2VfYXBwZW5kX2FyZ3MobWVzc2FnZSwNCi0JCQkJCURCVVNfVFlQRV9TVFJJ
TkcsIGxvY2FsX2FkZHIsDQotCQkJCQlEQlVTX1RZUEVfU1RSSU5HLCBwZWVyX2FkZHIsDQotCQkJ
CQlEQlVTX1RZUEVfU1RSSU5HLCBuYW1lLA0KKwkJCQkJREJVU19UWVBFX1NUUklORywgJmxvY2Fs
X2FkZHJfdG1wLA0KKwkJCQkJREJVU19UWVBFX1NUUklORywgJnBlZXJfYWRkcl90bXAsDQorCQkJ
CQlEQlVTX1RZUEVfU1RSSU5HLCAmbmFtZV90bXAsDQogCQkJCQlEQlVTX1RZUEVfSU5WQUxJRCk7
DQogI2Vsc2UNCiAJZGJ1c19tZXNzYWdlX2FwcGVuZF9pdGVyX2luaXQobWVzc2FnZSwgJml0ZXIp
Ow0K


--=-F4yeIqn6r8czQB1x70RY--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
