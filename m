Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E79DC43215
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7312071C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfKRNxq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:53:46 -0500
Received: from mail.monasterossannunziatatodi.it ([212.104.57.17]:44908 "EHLO
        mail.tinia.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfKRNxp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 08:53:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id C8D73222934;
        Mon, 18 Nov 2019 14:44:18 +0100 (CET)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ILRzboeQAzrY; Mon, 18 Nov 2019 14:44:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 13CC7220985;
        Mon, 18 Nov 2019 14:44:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5E-FGWWFcBXh; Mon, 18 Nov 2019 14:44:18 +0100 (CET)
Received: from blemesh.cbl.lan (customer-93-189-143-66.com-com.it [93.189.143.66])
        by mail.tinia.eu (Postfix) with ESMTPA id D5C1F22270B;
        Mon, 18 Nov 2019 14:44:17 +0100 (CET)
From:   Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele <dbiagio@tiscali.it>
Subject: [PATCH 2/6] tools/mesh: Fix status messages processing
Date:   Mon, 18 Nov 2019 14:44:01 +0100
Message-Id: <20191118134405.20212-3-daniele.biagetti@cblelectronics.com>
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

The status messages was processed and displayed even if they do
not belong to the present model. This fix ensure that the status
messages are processed only if they have the correct opcode.
---
 tools/mesh/node.c        | 11 +++++++++++
 tools/mesh/onoff-model.c | 19 ++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/mesh/node.c b/tools/mesh/node.c
index d23315ce4..3171ef01a 100644
--- a/tools/mesh/node.c
+++ b/tools/mesh/node.c
@@ -475,6 +475,8 @@ static bool deliver_model_data(struct mesh_element* e=
lement, uint16_t src,
 				uint16_t app_idx, uint8_t *data, uint16_t len)
 {
 	GList *l;
+	uint32_t opcode;
+	int n;
=20
 	for(l =3D element->models; l; l =3D l->next) {
 		struct mesh_model *model =3D l->data;
@@ -487,6 +489,15 @@ static bool deliver_model_data(struct mesh_element* =
element, uint16_t src,
 			return true;
 	}
=20
+	if (mesh_opcode_get(data, len, &opcode, &n)) {
+		len -=3D n;
+		data +=3D n;
+	} else
+		return false;
+	bt_shell_printf("Unknown Model Message received (%d) opcode %x\n",
+						len, opcode);
+	print_byte_array("\t",data, len);
+
 	return false;
 }
=20
diff --git a/tools/mesh/onoff-model.c b/tools/mesh/onoff-model.c
index 6236e1fea..a6baeb0c5 100644
--- a/tools/mesh/onoff-model.c
+++ b/tools/mesh/onoff-model.c
@@ -111,6 +111,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *d=
ata,
 {
 	uint32_t opcode;
 	int n;
+	char s[128];
=20
 	if (mesh_opcode_get(data, len, &opcode, &n)) {
 		len -=3D n;
@@ -127,18 +128,22 @@ static bool client_msg_recvd(uint16_t src, uint8_t =
*data,
 		return false;
=20
 	case OP_GENERIC_ONOFF_STATUS:
+		bt_shell_printf("On Off Model Message received (%d) opcode %x\n",
+			len, opcode);
+		print_byte_array("\t",data, len);
 		if (len !=3D 1 && len !=3D 3)
 			break;
=20
-		bt_shell_printf("Node %4.4x: Off Status present =3D %s",
-						src, data[0] ? "ON" : "OFF");
-
+		sprintf(s, "Node %4.4x: On Off Status present =3D %s",
+			src, data[0] ? "ON" : "OFF");
 		if (len =3D=3D 3) {
-			bt_shell_printf(", target =3D %s",
-					data[1] ? "ON" : "OFF");
+			sprintf(s, ", target =3D %s",
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
=20
--=20
2.20.1

