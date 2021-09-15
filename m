Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9404C61185
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhIOXCd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhIOXCc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 19:02:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E4C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:01:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x7so4076402pfa.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L0h86E9j0CfNSSJWMBPeikGzGgwSYkBSG+0Bm1Cw7vc=;
        b=OB1R9gA/7cZ9ldtklTRXoCiOxfTjaL8kbAjW2JrqX4DNQ6BMAsKA4f/OYbpO08xtft
         NThLhTxhWA+VploPsqGwMducLshG6e3Bd/65NsIlmL4ILcTBio26lvoU4cClbEp+mQMr
         0gHcHGdnNxNf5RavEQnC0jL9bdGaiDuO3ULsfFuGi8d+f5Tu2BLkXsQ5c8VdW8VoNBKg
         xPaVnZCKix+mFJS5vKuEkU8CP6H5MaVpOwA7Ow3jnBmOXkeb7g75jMcXfyHy8v9Z1lHF
         9VWTQ9b/LL1fgG5WBCoxd4fqA1j32jrzkCCSG+9Uvdqdkk/UzF7sM+JnQ9TIUnClhDpd
         oWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0h86E9j0CfNSSJWMBPeikGzGgwSYkBSG+0Bm1Cw7vc=;
        b=ds8tGgevklHHHoM2lF9uYZFxs7WJuY8/XVEj/tXltczsg/mrcHWVgStmsFyRfwxULE
         zEXHfliuZPZHN9CT7EpYVlkOLSkknKyhYXNOdBAe8eBiVELkqsVw2PVzv53AcRKJVDTj
         OKuE/nKpo4vYkLNw0jKgyRpqSXkYSlVZdDM3CvGMDwR1PBRCltgzHU9TVV+4QyP1Uhi7
         b0jUrrxUNvaraO/qjdMHz6IeYMTP2tRSDkR7qqh4ZJuhmCwagTQM6EvLWIUKX0AFytFw
         9mmYo1Cl4ZWb7n8Al6soViuFHSFy9IDI2dbX3J9uJ4BARJ0pjSKvzRyb1PGNHgzXnHQQ
         ypog==
X-Gm-Message-State: AOAM530GLyernP/sxxFCJSDQZG6FKoFo3T58S3a3OWY43Vy+16dp+Aql
        /Bg+EmV4Madsbf7PWR6fo7mdJkjJG8w=
X-Google-Smtp-Source: ABdhPJyHR/TtbWDIiLE3kn/05Rmet3PH2fxV0UKg9e4doxEtfPgugiS6Bayp1b/J7mLnLUnjM6X86Q==
X-Received: by 2002:aa7:83d8:0:b0:3ef:990f:5525 with SMTP id j24-20020aa783d8000000b003ef990f5525mr1856717pfn.29.1631746872596;
        Wed, 15 Sep 2021 16:01:12 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d3sm5742226pjc.49.2021.09.15.16.01.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:01:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: SCO: Fix sco_send_frame returning skb->len
Date:   Wed, 15 Sep 2021 16:01:09 -0700
Message-Id: <20210915230109.4107111-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915230109.4107111-1-luiz.dentz@gmail.com>
References: <20210915230109.4107111-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The skb in modified by hci_send_sco which pushes SCO headers thus
changing skb->len causing sco_sock_sendmsg to fail.

Fixes: 0771cbb3b97d ("Bluetooth: SCO: Replace use of memcpy_from_msg with bt_skb_sendmsg")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f51399d1b9cb..8eabf41b2993 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -284,16 +284,17 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 static int sco_send_frame(struct sock *sk, struct sk_buff *skb)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
+	int len = skb->len;
 
 	/* Check outgoing MTU */
-	if (skb->len > conn->mtu)
+	if (len > conn->mtu)
 		return -EINVAL;
 
-	BT_DBG("sk %p len %d", sk, skb->len);
+	BT_DBG("sk %p len %d", sk, len);
 
 	hci_send_sco(conn->hcon, skb);
 
-	return skb->len;
+	return len;
 }
 
 static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
@@ -744,7 +745,8 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		err = -ENOTCONN;
 
 	release_sock(sk);
-	if (err)
+
+	if (err < 0)
 		kfree_skb(skb);
 	return err;
 }
-- 
2.31.1

