Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABax29XWLWcBT6hHgSQud6qzhQ-Y-WAMjQ8ytCT7Px09H1iQtg@mail.gmail.com>
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
Date: Tue, 27 Mar 2012 10:57:58 +0300
Message-ID: <CACY+gR3aPvvMRvNW+c3QdF8UkGR4ZGPChWt4MAoa+5fK=HSBNQ@mail.gmail.com>
Subject: Re: [PATCH] Re: A2DP quality (bluetooth-alsa)
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=f46d042f9db66624f004bc34d982
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d042f9db66624f004bc34d982
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2012 at 4:29 AM, qduaty <qduaty@gmail.com> wrote:
>> 2012/3/26 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>>> Floating point code does not need any rounding coefficient.
>
> I'm very likely to agreed that I was wrong with initializing t1
> elements to 1, but seemingly it helps with quality, especially in
> conjunction with accumError. So either I discovered something new, or
> I repeatedly "hear" my changes in C code instead of actual difference.

I think Double Blind listening Test is necessary, otherwise everything
is very subjective:
    http://www.hydrogenaudio.org/forums/index.php?showtopic=3D16295

> Maybe I should look at sbcdec output.

You could also look at fixing sbc decoder, it still does have some
real audio quality problems :)

> Regarding the bitpool:
>
>>> Do you have a hcidump log before and after patching bluez for the part
>>> where A2DP settings are negotiated?
>
> Actually I just forced bluez to use higher bitpool for SBC than
> negotiated. This is the hcidump after the change, but it does not
> differ from what has been before.
>
>> ACL data: handle 1 flags 0x02 dlen 20
> =C2=A0 =C2=A0L2CAP(d): cid 0x0040 len 16 [psm 25]
> =C2=A0 =C2=A0 =C2=A0AVDTP(s): Capabilities rsp: transaction 4 nsp 0x00
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Media Transport
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Media Codec - SBC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016kHz 32kHz 44.1kHz 48kHz
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mono DualChannel Stereo JointStereo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 8 12 16 Blocks
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 8 Subbands
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SNR Loudness
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Bitpool Range 2-53
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Content Protection
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A002 00
> < ACL data: handle 1 flags 0x02 dlen 18
> =C2=A0 =C2=A0L2CAP(d): cid 0x0060 len 14 [psm 25]
> =C2=A0 =C2=A0 =C2=A0AVDTP(s): Set config cmd: transaction 5 nsp 0x00
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ACP SEID 1 - INT SEID 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Media Transport
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Media Codec - SBC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A044.1kHz
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Stereo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016 Blocks
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08 Subbands
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Loudness
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Bitpool Range 46-46
>
> The headset reports bltpool range of 2-53 and bluez reports 46-46, but
> according to Blueman, it streams at 99 KB/s

This is getting really confusing. If I run blueman, it reports ~40
KB/s for bitpool 53, ~48 KB/s for bitpool 64 and ~36 KB/s for bitpool
46 (if I add 'bitpool "46"' line to my .asoundrc).

> Also, I removed calls to
> default_bitpool(), which is now reported as unused function, and
> increased MAX_BITPOOL everywhere. It does not change anything.

I have attached two test patches.

The first patch adds debug prints to syslog from sbc encoder, just to
clearly confirm the real bitpool used by the encoder. If the encoder
is encoding data with some certain bitpool settings and you hear
something from your headset, then there is no way for the bitpool to
be magically different from that.

The second patch removes default_bitpool() limitation, and this boosts
bitpool from 53 to 64 for me. Confirmed by sbc encoder debug prints
from my first patch, hcidump log and blueman streaming rate
statistics.

> When bitpool is not set in ./asoundrc, Bluez responds with the same
> values it received from the device. There is a difference between
> Bluez and WinMo, which first sends its own capabilities and then asks
> the device (see my previous hcidump). I don't know what BH-503
> answers, but it's possible that it adapts to higher limits of the
> phone and reports higher bitpools than 53, or the phone overrides
> negotiated settings and streams at any bitpool it likes. I tested it
> with bitpools up to 250 and it always worked. Contrary to that, Bluez
> copies the (fake or backward-compatible) value of 53 that was received
> from the device and limits itself instead of reporting its real
> capabilities.

