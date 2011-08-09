Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Fix missing Name header check in FTP action code
Date: Tue,  9 Aug 2011 10:44:39 +0200
Message-Id: <1312879479-4577-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/ftp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 57fd23b..8705975 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -541,6 +541,10 @@ int ftp_action(struct obex_session *os, obex_object_t *obj, void *user_data)
 	uint8_t action_id;
 
 	name = obex_get_name(os);
+
+	if (name == NULL || !is_filename(name))
+		return -EBADR;
+
 	destname = obex_get_destname(os);
 	action_id = obex_get_action_id(os);
 
-- 
1.7.4.1

