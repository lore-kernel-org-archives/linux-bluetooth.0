Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v1 1/1] Add KeyboardDisplay IO Capability
Date: Mon, 16 Jan 2012 13:36:42 +0530
Message-ID: <1326701202-23977-2-git-send-email-hemant.gupta@stericsson.com>
In-Reply-To: <1326701202-23977-1-git-send-email-hemant.gupta@stericsson.com>
References: <1326701202-23977-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds suppport for KeyboardDisplay IO capability in BlueZ.
It is ensured that the new capability is set only if management
interface is being used. For hciops Keyboarddisplay capability is
mapped to DisplayYesNo.
---
 plugins/hciops.c |    8 +++++++-
 src/adapter.c    |    3 +++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 77d2421..4102537 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3573,7 +3573,13 @@ static int hciops_set_io_capability(int index, uint8_t io_capability)
 {
 	struct dev_info *dev = &devs[index];
 
-	dev->io_capability = io_capability;
+	/*
+	 * Hciops is not to be used for SMP
+	 * pairing for LE devices. So change the IO
+	 * capability from KeyboardDisplay to
+	 * DisplayYesNo in case it is set.
+	 */
+	dev->io_capability = (io_capability == 0x04) ? 0x01 : io_capability;
 
 	return 0;
 }
diff --git a/src/adapter.c b/src/adapter.c
index 7e4bbb6..ba86cd4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -74,6 +74,7 @@
 #define IO_CAPABILITY_DISPLAYYESNO	0x01
 #define IO_CAPABILITY_KEYBOARDONLY	0x02
 #define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
+#define IO_CAPABILITY_KEYBOARDDISPLAY	0x04
 #define IO_CAPABILITY_INVALID		0xFF
 
 #define check_address(address) bachk(address)
@@ -1533,6 +1534,8 @@ static uint8_t parse_io_capability(const char *capability)
 		return IO_CAPABILITY_KEYBOARDONLY;
 	if (g_str_equal(capability, "NoInputNoOutput"))
 		return IO_CAPABILITY_NOINPUTNOOUTPUT;
+	if (g_str_equal(capability, "KeyboardDisplay"))
+		return IO_CAPABILITY_KEYBOARDDISPLAY;
 	return IO_CAPABILITY_INVALID;
 }
 
-- 
1.6.6.1

