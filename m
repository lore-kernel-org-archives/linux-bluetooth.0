Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B3CC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 18:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbiGNSMb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbiGNSM3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 14:12:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAAD68DE6
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 11:12:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y9so2540166pff.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pZ7v0vZV1thkYyQOYQQJmubsK+Pvzo0Wu/qOpv54A+U=;
        b=PPThfFWvADwd7BLjI8kzelc71BTiQj6sudNiTvYyncJ+6AhBPnYuqgQ5I7ZZjA7Id9
         8ThwTd52wQ2Xt0dEkriR0klyq7PvdqgnDSxLE9Iy5e3C1xW9lBoWkCRGwlw5S44/wesu
         gFw/WDqIm5ZxQuk6GY9hU//ICjVRt4UPZTNZ5iXTDnPRjPYgcgUh427hu+8eUeylfSca
         AgyVd1R8DTPCn/isCtUyrqAQy7wDmD3ThfpI+0KQRc/I/AuT0g0DRk+2gaJB70zGyhLO
         w/53hFtey0CsfFxF7fMIvKjR6E2Hrf1E3r/a919sFMLSAFxnBcx2voIMRGKazGeaWQhK
         PgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZ7v0vZV1thkYyQOYQQJmubsK+Pvzo0Wu/qOpv54A+U=;
        b=PDMedIBriiqvhYJHN2VsqvqL+nTI++KoV/6sRyfuSwM05TjSQuK6N7xqQbyAXOf0d+
         q2Dva9Ih709BYl1fxGMXqYIu616ZY3Zp3LzV4y5vyrNwkoxzuJbnsnKBLakLCiGhu7mX
         KWIhkxqjuJYa3/ngbuy8dr/lSExy3qVkcU/neSFiLPDocPyTwHDOF6v0vdc4FMohLNhD
         +7pdhfVvi2kDlQL7A6tKbhbYgkzu8QkeE4wBYVvc52vowWWcBw45UpwJbmTahR7RHJuk
         1BrgJhE5haY4F4ALJg2P6WmeEOZH/8Ro4j2xjB2k4GaIVRo1gl84q9rhUOzB503FKk2L
         ojvQ==
X-Gm-Message-State: AJIora+K2b+rWN8z8t1mtPX1y4PbKgky2Gk/InHaseMa8fbdnBI0FcIX
        hwGhO6Z+4z9acXPpOcf6RLo6DGJwNzQ=
X-Google-Smtp-Source: AGRyM1sRUQeifQV/JSPczP4RuPVGvXuW/aHsvCUGrV/m0u0G3jBiC41fmwHmbohh8CtIpmg4PfK9OA==
X-Received: by 2002:a05:6a00:812:b0:52a:da89:d201 with SMTP id m18-20020a056a00081200b0052ada89d201mr9526166pfk.57.1657822346830;
        Thu, 14 Jul 2022 11:12:26 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b0016bf24790e4sm1833145pls.21.2022.07.14.11.12.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:12:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Don't remove connected devices from accept list
Date:   Thu, 14 Jul 2022 11:12:24 -0700
Message-Id: <20220714181224.3793757-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714181224.3793757-1-luiz.dentz@gmail.com>
References: <20220714181224.3793757-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These devices are likely going to be reprogrammed when disconnected so
this avoid a whole bunch of commands attempt to remove and the add back
to the list.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 256ece5640b7..c746714f218f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1892,12 +1892,15 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	}
 
 	/* Go through the current accept list programmed into the
-	 * controller one by one and check if that address is still
-	 * in the list of pending connections or list of devices to
+	 * controller one by one and check if that address is connected or is
+	 * still in the list of pending connections or list of devices to
 	 * report. If not present in either list, then remove it from
 	 * the controller.
 	 */
 	list_for_each_entry_safe(b, t, &hdev->le_accept_list, list) {
+		if (hci_conn_hash_lookup_le(hdev, &b->bdaddr, b->bdaddr_type))
+			continue;
+
 		pend_conn = hci_pend_le_action_lookup(&hdev->pend_le_conns,
 						      &b->bdaddr,
 						      b->bdaddr_type);
-- 
2.35.3

