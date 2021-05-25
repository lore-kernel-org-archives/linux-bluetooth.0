Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E77C47086
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0975061423
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhEYKbe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 06:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhEYKba (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 06:31:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EC5C06138D
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:00 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 28-20020a63135c0000b029021b78388f01so4642146pgt.23
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UvJLOv2gVJIXVa5GBDx5GvSc7WAOA+t44/q+nZdfURY=;
        b=Z/hYDFxQWfsOjkNfKZtQjYO4F0sjNyEPawpStKLooRsMRxctwbKOzodQ58NSJ1IhB7
         0psOosT/YVWe0GWwAfFaoocubI/LfANAqdiiQFikbK/+RW2AQhgc8mEUb2N4xs6+Sj0c
         cwoCNZ8n3RgPzVBIcNrkXK6ZMzKwrSIvhawgEylBEjoedjC+5pGPIspTtoQ+tOuz/5D3
         RRQXLwCAcY7s046OhrioP2+k5DFY/vAJkYsyLLOs/SCw1F7V/JMROlThR9/hfm6acdfg
         gTYxEltfQhjX3GbL1onZLgH2PuXV3uehTBu+4nzgh2slygqCn8rnt0fT4HPtPxhptoyf
         G5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UvJLOv2gVJIXVa5GBDx5GvSc7WAOA+t44/q+nZdfURY=;
        b=P0MfFj5u29anQesdBPsXEoiV/G+0K5gapgydUjORWhK7Oz+bKn+WkDsTpww8WiS+ey
         o7ZBnvrPtwiyHLs9SBjFMQYp/7nuUjHFL1hVpS7mHxvmP1fI/6c5Q/lbJJrSQwxzh45H
         fKlegKPuewLAqTyRJRw5rw5y9NRbeIDtUzM8u54JLoGOKKjDdrqgvmjMT4iDzvyEie6s
         UMUHTRm2hIEHME0Jr0sABZnnmI/h4rR7rozmxNEvi3fkfIV53c105CnkuUA9M1ZWJGpQ
         WLYaxnyBlitW6f76qdfd484Cz9aT0ocP2e1UlMuxLn6nfcy0hlWdBzKdGgdJGX0knGQ/
         cKUw==
X-Gm-Message-State: AOAM5337TB6jv0zM6n3F7bPb41r1X0VQBwwrXx4Xo5kNFgMrTargq5iJ
        MZ4EeeYdue7lP/X8v7KfP1lfbXtn+ArwZV+6A4ztbS3rfWS7uBRdHNsnI7tIjQplNm52vJXD1R+
        NYHzpBx/1zGQ37OHyVvY8/8w2fm7qRkQccm51MjSZmuhrUYTHSfQ3BW3vbyqArqPy7WJR8PUy9R
        7G
X-Google-Smtp-Source: ABdhPJwUM4afxIAmgfll5Xs6Yvyi6y17RQ4zNU2CAe61e3UkeOz80jcEKDQPpH6LKhH2y59i7z6UKVnylEQn
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:8806:6b98:8ae6:8824])
 (user=apusaka job=sendgmr) by 2002:a62:6045:0:b029:2e0:9371:57e1 with SMTP id
 u66-20020a6260450000b02902e0937157e1mr29526881pfb.14.1621938599800; Tue, 25
 May 2021 03:29:59 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:31 +0800
In-Reply-To: <20210525102941.3958649-1-apusaka@google.com>
Message-Id: <20210525182900.2.I0564cdade0879f3f2b192ae73d01a0135baf8050@changeid>
Mime-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 02/12] Bluetooth: use inclusive language in hci_core.h
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use "central" and "peripheral".
These attributes are not used elsewhere in the code.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

 include/net/bluetooth/hci.h | 44 ++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 18742f4471ff..c3efef266d6d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1839,23 +1839,23 @@ struct hci_rp_le_read_iso_tx_sync {
 #define HCI_OP_LE_SET_CIG_PARAMS		0x2062
 struct hci_cis_params {
 	__u8    cis_id;
-	__le16  m_sdu;
-	__le16  s_sdu;
-	__u8    m_phy;
-	__u8    s_phy;
-	__u8    m_rtn;
-	__u8    s_rtn;
+	__le16  c_sdu;
+	__le16  p_pdu;
+	__u8    c_phy;
+	__u8    p_phy;
+	__u8    c_rtn;
+	__u8    p_rtn;
 } __packed;
 
 struct hci_cp_le_set_cig_params {
 	__u8    cig_id;
-	__u8    m_interval[3];
-	__u8    s_interval[3];
-	__u8    sca;
+	__u8    c_interval[3];
+	__u8    p_interval[3];
+	__u8    wc_sca;
 	__u8    packing;
 	__u8    framing;
-	__le16  m_latency;
-	__le16  s_latency;
+	__le16  c_latency;
+	__le16  p_latency;
 	__u8    num_cis;
 	struct hci_cis_params cis[];
 } __packed;
@@ -2260,7 +2260,7 @@ struct hci_ev_sync_train_complete {
 	__u8	status;
 } __packed;
 
-#define HCI_EV_SLAVE_PAGE_RESP_TIMEOUT	0x54
+#define HCI_EV_PERIPHERAL_PAGE_RESP_TIMEOUT	0x54
 
 #define HCI_EV_LE_CONN_COMPLETE		0x01
 struct hci_ev_le_conn_complete {
@@ -2418,17 +2418,17 @@ struct hci_evt_le_cis_established {
 	__le16 handle;
 	__u8  cig_sync_delay[3];
 	__u8  cis_sync_delay[3];
-	__u8  m_latency[3];
-	__u8  s_latency[3];
-	__u8  m_phy;
-	__u8  s_phy;
+	__u8  c_latency[3];
+	__u8  p_latency[3];
+	__u8  c_phy;
+	__u8  p_phy;
 	__u8  nse;
-	__u8  m_bn;
-	__u8  s_bn;
-	__u8  m_ft;
-	__u8  s_ft;
-	__le16 m_mtu;
-	__le16 s_mtu;
+	__u8  c_bn;
+	__u8  p_bn;
+	__u8  c_ft;
+	__u8  p_ft;
+	__le16 c_mtu;
+	__le16 p_mtu;
 	__le16 interval;
 } __packed;
 
-- 
2.31.1.818.g46aad6cb9e-goog

