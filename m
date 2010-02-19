Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 19 Feb 2010 18:20:48 +0200
Message-ID: <eb7933e21002190820x7b2b0ea3v3f48ce96a5d11a1e@mail.gmail.com>
Subject: [PATCH] Fix double free on AVDTP Abort response
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=000e0cd1f8b46a6aa9047ff67700
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd1f8b46a6aa9047ff67700
Content-Type: text/plain; charset=ISO-8859-1

With the patch I submitted some time ago
http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=e9b1a8f7266d0674b1ea068a5bb5698e9ee424c9
there is a code path leading to a double free:
session_cb -> avdtp_parse_resp -> avdtp_abort_resp ->
avdtp_sep_set_state(..., AVDTP_STATE_IDLE) -> handle_unanswered_req

A response to AVDTP Abort could lead to the pending request being
freed both in session_cb and handle_unanswered_req.

This patch avoids doing it in the latter function. The primary purpose
of adding handle_unanswered_req was to trigger responses on the Audio
API (it was based on avdtp.c:request_timeout). AFAIU, AVDTP Abort
doesn't lead to an API response and will be freed elsewhere
(session_cb or avdtp_unref).

/Daniel

--000e0cd1f8b46a6aa9047ff67700
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-double-free-on-AVDTP-Abort-response.patch"
Content-Disposition: attachment;
	filename="0001-Fix-double-free-on-AVDTP-Abort-response.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5v6fbew0

RnJvbSA4MDM2MzdiYzBlNDUyMzkyNDk4NzE0Y2Q4MjQ1YTA2ZjVhZWEyZWRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgT3JzdGFkaXVzIDxkYW5pZWwub3JzdGFkaXVzQGdt
YWlsLmNvbT4KRGF0ZTogRnJpLCAxOSBGZWIgMjAxMCAxNzo1MTo0OCArMDIwMApTdWJqZWN0OiBb
UEFUQ0hdIEZpeCBkb3VibGUgZnJlZSBvbiBBVkRUUCBBYm9ydCByZXNwb25zZQoKVGhlIHBlbmRp
bmcgcmVxdWVzdCBtaWdodCBiZSBmcmVlZCB0d2ljZSB3aGVuIHJlY2VpdmluZyBhbiBBYm9ydApy
ZXNwb25zZSwgaW4gaGFuZGxlX3VuYW5zd2VyZWRfcmVxIGFuZCBzZXNzaW9uX2NiLiBBdm9pZCBm
cmVlaW5nCml0IGluIGhhbmRsZV91bmFuc3dlcmVkX3JlcS4KLS0tCiBhdWRpby9hdmR0cC5jIHwg
ICAgNyArKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9hdWRpby9hdmR0cC5jIGIvYXVkaW8vYXZkdHAuYwppbmRleCAy
NTkxODQ1Li5hZTdjODhlIDEwMDY0NAotLS0gYS9hdWRpby9hdmR0cC5jCisrKyBiL2F1ZGlvL2F2
ZHRwLmMKQEAgLTkwNSw2ICs5MDUsMTMgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3VuYW5zd2VyZWRf
cmVxKHN0cnVjdCBhdmR0cCAqc2Vzc2lvbiwKIAlzdHJ1Y3QgYXZkdHBfbG9jYWxfc2VwICpsc2Vw
OwogCXN0cnVjdCBhdmR0cF9lcnJvciBlcnI7CiAKKwlpZiAoc2Vzc2lvbi0+cmVxID09IEFWRFRQ
X0FCT1JUKSB7CisJCS8qIEF2b2lkIGZyZWVpbmcgdGhlIEFib3J0IHJlcXVlc3QgaGVyZSAqLwor
CQlkZWJ1ZygiaGFuZGxlX3VuYW5zd2VyZWRfcmVxOiBBYm9ydCByZXEsIHJldHVybmluZyIpOwor
CQlzZXNzaW9uLT5yZXEtPnN0cmVhbSA9IE5VTEw7CisJCXJldHVybjsKKwl9CisKIAlyZXEgPSBz
ZXNzaW9uLT5yZXE7CiAJc2Vzc2lvbi0+cmVxID0gTlVMTDsKIAotLSAKMS42LjAuNAoK
--000e0cd1f8b46a6aa9047ff67700--
