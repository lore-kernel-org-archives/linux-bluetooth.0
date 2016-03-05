Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 6 Mar 2016 02:16:50 +0300
Message-ID: <CAAo+LNOnDtHYjfLAQXj3Tgqiibd+oyKJP9109TfoGaDuAbmgag@mail.gmail.com>
Subject: Re: BTLE pairing sequence problem
From: Andrew - <hidefromkgb@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=089e0102fc423299b4052d556dbf
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--089e0102fc423299b4052d556dbf
Content-Type: text/plain; charset=UTF-8

> why don't you look at the source code. We have a smp_c1() in net/bluetooth/smp.c in \
> the kernel (including actual test vectors). And there is also bt_crypto_c1() in \
> src/shared/crypto.c in BlueZ userspace.

Shame on me, but static analysis of the kernel code has never been a
strong point of mine.
So, the only built-in test case for smp_c1() that I found is called
test_c1(), and it contains the very case described in the standard.

As for userspace tools, I found out that they yield same results as my
code (and the former kernel code, apparently): see the attached source
file. When the second, real-life test case is commented out,
everything is ok.
Unfortunately, none of the uses of bt_crypto_c1() explain why calling
it with inputs set to legitimate values and exact packet captures does
not produce the captured result. Everything seems to comply, and I`m
sure that the problem is some insanely subtle detail I fail to
understand.

> And on a side note, the PDUs from pairing request / response need to fed into c1 as \
> they are received over the air. Meaning you can not mask out bits and then feed it \
> in. That has been clarified in an erratum and especially important for LE Secure \
> Connections (which Linux does support).

Exactly as I do, actually.
Or do I? Are these request/response packet dumps I got on my capture
the ones that have to be put into _pres and _preq variables from the
code attached?

--089e0102fc423299b4052d556dbf
Content-Type: text/x-csrc; charset=US-ASCII; name="btle.c"
Content-Disposition: attachment; filename="btle.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlICJzcmMvc2hhcmVkL3V0aWwuaCIKI2luY2x1ZGUg
InNyYy9zaGFyZWQvY3J5cHRvLmgiCgppbnQgbWFpbigpIHsKICAgIHVpbnQ4X3QgcmV0blsxNl0g
PSB7fSwgY29uZlsxNl0gPSB7fSwgX21yYW5kWzE2XSA9IHt9OwogICAgdWludDhfdCBfcHJlcVs3
XSA9IHt9LCBfcHJlc1s3XSA9IHt9OwogICAgdWludDhfdCBfaWFbNl0gPSB7fSwgX3JhWzZdID0g
e307CiAgICB1aW50OF90IF9pYXQgPSAwLCBfcmF0ID0gMDsKICAgIHVpbnQzMl90IF9jb2RlID0g
MDsKCiAgICAvLy8gZXhhbXBsZSBmcm9tIHN0YW5kYXJkOgogICAgX2NvZGUgPSAwMDAwMDA7CiAg
ICBfaWF0ID0gMHgwMTsKICAgIF9yYXQgPSAweDAwOwogICAgbWVtY3B5KCZfaWEsICJceEE2XHhB
NVx4QTRceEEzXHhBMlx4QTEiLCBzaXplb2YoX2lhKSk7IC8vLyBzdHIyYmEoIkExOkEyOkEzOkE0
OkE1OkE2IiwgJik7CiAgICBtZW1jcHkoJl9yYSwgIlx4QjZceEI1XHhCNFx4QjNceEIyXHhCMSIs
IHNpemVvZihfcmEpKTsgLy8vIHN0cjJiYSgiQjE6QjI6QjM6QjQ6QjU6QjYiLCAmKTsKICAgIG1l
bWNweSgmX3ByZXEsICJceDAxXHgwMVx4MDBceDAwXHgxMFx4MDdceDA3Iiwgc2l6ZW9mKF9wcmVx
KSk7CiAgICBtZW1jcHkoJl9wcmVzLCAiXHgwMlx4MDNceDAwXHgwMFx4MDhceDAwXHgwNSIsIHNp
emVvZihfcHJlcykpOwogICAgbWVtY3B5KF9tcmFuZCwgIlx4RTBceDJFXHg3MFx4QzZceDRFXHgy
N1x4ODhceDYzXHgwRVx4NkZceEFEXHg1Nlx4MjFceEQ1XHg4M1x4NTciLCBzaXplb2YoX21yYW5k
KSk7CiAgICBtZW1jcHkoY29uZiwgIlx4ODZceDNCXHhGMVx4QkVceEM1XHg0RFx4QTdceEQyXHhF
QVx4ODhceDg5XHg4N1x4RUZceDNGXHgxRVx4MUUiLCBzaXplb2YoY29uZikpOwoKLy8qICAvLy8g
cmVhbCBleGFtcGxlOgogICAgX2NvZGUgPSA0MTUxODg7CiAgICBfaWF0ID0gMHgwMTsKICAgIF9y
YXQgPSAweDAxOwogICAgbWVtY3B5KCZfaWEsICJceEM0XHgzMFx4MTlceDNBXHg1QVx4MzAiLCBz
aXplb2YoX2lhKSk7IC8vLyBzdHIyYmEoIjMwOjVBOjNBOjE5OjMwOkM0IiwgJik7CiAgICBtZW1j
cHkoJl9yYSwgIlx4QjlceDk3XHgyRFx4NUJceEMzXHhDMSIsIHNpemVvZihfcmEpKTsgLy8vIHN0
cjJiYSgiQzE6QzM6NUI6MkQ6OTc6QjkiLCAmKTsKICAgIG1lbWNweSgmX3ByZXEsICJceDAxXHgw
MVx4MDBceDA1XHgxMFx4MDdceDA3Iiwgc2l6ZW9mKF9wcmVxKSk7CiAgICBtZW1jcHkoJl9wcmVz
LCAiXHgwMlx4MDJceDAwXHgwNVx4MTBceDA2XHgwMyIsIHNpemVvZihfcHJlcykpOwogICAgbWVt
Y3B5KF9tcmFuZCwgIlx4REJceDdBXHg0OFx4RDlceEM1XHgxRlx4NzZceDQzXHg5Q1x4RTRceDAw
XHg1Nlx4ODRceEY0XHhFN1x4MUIiLCBzaXplb2YoX21yYW5kKSk7CiAgICBtZW1jcHkoY29uZiwg
Ilx4RUZceERDXHgxQ1x4NjNceEFGXHg4Qlx4OTdceDFEXHhGQ1x4MzVceDFGXHgxRFx4MjZceDIx
XHg2MFx4RkMiLCBzaXplb2YoY29uZikpOwovLyovCgogICAgdWludDhfdCBrWzE2XSA9IHt9OwoK
ICAgIHB1dF9sZTMyKF9jb2RlLCBrKTsKICAgIGJ0X2NyeXB0b19jMShidF9jcnlwdG9fbmV3KCks
IGssIF9tcmFuZCwgJl9wcmVzLCAmX3ByZXEsIF9pYXQsICZfaWEsIF9yYXQsICZfcmEsIHJldG4p
OwogICAgdXRpbF9oZXhkdW1wKCdcbicsIHJldG4sIHNpemVvZihyZXRuKSwgcHJpbnRmLCAwKTsK
ICAgIHV0aWxfaGV4ZHVtcCgnXG4nLCBjb25mLCBzaXplb2YoY29uZiksIHByaW50ZiwgMCk7CiAg
ICBwcmludGYoIlxuXG4gJXMhXG4iLCAobWVtY21wKHJldG4sIGNvbmYsIHNpemVvZihyZXRuKSkp
PyAiRkFJTCIgOiAiUEFTUyIpOwogICAgcmV0dXJuIDA7Cn0K
--089e0102fc423299b4052d556dbf--
