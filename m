Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E3C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C33B2071C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKRNxr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:53:47 -0500
Received: from mail.sorellediluna.it ([212.104.57.17]:44912 "EHLO
        mail.tinia.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfKRNxr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 08:53:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 40A3D2229A2;
        Mon, 18 Nov 2019 14:44:20 +0100 (CET)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jEuCSiifNlLg; Mon, 18 Nov 2019 14:44:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 8792A220985;
        Mon, 18 Nov 2019 14:44:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QuWt4MO1278l; Mon, 18 Nov 2019 14:44:19 +0100 (CET)
Received: from blemesh.cbl.lan (customer-93-189-143-66.com-com.it [93.189.143.66])
        by mail.tinia.eu (Postfix) with ESMTPA id 4F61722270B;
        Mon, 18 Nov 2019 14:44:19 +0100 (CET)
From:   Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele <dbiagio@tiscali.it>
Subject: [PATCH 4/6] tools/mesh: Add subscription delete message to config client model
Date:   Mon, 18 Nov 2019 14:44:03 +0100
Message-Id: <20191118134405.20212-5-daniele.biagetti@cblelectronics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118134405.20212-1-daniele.biagetti@cblelectronics.com>
References: <20191118134405.20212-1-daniele.biagetti@cblelectronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Daniele <dbiagio@tiscali.it>

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
=20
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
+        n =3D mesh_opcode_set(OP_CONFIG_MODEL_SUB_DELETE, msg);
+
+        parm_cnt =3D read_input_parameters(argc, argv);
+        if (parm_cnt !=3D 3) {
+                bt_shell_printf("Bad arguments: %s\n", argv[1]);
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        /* Per Mesh Profile 4.3.2.19 */
+        /* Element Address */
+        put_le16(parms[0], msg + n);
+        n +=3D 2;
+        /* Subscription Address */
+        put_le16(parms[1], msg + n);
+        n +=3D 2;
+        /* SIG Model ID */
+        put_le16(parms[2], msg + n);
+        n +=3D 2;
+
+        if (!config_send(msg, n)) {
+                bt_shell_printf("Failed to send \"ADD SUBSCRIPTION\"\n")=
;
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_mod_appidx_get(int argc, char *argv[])
 {
 	uint16_t n;
@@ -1237,6 +1275,8 @@ static const struct bt_shell_menu cfg_menu =3D {
 				cmd_sub_add,    "Add subscription"},
 	{"sub-get", "<ele_addr> <model id>",
 				cmd_sub_get,    "Get subscription"},
+	{"sub-del", "<ele_addr> <sub_addr> <model id>",
+				cmd_sub_del,    "Delete subscription"},
 	{"node-reset",		NULL,                    cmd_node_reset,
 				"Reset a node and remove it from network"},
 	{} },
--=20
2.20.1

