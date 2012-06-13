Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH obexd 5/7] Fix dead assignments
Date: Wed, 13 Jun 2012 22:49:21 +0200
Message-Id: <1339620563-25161-5-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
References: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Values stored are never read.
---
 client/pbap.c        |    2 +-
 plugins/filesystem.c |    2 +-
 plugins/pbap.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 4428c14..48dbac1 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -520,7 +520,7 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 	p = fill_apparam(p, &count, MAXLISTCOUNT_TAG, MAXLISTCOUNT_LEN);
 
 	offset = GUINT16_TO_BE(offset);
-	p = fill_apparam(p, &offset, LISTSTARTOFFSET_TAG, LISTSTARTOFFSET_LEN);
+	fill_apparam(p, &offset, LISTSTARTOFFSET_TAG, LISTSTARTOFFSET_LEN);
 
 	request = pending_request_new(pbap, message);
 
diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index 677df76..e664fc5 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -604,7 +604,7 @@ ssize_t string_read(void *object, void *buf, size_t count)
 
 	len = MIN(string->len, count);
 	memcpy(buf, string->str, len);
-	string = g_string_erase(string, 0, len);
+	g_string_erase(string, 0, len);
 
 	return len;
 }
diff --git a/plugins/pbap.c b/plugins/pbap.c
index c6d7cfc..c7e792a 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -961,7 +961,7 @@ static ssize_t array_read(GByteArray *array, void *buf, size_t count)
 
 	len = MIN(array->len, count);
 	memcpy(buf, array->data, len);
-	array = g_byte_array_remove_range(array, 0, len);
+	g_byte_array_remove_range(array, 0, len);
 
 	return len;
 }
-- 
1.7.10.4


