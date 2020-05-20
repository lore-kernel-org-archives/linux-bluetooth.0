Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5332C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893B1207F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dHBIRx0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgETQcp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgETQcp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 12:32:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA74C061A0E
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:32:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci23so1556538pjb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eb41g2AQad/byf93tKxgnf75XG7RNiTm+eUN7CnVN4Y=;
        b=dHBIRx0wpM2xPNmVoPIb1MI54tyUz4U0r9wZNgrRDJWNV61AMhQKsEJ58rB/1ir/iD
         FPiWFAnqxut8ERkHSt4eacFJaoXHkdCyo7oq7/+ZPicKJx0FDdGJVix+TjKCCis3yzwU
         6mBFCM4rN9d4a6+hTurOvL4Aep2yJwl4r2Puw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eb41g2AQad/byf93tKxgnf75XG7RNiTm+eUN7CnVN4Y=;
        b=Lz/257FLcT29z/chh8z5i9plLvHbX5C8cIPcBBPmtLfpJhN/iXOfKYOdD0Ti3djisg
         inJxTzzZr7iRmwMM/EleH2fXSwjo1rffHh6V0XckwFuMKWY97HjR0NZg6lSDwrWhK9oH
         4q7xPqoxfLhG7fpgL927hcOls7lRoBKKaxrALM6AfqkYZpld3hf/nyX1fZsqKMbsUbs1
         ETBCRsl1jnR/pLLt1kN5cQoBXGEQ9AJ8b2BTMcqw5Xp3jmKv2wCKia+GbqpAZCp8AK8s
         8LfdukNKyh5UUXUTWoHC8tCD1SL79zotM+VHQs8RarEA1YWKlRwft6o0YVeSMXNkqrfN
         V67g==
X-Gm-Message-State: AOAM5324ZdOpwjWMGyWXC7lpuMjw3qBq8bjIZQ/bw9FQdalRBJ9tHxYp
        4qeojFBOjLa3e+5/FWMX0P4KlQ==
X-Google-Smtp-Source: ABdhPJxniiNq3ehWpj5I8r6TNirnznzrwfENT/hACu0Fau8x0GZmekPmzIEMagJxmoErHrgs2d0qrA==
X-Received: by 2002:a17:90a:8c01:: with SMTP id a1mr6547868pjo.127.1589992363972;
        Wed, 20 May 2020 09:32:43 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id n23sm2349648pjq.18.2020.05.20.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:32:43 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     dan.carpenter@oracle.com, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Fix uninitialized access to hdev
Date:   Wed, 20 May 2020 09:32:28 -0700
Message-Id: <20200520093206.1.I1a56163c173e14d1cc7a8b639147466171525eab@changeid>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hdev is always allocated and not only when power control is required.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 26efe822f6e58..e4a68238fcb93 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1947,8 +1947,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
+	hdev = qcadev->serdev_hu.hdev;
+
 	if (power_ctrl_enabled) {
-		hdev = qcadev->serdev_hu.hdev;
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		hdev->shutdown = qca_power_off;
 	}
-- 
2.27.0.rc0.183.gde8f92d652-goog

