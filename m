Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Add helper functions to get data from L2CAP frames
Date: Fri, 22 Aug 2014 13:25:29 +0300
Message-Id: <1408703129-12414-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 monitor/l2cap.h | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 9 deletions(-)

diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index a0f844b..645e3ef 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -40,15 +40,115 @@ struct l2cap_frame {
 static inline void l2cap_frame_pull(struct l2cap_frame *frame,
 				const struct l2cap_frame *source, uint16_t len)
 {
-	frame->index   = source->index;
-	frame->in      = source->in;
-	frame->handle  = source->handle;
-	frame->cid     = source->cid;
-	frame->psm     = source->psm;
-	frame->chan    = source->chan;
-	frame->mode    = source->mode;
-	frame->data    = source->data + len;
-	frame->size    = source->size - len;
+	if (frame != source) {
+		frame->index   = source->index;
+		frame->in      = source->in;
+		frame->handle  = source->handle;
+		frame->cid     = source->cid;
+		frame->psm     = source->psm;
+		frame->chan    = source->chan;
+		frame->mode    = source->mode;
+	}
+
+	frame->data = source->data + len;
+	frame->size = source->size - len;
+}
+
+static inline int l2cap_frame_get_u8(struct l2cap_frame *frame, uint8_t *value)
+{
+	if (frame->size < sizeof(*value))
+		return -1;
+
+	if (value)
+		*value = *((uint8_t *) frame->data);
+
+	l2cap_frame_pull(frame, frame, sizeof(*value));
+
+	return 0;
+}
+
+static inline int l2cap_frame_get_be16(struct l2cap_frame *frame,
+								uint16_t *value)
+{
+	if (frame->size < sizeof(*value))
+		return -1;
+
+	if (value)
+		*value = get_be16(frame->data);
+
+	l2cap_frame_pull(frame, frame, sizeof(*value));
+
+	return 0;
+}
+
+static inline int l2cap_frame_get_le16(struct l2cap_frame *frame,
+								uint16_t *value)
+{
+	if (frame->size < sizeof(*value))
+		return -1;
+
+	if (value)
+		*value = get_le16(frame->data);
+
+	l2cap_frame_pull(frame, frame, sizeof(*value));
+
+	return 0;
+}
+
+static inline int l2cap_frame_get_be32(struct l2cap_frame *frame,
+								uint32_t *value)
+{
+	if (frame->size < sizeof(*value))
+		return -1;
+
+	if (value)
+		*value = get_be32(frame->data);
+
+	l2cap_frame_pull(frame, frame, sizeof(*value));
+
+	return 0;
+}
+
+static inline int l2cap_frame_get_le32(struct l2cap_frame *frame,
+								uint32_t *value)
+{
+	if (frame->size < sizeof(*value))
+		return -1;
+
+	if (value)
+		*value = get_le32(frame->data);
+
+	l2cap_frame_pull(frame, frame, sizeof(*value));
+
+	return 0;
+}
+
+static inline int l2cap_frame_get_be64(struct l2cap_frame *frame,
+								uint64_t *value)
+{
+	if (frame->size < sizeof(*value))
+		return -1;
+
+	if (value)
+		*value = get_be64(frame->data);
+
+	l2cap_frame_pull(frame, frame, sizeof(*value));
+
+	return 0;
+}
+
+static inline int l2cap_frame_get_le64(struct l2cap_frame *frame,
+								uint64_t *value)
+{
+	if (frame->size < sizeof(*value))
+		return -1;
+
+	if (value)
+		*value = get_le64(frame->data);
+
+	l2cap_frame_pull(frame, frame, sizeof(*value));
+
+	return 0;
 }
 
 void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
-- 
1.9.3

