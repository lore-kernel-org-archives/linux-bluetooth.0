Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <564d96fb0606051415ldd16424mf7f1b02df025591a@mail.gmail.com>
Date: Mon, 5 Jun 2006 18:15:13 -0300
From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9147_5589822.1149542113972"
Subject: [Bluez-devel] bug in sdp_gen_pdu
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_Part_9147_5589822.1149542113972
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When handling SDP_TEXT_STR{8,16,32}, data_size is assumed to be
"d->unitSize - sizeof(uint8_t)". This is false.

In sdp_data_alloc_with_length, d->unitSize is defined to be
sizeof(unit8_t) + length + sizeof(uint8_t) if length <= UCHAR_MAX
or
sizeof(unit8_t) + length + sizeof(uint16_t) if length > UCHAR_MAX

The attached patch fixes sdp_gen_pdu to correctly compute data_size.

Another strange thing in sdp_data_alloc_with_length: after adjusting
unitSize, the dtd variable is changed from SDP_*_STR8 to SDP_*_STR16
or the other way around. But this code is dead, since the dtd variable
is no longer used in this function.

Best Regards,
Rafael

------=_Part_9147_5589822.1149542113972
Content-Type: application/octet-stream; name=bluez-libs.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eo3bfcft
Content-Disposition: attachment; filename="bluez-libs.patch"

LS0tIHNyYy9zZHAuYwkyMDA1LTEyLTI0IDE0OjAzOjM4LjAwMDAwMDAwMCAtMDMwMAorKysgL2hv
bWUvcmFmYWVsL3NkcC5jCTIwMDYtMDYtMDUgMTc6NDg6MzMuMDAwMDAwMDAwIC0wMzAwCkBAIC03
NDAsNiArNzQwLDEwIEBACiAJY2FzZSBTRFBfVEVYVF9TVFIzMjoKIAkJc3JjID0gKHVuc2lnbmVk
IGNoYXIgKilkLT52YWwuc3RyOwogCQlkYXRhX3NpemUgPSBkLT51bml0U2l6ZSAtIHNpemVvZih1
aW50OF90KTsKKwkJaWYgKGRhdGFfc2l6ZSAtIHNpemVvZih1aW50OF90KSA8PSBVQ0hBUl9NQVgp
CisJCQlkYXRhX3NpemUgLT0gc2l6ZW9mKHVpbnQ4X3QpOworCQllbHNlCisJCQlkYXRhX3NpemUg
LT0gc2l6ZW9mKHVpbnQxNl90KTsKIAkJc2RwX3NldF9zZXFfbGVuKHNlcXAsIGRhdGFfc2l6ZSk7
CiAJCWJyZWFrOwogCWNhc2UgU0RQX1VSTF9TVFI4Ogo=
------=_Part_9147_5589822.1149542113972
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_9147_5589822.1149542113972
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_9147_5589822.1149542113972--
