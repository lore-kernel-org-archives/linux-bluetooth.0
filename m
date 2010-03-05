Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 5 Mar 2010 15:00:31 +0200
Message-ID: <2d5a2c101003050500m2530d2a9n8bcae529e540c726@mail.gmail.com>
Subject: PATCH] Fix not emitting error properly when sco connection fails
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016367fa3deea925804810d4c88
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016367fa3deea925804810d4c88
Content-Type: text/plain; charset=ISO-8859-1

---
 audio/headset.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 15d3672..0176937 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -573,6 +573,7 @@ static void sco_connect_cb(GIOChannel *chan,
GError *err, gpointer user_data)

 	if (err) {
 		error("%s", err->message);
+		p->err = -errno;

 		if (p && p->msg)
 			error_connection_attempt_failed(dev->conn, p->msg, p->err);
-- 
1.6.3.3


-- 
Luiz Augusto von Dentz
Computer Engineer

--0016367fa3deea925804810d4c88
Content-Type: text/x-patch; charset=US-ASCII;
	name="0010-Fix-not-emitting-error-properly-when-sco-connection-.patch"
Content-Disposition: attachment;
	filename="0010-Fix-not-emitting-error-properly-when-sco-connection-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6ezswht0

RnJvbSBkZmNjNmIwYmZkOGVkNzU2MzA5NjhkYmI0OTY3YzMxZjZhMGRkMzlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gVm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IEZyaSwgNSBNYXIgMjAxMCAxNDoxOTo1OCArMDIwMApTdWJqZWN0
OiBbUEFUQ0ggMTAvMTFdIEZpeCBub3QgZW1pdHRpbmcgZXJyb3IgcHJvcGVybHkgd2hlbiBzY28g
Y29ubmVjdGlvbiBmYWlscwoKLS0tCiBhdWRpby9oZWFkc2V0LmMgfCAgICAxICsKIDEgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2F1
ZGlvL2hlYWRzZXQuYyBiL2F1ZGlvL2hlYWRzZXQuYwppbmRleCAxNWQzNjcyLi4wMTc2OTM3IDEw
MDY0NAotLS0gYS9hdWRpby9oZWFkc2V0LmMKKysrIGIvYXVkaW8vaGVhZHNldC5jCkBAIC01NzMs
NiArNTczLDcgQEAgc3RhdGljIHZvaWQgc2NvX2Nvbm5lY3RfY2IoR0lPQ2hhbm5lbCAqY2hhbiwg
R0Vycm9yICplcnIsIGdwb2ludGVyIHVzZXJfZGF0YSkKIAogCWlmIChlcnIpIHsKIAkJZXJyb3Io
IiVzIiwgZXJyLT5tZXNzYWdlKTsKKwkJcC0+ZXJyID0gLWVycm5vOwogCiAJCWlmIChwICYmIHAt
Pm1zZykKIAkJCWVycm9yX2Nvbm5lY3Rpb25fYXR0ZW1wdF9mYWlsZWQoZGV2LT5jb25uLCBwLT5t
c2csIHAtPmVycik7Ci0tIAoxLjYuMy4zCgo=
--0016367fa3deea925804810d4c88--
