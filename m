Return-Path: <SRS0=Q31N=TJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41A9C04AB2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 12:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CB321479
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 12:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEIMh5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 May 2019 08:37:57 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:37143 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIMhu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 May 2019 08:37:50 -0400
Received: from classic.redhat.com (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 64EB4100005;
        Thu,  9 May 2019 12:37:49 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 4/8] tools/csr_usb: Fix compilation failure
Date:   Thu,  9 May 2019 14:37:42 +0200
Message-Id: <20190509123746.8396-4-hadess@hadess.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509123746.8396-1-hadess@hadess.net>
References: <20190509123746.8396-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

GCC's "format-nonliteral" security check is enabled as an error in
recent versions of Fedora. Given the limited formats, pass a boolean
to switch between the 2 different formats.

tools/csr_usb.c: In function 'read_value':
tools/csr_usb.c:82:2: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
  n = fscanf(file, format, &value);
  ^
---
 tools/csr_usb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/csr_usb.c b/tools/csr_usb.c
index f3ab2ddce..32fdf1f14 100644
--- a/tools/csr_usb.c
+++ b/tools/csr_usb.c
@@ -32,6 +32,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 #include <dirent.h>
 #include <limits.h>
@@ -68,7 +69,7 @@ struct usbfs_bulktransfer {
 #define USBFS_IOCTL_CLAIMINTF	_IOR('U', 15, unsigned int)
 #define USBFS_IOCTL_RELEASEINTF	_IOR('U', 16, unsigned int)
 
-static int read_value(const char *name, const char *attr, const char *format)
+static int read_value(const char *name, const char *attr, bool hex_number)
 {
 	char path[PATH_MAX];
 	FILE *file;
@@ -80,7 +81,7 @@ static int read_value(const char *name, const char *attr, const char *format)
 	if (!file)
 		return -1;
 
-	n = fscanf(file, format, &value);
+	n = fscanf(file, hex_number ? "%d" : "%04x", &value);
 	if (n != 1) {
 		fclose(file);
 		return -1;
@@ -90,26 +91,29 @@ static int read_value(const char *name, const char *attr, const char *format)
 	return value;
 }
 
+#define read_hex_value(name, file) read_value((name), (file), true)
+#define read_num_value(name, file) read_value((name), (file), false)
+
 static char *check_device(const char *name)
 {
 	char path[PATH_MAX];
 	int busnum, devnum, vendor, product;
 
-	busnum = read_value(name, "busnum", "%d");
+	busnum = read_num_value(name, "busnum");
 	if (busnum < 0)
 		return NULL;
 
-	devnum = read_value(name, "devnum", "%d");
+	devnum = read_num_value(name, "devnum");
 	if (devnum < 0)
 		return NULL;
 
 	snprintf(path, sizeof(path), "/dev/bus/usb/%03u/%03u", busnum, devnum);
 
-	vendor = read_value(name, "idVendor", "%04x");
+	vendor = read_hex_value(name, "idVendor");
 	if (vendor < 0)
 		return NULL;
 
-	product = read_value(name, "idProduct", "%04x");
+	product = read_hex_value(name, "idProduct");
 	if (product < 0)
 		return NULL;
 
-- 
2.21.0

