Return-Path: <SRS0=G9Zr=XI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016DCC49ED7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Sep 2019 07:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5BC207FC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Sep 2019 07:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEGwxjrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfIMHX4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Sep 2019 03:23:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35829 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfIMHXz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Sep 2019 03:23:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so21373259lfl.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2019 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9HmYAGiqCp8l5hpSWHNuA0AqaHO2b9QKYehrxiiTIo=;
        b=DEGwxjrQK0s6s0xZPne+SgVRlAaPkuDM93LfS5AvCGbvbWhOuZE5oq6SNLqQMJDLpZ
         EufGYCGrQgislOaaBRz88TzMJKz/kSdxKzK5LYQn1LeYyp2mMe9E+NR/HBjK8e26SRG3
         yE4SKvZxl0UhwJsRJO4kcPM4sjf9y2z+lUWzEdJ86uGiHSefsIYfQl2EVsFJJyg05iw/
         /Pq1bnS3Q/RooE5RdX1h7+FPQed/WUJ8tWFaBNL3tRLE2rqLyqZ/I+Jeu2+U97xyKrS6
         WP0C2nYLieJXVAIFs6i0ItDz5nuWqvyKjDDfB26MHw/bvgU0/ciD6f5G8VoKmdc0Omct
         7OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9HmYAGiqCp8l5hpSWHNuA0AqaHO2b9QKYehrxiiTIo=;
        b=Ou3WaBZoxllojaSTEnIXylrU7dF3wbLDDhdZA5v/wpYIatcSaFMHD7uJsPYz+tv1eF
         WLnbuyLap+4mCSacTMkW8PVjZVgtmgc6EYSpUBb5jqtIVXkQb5jr670kvJyd0BKNX0Vo
         GOGGykjXgs9EFXVe7AW29bPL0gEhhPQRqNYvzdg7B9kqzNfOYTF2BcX4n65ccMHMunSz
         s4XTfQBr0fAXm0nogF+AyNr3lXE0LWq6VwDgiybpqp9Lg8BUiXhzuxm6vr6Ci7v9tO6W
         rZHV3gI/xy+088Vs980zG4gXmVybx0Hohodjs1DhBX8uxLha/6yND8tgL4j+eCxpR4G7
         DM4A==
X-Gm-Message-State: APjAAAW3mMrqqFCvC8xrw0M145VItvh2udDL3K5Xg5xwMFUTw3mBaHj1
        mIUoLeMEQvHj1mTOB84HKCpfs2TTsAps3g==
X-Google-Smtp-Source: APXvYqwg4D3ogFD7FGREfxV7ENhioQHD+f8Qm3FfdVSReSnwUng46zmr0zwCzWdEMLsZNbP+zz4zTw==
X-Received: by 2002:ac2:4257:: with SMTP id m23mr30083053lfl.6.1568359432588;
        Fri, 13 Sep 2019 00:23:52 -0700 (PDT)
Received: from vudentzs-t460s.www.huaweimobilewifi.com (83-245-224-6-nat-p.elisa-mobile.fi. [83.245.224.6])
        by smtp.gmail.com with ESMTPSA id r75sm6715338lff.7.2019.09.13.00.23.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 00:23:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Add proper decoding of LE flowctl mode
Date:   Fri, 13 Sep 2019 10:23:45 +0300
Message-Id: <20190913072345.24118-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables decoding LE flowctl mode properly and print out the
SDU.
---
 monitor/l2cap.c | 65 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 26719ac5e..ad2499851 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -47,6 +47,14 @@
 #include "rfcomm.h"
 #include "bnep.h"
 
+
+#define L2CAP_MODE_BASIC		0x00
+#define L2CAP_MODE_RETRANS		0x01
+#define L2CAP_MODE_FLOWCTL		0x02
+#define L2CAP_MODE_ERTM			0x03
+#define L2CAP_MODE_STREAMING		0x04
+#define L2CAP_MODE_LE_FLOWCTL		0x80
+
 /* L2CAP Control Field bit masks */
 #define L2CAP_CTRL_SAR_MASK		0xC000
 #define L2CAP_CTRL_REQSEQ_MASK		0x3F00
@@ -102,12 +110,13 @@ struct chan_data {
 	uint8_t  mode;
 	uint8_t  ext_ctrl;
 	uint8_t  seq_num;
+	uint16_t sdu;
 };
 
 static struct chan_data chan_list[MAX_CHAN];
 
