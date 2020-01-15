Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ABBC33CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AD92467C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpMCYjwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAOGfd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:35:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39978 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgAOGfd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:35:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so8016069pfh.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=MpMCYjwSTlG3hEuEFsp2U1+aXVvlXGFbmj2uFBCM2QLrX3wbJ3zyU9501WgzEIZzHv
         /SiOoPYxIEEO+f98gf6hB/6hYWvRGConPr97gsWpy8TpvqA80m6mSdEl8K0PhaadaFQD
         uaUhfxklXojjOSDtWNd+EfX1ss99TvVL9E3ZnBLZcM3n4ML9pDosCBKB28BrxPsArFi+
         0k8mQy34L2j9f2dWrYDZR2PpnzGqpG3S/jGPHVEdiSBqTbUD63jYlW+NPO4h4RWdrGGf
         D88BwXeyfmoB2TmCUFrCAcbr8oNeuXDZjK28gYi7uQc5X12t0/Hu6BztdZsygLN/TRt8
         knaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=n9pYCchXUMf1kFZPdz+eUxtwgtKS7a6d5BdIEsmrfx/2QbnLHXQvkzrlBMxigmO0SG
         evCWW6wNqaw6OD2nV7Hp3NBg893skuwwXhEKPx7bKYPB26aTi8rs/XK4hkGSh3EseFsr
         BV1UMsqMVsA64o31Ds3BE7Lx1JXbNUlhL8DKD0dRi0mWlQj9AoQrQO7E3YBfgL/7KfvR
         n5sv1GY+hZfoGVITibnqzi41cfwgX6Ft5lNzd5oiIjCgqnFBdOXWXs7C4utISDwjRMWq
         yR66M6+nns/eE5N8aM7vAE3UP2RTg729M71Qw/0bsPplgYdNJH5Bo8i2fhA0u+uSHN14
         ixaA==
X-Gm-Message-State: APjAAAWlnMBaGJRKS49/FEFZVr4eDgiLSHWWw3EAHXcjOJLxm1hPncLP
        Myk4Z8vP0nNzvW8wZhKLnl+MMzLwaFk=
X-Google-Smtp-Source: APXvYqyvIb/jNIcTQUNeBsByzclhLFCl89tGPLiSjRIWPGIwQXEsRPSSfzmMsUXm4Lchzj6XqzuxeQ==
X-Received: by 2002:aa7:800e:: with SMTP id j14mr30376300pfi.174.1579070132360;
        Tue, 14 Jan 2020 22:35:32 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q21sm19637469pff.105.2020.01.14.22.35.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:35:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 06/11] Bluetooth: hci_vhci: Add support for ISO packets
Date:   Tue, 14 Jan 2020 22:35:15 -0800
Message-Id: <20200115063523.32127-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063523.32127-1-luiz.dentz@gmail.com>
References: <20200115063523.32127-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make virtual controllers to pass ISO packets around.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 65e41c1d760f..8ab26dec5f6e 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -178,6 +178,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 	case HCI_EVENT_PKT:
 	case HCI_ACLDATA_PKT:
 	case HCI_SCODATA_PKT:
+	case HCI_ISODATA_PKT:
 		if (!data->hdev) {
 			kfree_skb(skb);
 			return -ENODEV;
-- 
2.21.0

