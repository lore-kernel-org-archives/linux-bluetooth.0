Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bdaddr: Add Marvell support
Message-Id: <20140307222807.97CEA100887@puck.mtv.corp.google.com>
Date: Fri,  7 Mar 2014 14:28:07 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/bdaddr.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/bdaddr.c b/tools/bdaddr.c
index e3ffa0e..ee9c01c 100644
--- a/tools/bdaddr.c
+++ b/tools/bdaddr.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <getopt.h>
+#include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
@@ -278,6 +279,30 @@ static int zeevo_write_bd_addr(int dd, bdaddr_t *bdaddr)
 	return 0;
 }
 
+#define OCF_MRVL_WRITE_BD_ADDR		0x0022
+typedef struct {
+	uint8_t		parameter_id;
+	uint8_t		bdaddr_len;
+	bdaddr_t	bdaddr;
+} __attribute__ ((packed)) mrvl_write_bd_addr_cp;
+
+static int mrvl_write_bd_addr(int dd, bdaddr_t *bdaddr)
+{
+	mrvl_write_bd_addr_cp cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.parameter_id = 0xFE;
+	cp.bdaddr_len = 6;
+	bacpy(&cp.bdaddr, bdaddr);
+
+	if (hci_send_cmd(dd, OGF_VENDOR_CMD, OCF_MRVL_WRITE_BD_ADDR,
+							sizeof(cp), &cp) < 0)
+		return -1;
+
+	sleep(1);
+	return 0;
+}
+
 static int st_write_bd_addr(int dd, bdaddr_t *bdaddr)
 {
 	return ericsson_store_in_flash(dd, 0xfe, 6, (uint8_t *) bdaddr);
@@ -295,6 +320,7 @@ static struct {
 	{ 18,		zeevo_write_bd_addr,	NULL			},
 	{ 48,		st_write_bd_addr,	generic_reset_device	},
 	{ 57,		ericsson_write_bd_addr,	generic_reset_device	},
+	{ 72,		mrvl_write_bd_addr,	generic_reset_device	},
 	{ 65535,	NULL,			NULL			},
 };
 
-- 
1.9.0.279.gdc9e3eb

