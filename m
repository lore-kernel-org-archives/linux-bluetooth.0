Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] hog: ignore UHID-setup events and document why
Date: Mon,  2 Sep 2013 13:58:09 +0200
Message-Id: <1378123089-3980-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The UHID_{START,STOP,OPEN,CLOSE} events should be ignored by us to avoid
triggering the warn(). It is safe to do that. Add few comments that
explain why we don't have to handle these.
---
 profiles/input/hog.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 91c2802..0130f94 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -621,12 +621,42 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 	DBG("uHID event type %d received", ev.type);
 
 	switch (ev.type) {
+	case UHID_START:
+	case UHID_STOP:
+		/* These are called to start and stop the underlying hardware.
+		 * For HoG we open the channels before creating the device so
+		 * the hardware is always ready. No need to handle these.
+		 * Note that these are also called when the kernel switches
+		 * between device-drivers loaded on the HID device. But we can
+		 * simply keep the hardware alive during transitions and it
+		 * works just fine.
+		 * The kernel never destroys a device itself! Only an explicit
+		 * UHID_DESTROY request can remove a device. */
+		break;
+	case UHID_OPEN:
+	case UHID_CLOSE:
+		/* OPEN/CLOSE are sent whenever user-space opens any interface
+		 * provided by the kernel HID device. Whenever the open-count
+		 * is non-zero we must be ready for I/O. As long as it is zero,
+		 * we can decide to drop all I/O and put the device asleep. This
+		 * is optional, though. Moreover, some special device drivers
+		 * are buggy in that regard, so maybe we just keep I/O always
+		 * awake like HIDP in the kernel does. */
+		break;
 	case UHID_OUTPUT:
 	case UHID_FEATURE:
 		forward_report(hogdev, &ev);
 		break;
 	case UHID_OUTPUT_EV:
-		DBG("uHID output event: type %d code %d value %d",
+		/* This is only sent by kernels prior to linux-3.11. It requires
+		 * us to parse HID-descriptors in user-space to properly handle
+		 * it. This is redundant as the kernel does it already. That's
+		 * why newer kernels assemble the output-reports and send it to
+		 * us via UHID_OUTPUT.
+		 * We never implemented this, so we rely on users to use
+		 * recent-enough kernels if they want this feature. No reason to
+		 * implement this for older kernels. */
+		DBG("Unsupported uHID output event: type %d code %d value %d",
 			ev.u.output_ev.type, ev.u.output_ev.code,
 			ev.u.output_ev.value);
 		break;
-- 
1.8.4
