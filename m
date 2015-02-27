Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/6] android/gatt: Fix client signed write on encrypted link
Date: Fri, 27 Feb 2015 16:01:09 +0100
Message-Id: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As defined in Core Specification 4.2:
"If a connection is already encrypted with LE security mode 1, level 2
or level 3 as defined in [Vol 3] Part C, Section 10.2 then, a Write
Without Response as defined in Section 4.9.1 shall be used instead of
a Signed Write Without Response."
---
 android/gatt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 53b1983..9e348d7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3358,14 +3358,14 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 			goto failed;
 		}
 
-		if (get_sec_level(conn->device) != BT_SECURITY_LOW) {
-			error("gatt: Cannot write signed on encrypted link");
-			status = HAL_STATUS_FAILED;
-			goto failed;
-		}
-
-		res = signed_write_cmd(conn->device, ch->ch.value_handle,
-							cmd->value, cmd->len);
+		if (get_sec_level(conn->device) > BT_SECURITY_LOW)
+			res = gatt_write_cmd(conn->device->attrib,
+						ch->ch.value_handle, cmd->value,
+						cmd->len, NULL, NULL);
+		else
+			res = signed_write_cmd(conn->device,
+						ch->ch.value_handle, cmd->value,
+						cmd->len);
 		break;
 	default:
 		error("gatt: Write type %d unsupported", cmd->write_type);
-- 
1.9.3

