Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B48C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215352071C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKRNxp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:53:45 -0500
Received: from mail.omegapg.it ([212.104.57.17]:44906 "EHLO mail.tinia.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfKRNxp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 08:53:45 -0500
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Nov 2019 08:53:44 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 05FD6222712;
        Mon, 18 Nov 2019 14:44:18 +0100 (CET)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wsimLMkMvaI1; Mon, 18 Nov 2019 14:44:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 41443220985;
        Mon, 18 Nov 2019 14:44:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dNphy5hWEZ2m; Mon, 18 Nov 2019 14:44:17 +0100 (CET)
Received: from blemesh.cbl.lan (customer-93-189-143-66.com-com.it [93.189.143.66])
        by mail.tinia.eu (Postfix) with ESMTPA id E274522270B;
        Mon, 18 Nov 2019 14:44:16 +0100 (CET)
From:   Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele <dbiagio@tiscali.it>
Subject: [PATCH 1/6] tools/mesh: Add onoff set unack message to onoff client model
Date:   Mon, 18 Nov 2019 14:44:00 +0100
Message-Id: <20191118134405.20212-2-daniele.biagetti@cblelectronics.com>
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
 tools/mesh/onoff-model.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/mesh/onoff-model.c b/tools/mesh/onoff-model.c
index b52afe2c8..6236e1fea 100644
--- a/tools/mesh/onoff-model.c
+++ b/tools/mesh/onoff-model.c
@@ -238,6 +238,8 @@ static void cmd_set(int argc, char *argv[])
 	uint16_t n;
 	uint8_t msg[32];
 	struct mesh_node *node;
+	int np;
+	uint32_t opcode;
=20
 	if (IS_UNASSIGNED(target)) {
 		bt_shell_printf("Destination not set\n");
@@ -249,13 +251,22 @@ static void cmd_set(int argc, char *argv[])
 	if (!node)
 		return;
=20
-	if ((read_input_parameters(argc, argv) !=3D 1) &&
-					parms[0] !=3D 0 && parms[0] !=3D 1) {
-		bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\"\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	np =3D read_input_parameters(argc, argv);
+	if ((np !=3D 1) && (np !=3D 2) &&
+		parms[0] !=3D 0 && parms[0] !=3D 1 &&
+		parms[1] !=3D 0 && parms[1] !=3D 1) {
+	bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" "
+		"and an optional \"0\" or \"1\" as unack\n");
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if( (np=3D=3D2) && parms[1] ){
+		opcode =3D OP_GENERIC_ONOFF_SET_UNACK;
+	}else{
+		opcode =3D OP_GENERIC_ONOFF_SET;
 	}
=20
-	n =3D mesh_opcode_set(OP_GENERIC_ONOFF_SET, msg);
+	n =3D mesh_opcode_set(opcode, msg);
 	msg[n++] =3D parms[0];
 	msg[n++] =3D trans_id++;
=20
@@ -275,7 +286,7 @@ static const struct bt_shell_menu onoff_menu =3D {
 						"Set node to configure"},
 	{"get",			NULL,				cmd_get_status,
 						"Get ON/OFF status"},
-	{"onoff",		"<0/1>",			cmd_set,
+	{"onoff",		"<0/1> [unack]",		cmd_set,
 						"Send \"SET ON/OFF\" command"},
 	{} },
 };
--=20
2.20.1

