Return-Path: <SRS0=LC31=TQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B333DC04AAF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9C320815
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfEPOm0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 May 2019 10:42:26 -0400
Received: from mail.edilprogetti.net ([185.96.219.211]:39612 "EHLO
        mail.tinia.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfEPOm0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 May 2019 10:42:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 69DDD2226BB
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 16:36:05 +0200 (CEST)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NkEIGUcNVESU for <linux-bluetooth@vger.kernel.org>;
        Thu, 16 May 2019 16:36:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 8D3702226C5
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 16:36:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nVmM6rsiUlxd for <linux-bluetooth@vger.kernel.org>;
        Thu, 16 May 2019 16:36:04 +0200 (CEST)
Received: from DANBIAMBL (customer-31-185-23-59.com-com.it [31.185.23.59])
        by mail.tinia.eu (Postfix) with ESMTPSA id 625E32226BB
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 16:36:04 +0200 (CEST)
From:   "Daniele Biagetti" <daniele.biagetti@cblelectronics.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 1/4] meshctl: Subscription Delete message added to configuration client
Date:   Thu, 16 May 2019 16:35:48 +0200
Message-ID: <000601d50bf4$b0527f60$10f77e20$@cblelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdUL66zO9sHo+9FiTgiUDqkruHD+iw==
Content-Language: it
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Subscription delete command/message added to the 
configuration client model.

Signed-off-by: Daniele Biagetti <daniele.biagetti@cblelectronics.com>

---
 tools/mesh/config-client.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/mesh/config-client.c b/tools/mesh/config-client.c
index df2643622..bff38e7a3 100644
--- a/tools/mesh/config-client.c
+++ b/tools/mesh/config-client.c
@@ -1042,6 +1042,44 @@ static void cmd_sub_get(int argc, char *argv[])
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
+                bt_shell_printf("Failed to send \"ADD SUBSCRIPTION\"\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_mod_appidx_get(int argc, char *argv[])
 {
 	uint16_t n;
@@ -1237,6 +1275,8 @@ static const struct bt_shell_menu cfg_menu = {
 				cmd_sub_add,    "Add subscription"},
 	{"sub-get", "<ele_addr> <model id>",
 				cmd_sub_get,    "Get subscription"},
+	{"sub-del", "<ele_addr> <sub_addr> <model id>",
+				cmd_sub_del,    "Delete subscription"},
 	{"node-reset",		NULL,                    cmd_node_reset,
 				"Reset a node and remove it from network"},
 	{} },
-- 
2.19.2.windows.1


