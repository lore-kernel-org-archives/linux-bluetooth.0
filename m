Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23862C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 16:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382104AbhLCQMy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:12:54 -0500
Received: from smtp202-pc.aruba.it ([62.149.157.202]:54421 "EHLO
        smtp200-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1382063AbhLCQMn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 11:12:43 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 11:12:37 EST
Received: from danbia2MBL ([188.217.48.39])
        by Aruba Outgoing Smtp  with ESMTPSA
        id tB0imxNzZrBxFtB0smsYMG; Fri, 03 Dec 2021 17:02:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638547338; bh=yOXpZilRtFzwUD8zDuZCx1oJ0FszD4bQpIKcFQHM54c=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=DNR44fHVlFdcriDMwgURoChgELZDS20mylOas2L6SdB4JdNc9N7H33dbaAbVCOk5T
         JolsgiZUigSrcGmDZNe/pRcWx4PUIAlDorhw+fDGMnUcsBDOLnFSRaE/uOIUWiWVN4
         JH98gnOSjJdurfmq73iTtmmP+9G2T4Sh1ipsRHqlA6Worh4Ry1uYSzz/JBP4zkpicN
         J8t56zaYefeW7UioDj9kbivv2IK0f1h5GIDFbtW+LP/NXskF5rqdkIxaOM2rAi3OxD
         OpisZgwyR3Wz0GzpwagHta/eHeaKaBg59wagejiGBKyWGX3XntjpPek/FQSAi/mM23
         nAoFzP/YOTs9g==
From:   <daniele.biagetti@cblelectronics.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 4/6] tools/mesh-gatt: Add subscription delete message to config client model
Date:   Fri, 3 Dec 2021 17:02:17 +0100
Message-ID: <000801d7e85f$251aa7c0$6f4ff740$@cblelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfoXnOKPcaZMa9gRYmgsvtpIEz4Cg==
Content-Language: it
X-CMAE-Envelope: MS4xfNzmIgnB3GF9p4T0UfMgrb+aIKMwqgkFKm0louqXqEnNnLWb4H23GjouaOIxPskYqI2O1KAvY9kvNFoTzcYOG9AAbyx4bKfJ55p6MOmB1r0MkLzTp4Ax
 8EpWoggTF3Qx6cketCQeHLfBdplyCy3euVxFTlz053q95AesDQM9hTVw/uE2X59iepppdoNM1qbGhWcogKsHSWImgrjByDrMgZfVrSMCS2QwHNS5nCGNP58Y
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh-gatt/config-client.c | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/mesh-gatt/config-client.c
b/tools/mesh-gatt/config-client.c
index 7bdd028d2..c61908b4e 100644
--- a/tools/mesh-gatt/config-client.c
+++ b/tools/mesh-gatt/config-client.c
@@ -1037,6 +1037,44 @@ static void cmd_sub_get(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_sub_del(int argc, char *argv[])
+{
+        uint16_t n;
+        uint8_t msg[32];
+        int parm_cnt;
+
+        if (IS_UNASSIGNED(target)) {
+                bt_shell_printf("Destination not set\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_DELETE, msg);
+
+        parm_cnt = read_input_parameters(argc, argv);
+        if (parm_cnt != 3) {
+                bt_shell_printf("Bad arguments: %s\n", argv[1]);
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        /* Per Mesh Profile 4.3.2.19 */
+        /* Element Address */
+        put_le16(parms[0], msg + n);
+        n += 2;
+        /* Subscription Address */
+        put_le16(parms[1], msg + n);
+        n += 2;
+        /* SIG Model ID */
+        put_le16(parms[2], msg + n);
+        n += 2;
+
+        if (!config_send(msg, n)) {
+                bt_shell_printf("Failed to send \"DELETE
SUBSCRIPTION\"\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_mod_appidx_get(int argc, char *argv[])
 {
 	uint16_t n;
@@ -1232,6 +1270,8 @@ static const struct bt_shell_menu cfg_menu = {
 				cmd_sub_add,    "Add subscription"},
 	{"sub-get", "<ele_addr> <model id>",
 				cmd_sub_get,    "Get subscription"},
+	{"sub-del", "<ele_addr> <sub_addr> <model id>",
+				cmd_sub_del,    "Delete subscription"},
 	{"node-reset",		NULL,                    cmd_node_reset,
 				"Reset a node and remove it from network"},
 	{} },
-- 
2.25.1


