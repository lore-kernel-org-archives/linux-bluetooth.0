Return-Path: <cyrus@holtmann.org>
Message-ID: <e1effdeb0803071312y7caabb1fj9d8ab74ab6cc4672@mail.gmail.com>
Date: Fri, 7 Mar 2008 18:12:51 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8620_28301424.1204924371916"
Subject: [Bluez-devel] [PATCH] bluez-libs leak
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

------=_Part_8620_28301424.1204924371916
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

I found a small leak. Please review the patch.

run valgrind sdptool browse xx:xx:xx:xx:xx:xx to see the leak.

Regards,
Claudio.
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_8620_28301424.1204924371916
Content-Type: text/x-diff; name=leak01.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fdj8u7c80
Content-Disposition: attachment; filename=leak01.patch

SW5kZXg6IHNyYy9zZHAuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9ibHVlei9saWJz
L3NyYy9zZHAuYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS44MQpkaWZmIC11IC1yMS44MSBzZHAu
YwotLS0gc3JjL3NkcC5jCTUgTWFyIDIwMDggMTk6MzA6MzIgLTAwMDAJMS44MQorKysgc3JjL3Nk
cC5jCTcgTWFyIDIwMDggMjE6MDc6NDIgLTAwMDAKQEAgLTE1MzAsMTMgKzE1MzAsMTQgQEAKIAlp
ZiAoc2RwZGF0YSAmJiBzZHBkYXRhLT5kdGQgPj0gU0RQX1NFUTggJiYgc2RwZGF0YS0+ZHRkIDw9
IFNEUF9TRVEzMikgewogCQlzZHBfZGF0YV90ICpkOwogCQlmb3IgKGQgPSBzZHBkYXRhLT52YWwu
ZGF0YXNlcTsgZDsgZCA9IGQtPm5leHQpIHsKLQkJCXV1aWRfdCAqdSA9IG1hbGxvYyhzaXplb2Yo
dXVpZF90KSk7Ci0JCQltZW1zZXQoKGNoYXIgKil1LCAwLCBzaXplb2YodXVpZF90KSk7Ci0JCQlp
ZiAoZC0+ZHRkID49IFNEUF9VVUlEMTYgJiYgZC0+ZHRkIDw9IFNEUF9VVUlEMTI4KSB7Ci0JCQkg
IAkqdSA9IGQtPnZhbC51dWlkOwotCQkJICAJKnNlcXAgPSBzZHBfbGlzdF9hcHBlbmQoKnNlcXAs
IHUpOwotCQkJfSBlbHNlCisJCQl1dWlkX3QgKnU7CisJCQlpZiAoZC0+ZHRkIDwgU0RQX1VVSUQx
NiB8fCBkLT5kdGQgPiBTRFBfVVVJRDEyOCkKIAkJCQlnb3RvIGZhaWw7CisKKwkJCXUgPSBtYWxs
b2Moc2l6ZW9mKHV1aWRfdCkpOworCQkJbWVtc2V0KChjaGFyICopdSwgMCwgc2l6ZW9mKHV1aWRf
dCkpOworCQkJKnUgPSBkLT52YWwudXVpZDsKKwkJCSpzZXFwID0gc2RwX2xpc3RfYXBwZW5kKCpz
ZXFwLCB1KTsKIAkJfQogCQlyZXR1cm4gMDsKIAl9Cg==
------=_Part_8620_28301424.1204924371916
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
------=_Part_8620_28301424.1204924371916
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_8620_28301424.1204924371916--
