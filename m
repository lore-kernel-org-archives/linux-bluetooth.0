Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82665C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 16:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382046AbhLCQMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:12:41 -0500
Received: from smtp202-pc.aruba.it ([62.149.157.202]:36567 "EHLO
        smtp200-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1382066AbhLCQMj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 11:12:39 -0500
Received: from danbia2MBL ([188.217.48.39])
        by Aruba Outgoing Smtp  with ESMTPSA
        id tB0imxNzZrBxFtB0lmsYJL; Fri, 03 Dec 2021 17:02:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638547331; bh=inxXi/2Ljmo41vlZVsG5c/isk9xC8rGDJWxaFKcyY6g=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=E7GPCRD8SDUbSWwu7vrShuhDu0O5P0zMQUXr8jAnEHVsPmgNVDrZuHZQ2VEwryE6f
         8ZT/cNTGraMuWkGTYhSu0WKp7hajpy+VSqkqtVgiusgFW2fy29dIin8pB1YbIIhFEx
         rh6bWgWh4VAYVvW87EMuCqRCavBh+0aGtI4letwGxtlokr4eyKBS4yJ9iqVkNwFWGn
         ZUbUDXbwPZeShFaDR+S+Sx/jZNQV3RMDkKNyFRic/6it3E4GoyHP3Ebu/4IZxryKyG
         Ji7JGtDJm5XdlOwj1jmPtdL48MvEVrWUBmPbjl//lEKvlEBI5vGeQD0jIlF3UyciMB
         073K93bv72A7w==
From:   <daniele.biagetti@cblelectronics.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 1/6] tools/mesh-gatt: Add onoff set unack message to onoff client model
Date:   Fri, 3 Dec 2021 17:02:10 +0100
Message-ID: <000501d7e85f$2105e2d0$6311a870$@cblelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfoXvYc6r6XD9G+SoyL3P0w05mzBQ==
Content-Language: it
X-CMAE-Envelope: MS4xfF3cbRY1IExUTsa8XkcX1hn3XGTVIs94MpoLCroyiDhFw2UDoZAuhsZ/Wr93fkd/0PeIrcts8IjLGtDpYRFJN77hngk2usYjLLYNgc7p8QKumH3IIncF
 moCB8Utrfqz26pZTsM1bkDen0scUWELtuAk+j2FtXFSv/8EdUGiwfBQJ8xh8ORvBybw1E20/2wZrGM0stN0gXnkBVNrmHbWZpmx+RZC54NQkJnwU8BULiDPV
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh-gatt/onoff-model.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
index 9dfedd85a..13ff4bbe3 100644
--- a/tools/mesh-gatt/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -226,6 +226,8 @@ static void cmd_set(int argc, char *argv[])
 	uint16_t n;
 	uint8_t msg[32];
 	struct mesh_node *node;
+	int np;
+	uint32_t opcode;
 
 	if (IS_UNASSIGNED(target)) {
 		bt_shell_printf("Destination not set\n");
@@ -237,13 +239,22 @@ static void cmd_set(int argc, char *argv[])
 	if (!node)
 		return;
 
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
 
@@ -263,7 +274,7 @@ static const struct bt_shell_menu onoff_menu = {
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
2.25.1


