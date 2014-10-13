Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] android/avrcp-lib: Add checks for unknown events
Date: Mon, 13 Oct 2014 12:55:49 +0300
Message-Id: <1413194150-21751-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1413194150-21751-1-git-send-email-luiz.dentz@gmail.com>
References: <1413194150-21751-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Unknown events should be treated as protocol error since there is no
way to parse them properly and there is no support for vendor specific
either.
---
 android/avrcp-lib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 60d6e97..a490d76 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1779,6 +1779,11 @@ static gboolean register_notification_rsp(struct avctp *conn,
 	rsp = (void *) pdu->params;
 	event = rsp->event;
 
+	if (event > AVRCP_EVENT_LAST) {
+		err = -EPROTO;
+		goto done;
+	}
+
 	switch (event) {
 	case AVRCP_EVENT_STATUS_CHANGED:
 	case AVRCP_EVENT_VOLUME_CHANGED:
@@ -1843,6 +1848,9 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 	struct iovec iov;
 	struct register_notification_req req;
 
+	if (event > AVRCP_EVENT_LAST)
+		return -EINVAL;
+
 	req.event = event;
 	put_be32(interval, &req.interval);
 
-- 
1.9.3

