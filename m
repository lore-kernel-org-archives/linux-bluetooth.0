Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F862C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 16:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiCLQsy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Mar 2022 11:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiCLQsx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Mar 2022 11:48:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB77A9A6
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 08:47:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u10so17440084wra.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9w/6bA1aoDkuJHS9K/TSkBOWaS4khHnnBbWGRmad4GA=;
        b=kX8golIdtVAkBB6ZLCRB9mXOVYRu7qL+w+gaG/UC2GEXzB+k3ZzNYziZElwDT5HkFV
         KD3W5VxxuCyy64hmDiXUv7e4DAvLYv6q2hGxOHdRmUGDbXhMwfFdkHqnfYdSa3BMNmVc
         pUU4TinqRVEmwF3fpE3OnuBGO8m/VfnW8RpVxjJt71chm04YyjbQ+Ed/Ec6/T/RJNLGZ
         o2XH2qxT5YO0Ye2SWI9gZcyzI8xguptKee4X5xjzwhQMuBdYy8+KAGWvdt7rSot3rIOc
         vMC2D8a/XG8IvHDMJBTS+fh6cfizjyAa1B1O0D7t63cc9c01uzm0R2lnv+unShXC4dpG
         fm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9w/6bA1aoDkuJHS9K/TSkBOWaS4khHnnBbWGRmad4GA=;
        b=ohuiqms/nKpXJ2AKTzV6QXi35MPS+dBBFvg3SXUlJ5buw5GL3hSyrXA+UPV+ZMVOxE
         53QdnGC8Mu1Lq96Is5o483Za1fIpgaHefEoW7QP9i3ai5za7Ij3rMeXGPc6tCUH3mpXL
         JqR6oKDSs9FpW/ypJr/SGxSF/P+Ax3CY4PsIGypzhCWhtUKUU2yHs30vxDd51JhgykyZ
         WPRKxDnabePMt51VZ4OGZxNzGoth2JsP2or+svqBubhLkOGqYdPRlkEMVgCafEVW0hMk
         J+dDLesdW9kXeywndaFaCuzRw60ZD/F31hqi3vyQbs9gWJBNR6dbvZ4gef+4tO8h8uLy
         6dNA==
X-Gm-Message-State: AOAM531bIdslRLKRpWObs4ob1SjCkwAa3YyeH+hS3QM/lWbjCAxbEBNz
        hZ7LcMKk1l9o90fRJ4gqNOPCOw==
X-Google-Smtp-Source: ABdhPJyA0kGFQ3L/J2KAMLzwTEX3mpb7NfSn4ieEi+P9Pmntd3uMjnsV0BEOouselFo9ecimO19RHw==
X-Received: by 2002:adf:d1c3:0:b0:203:8647:6fbe with SMTP id b3-20020adfd1c3000000b0020386476fbemr10323720wrd.65.1647103664396;
        Sat, 12 Mar 2022 08:47:44 -0800 (PST)
Received: from axion.fireburn.co.uk.fireburn.co.uk ([2a01:4b00:f40e:900::24e])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm12760833wmp.44.2022.03.12.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 08:47:43 -0800 (PST)
From:   Mike Lothian <mike@fireburn.co.uk>
Cc:     Mike Lothian <mike@fireburn.co.uk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Remove excessive bluetooth warning
Date:   Sat, 12 Mar 2022 16:45:51 +0000
Message-Id: <20220312164550.1810665-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixes: 3e54c5890c87a ("Bluetooth: hci_event: Use of a function table to handle HCI events")
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 net/bluetooth/hci_event.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fc30f4c03d29..aa57fccd2e47 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6818,14 +6818,6 @@ static void hci_event_func(struct hci_dev *hdev, u8 event, struct sk_buff *skb,
 		return;
 	}
 
-	/* Just warn if the length is over max_len size it still be
-	 * possible to partially parse the event so leave to callback to
-	 * decide if that is acceptable.
-	 */
-	if (skb->len > ev->max_len)
-		bt_dev_warn(hdev, "unexpected event 0x%2.2x length: %u > %u",
-			    event, skb->len, ev->max_len);
-
 	data = hci_ev_skb_pull(hdev, skb, event, ev->min_len);
 	if (!data)
 		return;
-- 
2.35.1

