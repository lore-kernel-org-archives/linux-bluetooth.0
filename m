Return-Path: <cyrus@holtmann.org>
From: Alban Browaeys <prahal@yahoo.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-DfTKWe/HgbQL6yBBe8Y9"
Date: Thu, 13 Mar 2008 20:36:06 +0100
Message-Id: <1205436966.22400.4.camel@cyclope.server.maison>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] shows error in logs if the special
	directories are not	defined and close the server if failure
	to start obex server
Reply-To: prahal@yahoo.com,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-DfTKWe/HgbQL6yBBe8Y9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is made out of my attempt to start obex-data-server from
debian without xdg-user-dirs . It does not work as the glib special
directories are nto defined but worst than that :
- it did not tell in the log anything went wrong, 
- it did not close the server when it failed to start it and
sharing_enabled and received_enabled where not in sync with the server
state anymore because of that. applet was trying to create the server
while it was already running leading to socket already in use errors
after two attempts. 
This fixes those issues.


Best regards
Alban

--=-DfTKWe/HgbQL6yBBe8Y9
Content-Disposition: attachment;
	filename*0=applet_obex_invalidpathshowerror_and_closeserveronfailuretost;
	filename*1=artit.diff
Content-Type: text/x-patch;
	name*0=applet_obex_invalidpathshowerror_and_closeserveronfailuretostarti;
	name*1=t.diff; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGFwcGxldC9vYmV4LmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9vdC9ibHVl
ei9nbm9tZS9hcHBsZXQvb2JleC5jLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS45DQpkaWZmIC11
IC1yMS45IG9iZXguYw0KLS0tIGFwcGxldC9vYmV4LmMJMjEgRmViIDIwMDggMjM6NDY6MTggLTAw
MDAJMS45DQorKysgYXBwbGV0L29iZXguYwkxMyBNYXIgMjAwOCAxNzozNToyMCAtMDAwMA0KQEAg
LTkzLDEwICs5MywxOSBAQA0KIHN0YXRpYyB2b2lkIHN0YXJ0X29wcF9ub3RpZnkoREJ1c0dQcm94
eSAqcHJveHksDQogCQkJCURCdXNHUHJveHlDYWxsICpjYWxsLCB2b2lkICp1c2VyX2RhdGEpDQog
ew0KKwlHRXJyb3IgKmVycm9yID0gTlVMTDsNCiAJb3BwX3N0YXJ0dXAgPSBGQUxTRTsNCiANCi0J
aWYgKGRidXNfZ19wcm94eV9lbmRfY2FsbChwcm94eSwgY2FsbCwgTlVMTCwgR19UWVBFX0lOVkFM
SUQpID09IEZBTFNFKQ0KKwlpZiAoZGJ1c19nX3Byb3h5X2VuZF9jYWxsKHByb3h5LCBjYWxsLCAm
ZXJyb3IsIEdfVFlQRV9JTlZBTElEKSA9PSBGQUxTRSkgew0KKwkJaWYgKGVycm9yICE9IE5VTEwp
IHsNCisJCQlnX3ByaW50ZXJyKCJCbHVldG9vdGggT0JFWCBzZXJ2ZXIgc3RhcnQgZmFpbGVkOiAl
c1xuIiwNCisJCQkJCQkJZXJyb3ItPm1lc3NhZ2UpOw0KKwkJCWdfZXJyb3JfZnJlZShlcnJvcik7
DQorCQl9DQorDQorCQljbG9zZV9vcHBfc2VydmVyKCk7DQogCQlyZXR1cm47DQorCX0NCiANCiAJ
cmVjZWl2ZV9lbmFibGVkID0gVFJVRTsNCiANCkBAIC0xNTAsMTAgKzE1OSwxOSBAQA0KIHN0YXRp
YyB2b2lkIHN0YXJ0X2Z0cF9ub3RpZnkoREJ1c0dQcm94eSAqcHJveHksDQogCQkJCURCdXNHUHJv
eHlDYWxsICpjYWxsLCB2b2lkICp1c2VyX2RhdGEpDQogew0KKwlHRXJyb3IgKiBlcnJvciA9IE5V
TEw7DQogCWZ0cF9zdGFydHVwID0gRkFMU0U7DQogDQotCWlmIChkYnVzX2dfcHJveHlfZW5kX2Nh
bGwocHJveHksIGNhbGwsIE5VTEwsIEdfVFlQRV9JTlZBTElEKSA9PSBGQUxTRSkNCisJaWYgKGRi
dXNfZ19wcm94eV9lbmRfY2FsbChwcm94eSwgY2FsbCwgJmVycm9yLCBHX1RZUEVfSU5WQUxJRCkg
PT0gRkFMU0UpIHsNCisJCWlmIChlcnJvciAhPSBOVUxMKSB7DQorCQkJZ19wcmludGVycigiQmx1
ZXRvb3RoIEZUUCBzZXJ2ZXIgc3RhcnQgZmFpbGVkOiAlc1xuIiwNCisJCQkJCQkJZXJyb3ItPm1l
c3NhZ2UpOw0KKwkJCWdfZXJyb3JfZnJlZShlcnJvcik7DQorCQl9DQorDQorCQljbG9zZV9mdHBf
c2VydmVyKCk7DQogCQlyZXR1cm47DQorCX0NCiANCiAJc2hhcmluZ19lbmFibGVkID0gVFJVRTsN
CiANCg==


--=-DfTKWe/HgbQL6yBBe8Y9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-DfTKWe/HgbQL6yBBe8Y9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-DfTKWe/HgbQL6yBBe8Y9--
