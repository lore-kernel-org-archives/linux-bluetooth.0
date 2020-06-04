Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62969C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 04:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3975E2072E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 04:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXIQJGGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgFDEFJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgFDEFI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 00:05:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0EDC03E96D
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 21:05:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q16so1617648plr.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 21:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RqbNZdfUYH4SzFn+I4Y/bQsxB/0Uon3AtvdfFK17OOE=;
        b=mXIQJGGYDKoJoYB2Qm+B9pT/w6t6r3UxcwMj9m6UPl7Cpq8T0hPtnBJolbmzuMGYTP
         eWMVEQJdRSLOtA2l0RGfLO/a4NisVbbwRvdcz8j2j8A5Apo9OhLYxHrx3aoe0Rfouf9R
         6JheofOnMg8718dCpIpZyIx8SgAl+m+CZP0jyaVADmrtW/zzdX5wF0+x9VD1ats20Mij
         3d5vba3HB82Kj1NYMf2+Mp7uCi1YpTM6HL05k03/QlY9w4XgNgesBP5p6PBrycgIw/zf
         auSuXDpsIFLTZwP78tpK581doDD8W9n+oMjX+aVpj48qxoD4GrD9jV0uqSrhj8vu/i2E
         ++yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RqbNZdfUYH4SzFn+I4Y/bQsxB/0Uon3AtvdfFK17OOE=;
        b=L2o6F+ERw3Dy1bokPiQpL1kGG8FxJpD/H1tmotu4opsxIAhnUnv7ivHb3MTXDOYKpg
         AB8FT1GX5EQliW0pHKTmUnJa53rafe5WjMHqmuQerapZWDTmWWbcK0VDGuTORPsArZE/
         jjkwrMdnsYrNc8HuVbI6T05+Vm9Ldzx7cNtZPkyewkE8HrXu98WICU1RU8cQoEir6wTy
         rJdoN3TGQEQm+FJlQMXIiBXZDMZxhHmfyW4Bna+ENhfE/3M0Zd0uFm1Zz9ZNKM7KP4MW
         dZUF26rs7Qpm9rbhFHJ/PwH6CGh91Aumy8eTrO9mn4WC6jQVS9eZWnajhnNk5XvviQPT
         oQ0w==
X-Gm-Message-State: AOAM531OBv2FvvrY2xjChvZuyG/Rl7w5Q8eEG2TbTkof16HD8T+30yFO
        W/U3q2A2h4B9vITH/HcZedbid9nEqpM=
X-Google-Smtp-Source: ABdhPJxAReCSs4aM5970z/4PrXW7Mo3fgJd7XeTEaWefZWSCN51QTqoP9JDyEwi976Vh2YX4Atj/Rw==
X-Received: by 2002:a17:90a:2070:: with SMTP id n103mr3695152pjc.109.1591243506770;
        Wed, 03 Jun 2020 21:05:06 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([134.134.137.77])
        by smtp.gmail.com with ESMTPSA id j130sm3119393pfd.94.2020.06.03.21.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 21:05:06 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v2 4/7] Bluetooth: Translate additional address type during le_conn
Date:   Thu,  4 Jun 2020 09:38:28 +0530
Message-Id: <20200604040828.13336-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
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
index cfeaee347db3..9c9c434844f2 100644
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