--=20
Best regards,
Siarhei Siamashka

--f46d042f9db66624f004bc34d982
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-HACK-report-bitpool-to-syslog-from-sbc-encoder.patch"
Content-Disposition: attachment;
	filename="0001-HACK-report-bitpool-to-syslog-from-sbc-encoder.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0amv6e20

RnJvbSA5NGE3NDk0ZjA2M2IzZTIyYzhlMmMzNTU2YTAyMWM1MzE1NTk4ZTg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaWFyaGVpIFNpYW1hc2hrYSA8c2lhcmhlaS5zaWFtYXNoa2FA
Z21haWwuY29tPgpEYXRlOiBUdWUsIDI3IE1hciAyMDEyIDEwOjAzOjAwICswMzAwClN1YmplY3Q6
IFtQQVRDSCAxLzJdIEhBQ0s6IHJlcG9ydCBiaXRwb29sIHRvIHN5c2xvZyBmcm9tIHNiYyBlbmNv
ZGVyCgotLS0KIHNiYy9zYmMuYyB8ICAgIDMgKysrCiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zYmMvc2JjLmMgYi9zYmMvc2Jj
LmMKaW5kZXggYzUwMTVhYi4uMDI3MzAzNSAxMDA2NDQKLS0tIGEvc2JjL3NiYy5jCisrKyBiL3Ni
Yy9zYmMuYwpAQCAtNDIsNiArNDIsNyBAQAogI2luY2x1ZGUgPHN0ZGxpYi5oPgogI2luY2x1ZGUg
PHN5cy90eXBlcy5oPgogI2luY2x1ZGUgPGxpbWl0cy5oPgorI2luY2x1ZGUgPHN5c2xvZy5oPgog
CiAjaW5jbHVkZSAic2JjX21hdGguaCIKICNpbmNsdWRlICJzYmNfdGFibGVzLmgiCkBAIC0xMDYw
LDkgKzEwNjEsMTEgQEAgc3NpemVfdCBzYmNfZW5jb2RlKHNiY190ICpzYmMsIGNvbnN0IHZvaWQg
KmlucHV0LCBzaXplX3QgaW5wdXRfbGVuLAogCiAJCXNiY19lbmNvZGVyX2luaXQoJnByaXYtPmVu
Y19zdGF0ZSwgJnByaXYtPmZyYW1lKTsKIAkJcHJpdi0+aW5pdCA9IDE7CisJCXN5c2xvZyhMT0df
VVNFUiB8IExPR19JTkZPLCAic2JjX2VuY29kZTogYml0cG9vbCBzZXQgdG8gJWRcbiIsIHNiYy0+
Yml0cG9vbCk7CiAJfSBlbHNlIGlmIChwcml2LT5mcmFtZS5iaXRwb29sICE9IHNiYy0+Yml0cG9v
bCkgewogCQlwcml2LT5mcmFtZS5sZW5ndGggPSBzYmNfZ2V0X2ZyYW1lX2xlbmd0aChzYmMpOwog
CQlwcml2LT5mcmFtZS5iaXRwb29sID0gc2JjLT5iaXRwb29sOworCQlzeXNsb2coTE9HX1VTRVIg
fCBMT0dfSU5GTywgInNiY19lbmNvZGU6IGJpdHBvb2wgY2hhbmdlZCB0byAlZFxuIiwgc2JjLT5i
aXRwb29sKTsKIAl9CiAKIAkvKiBpbnB1dCBtdXN0IGJlIGxhcmdlIGVub3VnaCB0byBlbmNvZGUg
YSBjb21wbGV0ZSBmcmFtZSAqLwotLSAKMS43LjMuNAoK
--f46d042f9db66624f004bc34d982
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-HACK-remove-default_bitpool-limitation.patch"
Content-Disposition: attachment;
	filename="0002-HACK-remove-default_bitpool-limitation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0amvktn1

