Return-Path: <arnaud.rebillout@collabora.com>
From: Arnaud Rebillout <arnaud.rebillout@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: arnaud.rebillout@collabora.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	vivek@collabora.com
Subject: [PATCH] Bluetooth: hidp: sixaxis dualshock report via ctrl quirk
Date: Wed, 28 Mar 2018 10:45:26 +0700
Message-Id: <20180328034526.13446-1-arnaud.rebillout@collabora.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: vivek <vivek@collabora.com>

The Sixaxis and Dualshock 4 wants report sent via the ctrl channel.

This patch has been used in the SteamOS kernel for a while now.
<https://github.com/ValveSoftware/steamos_kernel/commit/6e215b67a13c85d0cf5a9e0970acd9df7d2b77bd>

Signed-off-by: Vivek Das Mohapatra <vivek@collabora.com>
Signed-off-by: Arnaud Rebillout <arnaud.rebillout@collabora.com>
---
 net/bluetooth/hidp/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 1036e4fa1ea2..fa75da91a559 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -379,9 +379,16 @@ static int hidp_output_report(struct hid_device *hid, __u8 *data, size_t count)
 {
 	struct hidp_session *session = hid->driver_data;
 
-	return hidp_send_intr_message(session,
-				      HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT,
-				      data, count);
+	/* The Sixaxis and Dualshock 4 wants report sent via the ctrl channel */
+	if (hid->vendor == 0x54c && (hid->product == 0x5c4 || hid->product == 0x268)) {
+		return hidp_send_ctrl_message(session,
+					      HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT,
+					      data, count);
+	} else {
+		return hidp_send_intr_message(session,
+					      HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT,
+					      data, count);
+	}
 }
 
 static int hidp_raw_request(struct hid_device *hid, unsigned char reportnum,
-- 
2.16.2
