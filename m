Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <564d96fb0606071459i7367f84fkb7ee645941f84279@mail.gmail.com>
Date: Wed, 7 Jun 2006 18:59:36 -0300
From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1149714650.22472.62.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4108_30311868.1149717576686"
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
	<1149714650.22472.62.camel@localhost>
Subject: Re: [Bluez-devel] bug in sdp_gen_pd
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

------=_Part_4108_30311868.1149717576686
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> first you forgot the patch
Sorry, the first email was lost. I forgot to attach when I resent the email.

> and second, are you sure. The SDP code is
> actually messy and some stuff is in there that actually works, but is
> not quite obvious. Can you provide a simple test program?

I found the bug while running a mid sized program in valgrind. The
relevant part of the log is
==26360== Invalid read of size 1
==26360==    at 0x4A1BAA0: memcpy (mac_replace_strmem.c:394)
==26360==    by 0x523124D: sdp_gen_pdu (in /usr/lib/libbluetooth.so.1.0.24)
==26360==    by 0x5231D18: sdp_append_to_pdu (in
/usr/lib/libbluetooth.so.1.0.24)
==26360==    by 0x522E46B: sdp_gen_record_pdu (in
/usr/lib/libbluetooth.so.1.0.24)
==26360==    by 0x52305D2: sdp_device_record_register (in
/usr/lib/libbluetooth.so.1.0.24)
.....
==26360==    at 0x4A19A16: malloc (vg_replace_malloc.c:149)
==26360==    by 0x522DE07: sdp_data_alloc_with_length (in
/usr/lib/libbluetooth.so.1.0.24)
==26360==    by 0x523078D: sdp_attr_add_new (in /usr/lib/libbluetooth.so.1.0.24)
==26360==    by 0x52309A2: sdp_set_info_attr (in
/usr/lib/libbluetooth.so.1.0.24)
--------------------------------------------------

If it is really necessary I can try to build a "small" test program.

> Never looked at it actually, but you might be right. However again,
> there might be a really strange reason for it.
For dead code?

> Regards
>
> Marcel

Best Regards,
Rafael

------=_Part_4108_30311868.1149717576686
Content-Type: application/octet-stream; name=bluez-libs.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eo67gfm0
Content-Disposition: attachment; filename="bluez-libs.patch"

LS0tIHNyYy9zZHAuYwkyMDA1LTEyLTI0IDE0OjAzOjM4LjAwMDAwMDAwMCAtMDMwMAorKysgL2hv
bWUvcmFmYWVsL3NkcC5jCTIwMDYtMDYtMDUgMTc6NDg6MzMuMDAwMDAwMDAwIC0wMzAwCkBAIC03
NDAsNiArNzQwLDEwIEBACiAJY2FzZSBTRFBfVEVYVF9TVFIzMjoKIAkJc3JjID0gKHVuc2lnbmVk
IGNoYXIgKilkLT52YWwuc3RyOwogCQlkYXRhX3NpemUgPSBkLT51bml0U2l6ZSAtIHNpemVvZih1
aW50OF90KTsKKwkJaWYgKGRhdGFfc2l6ZSAtIHNpemVvZih1aW50OF90KSA8PSBVQ0hBUl9NQVgp
CisJCQlkYXRhX3NpemUgLT0gc2l6ZW9mKHVpbnQ4X3QpOworCQllbHNlCisJCQlkYXRhX3NpemUg
LT0gc2l6ZW9mKHVpbnQxNl90KTsKIAkJc2RwX3NldF9zZXFfbGVuKHNlcXAsIGRhdGFfc2l6ZSk7
CiAJCWJyZWFrOwogCWNhc2UgU0RQX1VSTF9TVFI4Ogo=
------=_Part_4108_30311868.1149717576686
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_4108_30311868.1149717576686
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_4108_30311868.1149717576686--
