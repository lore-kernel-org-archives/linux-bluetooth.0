Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/3] shared/att: Add set/get security level
Date: Thu, 12 Feb 2015 18:00:06 +0100
Message-Id: <1423760408-31020-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1423760408-31020-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423760408-31020-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/att.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h |  3 +++
 2 files changed, 75 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index a98909e..d2468a0 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -57,6 +57,7 @@ struct bt_att {
 	int ref_count;
 	int fd;
 	struct io *io;
+	bool io_on_l2cap;
 
 	struct queue *req_queue;	/* Queued ATT protocol requests */
 	struct att_send_op *pending_req;
@@ -774,6 +775,31 @@ static bool can_read_data(struct io *io, void *user_data)
 	return true;
 }
 
+static bool is_io_l2cap_based(int fd)
+{
+	int domain;
+	int proto;
+	int err;
+	socklen_t len;
+
+	domain = 0;
+	len = sizeof(domain);
+	err = getsockopt(fd, SOL_SOCKET, SO_DOMAIN, &domain, &len);
+	if (err < 0)
+		return false;
+
+	if (domain != AF_BLUETOOTH)
+		return false;
+
+	proto = 0;
+	len = sizeof(proto);
+	err = getsockopt(fd, SOL_SOCKET, SO_PROTOCOL, &proto, &len);
+	if (err < 0)
+		return false;
+
+	return proto == BTPROTO_L2CAP;
+}
+
 static void bt_att_free(struct bt_att *att)
 {
 	if (att->pending_req)
@@ -849,6 +875,8 @@ struct bt_att *bt_att_new(int fd)
 	if (!io_set_disconnect_handler(att->io, disconnect_cb, att, NULL))
 		goto fail;
 
+	att->io_on_l2cap = is_io_l2cap_based(att->fd);
+
 	return bt_att_ref(att);
 
 fail:
@@ -1226,3 +1254,47 @@ bool bt_att_unregister_all(struct bt_att *att)
 
 	return true;
 }
+
+int bt_att_get_sec_level(struct bt_att *att)
+{
+	struct bt_security sec;
+	socklen_t len;
+
+	if (!att)
+		return -EINVAL;
+
+	/*
+	 * Let's be nice for unit test.
+	 * TODO: Might be needed to emulate different levels for test purposes
+	 */
+	if (!att->io_on_l2cap)
+		return BT_SECURITY_LOW;
+
+	memset(&sec, 0, sizeof(sec));
+	len = sizeof(sec);
+	if (getsockopt(att->fd, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) < 0)
+		return -EIO;
+
+	return sec.level;
+}
+
+bool bt_att_set_sec_level(struct bt_att *att, int level)
+{
+	struct bt_security sec;
+
+	if (!att || level < BT_SECURITY_LOW || level > BT_SECURITY_HIGH)
+		return false;
+
+	/* Let's be nice for unit test.*/
+	if (!att->io_on_l2cap)
+		return true;
+
+	memset(&sec, 0, sizeof(sec));
+	sec.level = level;
+
+	if (setsockopt(att->fd, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) < 0)
+		return false;
+
+	return true;
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index cd00a1e..f13fc7b 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -79,3 +79,6 @@ unsigned int bt_att_register_disconnect(struct bt_att *att,
 bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id);
 
 bool bt_att_unregister_all(struct bt_att *att);
+
+int bt_att_get_sec_level(struct bt_att *att);
+bool bt_att_set_sec_level(struct bt_att *att, int level);
-- 
1.8.4

