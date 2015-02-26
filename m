Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/att: Emulate security level
Date: Thu, 26 Feb 2015 16:03:20 +0200
Message-Id: <1424959400-18701-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1424959400-18701-1-git-send-email-luiz.dentz@gmail.com>
References: <1424959400-18701-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Emulate security level with SO_PRIORITY.
---
 src/shared/att.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index aa06dc6..ba17f78 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1343,6 +1343,20 @@ bool bt_att_unregister_all(struct bt_att *att)
 	return true;
 }
 
+static int socket_get_sec_level(struct bt_att *att)
+{
+	socklen_t len;
+	uint32_t prio;
+
+	len = sizeof(prio);
+
+	/* Emulate sec level with SO_PRIORITY */
+	if (getsockopt(att->fd, SOL_SOCKET, SO_PRIORITY, &prio, &len) < 0)
+		return -errno;
+
+	return prio;
+}
+
 int bt_att_get_sec_level(struct bt_att *att)
 {
 	struct bt_security sec;
@@ -1351,12 +1365,8 @@ int bt_att_get_sec_level(struct bt_att *att)
 	if (!att)
 		return -EINVAL;
 
-	/*
-	 * Let's be nice for unit test.
-	 * TODO: Might be needed to emulate different levels for test purposes
-	 */
 	if (!att->io_on_l2cap)
-		return BT_SECURITY_LOW;
+		return socket_get_sec_level(att);
 
 	memset(&sec, 0, sizeof(sec));
 	len = sizeof(sec);
@@ -1366,6 +1376,13 @@ int bt_att_get_sec_level(struct bt_att *att)
 	return sec.level;
 }
 
+static bool socket_set_sec_level(struct bt_att *att, uint32_t level)
+{
+	/* Emulate sec level with SO_PRIORITY */
+	return (setsockopt(att->fd, SOL_SOCKET, SO_PRIORITY, &level,
+				sizeof(level)) < 0) ? false : true;
+}
+
 bool bt_att_set_sec_level(struct bt_att *att, int level)
 {
 	struct bt_security sec;
@@ -1373,9 +1390,8 @@ bool bt_att_set_sec_level(struct bt_att *att, int level)
 	if (!att || level < BT_SECURITY_LOW || level > BT_SECURITY_HIGH)
 		return false;
 
-	/* Let's be nice for unit test.*/
 	if (!att->io_on_l2cap)
-		return true;
+		return socket_set_sec_level(att, level);
 
 	memset(&sec, 0, sizeof(sec));
 	sec.level = level;
-- 
2.1.0

