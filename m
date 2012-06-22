Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 16/19] hog: Handle output events
Date: Fri, 22 Jun 2012 12:08:04 -0300
Message-Id: <1340377687-4711-17-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
References: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch prints the output events coming from the HID host for debug
purposes.
---
 input/hog_device.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/input/hog_device.c b/input/hog_device.c
index 50394e7..374f9fe 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -415,6 +415,11 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 	case UHID_OUTPUT:
 		forward_report(hogdev, &ev);
 		break;
+	case UHID_OUTPUT_EV:
+		DBG("uHID output event: type %d code %d value %d",
+			ev.u.output_ev.type, ev.u.output_ev.code,
+			ev.u.output_ev.value);
+		break;
 	default:
 		warn("unexpected uHID event");
 		break;
-- 
1.7.10.2

