Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 16 Feb 2010 16:37:06 +0200
Message-ID: <2d5a2c101002160637k59f9cb0fx963d3b489ee37df3@mail.gmail.com>
Subject: [PATCH] Fix bug on ftp plugin when mimetype exists but is unknown
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e6dab6dcfb25cd047fb8aa42
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6dab6dcfb25cd047fb8aa42
Content-Type: text/plain; charset=ISO-8859-1

Hi,

The code was returning FALSE (0) when it should return a posix error thus
causing a unkown mimetype to not be handle by mimetype drivers as it
should.

ps: obexd patch

Regards,

-- 
Luiz Augusto von Dentz
Computer Engineer

--0016e6dab6dcfb25cd047fb8aa42
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-bug-on-ftp-plugin-when-mimetype-exists-but-is-un.patch"
Content-Disposition: attachment;
	filename="0001-Fix-bug-on-ftp-plugin-when-mimetype-exists-but-is-un.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5qsprhs0

RnJvbSA3NGE2NzU4N2UzZjMwNzg4YzcxNDU4MmNjZThmMmY3OTA0NjUyNjFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gVm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IE1vbiwgMTUgRmViIDIwMTAgMTM6MzM6MDYgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBGaXggYnVnIG9uIGZ0cCBwbHVnaW4gd2hlbiBtaW1ldHlwZSBleGlzdHMgYnV0
IGlzIHVua25vd24KClRoZSBjb2RlIHdhcyByZXR1cm5pbmcgRkFMU0UgKDApIHdoZW4gaXQgc2hv
dWxkIHJldHVybiBhIHBvc2l4IGVycm9yIHRodXMKY2F1c2luZyBhIHVua293biBtaW1ldHlwZSB0
byBub3QgYmUgaGFuZGxlIGJ5IG1pbWV0eXBlIGRyaXZlcnMgYXMgaXQKc2hvdWxkLgotLS0KIHBs
dWdpbnMvZnRwLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wbHVnaW5zL2Z0cC5jIGIvcGx1Z2lucy9mdHAu
YwppbmRleCBmMTU1OTdlLi5lMGEzYjk3IDEwMDY0NAotLS0gYS9wbHVnaW5zL2Z0cC5jCisrKyBi
L3BsdWdpbnMvZnRwLmMKQEAgLTE1NSw3ICsxNTUsNyBAQCBzdGF0aWMgZ2ludCBnZXRfYnlfdHlw
ZShzdHJ1Y3Qgb2JleF9zZXNzaW9uICpvcywgZ2NoYXIgKnR5cGUsIHNpemVfdCAqc2l6ZSkKIAlp
ZiAoZ19zdHJfZXF1YWwodHlwZSwgTFNUX1RZUEUpKQogCQlyZXR1cm4gb3NfcHJlcGFyZV9nZXQo
b3MsIG9zLT5jdXJyZW50X2ZvbGRlciwgc2l6ZSk7CiAKLQlyZXR1cm4gRkFMU0U7CisJcmV0dXJu
IC1FTk9FTlQ7CiB9CiAKIHN0YXRpYyBnaW50IGZ0cF9wcmVwYXJlX2dldChzdHJ1Y3Qgb2JleF9z
ZXNzaW9uICpvcywgZ2NoYXIgKmZpbGUsCi0tIAoxLjYuMy4zCgo=
--0016e6dab6dcfb25cd047fb8aa42--