RnJvbSBiYmQ1MTAyYTE4NWQ4YzgwYjM2Njg4NjQ2MThmMzQzNTljMmQyMTM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaWFyaGVpIFNpYW1hc2hrYSA8c2lhcmhlaS5zaWFtYXNoa2FA
Z21haWwuY29tPgpEYXRlOiBUdWUsIDI3IE1hciAyMDEyIDEwOjEwOjI3ICswMzAwClN1YmplY3Q6
IFtQQVRDSCAyLzJdIEhBQ0s6IHJlbW92ZSBkZWZhdWx0X2JpdHBvb2wgbGltaXRhdGlvbgoKLS0t
CiBhdWRpby9hMmRwLmMgICAgICAgICAgfCAgICAzICstLQogYXVkaW8vcGNtX2JsdWV0b290aC5j
IHwgICAgNCArLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9hdWRpby9hMmRwLmMgYi9hdWRpby9hMmRwLmMKaW5kZXggNjIz
YTBiYy4uODE1MzgxOSAxMDA2NDQKLS0tIGEvYXVkaW8vYTJkcC5jCisrKyBiL2F1ZGlvL2EyZHAu
YwpAQCAtMTgzOSw4ICsxODM5LDcgQEAgc3RhdGljIGdib29sZWFuIHNlbGVjdF9zYmNfcGFyYW1z
KHN0cnVjdCBzYmNfY29kZWNfY2FwICpjYXAsCiAJCWNhcC0+YWxsb2NhdGlvbl9tZXRob2QgPSBT
QkNfQUxMT0NBVElPTl9TTlI7CiAKIAltaW5fYml0cG9vbCA9IE1BWChNSU5fQklUUE9PTCwgc3Vw
cG9ydGVkLT5taW5fYml0cG9vbCk7Ci0JbWF4X2JpdHBvb2wgPSBNSU4oZGVmYXVsdF9iaXRwb29s
KGNhcC0+ZnJlcXVlbmN5LCBjYXAtPmNoYW5uZWxfbW9kZSksCi0JCQkJCQkJc3VwcG9ydGVkLT5t
YXhfYml0cG9vbCk7CisJbWF4X2JpdHBvb2wgPSBNQVgobWluX2JpdHBvb2wsIHN1cHBvcnRlZC0+
bWF4X2JpdHBvb2wpOwogCiAJY2FwLT5taW5fYml0cG9vbCA9IG1pbl9iaXRwb29sOwogCWNhcC0+
bWF4X2JpdHBvb2wgPSBtYXhfYml0cG9vbDsKZGlmZiAtLWdpdCBhL2F1ZGlvL3BjbV9ibHVldG9v
dGguYyBiL2F1ZGlvL3BjbV9ibHVldG9vdGguYwppbmRleCA4NTU2NmEzLi45MTMwZTM1IDEwMDY0
NAotLS0gYS9hdWRpby9wY21fYmx1ZXRvb3RoLmMKKysrIGIvYXVkaW8vcGNtX2JsdWV0b290aC5j
CkBAIC02MDksOSArNjA5LDcgQEAgc3RhdGljIGludCBibHVldG9vdGhfYTJkcF9pbml0KHN0cnVj
dCBibHVldG9vdGhfZGF0YSAqZGF0YSwKIAkJbWluX2JpdHBvb2wgPSBtYXhfYml0cG9vbCA9IGNm
Zy0+Yml0cG9vbDsKIAllbHNlIHsKIAkJbWluX2JpdHBvb2wgPSBNQVgoTUlOX0JJVFBPT0wsIGNh
cC0+bWluX2JpdHBvb2wpOwotCQltYXhfYml0cG9vbCA9IE1JTihkZWZhdWx0X2JpdHBvb2woY2Fw
LT5mcmVxdWVuY3ksCi0JCQkJCWNhcC0+Y2hhbm5lbF9tb2RlKSwKLQkJCQkJY2FwLT5tYXhfYml0
cG9vbCk7CisJCW1heF9iaXRwb29sID0gTUFYKG1pbl9iaXRwb29sLCBjYXAtPm1heF9iaXRwb29s
KTsKIAl9CiAKIAljYXAtPm1pbl9iaXRwb29sID0gbWluX2JpdHBvb2w7Ci0tIAoxLjcuMy40Cgo=
--f46d042f9db66624f004bc34d982--
