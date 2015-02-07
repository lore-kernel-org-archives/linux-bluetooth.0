Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android/gatt: Disconnect ATT if MTU is too small on BR/EDR
Date: Sat,  7 Feb 2015 16:18:16 +0100
Message-Id: <1423322298-6502-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423322298-6502-1-git-send-email-szymon.janc@tieto.com>
References: <1423322298-6502-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On BR/EDR MTU is negotiated using L2CAP configuration and not by
ATT MTU exchange procedure.
---
 android/gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 49fff6f..45d70fd 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1519,6 +1519,14 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		goto reply;
 	}
 
+	/* on BR/EDR MTU must not be less then minimal allowed MTU */
+	if (cid != ATT_CID && mtu < ATT_DEFAULT_L2CAP_MTU) {
+		error("gatt: MTU too small (%u bytes)", mtu);
+		device_set_state(dev, DEVICE_DISCONNECTED);
+		status = GATT_FAILURE;
+		goto reply;
+	}
+
 	DBG("mtu %u cid %u", mtu, cid);
 
 	/* on LE we always start with default MTU */
-- 
1.9.3

