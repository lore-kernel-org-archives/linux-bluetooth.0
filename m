Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7F6C001B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjF3WKY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjF3WKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:10:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE544420C
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:10:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b7f9d66812so18037055ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688163020; x=1690755020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaAN0G7fwCuNl5CzPxOPdbGCqVfxseZDjS8aC/Jsx3Y=;
        b=e3P4cQ8hu7ahgxfyUOoSkEIYQdlx2lHHDXZTEEP32jHHZTvBd6yXMb3tZ1VNAewpvb
         e+LkTlfonZstm3DdWuKP4h2Pjtv7qPH3Ha539VoU8zZSfg6sF9yE62h76pewy3hEpQfq
         9IvjY5xDP+Cdjy/gkQeFL7D7so60UlGTKUe8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163020; x=1690755020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaAN0G7fwCuNl5CzPxOPdbGCqVfxseZDjS8aC/Jsx3Y=;
        b=VGFQTieOa2XsJw6X0S/boew78n/jcNAsnU26M6eikCpKjBlkSjTwMPB/eWuD1h/t+c
         bAqOaTOrzZLGz+GueJZIBf7Iuf6I+NrOzv2Y8w2tPqLDTwjIugRr/vZHCKFZ7/zGcGJU
         gHNNYs5wmD70K/5zTiHTKMq1gJWisgrPwJOC79bJ+JuMfIvfFSQ9N37EWS4YP0Nkks/a
         vB4J7cfb19+SkOiNRuUrUhI03jQ6ssBvypJnj2bqON1paizrfPb/n7OCBMuk8nan0FHw
         eTqU8NnJhpqd1Efa9QgvpcF13BnPxxPAmvjb8VgcSAS3yCdixDdXSotzfqcHIdDM6uJn
         emqg==
X-Gm-Message-State: ABy/qLaq1dTAdmpq9GiVJOoxWbgjAIE7DkZLE0aWLYZaYv6Nr9ZNk/OG
        yrQpcL6Bo1rFyl5OUDSg+I8i8g==
X-Google-Smtp-Source: APBJJlEgjiww29Uk47zncHTRUxXnIYTM/5vIHSdwNVSYwHJKplW02d7JYNLEZLLXGSSXLZtIXPitEA==
X-Received: by 2002:a17:903:24e:b0:1b7:f73d:524 with SMTP id j14-20020a170903024e00b001b7f73d0524mr4015022plh.43.1688163020445;
        Fri, 30 Jun 2023 15:10:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001ac897026cesm11238797plh.102.2023.06.30.15.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:10:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor
Date:   Fri, 30 Jun 2023 15:09:07 -0700
Message-ID: <20230630150906.v2.2.I8b6365c6a13afc74d7a91324dad73601a42038c9@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
References: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The hci_add_adv_monitor() hci_remove_adv_monitor() functions call
bt_dev_dbg() to print some debug statements. The bt_dev_dbg() macro
automatically adds in the device's name. That means that we shouldn't
include the name in the bt_dev_dbg() calls.

Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Don't double print name...") new for v2.

 net/bluetooth/hci_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7e2ecf8a55d8..a8e54383e551 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1949,14 +1949,14 @@ int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE:
-		bt_dev_dbg(hdev, "%s add monitor %d status %d", hdev->name,
+		bt_dev_dbg(hdev, "add monitor %d status %d",
 			   monitor->handle, status);
 		/* Message was not forwarded to controller - not an error */
 		break;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
 		status = msft_add_monitor_pattern(hdev, monitor);
-		bt_dev_dbg(hdev, "%s add monitor %d msft status %d", hdev->name,
+		bt_dev_dbg(hdev, "add monitor %d msft status %d",
 			   monitor->handle, status);
 		break;
 	}
@@ -1975,13 +1975,13 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered off */
-		bt_dev_dbg(hdev, "%s remove monitor %d status %d", hdev->name,
+		bt_dev_dbg(hdev, "remove monitor %d status %d",
 			   monitor->handle, status);
 		goto free_monitor;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
-		bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
-			   hdev->name, monitor->handle, status);
+		bt_dev_dbg(hdev, "remove monitor %d msft status %d",
+			   monitor->handle, status);
 		status = msft_remove_monitor(hdev, monitor);
 		break;
 	}
-- 
2.41.0.255.g8b1d071c50-goog

