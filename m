Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 5 Mar 2010 15:03:56 +0200
Message-ID: <2d5a2c101003050503j4e9bf8a0hdd91c8af4a9bb5a4@mail.gmail.com>
Subject: [PATCH] Fix error not being propagated properly
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e6d77e5e202a8d04810d59ab
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6d77e5e202a8d04810d59ab
Content-Type: text/plain; charset=ISO-8859-1

---
 audio/headset.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 0176937..893edd0 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -198,7 +198,7 @@ static DBusHandlerResult
error_connection_attempt_failed(DBusConnection *conn,
 {
 	return error_common_reply(conn, msg,
 			ERROR_INTERFACE ".ConnectionAttemptFailed",
-			err > 0 ? strerror(err) : "Connection attempt failed");
+			err < 0 ? strerror(-err) : "Connection attempt failed");
 }

 static int rfcomm_connect(struct audio_device *device, headset_stream_cb_t cb,
@@ -435,7 +435,7 @@ static void pending_connect_complete(struct
connect_cb *cb, struct audio_device
 {
 	struct headset *hs = dev->headset;

-	if (hs->pending->err)
+	if (hs->pending->err < 0)
 		cb->cb(NULL, cb->cb_data);
 	else
 		cb->cb(dev, cb->cb_data);
-- 
1.6.3.3


-- 
Luiz Augusto von Dentz
Computer Engineer

--0016e6d77e5e202a8d04810d59ab
Content-Type: text/x-patch; charset=US-ASCII;
	name="0010-Fix-not-emitting-error-properly-when-sco-connection-.patch"
Content-Disposition: attachment;
	filename="0010-Fix-not-emitting-error-properly-when-sco-connection-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6ezy4j30

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
--0016e6d77e5e202a8d04810d59ab--
