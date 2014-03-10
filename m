Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] android/avrcp: Fill attributes in case of empty for GetElementAttributes
Date: Mon, 10 Mar 2014 11:45:46 +0200
Message-Id: <1394444747-7508-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This has to be done since Android do not interpret empty list as get all
attributes as it should.
---
v2: Move empty list handling to daemon side and fix starting with attribute
0x00 which is illegal.
v3: Fix not handling response code properly in set_volume_rsp

 android/avrcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index e26ddf2..70266f7 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -655,11 +655,23 @@ static ssize_t handle_get_element_attrs_cmd(struct avrcp *session,
 		return -EINVAL;
 
 	params += 9;
+
+	/* Set everything in case of empty list */
+	if (ev->number == 0) {
+		for (i = 0; i < HAL_AVRCP_MEDIA_ATTR_DURATION; i++) {
+			/* Skip 0x00 as the attributes start with 0x01 */
+			ev->attrs[i] = i + 1;
+		}
+		ev->number = i;
+		goto done;
+	}
+
 	for (i = 0; i < ev->number; i++) {
 		ev->attrs[i] = bt_get_be32(params);
 		params += 4;
 	}
 
+done:
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
 					HAL_EV_AVRCP_GET_ELEMENT_ATTRS,
 					sizeof(*ev) + ev->number, ev);
-- 
1.8.5.3

