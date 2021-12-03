Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45401C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 16:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382058AbhLCQMm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:12:42 -0500
Received: from smtp202-pc.aruba.it ([62.149.157.202]:36198 "EHLO
        smtp200-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1382077AbhLCQMj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 11:12:39 -0500
Received: from danbia2MBL ([188.217.48.39])
        by Aruba Outgoing Smtp  with ESMTPSA
        id tB0imxNzZrBxFtB0omsYKy; Fri, 03 Dec 2021 17:02:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638547334; bh=0N9A8HEtNgE0tJ8W97u9axtv58jzcGRcijZ/Nfpgj5s=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=mk4D91qYla52PNwQcOZtkuEMHj4aKDNpA7/PVtPyP7SPn0p6wh8TR5dJwioTiG9Cf
         C1BvN6KOQFoxxYiWfx/9Ow3iWCuKOkEn1rPZpfTFw1Mf5BwyjaWAXR8RXC/OkPS0x3
         aiW8fafnWxVRZ5RA1zwXzjC5fLSBD4x0obeXMXzzNBt07+d1gvFf5hZe1HxfXiaRGD
         SdqLCK3dTwcdcW+cB+KOv8qkVQd52YtIP5G3yYn12WLVhjjo9epp549NbuNQunhzvo
         RVA/6Ze0wxKEjTxRHSYN5eHGruvY+nB0JqZPdKx0/0T1hWMF7GsFMpEkmEj/eSy4R1
         rQKtV7apMUx3w==
From:   <daniele.biagetti@cblelectronics.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 2/6] tools/mesh-gatt: Fix status messages processing
Date:   Fri, 3 Dec 2021 17:02:12 +0100
Message-ID: <000601d7e85f$228e7ea0$67ab7be0$@cblelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfoXhoSvPDwxinGTn6eFFOONeASOg==
Content-Language: it
X-CMAE-Envelope: MS4xfLi5yG4h1Fim+3qL6+VNFCkA3JR8q2JA/Jsb3z7QXxSPx50jOIAa1exTloc0QGftqINohpjvCX7UEzXArHWA4EY7XLQiAsEvlAC7sM+HmAigKEkdrv9a
 uI8YjSNtE+lCzeGNilIjIUxxGUfu2uR/xwmBktda4S6XJfaCy+kCO9QNBMMc/GWuUtFKL39FZExIt4Q5NJ64djnYJgwYjzhgZmWMSNi8/9Y7xpoDEwaMYG7u
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The status messages was processed and displayed even if they do
not belong to the present model. This fix ensure that the status
messages are processed only if they have the correct opcode.
---
 tools/mesh-gatt/node.c        | 11 +++++++++++
 tools/mesh-gatt/onoff-model.c | 23 ++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/mesh-gatt/node.c b/tools/mesh-gatt/node.c
index 356e1cd1a..4d0cc21e9 100644
--- a/tools/mesh-gatt/node.c
+++ b/tools/mesh-gatt/node.c
@@ -470,6 +470,8 @@ static bool deliver_model_data(struct mesh_element*
element, uint16_t src,
 				uint16_t app_idx, uint8_t *data, uint16_t
len)
 {
 	GList *l;
+	uint32_t opcode;
+	int n;
 
 	for(l = element->models; l; l = l->next) {
 		struct mesh_model *model = l->data;
@@ -482,6 +484,15 @@ static bool deliver_model_data(struct mesh_element*
element, uint16_t src,
 			return true;
 	}
 
+	if (mesh_opcode_get(data, len, &opcode, &n)) {
+		len -= n;
+		data += n;
+	} else
+		return false;
+	bt_shell_printf("Unknown Model Message received (%d) opcode %x\n",
+						len, opcode);
+	print_byte_array("\t",data, len);
+
 	return false;
 }
 
diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
index 13ff4bbe3..1c9676e03 100644
--- a/tools/mesh-gatt/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -99,6 +99,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 {
 	uint32_t opcode;
 	int n;
+	char s[128];
 
 	if (mesh_opcode_get(data, len, &opcode, &n)) {
 		len -= n;
@@ -106,27 +107,27 @@ static bool client_msg_recvd(uint16_t src, uint8_t
*data,
 	} else
 		return false;
 
-	bt_shell_printf("On Off Model Message received (%d) opcode %x\n",
-								len,
opcode);
-	print_byte_array("\t",data, len);
-
 	switch (opcode) {
 	default:
 		return false;
 
 	case OP_GENERIC_ONOFF_STATUS:
+		bt_shell_printf("On Off Model Message received (%d) opcode
%x\n",
+			len, opcode);
+		print_byte_array("\t",data, len);
 		if (len != 1 && len != 3)
 			break;
 
-		bt_shell_printf("Node %4.4x: Off Status present = %s",
-						src, data[0] ? "ON" :
"OFF");
-
+		snprintf(s, sizeof(s), "Node %4.4x: On Off Status present =
%s",
+			src, data[0] ? "ON" : "OFF");
 		if (len == 3) {
-			bt_shell_printf(", target = %s",
-					data[1] ? "ON" : "OFF");
+			snprintf(s + strlen(s), sizeof(s), ", target = %s",
+				data[1] ? "ON" : "OFF");
+			bt_shell_printf("%s\n", s);
 			print_remaining_time(data[2]);
-		} else
-			bt_shell_printf("\n");
+		}else
+			bt_shell_printf("%s\n", s);
+
 		break;
 	}
 
-- 
2.25.1


