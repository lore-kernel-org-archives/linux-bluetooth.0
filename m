Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH BlueZ 1/1] Add KeyboardDisplay IO Capability.
Date: Mon, 26 Dec 2011 12:05:11 +0530
Message-ID: <1324881311-26211-2-git-send-email-hemant.gupta@stericsson.com>
In-Reply-To: <1324881311-26211-1-git-send-email-hemant.gupta@stericsson.com>
References: <1324881311-26211-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds suppport for KeyboardDisplay IO capability in BlueZ.
---
 src/adapter.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2d9e368..3bdf525 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -74,6 +74,7 @@
 #define IO_CAPABILITY_DISPLAYYESNO	0x01
 #define IO_CAPABILITY_KEYBOARDONLY	0x02
 #define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
+#define IO_CAPABILITY_KEYBOARDDISPLAY	0x04
 #define IO_CAPABILITY_INVALID		0xFF
 
 #define check_address(address) bachk(address)
@@ -1634,6 +1635,8 @@ static uint8_t parse_io_capability(const char *capability)
 		return IO_CAPABILITY_KEYBOARDONLY;
 	if (g_str_equal(capability, "NoInputNoOutput"))
 		return IO_CAPABILITY_NOINPUTNOOUTPUT;
+	if (g_str_equal(capability, "KeyboardDisplay"))
+		return IO_CAPABILITY_KEYBOARDDISPLAY;
 	return IO_CAPABILITY_INVALID;
 }
 
-- 
1.6.6.1

