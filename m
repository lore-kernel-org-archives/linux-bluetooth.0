Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 11/12] android/hid: Handle uhid events
Date: Tue,  5 Nov 2013 23:09:17 +0200
Message-Id: <1383685758-3900-12-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handling few uhid events and described scenarios. OUTPUT and
FEATURE events are not yet handled.
---
 android/hid.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/android/hid.c b/android/hid.c
index 999f5d6..172a945 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -149,6 +149,11 @@ static void hid_device_free(struct hid_device *dev)
 	g_free(dev);
 }
 
+static void handle_uhid_event(struct hid_device *dev, struct uhid_event *ev)
+{
+	DBG("UHID_OUTPUT UHID_FEATURE unsupported");
+}
+
 static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -172,7 +177,40 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	DBG("uHID event type %d received", ev.type);
-	/* TODO Handle events */
+
+	switch (ev.type) {
+	case UHID_START:
+	case UHID_STOP:
+		/* These are called to start and stop the underlying hardware.
+		 * We open the channels before creating the device so the
+		 * hardware is always ready. No need to handle these.
+		 * The kernel never destroys a device itself! Only an explicit
+		 * UHID_DESTROY request can remove a device. */
+
+		break;
+	case UHID_OPEN:
+	case UHID_CLOSE:
+		/* OPEN/CLOSE are sent whenever user-space opens any interface
+		 * provided by the kernel HID device. Whenever the open-count
+		 * is non-zero we must be ready for I/O. As long as it is zero,
+		 * we can decide to drop all I/O and put the device
+		 * asleep This is optional, though. */
+		break;
+	case UHID_OUTPUT:
+	case UHID_FEATURE:
+		handle_uhid_event(dev, &ev);
+		break;
+	case UHID_OUTPUT_EV:
+		/* This is only sent by kernels prior to linux-3.11. It
+		 * requires us to parse HID-descriptors in user-space to
+		 * properly handle it. This is redundant as the kernel
+		 * does it already. That's why newer kernels assemble
+		 * the output-reports and send it to us via UHID_OUTPUT. */
+		DBG("UHID_OUTPUT_EV unsupported");
+		break;
+	default:
+		warn("unexpected uHID event");
+	}
 
 	return TRUE;
 
-- 
1.8.1.2

