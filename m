Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D83C43141
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A612071C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKRNxr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:53:47 -0500
Received: from mail.borgobrufa.it ([212.104.57.17]:44911 "EHLO mail.tinia.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfKRNxq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 08:53:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 5E5FA22293F;
        Mon, 18 Nov 2019 14:44:19 +0100 (CET)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OMk9Tr3MP3PY; Mon, 18 Nov 2019 14:44:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id E419B220985;
        Mon, 18 Nov 2019 14:44:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sobRhVny-Wu4; Mon, 18 Nov 2019 14:44:18 +0100 (CET)
Received: from blemesh.cbl.lan (customer-93-189-143-66.com-com.it [93.189.143.66])
        by mail.tinia.eu (Postfix) with ESMTPA id A915D22270B;
        Mon, 18 Nov 2019 14:44:18 +0100 (CET)
From:   Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele <dbiagio@tiscali.it>
Subject: [PATCH 3/6] tools/mesh: Fix unwanted return in onoff client model
Date:   Mon, 18 Nov 2019 14:44:02 +0100
Message-Id: <20191118134405.20212-4-daniele.biagetti@cblelectronics.com>
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

Replaced the return statement with a warning message in case of
transmission or reception of messages coming from unknown addresses
(such as group addresses)
---
 tools/mesh/onoff-model.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/mesh/onoff-model.c b/tools/mesh/onoff-model.c
index a6baeb0c5..8199e32bd 100644
--- a/tools/mesh/onoff-model.c
+++ b/tools/mesh/onoff-model.c
@@ -225,8 +225,9 @@ static void cmd_get_status(int argc, char *argv[])
=20
 	node =3D node_find_by_addr(target);
=20
-	if (!node)
-		return;
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+	}
=20
 	n =3D mesh_opcode_set(OP_GENERIC_ONOFF_GET, msg);
=20
@@ -253,8 +254,9 @@ static void cmd_set(int argc, char *argv[])
=20
 	node =3D node_find_by_addr(target);
=20
-	if (!node)
-		return;
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+	}
=20
 	np =3D read_input_parameters(argc, argv);
 	if ((np !=3D 1) && (np !=3D 2) &&
--=20
2.20.1

