Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 10 Feb 2010 21:10:55 -0200
Message-ID: <f9d4bd31002101510y1435f74ev886d7993959990ff@mail.gmail.com>
Subject: [PATCH] Fix segmentation fault when headset disconnects during
	authorization
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=000e0cd299447db5d3047f472550
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd299447db5d3047f472550
Content-Type: text/plain; charset=UTF-8

Hi guys,

This patch fix a segmentation fault when the headset disconnected
during authorization, see gdb backtrace:
http://pastebin.com/m1529c2dc

Can someone fix avctp now? For this case, answering "yes" in agent
avctp connection will be left open:

bluetoothd[5406]: Headset disconnected during authorization
bluetoothd[5406]: State changed
/org/bluez/5406/hci0/dev_00_15_A0_0F_76_CF: HEADSET_STATE_CONNECTING
-> HEADSET_STATE_DISCONNECTED
bluetoothd[5406]: AVCTP: connected to 00:15:A0:0F:76:CF
bluetoothd[5406]: Can't open input device: No such file or directory (2)
bluetoothd[5406]: AVRCP: failed to init uinput for 00:15:A0:0F:76:CF
bluetoothd[5406]: AVCTP Connected


Regards,
Claudio.

--000e0cd299447db5d3047f472550
Content-Type: application/octet-stream;
	name="0001-Fix-segmentation-fault-when-headset-disconnects-duri.patch"
Content-Disposition: attachment;
	filename="0001-Fix-segmentation-fault-when-headset-disconnects-duri.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5iq5rp70

RnJvbSA5NmY2NDBlZDE4ZGJmMzRmMGFhNzM5ZDhmYjA4YzUyOWVkZmI3NGVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDbGF1ZGlvIFRha2FoYXNpIDxjbGF1ZGlvLnRha2FoYXNpQG9w
ZW5ib3NzYS5vcmc+CkRhdGU6IFdlZCwgMTAgRmViIDIwMTAgMTI6Mjk6MTYgLTAyMDAKU3ViamVj
dDogW1BBVENIIDEvMV0gRml4IHNlZ21lbnRhdGlvbiBmYXVsdCB3aGVuIGhlYWRzZXQgZGlzY29u
bmVjdHMgZHVyaW5nIGF1dGhvcml6YXRpb24KCkhlYWRzZXQgYXV0aG9yaXphdGlvbiBjYWxsYmFj
ayBpcyBub3QgYmVpbmcgcmVtb3ZlZCB3aGVuIHRoZSBoZWFkc2V0CmRpc2Nvbm5lY3RzIGR1cmlu
ZyBhdXRob3JpemF0aW9uLiBDYW5jZWwgYXV0aG9yaXphdGlvbiBmdW5jdGlvbiBvZgphdWRpbyBk
ZXZpY2VzIGRvZXNuJ3QgaXRlcmF0ZSB0aGUgY2FsbGJhY2tzIGxpc3QgcHJvcGVybHkuCi0tLQog
YXVkaW8vZGV2aWNlLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hdWRpby9kZXZpY2UuYyBiL2F1ZGlvL2Rl
dmljZS5jCmluZGV4IGI4ZWE5MjcuLjc2YWFkZGQgMTAwNjQ0Ci0tLSBhL2F1ZGlvL2RldmljZS5j
CisrKyBiL2F1ZGlvL2RldmljZS5jCkBAIC03ODEsNyArNzgxLDcgQEAgaW50IGF1ZGlvX2Rldmlj
ZV9jYW5jZWxfYXV0aG9yaXphdGlvbihzdHJ1Y3QgYXVkaW9fZGV2aWNlICpkZXYsCiAJR1NMaXN0
ICpsLCAqbmV4dDsKIAogCWZvciAobCA9IHByaXYtPmF1dGhzOyBsICE9IE5VTEw7IGwgPSBuZXh0
KSB7Ci0JCXN0cnVjdCBzZXJ2aWNlX2F1dGggKmF1dGggPSBwcml2LT5hdXRocy0+ZGF0YTsKKwkJ
c3RydWN0IHNlcnZpY2VfYXV0aCAqYXV0aCA9IGwtPmRhdGE7CiAKIAkJbmV4dCA9IGdfc2xpc3Rf
bmV4dChsKTsKIAotLSAKMS42LjYuMQoK
--000e0cd299447db5d3047f472550--
