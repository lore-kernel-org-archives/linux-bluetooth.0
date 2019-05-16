Return-Path: <SRS0=LC31=TQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2221C04E84
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE99320862
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfEPOm1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 May 2019 10:42:27 -0400
Received: from mail.tinia.eu ([185.96.219.211]:39606 "EHLO mail.tinia.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfEPOm0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 May 2019 10:42:26 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 10:42:25 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id E0E402226C5
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 16:36:05 +0200 (CEST)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3XrFluSv_V9Q for <linux-bluetooth@vger.kernel.org>;
        Thu, 16 May 2019 16:36:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 7531B22299B
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 16:36:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R4ziCWsFlfja for <linux-bluetooth@vger.kernel.org>;
        Thu, 16 May 2019 16:36:04 +0200 (CEST)
Received: from DANBIAMBL (customer-31-185-23-59.com-com.it [31.185.23.59])
        by mail.tinia.eu (Postfix) with ESMTPSA id 469602226C5
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 16:36:04 +0200 (CEST)
From:   "Daniele Biagetti" <daniele.biagetti@cblelectronics.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 2/4] meshctl: Status messages processed even if they do not belong to the model
Date:   Thu, 16 May 2019 16:35:48 +0200
Message-ID: <000501d50bf4$b040a510$10c1ef30$@cblelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdUL8J+AwKb/FsyNSy6EMVVe8dYf/g==
Content-Language: it
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix: The status messages was processed and displayed even if they do not 
belong to the present model. Now the status messages are processed only 
if they have the correct opcode. 
Addition: Added generic onoff set unack message
Addition: Replaced the return statement with a warning message in 
case of transmission or reception of messages coming from unknown
addresses (such as group addresses)

Signed-off-by: Daniele Biagetti <daniele.biagetti@cblelectronics.com>

---
 tools/mesh/node.c        | 11 ++++++++
 tools/mesh/onoff-model.c | 56 +++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/tools/mesh/node.c b/tools/mesh/node.c
index d23315ce4..3171ef01a 100644
--- a/tools/mesh/node.c
+++ b/tools/mesh/node.c
@@ -475,6 +475,8 @@ static bool deliver_model_data(struct mesh_element*
element, uint16_t src,
 				uint16_t app_idx, uint8_t *data, uint16_t
len)
 {
 	GList *l;
+	uint32_t opcode;
+	int n;
 
 	for(l = element->models; l; l = l->next) {
 		struct mesh_model *model = l->data;
@@ -487,6 +489,15 @@ static bool deliver_model_data(struct mesh_element*
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
 
diff --git a/tools/mesh/onoff-model.c b/tools/mesh/onoff-model.c
index b52afe2c8..8c41e005d 100644
--- a/tools/mesh/onoff-model.c
+++ b/tools/mesh/onoff-model.c
@@ -111,6 +111,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t
*data,
 {
 	uint32_t opcode;
 	int n;
+	char s[128];
 
 	if (mesh_opcode_get(data, len, &opcode, &n)) {
 		len -= n;
@@ -118,27 +119,27 @@ static bool client_msg_recvd(uint16_t src, uint8_t
*data,
 	} else
 		return false;
 
-	bt_shell_printf("On Off Model Message received (%d) opcode %x\n",
-								len,
opcode);
-	print_byte_array("\t",data, len);
-
 	switch (opcode & ~OP_UNRELIABLE) {
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
+		sprintf(s, "Node %4.4x: On Off Status present = %s",
+			src, data[0] ? "ON" : "OFF");
 		if (len == 3) {
-			bt_shell_printf(", target = %s",
-					data[1] ? "ON" : "OFF");
+			sprintf(s, ", target = %s",
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
 
@@ -220,8 +221,9 @@ static void cmd_get_status(int argc, char *argv[])
 
 	node = node_find_by_addr(target);
 
-	if (!node)
-		return;
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in
database\n",target);
+	}
 
 	n = mesh_opcode_set(OP_GENERIC_ONOFF_GET, msg);
 
@@ -238,6 +240,8 @@ static void cmd_set(int argc, char *argv[])
 	uint16_t n;
 	uint8_t msg[32];
 	struct mesh_node *node;
+	int np;
+	uint32_t opcode;
 
 	if (IS_UNASSIGNED(target)) {
 		bt_shell_printf("Destination not set\n");
@@ -246,16 +250,26 @@ static void cmd_set(int argc, char *argv[])
 
 	node = node_find_by_addr(target);
 
-	if (!node)
-		return;
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in
database\n",target);
+	}
 
-	if ((read_input_parameters(argc, argv) != 1) &&
-					parms[0] != 0 && parms[0] != 1) {
-		bt_shell_printf("Bad arguments: Expecting \"0\" or
\"1\"\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	np = read_input_parameters(argc, argv);
+	if ((np != 1) && (np != 2) &&
+		parms[0] != 0 && parms[0] != 1 &&
+		parms[1] != 0 && parms[1] != 1) {
+	bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" "
+		"and an optional \"0\" or \"1\" as unack\n");
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if( (np==2) && parms[1] ){
+		opcode = OP_GENERIC_ONOFF_SET_UNACK;
+	}else{
+		opcode = OP_GENERIC_ONOFF_SET;
 	}
 
-	n = mesh_opcode_set(OP_GENERIC_ONOFF_SET, msg);
+	n = mesh_opcode_set(opcode, msg);
 	msg[n++] = parms[0];
 	msg[n++] = trans_id++;
 
@@ -275,7 +289,7 @@ static const struct bt_shell_menu onoff_menu = {
 						"Set node to configure"},
 	{"get",			NULL,
cmd_get_status,
 						"Get ON/OFF status"},
-	{"onoff",		"<0/1>",			cmd_set,
+	{"onoff",		"<0/1> [unack]",		cmd_set,
 						"Send \"SET ON/OFF\"
command"},
 	{} },
 };
-- 
2.19.2.windows.1

