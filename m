Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/2] tools: Fix compilation error with GINT_TO_POINTER
Date: Mon, 18 Feb 2013 21:34:42 +0530
Message-id: <1361203483-32117-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes the following error:
tools/btmgmt.c: In function ‘index_rsp’:
tools/btmgmt.c:756:10: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
tools/btmgmt.c: In function ‘cmd_info’:
tools/btmgmt.c:791:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
cc1: all warnings being treated as errors
make[1]: *** [tools/btmgmt.o] Error 1
make: *** [all] Error 2
---
 tools/btmgmt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 85e790b..715efde 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -753,7 +753,7 @@ static void index_rsp(uint8_t status, uint16_t len, const void *param,
 		if (monitor)
 			printf("hci%u ", index);
 
-		data = GINT_TO_POINTER(index);
+		data = GINT_TO_POINTER((gint) index);
 
 		if (mgmt_send(mgmt, MGMT_OP_READ_INFO, index, 0, NULL,
 						info_rsp, data, NULL) == 0) {
@@ -788,7 +788,7 @@ static void cmd_info(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 		return;
 	}
 
-	data = GINT_TO_POINTER(index);
+	data = GINT_TO_POINTER((gint) index);
 
 	if (mgmt_send(mgmt, MGMT_OP_READ_INFO, index, 0, NULL, info_rsp,
 							data, NULL) == 0) {
-- 
1.7.9.5

