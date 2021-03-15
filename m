Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F90C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 20:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6736764E12
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 20:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhCOUFN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 16:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhCOUEm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 16:04:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5180C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 13:04:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so173070pjb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2LNfrkoZiMGFTIJG/i9VYE2etsrlnCmN/4Qd+uOMTg=;
        b=vKqUkqLivyYNPh1CxtK4lHhCoGmlSRI5ItqvBAjHkJ6rMvi+8/+Y5vAuDj7BZBdFOM
         Kub8nd2ciwtX38amax1GCFC3Q/OlAKCy4KNiy+y/y32xv6jDaljma8bdC45nVeVGkdUA
         iApdVKxEkbXUS7SPAEdfddKdfARwRbmizwkwByWgpzzLHJXIh4R3lfKBo9EszO2LtuPQ
         kuOuNZdv/mEG1OOC0L9AYK931gqXwzX/zxZaqiBHAMKynmGh3QAVM6EkGnVrGoMPeTRZ
         pPzzuCaQcCmywKw1FDGnXdPeW3bKWVCR3azq9SKyj/Vz3rDv1d2zdZPn8Q866rLBOE04
         OMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2LNfrkoZiMGFTIJG/i9VYE2etsrlnCmN/4Qd+uOMTg=;
        b=WwqgfBvoW1b7ymjOX2iOTsAUwv274/gA1N613JG1a8YEB89Yo/WGvgdSXTxdtfx1iJ
         +7I7c/WGiCh0SF2fjMvcakbCW5wF7aTm67h3FxIk98RBWjkbXTPy5vcjzeqW7t9WBTXq
         /C5j+tc/f61ejoN6UeFBaHhMPisBiNNVIBGQw5yGWT9WllCyFWs9vOP5ELVPyTh9lEDE
         SpUCXHk03Tvvy2OSIC5+Qge7qlWdn7AwVAdGYWfyv2Y/lFkVpyp/xdB8uuYgcLZ/IKue
         Te6Sl7gAeYgttfkaBz8myGIQMV0EVy1/v/vdUK2OyYC/qsg3BFnjztdxEnqxemGR5dNb
         nyow==
X-Gm-Message-State: AOAM530IL4gPYUpUGwNwN2pkmg7Rm+PwJ2TJFdthW0p+f2iE2v7mSOZH
        ZHqtFa6zmR53wYbmYDCm9A00XMaSKfBk6g==
X-Google-Smtp-Source: ABdhPJxx/x/Haf6npKK7VcbCWgbFEPf6Opsj0ImNcaMTJskYpeYS4WJHiUe055TtHt3TFC2VHy14pA==
X-Received: by 2002:a17:902:d30c:b029:e3:f95:6da5 with SMTP id b12-20020a170902d30cb02900e30f956da5mr13271258plc.6.1615838681037;
        Mon, 15 Mar 2021 13:04:41 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q95sm457395pjq.20.2021.03.15.13.04.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:04:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix not checking for maximum number of DCID
Date:   Mon, 15 Mar 2021 13:04:37 -0700
Message-Id: <20210315200437.1800434-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When receiving L2CAP_CREDIT_BASED_CONNECTION_REQ the remote may request
more channels than allowed by the spec (10 octecs = 5 CIDs) so this
checks if the number of channels is bigger than the maximum allowed and
respond with an error.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Respond with an error instead of truncating the response with maximum
allowed nunber of channels.

 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 61800a7b6192..3c4f550e5a8b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -494,6 +494,7 @@ struct l2cap_le_credits {
 
 #define L2CAP_ECRED_MIN_MTU		64
 #define L2CAP_ECRED_MIN_MPS		64
+#define L2CAP_ECRED_MAX_CID		5
 
 struct l2cap_ecred_conn_req {
 	__le16 psm;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 72c2f5226d67..374cc32d7138 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5921,7 +5921,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	struct l2cap_ecred_conn_req *req = (void *) data;
 	struct {
 		struct l2cap_ecred_conn_rsp rsp;
-		__le16 dcid[5];
+		__le16 dcid[L2CAP_ECRED_MAX_CID];
 	} __packed pdu;
 	struct l2cap_chan *chan, *pchan;
 	u16 mtu, mps;
@@ -5938,6 +5938,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
+	cmd_len -= sizeof(*req);
+	num_scid = cmd_len / sizeof(u16);
+
+	if (num_scid > ARRAY_SIZE(pdu.dcid)) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto response;
+	}
+
 	mtu  = __le16_to_cpu(req->mtu);
 	mps  = __le16_to_cpu(req->mps);
 
@@ -5970,8 +5978,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	}
 
 	result = L2CAP_CR_LE_SUCCESS;
-	cmd_len -= sizeof(*req);
-	num_scid = cmd_len / sizeof(u16);
 
 	for (i = 0; i < num_scid; i++) {
 		u16 scid = __le16_to_cpu(req->scid[i]);
-- 
2.30.2

