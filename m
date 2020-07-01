Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDC420747
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7uURM5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgGAKBT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKBS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:01:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33437C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:01:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so8822491plm.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SiGWJykKRUEpwFqa25J4j/wcmszxEYFYY2Kihm0MUu8=;
        b=f7uURM5yqevpDA2KH5B6wkuUNNejZsTKOoudMOcwSrTbp9uqtfea0vtdtaJ4XCihwE
         YnRCaZrjE+Tff5LJn8M/EfcgFXvLjgF8MLSsaJ1PjT25z5iCaCXLACKFmYEjefyuXKWm
         70RTNFZaJ7BFGjub2ivy6vRFIJadDWFV8ndaU3+0eNtMSHsUG136lBJTjocx0SsLOu0I
         GhXzpfv3vArKUE8AoCwUf7yv/crxahkF6ogmqOhNKNAdNeTvzhM1cGUDh+Syn8npHwd+
         y9dk6iN1wAW7/6Jf/rl5nexwz7XjFtL7/iO0I6CY9C8j9iKVuPLOp5m7UNuqFFT/9WIg
         6eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SiGWJykKRUEpwFqa25J4j/wcmszxEYFYY2Kihm0MUu8=;
        b=q+/4uFQauWxhyk6QSAMSakGSnGFDS25siFtlBZ1wXmsJXgqNz4dam8CERRUIos0dkO
         mIP92ctjkMmQWtFwWBhZXxh++x1/dDzPQbacGdF4IaXU3+zTibBhvhstemwl/LeM7gjA
         ecJtyp+yYfRK7qbSRf6lJHFp9RSCLn5f8j3UB5CEBN3d5FF3fAONFBLZBO92SMJUoD2w
         UEjeLw+MX20/uGSkyYp99MxkWeNoPVUnSrhcNe1ejAdIgiyynsLyjugO5QHVJcUlrC37
         +xSBbTFKcLPp+8waH8gUb7uD9F1MPL6uuieZjBD8YH4wD0qDL5OquTWxitdFZ1fO1AD+
         g2xg==
X-Gm-Message-State: AOAM533Q+Q8SjA8hcZq0dV9BMxalA+GWH8gc55tEhdr198GH03ajoppH
        GQf+WX+cwaetStQAFJGjj/UFd0hDknmZMQ==
X-Google-Smtp-Source: ABdhPJyUvdacwJjPCU1dUiJqroxQse9Zkqz+wDNuAnasVH5jODG1XQSYH3iFrE646ihnscEq/gU6Mw==
X-Received: by 2002:a17:90a:26a4:: with SMTP id m33mr6814342pje.124.1593597676371;
        Wed, 01 Jul 2020 03:01:16 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id d37sm5381961pgd.18.2020.07.01.03.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:01:15 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v3 4/8] Bluetooth: Translate additional address type during le_conn
Date:   Wed,  1 Jul 2020 15:34:28 +0530
Message-Id: <20200701100432.28038-5-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701100432.28038-1-sathish.narasimman@intel.com>
References: <20200701100432.28038-1-sathish.narasimman@intel.com>
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
index e060fc9ebb18..592ef5dda3ab 100644
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

