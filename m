Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B0EC48BE5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 19:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDE3613BF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 19:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhFPTrM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 15:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFPTrM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 15:47:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143EBC061574;
        Wed, 16 Jun 2021 12:45:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r7so2802164qta.12;
        Wed, 16 Jun 2021 12:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TSWNEebZdJggRlMllvNRbaUNyUYubPDxjZkjLMUSRWM=;
        b=mWF3gHywU9bbmML4SEjtbHf4FK3AYf73jn3/z0670ZT6XDCTQNDCSh2+qm5e48uqcd
         9mQWg3PaINy5BDFT6kS+5LKAwC4MZoKJO4ERQ3irVCtzZXLo83adC2IHdP0mHfdqzGH4
         q/6sy/TQD6PXVglegdHG6QTXhQzlwlmMTgGDZPT98+WCcNn/a0ZO05skE5weaNX7XgpE
         aY39v/A2aPCNirOotsMI04qqrqdlP2npgJf2+pDkQn+vK8UmjuUE6Oop1UdtH6/2ueyL
         i/RyvG1nZv2ZDnZ2C9iQ4kNR6loCYDTJFY9zsjtebCzHpRwEtNjq8k1tZj29jnEYTDX5
         Jdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TSWNEebZdJggRlMllvNRbaUNyUYubPDxjZkjLMUSRWM=;
        b=TacVYtb6z/Uj648SO3UA7SRoE8n8dECxSzY1f/OhoF9mwpn/MeMsTlvcbBdiFEeuR1
         hwML+KlaHXne4b3LNVFO6wSNw9w7Ric0XQiAB7cmtthtKXbHDbLKvAjlItUaPyZBtk3X
         yqRl9/cw9H1QFS08JfgPG78Tg/qyVDLjW74aJaJcn6xN2RiMTTMHthtpg+V6TRdMC7Cj
         Z8hp8UZQ71ndvk6Zwh6qex+yiEvgsXu2iYGBB96WjlmhU0A2+RykozqGexAKHdcM22yn
         7VLWFS8ZxrQPB/jQqexuu59bc3HlFf18xQYvcRWmMovR6bgwVpEXjhZrTPv3A09qRKGW
         vZMA==
X-Gm-Message-State: AOAM531JiroTjCn2hAauhixacmIM4g52W2Ui9Qi8GZOANy4X2H9N3pZR
        IH04EjBHet3wirbWU2bhRck=
X-Google-Smtp-Source: ABdhPJyLbpcDEW5qew2RBIGMNsGRw0j3PLPE7vmRBAV8Q4fGp6nhWd16of53wrVyCcbe4Ba63omyNQ==
X-Received: by 2002:ac8:4b61:: with SMTP id g1mr1475110qts.193.1623872705195;
        Wed, 16 Jun 2021 12:45:05 -0700 (PDT)
Received: from fedora (cpe-74-66-16-195.nyc.res.rr.com. [74.66.16.195])
        by smtp.gmail.com with ESMTPSA id 5sm170104qkj.99.2021.06.16.12.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:45:04 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:45:02 -0400
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Remove redundant assignment to fw_ptr
Message-ID: <YMpUvvOUKGOKZWuH@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The variable fw_ptr is assigned a value that is not read and the same value
is assigned in the patch goto. The assignment is redundant and can be
removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
---
 drivers/bluetooth/hci_ag6xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ag6xx.c b/drivers/bluetooth/hci_ag6xx.c
index 1f55df93e4ce..2d40302409ff 100644
--- a/drivers/bluetooth/hci_ag6xx.c
+++ b/drivers/bluetooth/hci_ag6xx.c
@@ -199,7 +199,6 @@ static int ag6xx_setup(struct hci_uart *hu)
 			   fwname, err);
 		goto patch;
 	}
-	fw_ptr = fw->data;
 
 	bt_dev_info(hdev, "Applying bddata (%s)", fwname);
 
-- 
2.31.1

