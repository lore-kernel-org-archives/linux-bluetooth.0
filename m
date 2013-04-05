Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v3 16/18] Bluetooth: hidp: merge 'send' functions into hidp_send_message()
Date: Fri,  5 Apr 2013 14:57:48 +0200
Message-Id: <1365166670-3271-17-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We handle skb buffers all over the place, even though we have
hidp_send_*_message() helpers. This creates a more generic
hidp_send_message() helper and uses it instead of dealing with transmit
queues directly everywhere.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/hidp/core.c | 156 ++++++++++++++++++----------------------------
 1 file changed, 60 insertions(+), 96 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a566dc2..b6c5a82 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -68,15 +68,6 @@ static void hidp_session_remove(struct l2cap_conn *conn,
 static int hidp_session_thread(void *arg);
 static void hidp_session_terminate(struct hidp_session *s);
 
-static inline void hidp_schedule(struct hidp_session *session)
-{
-	struct sock *ctrl_sk = session->ctrl_sock->sk;
-	struct sock *intr_sk = session->intr_sock->sk;
-
-	wake_up_interruptible(sk_sleep(ctrl_sk));
-	wake_up_interruptible(sk_sleep(intr_sk));
-}
-
 static void hidp_copy_session(struct hidp_session *session, struct hidp_conninfo *ci)
 {
 	memset(ci, 0, sizeof(*ci));
@@ -107,11 +98,56 @@ static void hidp_copy_session(struct hidp_session *session, struct hidp_conninfo
 	}
 }
 
+/* assemble skb, queue message on @transmit and wake up the session thread */
+static int hidp_send_message(struct hidp_session *session, struct socket *sock,
+			     struct sk_buff_head *transmit, unsigned char hdr,
+			     const unsigned char *data, int size)
+{
+	struct sk_buff *skb;
+	struct sock *sk = sock->sk;
+
+	BT_DBG("session %p data %p size %d", session, data, size);
+
+	if (atomic_read(&session->terminate))
+		return -EIO;
+
+	skb = alloc_skb(size + 1, GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("Can't allocate memory for new frame");
+		return -ENOMEM;
+	}
+
+	*skb_put(skb, 1) = hdr;
+	if (data && size > 0)
+		memcpy(skb_put(skb, size), data, size);
+
+	skb_queue_tail(transmit, skb);
+	wake_up_interruptible(sk_sleep(sk));
+
+	return 0;
+}
+
+static int hidp_send_ctrl_message(struct hidp_session *session,
+				  unsigned char hdr, const unsigned char *data,
+				  int size)
+{
+	return hidp_send_message(session, session->ctrl_sock,
+				 &session->ctrl_transmit, hdr, data, size);
+}
+
+static int hidp_send_intr_message(struct hidp_session *session,
+				  unsigned char hdr, const unsigned char *data,
+				  int size)
+{
+	return hidp_send_message(session, session->intr_sock,
+				 &session->intr_transmit, hdr, data, size);
+}
+
 static int hidp_queue_event(struct hidp_session *session, struct input_dev *dev,
 				unsigned int type, unsigned int code, int value)
 {
 	unsigned char newleds;
-	struct sk_buff *skb;
+	unsigned char hdr, data[2];
 
 	BT_DBG("session %p type %d code %d value %d", session, type, code, value);
 
@@ -129,21 +165,11 @@ static int hidp_queue_event(struct hidp_session *session, struct input_dev *dev,
 
 	session->leds = newleds;
 
-	skb = alloc_skb(3, GFP_ATOMIC);
-	if (!skb) {
-		BT_ERR("Can't allocate memory for new frame");
-		return -ENOMEM;
-	}
-
-	*skb_put(skb, 1) = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
-	*skb_put(skb, 1) = 0x01;
-	*skb_put(skb, 1) = newleds;
-
-	skb_queue_tail(&session->intr_transmit, skb);
+	hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
+	data[0] = 0x01;
+	data[1] = newleds;
 
-	hidp_schedule(session);
-
-	return 0;
+	return hidp_send_intr_message(session, hdr, data, 2);
 }
 
 static int hidp_hidinput_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
@@ -216,71 +242,9 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 	input_sync(dev);
 }
 
-static int __hidp_send_ctrl_message(struct hidp_session *session,
-				    unsigned char hdr, unsigned char *data,
-				    int size)
-{
-	struct sk_buff *skb;
-
-	BT_DBG("session %p data %p size %d", session, data, size);
-
-	if (atomic_read(&session->terminate))
-		return -EIO;
-
-	skb = alloc_skb(size + 1, GFP_ATOMIC);
-	if (!skb) {
-		BT_ERR("Can't allocate memory for new frame");
-		return -ENOMEM;
-	}
-
-	*skb_put(skb, 1) = hdr;
-	if (data && size > 0)
-		memcpy(skb_put(skb, size), data, size);
-
-	skb_queue_tail(&session->ctrl_transmit, skb);
-
-	return 0;
-}
-
-static int hidp_send_ctrl_message(struct hidp_session *session,
-			unsigned char hdr, unsigned char *data, int size)
-{
-	int err;
-
-	err = __hidp_send_ctrl_message(session, hdr, data, size);
-
-	hidp_schedule(session);
-
-	return err;
-}
-
-static int hidp_queue_report(struct hidp_session *session,
-				unsigned char *data, int size)
-{
-	struct sk_buff *skb;
-
-	BT_DBG("session %p hid %p data %p size %d", session, session->hid, data, size);
-
-	skb = alloc_skb(size + 1, GFP_ATOMIC);
-	if (!skb) {
-		BT_ERR("Can't allocate memory for new frame");
-		return -ENOMEM;
-	}
-
-	*skb_put(skb, 1) = 0xa2;
-	if (size > 0)
-		memcpy(skb_put(skb, size), data, size);
-
-	skb_queue_tail(&session->intr_transmit, skb);
-
-	hidp_schedule(session);
-
-	return 0;
-}
-
 static int hidp_send_report(struct hidp_session *session, struct hid_report *report)
 {
-	unsigned char buf[32];
+	unsigned char buf[32], hdr;
 	int rsize;
 
 	rsize = ((report->size - 1) >> 3) + 1 + (report->id > 0);
@@ -288,8 +252,9 @@ static int hidp_send_report(struct hidp_session *session, struct hid_report *rep
 		return -EIO;
 
 	hid_output_report(report, buf);
+	hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
 
-	return hidp_queue_report(session, buf, rsize);
+	return hidp_send_intr_message(session, hdr, buf, rsize);
 }
 
 static int hidp_get_raw_report(struct hid_device *hid,
@@ -325,7 +290,7 @@ static int hidp_get_raw_report(struct hid_device *hid,
 	session->waiting_report_number = numbered_reports ? report_number : -1;
 	set_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
 	data[0] = report_number;
-	ret = hidp_send_ctrl_message(hid->driver_data, report_type, data, 1);
+	ret = hidp_send_ctrl_message(session, report_type, data, 1);
 	if (ret)
 		goto err;
 
@@ -385,7 +350,7 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
 		break;
 	case HID_OUTPUT_REPORT:
-		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;
+		report_type = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
 		break;
 	default:
 		return -EINVAL;
@@ -396,8 +361,7 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 
 	/* Set up our wait, and send the report request to the device. */
 	set_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
-	ret = hidp_send_ctrl_message(hid->driver_data, report_type, data,
-									count);
+	ret = hidp_send_ctrl_message(session, report_type, data, count);
 	if (ret)
 		goto err;
 
@@ -482,12 +446,12 @@ static void hidp_process_handshake(struct hidp_session *session,
 	case HIDP_HSHK_ERR_FATAL:
 		/* Device requests a reboot, as this is the only way this error
 		 * can be recovered. */
-		__hidp_send_ctrl_message(session,
+		hidp_send_ctrl_message(session,
 			HIDP_TRANS_HID_CONTROL | HIDP_CTRL_SOFT_RESET, NULL, 0);
 		break;
 
 	default:
-		__hidp_send_ctrl_message(session,
+		hidp_send_ctrl_message(session,
 			HIDP_TRANS_HANDSHAKE | HIDP_HSHK_ERR_INVALID_PARAMETER, NULL, 0);
 		break;
 	}
@@ -535,7 +499,7 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 		break;
 
 	default:
-		__hidp_send_ctrl_message(session,
+		hidp_send_ctrl_message(session,
 			HIDP_TRANS_HANDSHAKE | HIDP_HSHK_ERR_INVALID_PARAMETER, NULL, 0);
 	}
 
@@ -582,7 +546,7 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 		break;
 
 	default:
-		__hidp_send_ctrl_message(session,
+		hidp_send_ctrl_message(session,
 			HIDP_TRANS_HANDSHAKE | HIDP_HSHK_ERR_UNSUPPORTED_REQUEST, NULL, 0);
 		break;
 	}
-- 
1.8.2
