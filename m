Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83515C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627B92065F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6HuWtKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgGMGSp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGSp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:18:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5AFC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m16so3866848pls.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s2IcTEAY6E8gqIiH1UvcKWcRD7F04eaPXNmCRRgH/EI=;
        b=j6HuWtKXJA0LJN3It5/huBCCyvIsHDa95qy/PrtPY0SHVarddS5eFhjMMqvUr4b+tV
         8op+y5evL7Ai0OdNrqE6iKaPeBgO5uEtIyX5YC0whmpQvgIgeCV7Z1Dp5Jwmr6DmexUQ
         BfVUXfMTrzwTHvoNEGDIJEetl2T1Ps2RMrxWRClU7psHNsYbXnZtg4Yg6YFz4a/1p6V1
         kQIcJN9pkyXPaUI5Tpz7rAshwzulXlfAdOyJRTL2Ok5xJswtLtf6mdKL9N9qyLKbaGQC
         nCsoaTYmKMvQCdMWzwhXIIclBJYLn/td3cxCkF9me1ACxIMayTj9gYip7js9DgxZjOdL
         wZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s2IcTEAY6E8gqIiH1UvcKWcRD7F04eaPXNmCRRgH/EI=;
        b=KlXUnqSdYe1ATUvPBqv/W3SqlPqtKLNHHWdi4YzzwS6uU8XPHUOoKaLE/FQXoNhEsd
         oyLuTnusQaQ6QPGlfLSsBJ8Q+ZlxKWWeqcFTfiXEpPUjI2KRdg+Qkob66Kx3syx+6u3d
         ODCptGPpNXghCE1+uIzauTgTZY/ZeNBIKCwHHbCTB6duSwin3r6dOCzafs/csdfIx785
         SFatGzZBGj5/0iN3xoJya1s0YDN1ppu6nrqQVJsw4VaCAEShM6Rj1RHtR5jSI8Eao6Na
         bldd6Q7chhD4p2Pw25teEmeHjPR8p1g8vIzmPq0GwVeOtliLx5gFQAmArNhA9TzB1WOB
         XO4g==
X-Gm-Message-State: AOAM53202gMV53YHxRm+CH+JYu1jYd9I+k6ZcDV2bbBW6V1JissUhUUe
        Ap7oWYy5XOWjgf/q2kheI0l5ek3v9+Y/yQ==
X-Google-Smtp-Source: ABdhPJyn8nljlXT68UpGRDusEmqYlIgFDYMFEfPtiFKpaBpclIpd+Vw8jj8HKc5t47FbUbVeC7TvwA==
X-Received: by 2002:a17:90a:8a8b:: with SMTP id x11mr19062807pjn.127.1594621124489;
        Sun, 12 Jul 2020 23:18:44 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 204sm13096371pfx.3.2020.07.12.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:18:44 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v4 4/8] Bluetooth: Translate additional address type during le_conn
Date:   Mon, 13 Jul 2020 11:52:09 +0530
Message-Id: <20200713062213.3692-5-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713062213.3692-1-sathish.narasimman@intel.com>
References: <20200713062213.3692-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When using controller based address resolution, then the new address
types 0x02 and 0x03 are used. These types need to be converted back into
either public address or random address types.

This patch is specially during LE_CREATE_CONN if using own_add_type as 0x02
or 0x03.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_event.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 927bde511170..eae5bd4a53ac 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2296,6 +2296,22 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 	if (!conn)
 		return;
 
+	/* When using controller based address resolution, then the new
+	 * address types 0x02 and 0x03 are used. These types need to be
+	 * converted back into either public address or random address type
+	 */
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+		switch (own_address_type) {
+		case ADDR_LE_DEV_PUBLIC_RESOLVED:
+			own_address_type = ADDR_LE_DEV_PUBLIC;
+			break;
+		case ADDR_LE_DEV_RANDOM_RESOLVED:
+			own_address_type = ADDR_LE_DEV_RANDOM;
+			break;
+		}
+	}
+
 	/* Store the initiator and responder address information which
 	 * is needed for SMP. These values will not change during the
 	 * lifetime of the connection.
-- 
2.17.1

