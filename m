Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6BFA3741
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 23:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJaXLC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJaXKt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 19:10:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510C815FD0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:10:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g24so12055937plq.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sG9vTJFKbrcfPj8G/bF5aXTDFvy1Lzr1P6CitAHPyok=;
        b=XWFQ7LjgNqWWKC8U3GHRls248dauK+VvbYmh4eSnCoMPcTBi+dJrtA6C6a/oHgEMBf
         +84SqeVjEbCFVKWPzgOHGDLVN5j6AkwvMgMdLlOVX1nV98ndpmgJafkrBm2mk7HDcN/6
         n9LnXN823VlDCwYJu/MdyUMQJJeai7o4ITCplFLN4kza0WVsQHk2rhbcWL09/faTsKJ0
         kB8lMLBHEOLnO+qpFXRD+QMKVQlpXAODrLEH5t3u/dI927nr5PgRXMAcc75GX5hfMVz6
         D+fdYAdepaZEPOBdxVLhUOCdhSCzO1YWJNgfzwTc2mesneo8sqCjwcFNDksKV3BXdFpZ
         Y6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sG9vTJFKbrcfPj8G/bF5aXTDFvy1Lzr1P6CitAHPyok=;
        b=ot/lQMl7955QntjM0OGBpVs4HF0Ma/tuixwz0yCvmS0pc13rlFzviVC9tW+UQQ+Dl4
         dw+9/3YnrZQkg76kVsYYAwQMBYTWE7uOSfIwDo0cYwQin6u+bCpfEWiOsmnNnGwAQwWM
         latmI11r6XnTAVoJ62oWisEGRiabXVkkvcpb+JHEErUBTckTDYRhH+DAdsqaW8kd4Vng
         iFoTBqv7eCnsWfDeJ+mkM/nJ0VAj7b7KpmebzMyXWp5dvFP75dK6y9T/WrEIRWhFq9b2
         FPT2MdWQrxzvWgFgzUsbkThdh2SEiy3CV4MhRdi23q3Qc7dzKOvC1rXWI2u8rx+MqSjl
         yDfg==
X-Gm-Message-State: ACrzQf228XRy6xaNnGA9dLSDw4YVSa1Es9epqQ0xK6JCneP511qTOADh
        UUF9sCJfb31CmdevlqI4919fVERNtRk=
X-Google-Smtp-Source: AMsMyM6CxMve1qAmSIJu9EdBsjXEJJ+mLxoFFoR7xmzS9NS99SW+dsMAg7MhJHYO9L4BROF/FLwCwg==
X-Received: by 2002:a17:902:7c12:b0:186:8111:ade2 with SMTP id x18-20020a1709027c1200b001868111ade2mr16531179pll.111.1667257835338;
        Mon, 31 Oct 2022 16:10:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b7-20020aa78ec7000000b00561382a5a25sm5104265pfr.26.2022.10.31.16.10.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:10:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: L2CAP: Fix accepting connection request for invalid SPSM
Date:   Mon, 31 Oct 2022 16:10:32 -0700
Message-Id: <20221031231033.2718204-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The Bluetooth spec states that the valid range for SPSM is from
0x0001-0x00ff so it is invalid to accept values outside of this range:

  BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part A
  page 1059:
  Table 4.15: L2CAP_LE_CREDIT_BASED_CONNECTION_REQ SPSM ranges

CVE: CVE-2022-42896
CC: stable@vger.kernel.org
Reported-by: Tamás Koczka <poprdi@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ef725ed41303..2978a34ea33f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5813,6 +5813,19 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	BT_DBG("psm 0x%2.2x scid 0x%4.4x mtu %u mps %u", __le16_to_cpu(psm),
 	       scid, mtu, mps);
 
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part A
+	 * page 1059:
+	 *
+	 * Valid range: 0x0001-0x00ff
+	 *
+	 * Table 4.15: L2CAP_LE_CREDIT_BASED_CONNECTION_REQ SPSM ranges
+	 */
+	if (!psm || __le16_to_cpu(psm) > L2CAP_PSM_LE_DYN_END) {
+		result = L2CAP_CR_LE_BAD_PSM;
+		chan = NULL;
+		goto response;
+	}
+
 	/* Check if we have socket listening on psm */
 	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
 					 &conn->hcon->dst, LE_LINK);
@@ -6001,6 +6014,18 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 	psm  = req->psm;
 
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part A
+	 * page 1059:
+	 *
+	 * Valid range: 0x0001-0x00ff
+	 *
+	 * Table 4.15: L2CAP_LE_CREDIT_BASED_CONNECTION_REQ SPSM ranges
+	 */
+	if (!psm || __le16_to_cpu(psm) > L2CAP_PSM_LE_DYN_END) {
+		result = L2CAP_CR_LE_BAD_PSM;
+		goto response;
+	}
+
 	BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps);
 
 	memset(&pdu, 0, sizeof(pdu));
-- 
2.37.3

