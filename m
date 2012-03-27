Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACY+gR3aPvvMRvNW+c3QdF8UkGR4ZGPChWt4MAoa+5fK=HSBNQ@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
	<CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
	<CABax29U8N2nOge34tr=G2f-fZvowCHPf3V=N2an-vC+x=UBdiQ@mail.gmail.com>
	<CACY+gR2PkP76J2Dw9xobpeGsU2HKhsOYvU6Wcx8WCcq1opihiA@mail.gmail.com>
	<CABax29VadeA+6WZWRDiZZUhpRqk2Nk35__b0Cjfz8HO12Tq4vQ@mail.gmail.com>
	<CACY+gR0DJfbOgfSGHrsAj5vk00v4-_+KYwR+SF+0BRRs2oYBkw@mail.gmail.com>
	<CABax29X+ke_PO9obAxbEJjdx68g8JW4ZZn7vS7mYpE7+00iYng@mail.gmail.com>
	<CABax29WFvAXH9g8CnOtEDAqfmKmURnt4eYY58fi+P9zBa5Ji1A@mail.gmail.com>
	<CACY+gR3pqj6xoJ-G-pt5QTY6BjuyUNXTZRzsQmmutcSNBzY3qQ@mail.gmail.com>
	<CABax29Unh0AOhExp_FJwUr=edmPSDXy=_YJAXN81M5tp5+yUxw@mail.gmail.com>
	<CABax29XWLWcBT6hHgSQud6qzhQ-Y-WAMjQ8ytCT7Px09H1iQtg@mail.gmail.com>
	<CACY+gR3aPvvMRvNW+c3QdF8UkGR4ZGPChWt4MAoa+5fK=HSBNQ@mail.gmail.com>
Date: Wed, 28 Mar 2012 01:28:24 +0200
Message-ID: <CABax29U=bsb0T2FQtzkQ2WGOkDTgJ8STshcu8fRmC4QvHEv=QQ@mail.gmail.com>
Subject: [PATCH] Re: A2DP quality (bluetooth-alsa)
From: qduaty <qduaty@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=20cf300faf0fde4c2b04bc41d8da
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--20cf300faf0fde4c2b04bc41d8da
Content-Type: text/plain; charset=ISO-8859-1

ALSA bitpool patch is attached.

2012/3/27 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
> The first patch adds debug prints to syslog from sbc encoder, just to
> clearly confirm the real bitpool used by the encoder.

It obviously worked:

Mar 27 17:49:41 machina-turbo pulseaudio[2355]: sbc_encode: bitpool set to 138

> The second patch removes default_bitpool() limitation, and this boosts
> bitpool from 53 to 64 for me.

I found it was my device that prevented Bluez from using higher
bitpools. Bluez assumes that requesting a wider range of bitpools from
a device will cause an error, and indeed, my device cannot be
configured with a bitpool range wider than 2-53. So the only way to
achieve higher bitrates is to force them.

There is (was) a rather serious problem in the ALSA module, when it
tried to set bitpool exceding device capabilities, it ended with an
error and next tries, even with a valid bitpool, resulted in "Invalid
seid 0" in syslog and required bluetooth service to be restarted. With
my patch, bluez only uses the configured bitpool for sbc, without
sending it to the device. So, any bitpool value not exceeding true
device and adapter capabilities will work (and these can be much
higher than negotiated).


Regards
--

Sebastian Olter

--20cf300faf0fde4c2b04bc41d8da
Content-Type: text/x-diff; charset=US-ASCII; name="alsa_use_arbitrary_bitpool.diff"
Content-Disposition: attachment; filename="alsa_use_arbitrary_bitpool.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0bklgyc1

