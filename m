Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] bluetooth/hidhost: Fix using feature event as output event
Date: Mon, 16 Dec 2013 15:37:31 +0100
Message-Id: <1387204652-14850-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rename handle_uhid_event to handle_uhid_output and make it handle only
output events.
---
 android/hidhost.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 8bfdfed..0e0391a 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -153,7 +153,8 @@ static void hid_device_free(struct hid_device *dev)
 	g_free(dev);
 }
 
-static void handle_uhid_event(struct hid_device *dev, struct uhid_event *ev)
+static void handle_uhid_output(struct hid_device *dev,
+						struct uhid_output_req *output)
 {
 	int fd, i;
 	uint8_t *req = NULL;
@@ -162,15 +163,14 @@ static void handle_uhid_event(struct hid_device *dev, struct uhid_event *ev)
 	if (!(dev->ctrl_io))
 		return;
 
-	req_size = 1 + (ev->u.output.size / 2);
+	req_size = 1 + (output->size / 2);
 	req = g_try_malloc0(req_size);
 	if (!req)
 		return;
 
-	req[0] = HID_MSG_SET_REPORT | ev->u.output.rtype;
+	req[0] = HID_MSG_SET_REPORT | output->rtype;
 	for (i = 0; i < (req_size - 1); i++)
-		sscanf((char *) &(ev->u.output.data)[i * 2],
-							"%hhx", &req[1 + i]);
+		sscanf((char *) &(output->data)[i * 2], "%hhx", &req[1 + i]);
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
@@ -224,8 +224,10 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 		 * asleep This is optional, though. */
 		break;
 	case UHID_OUTPUT:
+		handle_uhid_output(dev, &ev.u.output);
+		break;
 	case UHID_FEATURE:
-		handle_uhid_event(dev, &ev);
+		/* TODO */
 		break;
 	case UHID_OUTPUT_EV:
 		/* This is only sent by kernels prior to linux-3.11. It
-- 
1.8.3.2

