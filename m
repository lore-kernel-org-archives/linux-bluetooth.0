Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] monitor: Add Broadcom BCM4324B3 chip name information
Date: Tue, 19 May 2015 16:20:30 +0200
Message-Id: <1432045230-26074-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 8f75ee2..af51378 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2404,6 +2404,7 @@ static const struct {
 	const char *str;
 } broadcom_uart_subversion_table[] = {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
+	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ }
 };
 
@@ -2433,6 +2434,7 @@ static void print_manufacturer_broadcom(uint16_t subversion, uint16_t revision)
 
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
+	case 3:
 		for (i = 0; broadcom_uart_subversion_table[i].str; i++) {
 			if (broadcom_uart_subversion_table[i].ver == ver) {
 				str = broadcom_uart_subversion_table[i].str;
-- 
1.9.1

