Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 1/5] lib/mgmt: Add MGMT_DEV_DISCONN_AUTH_FAILURE definition
Date: Thu,  4 Aug 2016 15:28:35 +0200
Message-Id: <1470317319-3985-2-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
References: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This error code was recently added to device disconnected event.
---
 lib/mgmt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f6a976a..705be07 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -589,6 +589,7 @@ struct mgmt_ev_device_connected {
 #define MGMT_DEV_DISCONN_TIMEOUT	0x01
 #define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
 #define MGMT_DEV_DISCONN_REMOTE		0x03
+#define MGMT_DEV_DISCONN_AUTH_FAILURE	0x04
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
 struct mgmt_ev_device_disconnected {
-- 
2.7.4

