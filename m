Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 18 Feb 2010 16:04:32 +0200
Message-ID: <2d5a2c101002180604u7cecd3ecsa3a047c3c28bcf61@mail.gmail.com>
Subject: [PATCH] Mark inuse flag whenever a stream is configured
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e6db2b1c3ba070047fe07211
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6db2b1c3ba070047fe07211
Content-Type: text/plain; charset=ISO-8859-1

Currently it was only marked when acting as the initiator.
---
 audio/avdtp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index efed9b6..2591845 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1426,6 +1426,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp
*session, uint8_t transaction,
 	}

 	sep->stream = stream;
+	sep->info.inuse = 1;
 	session->streams = g_slist_append(session->streams, stream);

 	avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);
-- 
1.6.3.3


-- 
Luiz Augusto von Dentz
Computer Engineer

--0016e6db2b1c3ba070047fe07211
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Mark-inuse-flag-whenever-a-stream-is-configured.patch"
Content-Disposition: attachment;
	filename="0001-Mark-inuse-flag-whenever-a-stream-is-configured.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5tmcu1y0

RnJvbSAyMmVhNTBmMjY2NjkyMjI1ZGZjMzgzNmI5MGNlZDQ1MTRlMmRlMTZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gVm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IFRodSwgMTggRmViIDIwMTAgMTM6MjE6MjEgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBNYXJrIGludXNlIGZsYWcgd2hlbmV2ZXIgYSBzdHJlYW0gaXMgY29uZmlndXJl
ZAoKQ3VycmVudGx5IGl0IHdhcyBvbmx5IG1hcmtlZCB3aGVuIGFjdGluZyBhcyB0aGUgaW5pdGlh
dG9yLgotLS0KIGF1ZGlvL2F2ZHRwLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2F1ZGlvL2F2ZHRwLmMgYi9h
dWRpby9hdmR0cC5jCmluZGV4IGVmZWQ5YjYuLjI1OTE4NDUgMTAwNjQ0Ci0tLSBhL2F1ZGlvL2F2
ZHRwLmMKKysrIGIvYXVkaW8vYXZkdHAuYwpAQCAtMTQyNiw2ICsxNDI2LDcgQEAgc3RhdGljIGdi
b29sZWFuIGF2ZHRwX3NldGNvbmZfY21kKHN0cnVjdCBhdmR0cCAqc2Vzc2lvbiwgdWludDhfdCB0
cmFuc2FjdGlvbiwKIAl9CiAKIAlzZXAtPnN0cmVhbSA9IHN0cmVhbTsKKwlzZXAtPmluZm8uaW51
c2UgPSAxOwogCXNlc3Npb24tPnN0cmVhbXMgPSBnX3NsaXN0X2FwcGVuZChzZXNzaW9uLT5zdHJl
YW1zLCBzdHJlYW0pOwogCiAJYXZkdHBfc2VwX3NldF9zdGF0ZShzZXNzaW9uLCBzZXAsIEFWRFRQ
X1NUQVRFX0NPTkZJR1VSRUQpOwotLSAKMS42LjMuMwoK
--0016e6db2b1c3ba070047fe07211--