LS0tIGJsdWV6LTQuOTktb3JpZy9hdWRpby9wY21fYmx1ZXRvb3RoLmMJMjAxMS0xMi0yMSAyMzo1
Mzo1NC4wMDAwMDAwMDAgKzAxMDAKKysrIGJsdWV6LTQuOTkvYXVkaW8vcGNtX2JsdWV0b290aC5j
CTIwMTItMDMtMjggMDE6MjA6NDEuOTc3ODI5MDgwICswMjAwCkBAIC03OCw3ICs3OCw3IEBACiAj
IGRlZmluZSBNQVgoeCwgeSkgKCh4KSA+ICh5KSA/ICh4KSA6ICh5KSkKICNlbmRpZgogCi0jZGVm
aW5lIE1BWF9CSVRQT09MIDY0CisjZGVmaW5lIE1BWF9CSVRQT09MIDI1MAogI2RlZmluZSBNSU5f
QklUUE9PTCAyCiAKIC8qIGFkYXB0ZWQgZnJvbSBnbGliYyBzeXMvdGltZS5oIHRpbWVyc3ViKCkg
bWFjcm8gKi8KQEAgLTYwNiwxMyArNjA2LDEyIEBACiAJCWNhcC0+YWxsb2NhdGlvbl9tZXRob2Qg
PSBCVF9BMkRQX0FMTE9DQVRJT05fU05SOwogCiAJaWYgKGNmZy0+aGFzX2JpdHBvb2wpCi0JCW1p
bl9iaXRwb29sID0gbWF4X2JpdHBvb2wgPSBjZmctPmJpdHBvb2w7Ci0JZWxzZSB7Ci0JCW1pbl9i
aXRwb29sID0gTUFYKE1JTl9CSVRQT09MLCBjYXAtPm1pbl9iaXRwb29sKTsKLQkJbWF4X2JpdHBv
b2wgPSBNSU4oZGVmYXVsdF9iaXRwb29sKGNhcC0+ZnJlcXVlbmN5LAotCQkJCQljYXAtPmNoYW5u
ZWxfbW9kZSksCi0JCQkJCWNhcC0+bWF4X2JpdHBvb2wpOwotCX0KKwkJZGF0YS0+YTJkcC5zYmMu
Yml0cG9vbCA9IGNmZy0+Yml0cG9vbDsKKwllbHNlIC8qIEluaXRpYWxpemUgdG8gTUlOX0JJVFBP
T0wgaW4gb3JkZXIgdG8gcmVwbGFjZSBpdCB3aXRoIG5lZ290aWF0ZWQgbWF4aW11bSAqLworCQlk
YXRhLT5hMmRwLnNiYy5iaXRwb29sID0gTUlOX0JJVFBPT0w7CisKKwltaW5fYml0cG9vbCA9IE1B
WChNSU5fQklUUE9PTCwgY2FwLT5taW5fYml0cG9vbCk7CisJbWF4X2JpdHBvb2wgPSBNSU4oTUFY
X0JJVFBPT0wsIGNhcC0+bWF4X2JpdHBvb2wpOwogCiAJY2FwLT5taW5fYml0cG9vbCA9IG1pbl9i
aXRwb29sOwogCWNhcC0+bWF4X2JpdHBvb2wgPSBtYXhfYml0cG9vbDsKQEAgLTYyMywxMSArNjIy
LDE1IEBACiBzdGF0aWMgdm9pZCBibHVldG9vdGhfYTJkcF9zZXR1cChzdHJ1Y3QgYmx1ZXRvb3Ro
X2EyZHAgKmEyZHApCiB7CiAJc2JjX2NhcGFiaWxpdGllc190IGFjdGl2ZV9jYXBhYmlsaXRpZXMg
PSBhMmRwLT5zYmNfY2FwYWJpbGl0aWVzOworCWludCBzdG9yZWRfYml0cG9vbCA9IGEyZHAtPnNi
Yy5iaXRwb29sOwogCiAJaWYgKGEyZHAtPnNiY19pbml0aWFsaXplZCkKIAkJc2JjX3JlaW5pdCgm
YTJkcC0+c2JjLCAwKTsKIAllbHNlCiAJCXNiY19pbml0KCZhMmRwLT5zYmMsIDApOworCisJLyog
cmVzdG9yZSBjb25maWd1cmVkIChvciBtaW5pbXVtKSBiaXRwb29sICovCisJYTJkcC0+c2JjLmJp
dHBvb2wgPSBzdG9yZWRfYml0cG9vbDsKIAlhMmRwLT5zYmNfaW5pdGlhbGl6ZWQgPSAxOwogCiAJ
aWYgKGFjdGl2ZV9jYXBhYmlsaXRpZXMuZnJlcXVlbmN5ICYgQlRfU0JDX1NBTVBMSU5HX0ZSRVFf
MTYwMDApCkBAIC02ODIsNyArNjg1LDEwIEBACiAJCWJyZWFrOwogCX0KIAotCWEyZHAtPnNiYy5i
aXRwb29sID0gYWN0aXZlX2NhcGFiaWxpdGllcy5tYXhfYml0cG9vbDsKKwkvKiBJbmNyZWFzZSB0
aGUgYml0cG9vbCB0byBhbGxvd2VkIG1heGltdW0sIGlmIGl0IHdhcyBub3QgY29uZmlndXJlZCAq
LworCWlmKGEyZHAtPnNiYy5iaXRwb29sIDw9IE1JTl9CSVRQT09MKQorCSAgICBhMmRwLT5zYmMu
Yml0cG9vbCA9IGFjdGl2ZV9jYXBhYmlsaXRpZXMubWF4X2JpdHBvb2w7CisgCiAJYTJkcC0+Y29k
ZXNpemUgPSBzYmNfZ2V0X2NvZGVzaXplKCZhMmRwLT5zYmMpOwogCWEyZHAtPmNvdW50ID0gc2l6
ZW9mKHN0cnVjdCBydHBfaGVhZGVyKSArIHNpemVvZihzdHJ1Y3QgcnRwX3BheWxvYWQpOwogfQpA
QCAtMTcxNCw3ICsxNzIwLDcgQEAKIAkJZ290byBmYWlsZWQ7CiAKIAlibHVldG9vdGhfcGFyc2Vf
Y2FwYWJpbGl0aWVzKGRhdGEsIHJzcCk7Ci0KKwkKIAlyZXR1cm4gMDsKIAogZmFpbGVkOgo=
--20cf300faf0fde4c2b04bc41d8da--
