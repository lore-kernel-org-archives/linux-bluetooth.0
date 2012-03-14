Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACY+gR0DJfbOgfSGHrsAj5vk00v4-_+KYwR+SF+0BRRs2oYBkw@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
	<CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
	<CABax29U8N2nOge34tr=G2f-fZvowCHPf3V=N2an-vC+x=UBdiQ@mail.gmail.com>
	<CACY+gR2PkP76J2Dw9xobpeGsU2HKhsOYvU6Wcx8WCcq1opihiA@mail.gmail.com>
	<CABax29VadeA+6WZWRDiZZUhpRqk2Nk35__b0Cjfz8HO12Tq4vQ@mail.gmail.com>
	<CACY+gR0DJfbOgfSGHrsAj5vk00v4-_+KYwR+SF+0BRRs2oYBkw@mail.gmail.com>
Date: Wed, 14 Mar 2012 13:53:59 +0100
Message-ID: <CABax29X+ke_PO9obAxbEJjdx68g8JW4ZZn7vS7mYpE7+00iYng@mail.gmail.com>
Subject: Re: A2DP quality (bluetooth-alsa)
From: qduaty <qduaty@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0023545300901f404804bb33782e
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0023545300901f404804bb33782e
Content-Type: text/plain; charset=ISO-8859-1

2012/3/13 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
> Are you now comparing streaming of A2DP audio from your phone to your
> PC (using bluez A2DP sink) and to your bluetooth headset?

I assume that the phone streams data to the headset (whose session is
hard to dump on Windows mobile) with bitpool = 112, ie. the same it
fails to set in Bluez and I'm saying it gives good results in terms of
perceiveable quality, from which Bluez cannot take advantage due to
its inherent bitpool=53 limitation.

Anyway, I did some additional listening tests (by listening to Bluez
SBC on an A2DP headset). SBC_HIGH_PRECISION alone (without your hack)
only slightly improves quality. Also I finally managed to force higher
bitpool in ALSA (patch attached). This makes further improvement in
quality, at least on headsets that do not choke on higher bitpools.


Regards


--
Sebastian Olter

--0023545300901f404804bb33782e
Content-Type: application/octet-stream; name="pcm_bluetooth.c.diff"
Content-Disposition: attachment; filename="pcm_bluetooth.c.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gzsctyd60

KioqIHBjbV9ibHVldG9vdGguYwkyMDExLTEyLTIxIDIzOjUzOjU0LjAwMDAwMDAwMCArMDEwMAot
LS0gL3Vzci9zcmMvYmx1ZXotNC45OS9hdWRpby9wY21fYmx1ZXRvb3RoLmMJMjAxMi0wMy0xNCAx
Mjo1MjozNC4yOTkxNzM2ODQgKzAxMDAKKioqKioqKioqKioqKioqCioqKiA2ODAsNjkwICoqKioK
ICAJY2FzZSBCVF9BMkRQX0JMT0NLX0xFTkdUSF8xNjoKICAJCWEyZHAtPnNiYy5ibG9ja3MgPSBT
QkNfQkxLXzE2OwogIAkJYnJlYWs7CiAgCX0KICAKISAJYTJkcC0+c2JjLmJpdHBvb2wgPSBhY3Rp
dmVfY2FwYWJpbGl0aWVzLm1heF9iaXRwb29sOwogIAlhMmRwLT5jb2Rlc2l6ZSA9IHNiY19nZXRf
Y29kZXNpemUoJmEyZHAtPnNiYyk7CiAgCWEyZHAtPmNvdW50ID0gc2l6ZW9mKHN0cnVjdCBydHBf
aGVhZGVyKSArIHNpemVvZihzdHJ1Y3QgcnRwX3BheWxvYWQpOwogIH0KICAKICBzdGF0aWMgaW50
IGJsdWV0b290aF9hMmRwX2h3X3BhcmFtcyhzbmRfcGNtX2lvcGx1Z190ICppbywKLS0tIDY3OCw2
ODkgLS0tLQogIAljYXNlIEJUX0EyRFBfQkxPQ0tfTEVOR1RIXzE2OgogIAkJYTJkcC0+c2JjLmJs
b2NrcyA9IFNCQ19CTEtfMTY7CiAgCQlicmVhazsKICAJfQogIAohIAlhMmRwLT5zYmMuYml0cG9v
bCA9IGFjdGl2ZV9jYXBhYmlsaXRpZXMubWF4X2JpdHBvb2wgKiAyOwohICAKICAJYTJkcC0+Y29k
ZXNpemUgPSBzYmNfZ2V0X2NvZGVzaXplKCZhMmRwLT5zYmMpOwogIAlhMmRwLT5jb3VudCA9IHNp
emVvZihzdHJ1Y3QgcnRwX2hlYWRlcikgKyBzaXplb2Yoc3RydWN0IHJ0cF9wYXlsb2FkKTsKICB9
CiAgCiAgc3RhdGljIGludCBibHVldG9vdGhfYTJkcF9od19wYXJhbXMoc25kX3BjbV9pb3BsdWdf
dCAqaW8sCg==
--0023545300901f404804bb33782e--
