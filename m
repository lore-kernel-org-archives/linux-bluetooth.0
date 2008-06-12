Return-Path: <cyrus@holtmann.org>
Message-ID: <ef9938ec0806121252p17878962x186ef28e81b1a86c@mail.gmail.com>
Date: Thu, 12 Jun 2008 15:52:07 -0400
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_27382_27713775.1213300327256"
Subject: [Bluez-devel] sdpd doesn't always collect non-persistent service
	records
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
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

------=_Part_27382_27713775.1213300327256
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

When using the libbluetooth SDP API, records registered that do not
have SDP_RECORD_PERSIST are not always collected by sdpd when the sdp
session is closed.  I think the attached patch should help.

Regards,
Albert

------=_Part_27382_27713775.1213300327256
Content-Type: text/plain; name=patch.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhdrncuh0
Content-Disposition: attachment; filename=patch.txt

SW5kZXg6IHNlcnZlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2JsdWV6L3V0aWxz
L3NkcGQvc2VydmVyLmMsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTMKZGlmZiAtdSAtcjEuMTMg
c2VydmVyLmMKLS0tIHNlcnZlci5jCTIgRmViIDIwMDggMDM6Mzc6NDggLTAwMDAJMS4xMworKysg
c2VydmVyLmMJMTIgSnVuIDIwMDggMTk6NDc6NTIgLTAwMDAKQEAgLTE1MSwxMSArMTUxLDE1IEBA
CiAJdWludDhfdCAqYnVmOwogCWludCBzaywgbGVuLCBzaXplOwogCi0JaWYgKGNvbmQgJiAoR19J
T19IVVAgfCBHX0lPX0VSUiB8IEdfSU9fTlZBTCkpCi0JCXJldHVybiBGQUxTRTsKLQogCXNrID0g
Z19pb19jaGFubmVsX3VuaXhfZ2V0X2ZkKGNoYW4pOwogCisJaWYgKGNvbmQgJiBHX0lPX05WQUwp
IHsKKwkJcmV0dXJuIEZBTFNFOworCX0gZWxzZSBpZiAoY29uZCAmIChHX0lPX0hVUCB8IEdfSU9f
RVJSKSkgeworCQlzZHBfc3ZjZGJfY29sbGVjdF9hbGwoc2spOworCQlyZXR1cm4gRkFMU0U7CisJ
fQorCiAJbGVuID0gcmVjdihzaywgJmhkciwgc2l6ZW9mKHNkcF9wZHVfaGRyX3QpLCBNU0dfUEVF
Syk7CiAJaWYgKGxlbiA8PSAwKSB7CiAJCXNkcF9zdmNkYl9jb2xsZWN0X2FsbChzayk7Cg==
------=_Part_27382_27713775.1213300327256
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
------=_Part_27382_27713775.1213300327256
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_27382_27713775.1213300327256--
