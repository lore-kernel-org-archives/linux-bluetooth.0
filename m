Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Add .flush callback to backup plugin
Date: Wed, 23 Feb 2011 11:54:39 +0200
Message-Id: <1298454881-7941-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1298454881-7941-1-git-send-email-luiz.dentz@gmail.com>
References: <1298454881-7941-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 plugins/nokia-backup.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/plugins/nokia-backup.c b/plugins/nokia-backup.c
index 4a69d8f..cf17e16 100644
--- a/plugins/nokia-backup.c
+++ b/plugins/nokia-backup.c
@@ -278,6 +278,13 @@ static ssize_t backup_write(void *object, const void *buf, size_t count)
 	return ret;
 }
 
+static int backup_flush(void *object)
+{
+	DBG("%p", object);
+
+	return 0;
+}
+
 static struct obex_mime_type_driver backup = {
 	.target = FTP_TARGET,
 	.target_size = TARGET_SIZE,
@@ -286,6 +293,7 @@ static struct obex_mime_type_driver backup = {
 	.close = backup_close,
 	.read = backup_read,
 	.write = backup_write,
+	.flush = backup_flush,
 };
 
 static int backup_init(void)
-- 
1.7.1

