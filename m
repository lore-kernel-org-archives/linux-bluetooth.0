Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A626C38145
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Sep 2022 21:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIFVY2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIFVY1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Sep 2022 17:24:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037C038B3
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Sep 2022 14:24:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso7817162pjd.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Sep 2022 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=qPYwQHT9RmzS2p/zqvpJTwjStaKJdywGIoKvk8Go+AE=;
        b=e5vaDM17ztvcB0X8xlaOVcRM7AdUbApR5O0VzJxvdqRMyApifnQabXsyH5Be5N0qw1
         DBoYTw7gyJ7RXbPo4EhBfom4VI1M7DbGBsgveplfzKRqTu/JaknwzsLhJ43RVA5VofaR
         5UuCVjrPr9h28eofb/gRxd+KzD07bLGm1dBD4NYh7sFdzNGMFQYRL1gs4FGCgqJLKNo1
         HEuB85W+iXqqSrf8JR9C2CMkQ9V/AcmLo09Tp2L3800Zn+ZQlQEdZprUymZlULKoM7LX
         uVjAzCgTw9Wu9hX+avMsr7MoTtETFrxKPy+XMmhqlmkzZ5n2XSP3+NkWGDo8HnbLgypV
         PaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=qPYwQHT9RmzS2p/zqvpJTwjStaKJdywGIoKvk8Go+AE=;
        b=HwLisVjhE4sRjyxeeM2ohHksZbiGDdvb97lW4Fy76quv1qZzxYryarrLOy6/zp8luM
         8Wtl5AKkK6GYMAGDfqSmlAE3Rs85cU+lhsfOMpey7LeAYqDt79m93nzRzvLIzSn2qIlI
         WJ7vS6yzuLTEhZm7BrqQx1ne/F/5Ri7et5zrPc2nhM607caLt0GOBksspq9Qr0DmSkOr
         smSaVVhuN9p+rIuNmcp774oCJ2WTMaqAfUFWkhGenOZ4cI3MJ4Qn0EW6BBHQfn+2qKi+
         pucwdBuxUYZR+l3ZNJjB8+L5s7+57LZw15SIf39BuSHGIJXaRlxQuXVRVoFYT6q6Of9j
         LwXA==
X-Gm-Message-State: ACgBeo22uJJIVy6qYfl0ziwyLp5SVb+/UDUQGbrYAnDKI4TOI/nBIVkT
        uKTEjLzAiuuC2HaMZ4cpI63EMojDw0E=
X-Google-Smtp-Source: AA6agR53C06QRxOnz1LkUvAJWoVBOOpPesZC8WNnx6qB/0Uhd5QzxqJLo4hnnGa7nt9QaphN2XCRpw==
X-Received: by 2002:a17:902:8a8d:b0:172:b26d:7a54 with SMTP id p13-20020a1709028a8d00b00172b26d7a54mr601388plo.36.1662499463889;
        Tue, 06 Sep 2022 14:24:23 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b00172f4835f53sm2651246plr.192.2022.09.06.14.24.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:24:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix Set PHY Configuration command
Date:   Tue,  6 Sep 2022 14:24:21 -0700
Message-Id: <20220906212421.2810556-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The command shall accept any subset that is considered configurable but
instead it was only accepting the exact match causing errors such as:

[mgmt]# phy
Supported phys: BR1M1SLOT BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT
EDR2M5SLOT EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT LE1MTX LE1MRX LE2MTX
LE2MRX LECODEDTX LECODEDRX
Configurable phys: BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT EDR2M5SLOT
EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT LE2MTX LE2MRX LECODEDTX LECODEDRX
Selected phys: BR1M1SLOT BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT
EDR2M5SLOT EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT LE1MTX LE1MRX
[mgmt]# phy BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT EDR2M5SLOT
EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT LE2MTX LE2MRX
Could not set PHY Configuration with status 0x0d (Invalid Parameters)

Fixes: 0314f2867fa0 ("Bluetooth: Implement Set PHY Confguration command")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4c421ebac669..9627528ed35f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4049,7 +4049,7 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_cp_set_phy_configuration *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	u32 selected_phys, configurable_phys, supported_phys, unconfigure_phys;
+	u32 selected_phys, configurable_phys, supported_phys;
 	u16 pkt_type = (HCI_DH1 | HCI_DM1);
 	bool changed = false;
 	int err;
@@ -4060,14 +4060,7 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 	supported_phys = get_supported_phys(hdev);
 	selected_phys = __le32_to_cpu(cp->selected_phys);
 
-	if (selected_phys & ~supported_phys)
-		return mgmt_cmd_status(sk, hdev->id,
-				       MGMT_OP_SET_PHY_CONFIGURATION,
-				       MGMT_STATUS_INVALID_PARAMS);
-
-	unconfigure_phys = supported_phys & ~configurable_phys;
-
-	if ((selected_phys & unconfigure_phys) != unconfigure_phys)
+	if (selected_phys & ~configurable_phys)
 		return mgmt_cmd_status(sk, hdev->id,
 				       MGMT_OP_SET_PHY_CONFIGURATION,
 				       MGMT_STATUS_INVALID_PARAMS);
-- 
2.37.2

