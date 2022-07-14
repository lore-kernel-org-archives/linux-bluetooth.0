Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315F3C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 00:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiGNAWl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 20:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGNAWl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 20:22:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221A1583A
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 17:22:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s27so50661pga.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 17:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VGJIIZrNjuYfNVmoQvK1yk2T9hZwYcMUOQiL6YF3FRs=;
        b=btw3gxje4f5RUGlPIjz9boHcWfHY/lz0mJmf3KhDorgyqhAGaW2YFoGNqcqd0I4Kdy
         r/hy1AygWGLkYQ1dpWnOLR6Awg+0+KicR5QliPvHGSv7cnHQuZ+TRGnp20meXR2UBH2e
         HVIH0pKw+MYV9Sg2AthUKaJuvrZpstooZ6bNTdensikeTAe8vaDHDSBWMvmzwor+7T7C
         WwJsgHbkAU77awUtl0DGHYRohTaRRD0vkfhnFV2QOsSD4pwjNZa7DaVPiw5IgX4v14I+
         9HGhayr4+MVFaOD64oX6RYOp4MkwylXD3Poo+rIuYFnVn2Y1lGECKDSQuNp2zh+Cx5dZ
         yZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGJIIZrNjuYfNVmoQvK1yk2T9hZwYcMUOQiL6YF3FRs=;
        b=qNz2xanlXSjxvpqSjXqWAZ+A3eMCAKO5omJlv6K9IiWRjf3BuQISPogyCX7RJhRXHi
         MM5eF5pWC8UNwbsDgM+7+sCeWQa1tAANcq2aUB5nXxykgiewCS/2CAcwG4JxG5o3q6zG
         kIudLii3xoglYXpcTYeDVNxrZbClr61LgRC4wtFQzoqMy15AA+oLvbOEpDVrRZlpHJH1
         /9qfd0ysINjtaAG5w3ZwvbIbbCHPwiX1thtEBsPNkmazYVLWG9XucF27tlmp9ipKTasT
         sYdeRmvI5NznOG3SN8KGBFEkrhYtMw2mPBuEL0XP09DMFG8cbcZE+YvALls/Rop0u1Ty
         7T7g==
X-Gm-Message-State: AJIora9fy5dLuiay+UOuWuJSGCQ4qKpOWYGGVVmK4ZM7W/XollqHLM0T
        6KvcFFYQne8MfoCWxG1En06+w4I1P6E=
X-Google-Smtp-Source: AGRyM1tH9F2DR3dk/HPLUO7TfjURZjokYqLXrtXgHfDUTNjL0n+L8F9OXnPvU6kFYvQkQ7wKA5FeHw==
X-Received: by 2002:a63:2785:0:b0:413:655d:fb0 with SMTP id n127-20020a632785000000b00413655d0fb0mr5175122pgn.297.1657758159547;
        Wed, 13 Jul 2022 17:22:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mm18-20020a17090b359200b001efa35356besm2221893pjb.28.2022.07.13.17.22.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:22:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_sync: Don't remove connected devices from accept list
Date:   Wed, 13 Jul 2022 17:22:36 -0700
Message-Id: <20220714002236.3540353-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714002236.3540353-1-luiz.dentz@gmail.com>
References: <20220714002236.3540353-1-luiz.dentz@gmail.com>
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
index 9f44537db348..86846a765be0 100644
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

