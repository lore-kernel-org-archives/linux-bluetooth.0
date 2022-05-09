Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFBFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiEIVJt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 17:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiEIVJr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 17:09:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6954272216
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 14:05:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f16f3a7c34so129425127b3.17
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 May 2022 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bfz1mnwaX4ka3VLZxEi1SIdcRgMxAF5AucTmvkifj0I=;
        b=AiKMPLXlZuaA3VPSpj/ofOF1/jtgSK4b7F0Y8MltTlfTMOaVr/mSsv2C6Lg+/bm8pK
         b3MmagvFZZvLwH/NIdZSL/eOLHl/1wD7ijQNvZOA1w8Eu5TQCsxDm4fKdWQ/y/zEIymr
         W6lPsa9LMn534psJhgmJ2CL5y5aVTvrinKDT+vVcXvn2BMhzvpxOXWNFAvmmiqAfZVKS
         uefy5ND7VVukTWWPv4zKp8Hbcf7m0qf+5X2rJuh/yg3XD5UKXakphQPF4AZwHvr0+v9R
         yG+smavIqT0RJ9KqK99UIt65nZaAnpD/oCat5UVC/7ZKsCtMuTdXpWH49MM/03xDvj/9
         0aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bfz1mnwaX4ka3VLZxEi1SIdcRgMxAF5AucTmvkifj0I=;
        b=iS2zgPbTp9mE5K7Ha1k4LCDb+FWKUW/lNXe9S0NbN+U3gcwaOOPV1X+hRjcmWWLtbh
         7MOpZRvyEJLaNQUz9LaROpFVhuDwfe+RsPvh5XBAvtFKBglRTPigZTYDYZW4b+SPWUS1
         AI09yIpITYmDS1c6R4mqzVSfXaWZFh/f+cjaGoMTEtnCIt3BDvm6bUUpdO+fHAOAGJBz
         IkBUt9W/gWVQSHIogTX0LtIHNEAI9ORQ0ENQTkE9Ak4GjLVjFE8mudkmN8VAsliFKFKM
         RqRY3W1nDvYkof/e3YszAnOOllvvi+vnTuPTwIMacXYGQ+lvTx4LVSfmMpOpzUYDrdXt
         JczA==
X-Gm-Message-State: AOAM533oddyjn56+dddyUB7jnYxTo25oCFBSighOe9sLGqQqzthMl3bt
        8878LogAnlbmNQiayR/AXKEqhgxTRuvhyA==
X-Google-Smtp-Source: ABdhPJxuy3o513Mphh5qdmHGZppOwcPpU0V84poKA6tagZCsNhO7fAnDzJqL+eG1MvWxf2DsHMZGUUGiCIggUw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:dfb9:149b:15ff:6b47])
 (user=mmandlik job=sendgmr) by 2002:a25:d450:0:b0:649:1be0:506b with SMTP id
 m77-20020a25d450000000b006491be0506bmr14843403ybf.532.1652130338606; Mon, 09
 May 2022 14:05:38 -0700 (PDT)
Date:   Mon,  9 May 2022 14:05:33 -0700
Message-Id: <20220509140403.1.I28d2ec514ad3b612015b28b8de861b8955033a19@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH] Bluetooth: Fix Adv Monitor msft_add/remove_monitor_sync()
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Do not call skb_pull() in msft_add_monitor_sync() as
msft_le_monitor_advertisement_cb() expects 'status' to be
part of the skb.

Same applies for msft_remove_monitor_sync().

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 net/bluetooth/msft.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index f43994523b1f..9990924719aa 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -387,7 +387,6 @@ static int msft_remove_monitor_sync(struct hci_dev *hdev,
 		return PTR_ERR(skb);
 
 	status = skb->data[0];
-	skb_pull(skb, 1);
 
 	msft_le_cancel_monitor_advertisement_cb(hdev, status, hdev->msft_opcode,
 						skb);
@@ -506,7 +505,6 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 		return PTR_ERR(skb);
 
 	status = skb->data[0];
-	skb_pull(skb, 1);
 
 	msft_le_monitor_advertisement_cb(hdev, status, hdev->msft_opcode, skb);
 
-- 
2.36.0.512.ge40c2bad7a-goog

