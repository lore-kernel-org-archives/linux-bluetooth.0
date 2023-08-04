Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4659C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 00:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjHDALb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 20:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjHDAL3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 20:11:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31FE421D
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 17:11:26 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76af2cb7404so112683985a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691107885; x=1691712685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIEsPwNQJyDAIqXk9eD9dl8ZlbgEpVSK34aQ6MX/wbs=;
        b=HNuuDPMS1h0wYiephHJDauMEqg3Cb5OaOV336FElUa3oC9zLDcZ9YaPq/cjg2TyPpd
         uw1aeWvnEEAAwo+64qbOmRVAVp4yOaXxbYFyCSw+baiYbqhb7cWSAuXyGJbAzWoWzMs7
         6afrzEqloFZgvExHkkpEnLWX0wc71o4AJIMxSyJdwKgaTKnH/izqrrrtKTut3gGEoWSG
         DeRvjR2Fsj6wEGlV82IA5RNkuDavKbcUWtti3S8Vqrv7emUB8blXjlgWjiaS+U6fOmEM
         kouHF4SuQ15NdVAqS5YLJqkl7m7IKQCJVfjDSiLiqwgKvyxfKm+ehgc53jTilMuAesIi
         /DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691107885; x=1691712685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIEsPwNQJyDAIqXk9eD9dl8ZlbgEpVSK34aQ6MX/wbs=;
        b=jhtd3xTd0h8n8DLd0YRxRgAUHHQjl4Q2Yd5FguJPa8A9rl75jLOQa8ujAkS2i0w6Nn
         mRTJd+6IzlcLHhbgB5qKwQ5yQKkZcX2jpg3n0xR1QCeF6XIQWh3QVOZ+X6DIZkV1Esfn
         bBUitOjwzIHMLbxbA+DSe4tBx21hcaB8taUHJo5n/uextKpOcCH0rewg0PqyM1Hk80ug
         j4f5ZwDNP2ZTHFRFZmhGWmyQ2pPNi6pOxfl94JGVkcm3ET53fyQWBtA34vv9xkpUieyW
         y3S1fff+Kcpmq7YLB7IjW1b1ORYJuuNHHwe/y+TkcizdgfYA+8VPlA1BzHOURQmdtzmo
         ZI+A==
X-Gm-Message-State: AOJu0Yzzlcx2cG8JngpxlFDMSyXWr2Q9hNMuLcLrWvgMoqtKFYmlD6id
        6mx5kjkuHVCUpv0cmY1OiPZZvBwFq+k=
X-Google-Smtp-Source: AGHT+IER4JFqkf9Y9Cw2DXgdSvWVPx7/obq7Lzo8pHH7buLdkv61gznIgzx7BDCBx4kqMlyFyGwlGQ==
X-Received: by 2002:a05:6214:18ee:b0:63c:ef88:f8f2 with SMTP id ep14-20020a05621418ee00b0063cef88f8f2mr194515qvb.32.1691107885330;
        Thu, 03 Aug 2023 17:11:25 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id y11-20020a0ce04b000000b0063c6c7f4b92sm272448qvk.1.2023.08.03.17.11.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:11:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] Bluetooth: hci_conn: Fix not allowing valid CIS ID
Date:   Thu,  3 Aug 2023 17:11:15 -0700
Message-ID: <20230804001115.907885-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804001115.907885-1-luiz.dentz@gmail.com>
References: <20230804001115.907885-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Only the number of CIS shall be limited to 0x1f, the CIS ID in the
other hand is up to 0xef.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 13bd2753abbb..84f2ac21a85a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1849,9 +1849,12 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 		cis_add(&data, qos);
 	}
 
-	/* Reprogram all CIS(s) with the same CIG */
-	for (data.cig = qos->ucast.cig, data.cis = 0x00; data.cis < 0x11;
-	     data.cis++) {
+	/* Reprogram all CIS(s) with the same CIG, valid range are:
+	 * num_cis: 0x00 to 0x1F
+	 * cis_id: 0x00 to 0xEF
+	 */
+	for (data.cig = qos->ucast.cig, data.cis = 0x00; data.cis < 0xf0 &&
+	     data.pdu.cp.num_cis < ARRAY_SIZE(data.pdu.cis); data.cis++) {
 		data.count = 0;
 
 		hci_conn_hash_list_state(hdev, cis_list, ISO_LINK, BT_BOUND,
-- 
2.41.0

