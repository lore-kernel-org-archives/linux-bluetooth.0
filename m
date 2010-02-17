Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 17 Feb 2010 11:39:44 +0200
Message-ID: <2d5a2c101002170139x52314d9g7b665c7fb769f40c@mail.gmail.com>
Subject: [PATCH] Fix possible crash while verifying avdtp version
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e6d623355adf89047fc8a1ae
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6d623355adf89047fc8a1ae
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Codenomicon a2dp tests makes bluetoothd to crash due to a malformed
sdp record (BlueZ 4.60):

Signal 11 (SIGSEGV)
0		avdtp_get_internal () at audio/avdtp.c:2073
1	0x00022f18	avdtp_confirm_cb (chan=0x6c0e0) at audio/avdtp.c:2266
2	0x0003a7dc	server_cb (user_data=0x6d380) at src/btio.c:193

-- 
Luiz Augusto von Dentz
Computer Engineer

--0016e6d623355adf89047fc8a1ae
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-possible-crash-while-verifying-avdtp-version.patch"
Content-Disposition: attachment;
	filename="0001-Fix-possible-crash-while-verifying-avdtp-version.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5rxl6kd0

RnJvbSA5ZmE2MGFhNjE2ZWQxZTZjNzI3OGYwY2IyNjVjODgxYzgwZTYyOGYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gVm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IFdlZCwgMTcgRmViIDIwMTAgMTE6MjI6MTYgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBGaXggcG9zc2libGUgY3Jhc2ggd2hpbGUgdmVyaWZ5aW5nIGF2ZHRwIHZlcnNp
b24KClJlcHJvZHVjaWJsZSB3aXRoIENvZGVub21pY29uIEEyRFAgdGVzdHN1aXRlIDEuNC4yLgot
LS0KIGF1ZGlvL2F2ZHRwLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hdWRpby9hdmR0cC5jIGIvYXVkaW8v
YXZkdHAuYwppbmRleCAzYjljNmMxLi5lZmVkOWI2IDEwMDY0NAotLS0gYS9hdWRpby9hdmR0cC5j
CisrKyBiL2F1ZGlvL2F2ZHRwLmMKQEAgLTIxMjUsNyArMjEyNSw3IEBAIHN0YXRpYyB1aW50MTZf
dCBnZXRfdmVyc2lvbihzdHJ1Y3QgYXZkdHAgKnNlc3Npb24pCiAJCWdvdG8gZG9uZTsKIAogCXBy
b3RvX2Rlc2MgPSBzZHBfZ2V0X3Byb3RvX2Rlc2MocHJvdG9zLCBBVkRUUF9VVUlEKTsKLQlpZiAo
cHJvdG9fZGVzYy0+ZHRkID09IFNEUF9VSU5UMTYpCisJaWYgKHByb3RvX2Rlc2MgJiYgcHJvdG9f
ZGVzYy0+ZHRkID09IFNEUF9VSU5UMTYpCiAJCXZlciA9IHByb3RvX2Rlc2MtPnZhbC51aW50MTY7
CiAKIAlzZHBfbGlzdF9mb3JlYWNoKHByb3RvcywgKHNkcF9saXN0X2Z1bmNfdCkgc2RwX2xpc3Rf
ZnJlZSwgTlVMTCk7Ci0tIAoxLjYuMy4zCgo=
--0016e6d623355adf89047fc8a1ae--