-static void assign_scid(const struct l2cap_frame *frame,
-				uint16_t scid, uint16_t psm, uint8_t ctrlid)
+static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
+			uint16_t psm, uint8_t mode, uint8_t ctrlid)
 {
 	int i, n = -1;
 	uint8_t seq_num = 1;
@@ -154,7 +163,7 @@ static void assign_scid(const struct l2cap_frame *frame,
 
 	chan_list[n].psm = psm;
 	chan_list[n].ctrlid = ctrlid;
-	chan_list[n].mode = 0;
+	chan_list[n].mode = mode;
 
 	chan_list[n].seq_num = seq_num;
 }
@@ -257,6 +266,9 @@ static int get_chan_data_index(const struct l2cap_frame *frame)
 {
 	int i;
 
+	if (frame->chan)
+		return frame->chan;
+
 	for (i = 0; i < MAX_CHAN; i++) {
 		if (chan_list[i].index != frame->index &&
 					chan_list[i].ctrlid == 0)
@@ -1091,7 +1103,8 @@ static void sig_conn_req(const struct l2cap_frame *frame)
 	print_psm(pdu->psm);
 	print_cid("Source", pdu->scid);
 
-	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0);
+	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm),
+						L2CAP_MODE_BASIC, 0);
 }
 
 static void sig_conn_rsp(const struct l2cap_frame *frame)
@@ -1220,7 +1233,7 @@ static void sig_create_chan_req(const struct l2cap_frame *frame)
 	print_field("Controller ID: %d", pdu->ctrlid);
 
 	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm),
-								pdu->ctrlid);
+						L2CAP_MODE_BASIC, pdu->ctrlid);
 }
 
 static void sig_create_chan_rsp(const struct l2cap_frame *frame)
@@ -1293,7 +1306,8 @@ static void sig_le_conn_req(const struct l2cap_frame *frame)
 	print_field("MPS: %u", le16_to_cpu(pdu->mps));
 	print_field("Credits: %u", le16_to_cpu(pdu->credits));
 
-	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0);
+	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm),
+						L2CAP_MODE_LE_FLOWCTL, 0);
 }
 
 static void sig_le_conn_rsp(const struct l2cap_frame *frame)
@@ -3015,10 +3029,21 @@ static void smp_packet(uint16_t index, bool in, uint16_t handle,
 	opcode_data->func(&frame);
 }
 
+static struct chan_data *get_data(const struct l2cap_frame *frame)
+{
+	int i = get_chan_data_index(frame);
+
+	if (i < 0)
+		return NULL;
+
+	return &chan_list[i];
+}
+
 void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 			uint16_t psm, const void *data, uint16_t size)
 {
 	struct l2cap_frame frame;
+	struct chan_data *chan;
 	uint32_t ctrl32 = 0;
 	uint16_t ctrl16 = 0;
 	uint8_t ext_ctrl;
@@ -3047,7 +3072,27 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 		l2cap_frame_init(&frame, index, in, handle, 0, cid, psm,
 							data, size);
 
-		if (frame.mode > 0) {
+		switch (frame.mode) {
+		case L2CAP_MODE_LE_FLOWCTL:
+			chan = get_data(&frame);
+			if (!chan->sdu) {
+				if (!l2cap_frame_get_le16(&frame, &chan->sdu))
+					return;
+			}
+			print_indent(6, COLOR_CYAN, "Channel:", "",
+					COLOR_OFF, " %d len %d sdu %d"
+					" [PSM %d mode %d] {chan %d}",
+					cid, size, chan->sdu, frame.psm,
+					frame.mode, frame.chan);
+			chan->sdu -= frame.size;
+			break;
+		case L2CAP_MODE_BASIC:
+			print_indent(6, COLOR_CYAN, "Channel:", "", COLOR_OFF,
+					" %d len %d [PSM %d mode %d] {chan %d}",
+						cid, size, frame.psm,
+						frame.mode, frame.chan);
+			break;
+		default:
 			ext_ctrl = get_ext_ctrl(&frame);
 
 			if (ext_ctrl) {
@@ -3077,11 +3122,7 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 			}
 
 			printf("\n");
-		} else {
-			print_indent(6, COLOR_CYAN, "Channel:", "", COLOR_OFF,
-					" %d len %d [PSM %d mode %d] {chan %d}",
-						cid, size, frame.psm,
-						frame.mode, frame.chan);
+			break;
 		}
 
 		switch (frame.psm) {
-- 
2.21.0

