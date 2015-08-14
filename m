Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] audio: Fix not resetting connect_id
Date: Fri, 14 Aug 2015 18:48:37 +0300
Message-Id: <1439567318-23918-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Ever since discovery can be canceled connect_id is now set while
discovering so it needs to be reset on the callback otherwise it will
cause .connect to always return -EBUSY until .disconnect is called.
---
 profiles/audio/sink.c   | 2 ++
 profiles/audio/source.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 1c36735..3af8e0f 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -227,6 +227,8 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	struct sink *sink = user_data;
 	int id, perr;
 
+	sink->connect_id = 0;
+
 	if (err) {
 		avdtp_unref(sink->session);
 		sink->session = NULL;
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 16a8287..c036208 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -227,6 +227,8 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	struct source *source = user_data;
 	int id, perr;
 
+	source->connect_id = 0;
+
 	if (err) {
 		avdtp_unref(source->session);
 		source->session = NULL;
-- 
2.4.3

