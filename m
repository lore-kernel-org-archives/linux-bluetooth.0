Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dimitry Andric <dimitry@andric.com>
Message-ID: <381006269.20050404171656@andric.com>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------66EE1FABF462D5"
Subject: [Bluez-devel] [PATCH] Add sdptool option for browsing with L2CAP_UUID
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
Date: Mon, 4 Apr 2005 17:16:56 +0200

------------66EE1FABF462D5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Some phones (e.g. Samsung D500, Motorola MPx220, and possibly some
other Windows Mobile models) don't return any services if you ask them
for the public browse group.  You notice this, when "sdptool browse
xx:xx:xx:xx:xx:xx" returns immediately, without any output.

It turns out that the Windows XP Bluetooth browser asks for
L2CAP_UUID, which *does* work for all the phones I've tested.

So I've made this simple patch, that adds a `-l' or `--l2cap' command
line option to sdptool, to use the L2CAP_UUID for browsing, instead of
PUBLIC_BROWSE_GROUP.

------------66EE1FABF462D5
Content-Type: text/plain; name="bluez-utils-2.15-sdpbrowse-l2cap.patch"
Content-transfer-encoding: base64
Content-Disposition: attachment; filename="bluez-utils-2.15-sdpbrowse-l2cap.patch"

IyBibHVlei11dGlscy0yLjE1LXNkcGJyb3dzZS1sMmNhcC5wYXRjaAojCiMgU29tZSBwaG9u
ZXMgZG9uJ3QgcmV0dXJuIGFueSBzZXJ2aWNlcyBpZiB5b3UgYXNrIHRoZW0gZm9yIHRoZSBw
dWJsaWMKIyBicm93c2UgZ3JvdXAuICBJdCB0dXJucyBvdXQgdGhhdCB0aGUgV2luZG93cyBY
UCBCbHVldG9vdGggYnJvd3NlcgojIGFza3MgZm9yIEwyQ0FQX1VVSUQsIHdoaWNoIHNlZW1z
IHRvIHdvcmsgZm9yIGFsbCBwaG9uZXMuCiMKIyBUaGlzIHBhdGNoIGFkZHMgYSBgLWwnIG9y
IGAtLWwyY2FwJyBjb21tYW5kIGxpbmUgb3B0aW9uIHRvIHNkcHRvb2wsCiMgdG8gdXNlIHRo
ZSBMMkNBUF9VVUlEIGZvciBicm93c2luZywgaW5zdGVhZCBvZiBQVUJMSUNfQlJPV1NFX0dS
T1VQLgojCiMgRGltaXRyeSBBbmRyaWMgPGRpbWl0cnlAYW5kcmljLmNvbT4sIDIwMDUtMDQt
MDQgMTY6Mzk6MzMKCmRpZmYgLXVyTmQgYS91dGlscy90b29scy9zZHB0b29sLmMgYi91dGls
cy90b29scy9zZHB0b29sLmMKLS0tIGEvdXRpbHMvdG9vbHMvc2RwdG9vbC5jCTIwMDQtMTIt
MjUgMTk6MDY6MDIuMDAwMDAwMDAwICswMTAwCisrKyBiL3V0aWxzL3Rvb2xzL3NkcHRvb2wu
YwkyMDA1LTA0LTA0IDE2OjM1OjAxLjAwMDAwMDAwMCArMDIwMApAQCAtMjAxNiwxMiArMjAz
MywxMyBAQAogc3RhdGljIHN0cnVjdCBvcHRpb24gYnJvd3NlX29wdGlvbnNbXSA9IHsKIAl7
ICJoZWxwIiwgICAgMCwwLCAnaCcgfSwKIAl7ICJ0cmVlIiwgICAgMCwwLCAndCcgfSwKKwl7
ICJsMmNhcCIsICAgMCwwLCAnbCcgfSwKIAl7IDAsIDAsIDAsIDAgfQogfTsKIAogc3RhdGlj
IGNoYXIgKmJyb3dzZV9oZWxwID0gCiAJIlVzYWdlOlxuIgotCSJcdGJyb3dzZSBbLS10cmVl
XSBbYmRhZGRyXVxuIjsKKwkiXHRicm93c2UgWy0tdHJlZV0gWy0tbDJjYXBdIFtiZGFkZHJd
XG4iOwogCiAvKgogICogQnJvd3NlIHRoZSBmdWxsIFNEUCBkYXRhYmFzZSAoaS5lLiBsaXN0
IGFsbCBzZXJ2aWNlcyBzdGFydGluZyBmcm9tIHRoZQpAQCAtMjA0Miw2ICsyMDYwLDEzIEBA
CiAJCWNhc2UgJ3QnOgogCQkJY29udGV4dC50cmVlID0gMTsKIAkJCWJyZWFrOworCQljYXNl
ICdsJzoKKwkJCS8qIFNvbWUgcGhvbmVzIGRvbid0IHJldHVybiBhbnkgc2VydmljZXMgaWYg
eW91IGFzayB0aGVtIGZvciB0aGUKKwkJCSAqIHB1YmxpYyBicm93c2UgZ3JvdXAuICBJdCB0
dXJucyBvdXQgdGhhdCB0aGUgV2luZG93cyBYUCBCbHVldG9vdGgKKwkJCSAqIGJyb3dzZXIg
YXNrcyBmb3IgTDJDQVBfVVVJRCwgd2hpY2ggc2VlbXMgdG8gd29yayBmb3IgYWxsIHBob25l
cy4KKwkJCSAqLworCQkJc2RwX3V1aWQxNl9jcmVhdGUoJihjb250ZXh0Lmdyb3VwKSwgTDJD
QVBfVVVJRCk7CisJCQlicmVhazsKIAkJZGVmYXVsdDoKIAkJCXByaW50Zihicm93c2VfaGVs
cCk7CiAJCQlyZXR1cm4gLTE7Cg==

------------66EE1FABF462D5--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
