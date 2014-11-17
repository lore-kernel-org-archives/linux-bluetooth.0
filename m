Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 02/12] shared/att: Add bt_att_get_fd.
Date: Mon, 17 Nov 2014 11:22:08 -0800
Message-Id: <1416252138-17477-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1416252138-17477-1-git-send-email-armansito@chromium.org>
References: <1416252138-17477-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a getter for a bt_att structure's underlying connection
file descriptor.
---
 src/shared/att.c | 8 ++++++++
 src/shared/att.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 2bc7682..264cece 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -907,6 +907,14 @@ void bt_att_unref(struct bt_att *att)
 	free(att);
 }
 
+int bt_att_get_fd(struct bt_att *att)
+{
+	if (!att)
+		return -1;
+
+	return att->fd;
+}
+
 bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
 {
 	if (!att || !att->io)
diff --git a/src/shared/att.h b/src/shared/att.h
index 99b5a5b..b946b18 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -33,6 +33,7 @@ struct bt_att *bt_att_new(int fd);
 struct bt_att *bt_att_ref(struct bt_att *att);
 void bt_att_unref(struct bt_att *att);
 
+int bt_att_get_fd(struct bt_att *att);
 bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
 
 typedef void (*bt_att_response_func_t)(uint8_t opcode, const void *pdu,
-- 
2.1.0.rc2.206.gedb03e5

