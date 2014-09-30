Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/12] android/README: Update with new configuration options
Date: Tue, 30 Sep 2014 13:06:27 +0200
Message-Id: <1412075187-5518-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/README b/android/README
index 706d424..4bfe10b 100644
--- a/android/README
+++ b/android/README
@@ -216,6 +216,18 @@ model		<any>		Set model name used as default adapter name.
 				If not set fallback to "ro.product.model".
 name		<any>		Set model number in DIS. If not set fallback to
 				"ro.product.name".
+serialno	<any>		Set serial number in DIS. If not set fallback to
+				"ro.serialno".
+systemid	<uint64>	Set system ID in DIS. Hex string encoded uint64.
+pnpid		<any>		PnP information used in DIS and DID profiles.
+				Required format: "Source:VID:PID:Version".
+				Source must be either "bluetooth" or "usb".
+				VID, PID and Version are uint16. Version is
+				optional.
+fwrev		<any>		Firmware revision in DIS. If not set fallback to
+				"ro.build.version.release".
+hwrew		<any>		Hardware revision in DIS. If not set fallback to
+				"ro.board.platform".
 
 
 Building and running on Linux
-- 
1.9.1

