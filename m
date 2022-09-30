Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 20:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiI3UTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 16:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiI3UTX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 16:19:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB78D111
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 13:19:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so10083153pjs.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=s/Inp1HS5kBZtYtJsXUoSMoW91GyoWZDDpJFvBFXxQM=;
        b=CQBowV+YDEEIlIB1lSUp/wbzLU5Z/1yeaTzuA0iNpHEZ+GXLRsd4edoEW1DmwIUmTk
         EXOk8mIkCoUyrLXgVkQhTxZxHyYAVeWMOFzs+pnziGBSwCuKb01prV9lH7/ys/0tXZ6u
         zg1Z6/giFvyiKWwbWF4NsGjDcjb830qLPo0n3nDSwLQqkJJhQwjhX6gUPEOHVaNP6OtV
         w0tRjl8XQ3eKjYe8b/2q2Bt40hWnJWxATOiBQ4k8ONu4iZof2AQb7I2lxZ1v+ogRY9N3
         ahtv+HQTiol2kgqXR0kGXVHK8EB0+baT6jvtVgRRuwB8z3WgUo6vmHP6Ohuipl2NEA5/
         3Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=s/Inp1HS5kBZtYtJsXUoSMoW91GyoWZDDpJFvBFXxQM=;
        b=KYThItPgHeGanENEKwLYyhhGkf7I7X6Az+r9xUZ+ttcw8dtWU0cpOvxZqKo6GNe8X5
         yt6TjaOiAXYy0d9s0ukivo4i31di84UQw4/rcxwVnVHt39yvxQtlOKM+NBDDOhZrA4up
         Y14KHGvYk/06mtl74CedD9QE2wkRfskdS8o2K/bPIWCbFP1ES4OqQnpP1FTvzmybeJUd
         F2TYHQol0mvp1X5m6fM6WBGISiRoVjwau5cx7E9GwshvNy5UNHLZ/fTVa0msJHUEJ7/K
         DPgPZKtXn6lV+XDZrzQIGvkF/oilIQH8ZqLeaEzj9sB/irfeCCFQbiyiiv1vQ0YKb3az
         jhDw==
X-Gm-Message-State: ACrzQf2a3IqqsPoJAFWB/FGJFFBVn6mhSt7H91U4X0+AFZT+XU+82NiW
        XBrJ+9IW27eId1jcjIjy8Rh1xmElYss=
X-Google-Smtp-Source: AMsMyM6o2oGtrFX1pjkDR6zuooXt3xQukFkKEqGDjv0LF4o/m0SBQwxq0W2k2YMDF7UDiRJ4NfY2tQ==
X-Received: by 2002:a17:902:ef83:b0:17c:a2f:1e3 with SMTP id iz3-20020a170902ef8300b0017c0a2f01e3mr6333933plb.35.1664569161984;
        Fri, 30 Sep 2022 13:19:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q12-20020a65624c000000b0043a1c0a0ab1sm2081832pgv.83.2022.09.30.13.19.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:19:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix not indicating power state
Date:   Fri, 30 Sep 2022 13:19:20 -0700
Message-Id: <20220930201920.225767-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When setting power state using legacy/non-mgmt API
(e.g hcitool hci0 up) the likes of mgmt_set_powered_complete won't be
called causing clients of the MGMT API to not be notified of the change
of the state.

Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 15c75ef4c271..76c3107c9f91 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4676,6 +4676,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 		    hci_dev_test_flag(hdev, HCI_MGMT) &&
 		    hdev->dev_type == HCI_PRIMARY) {
 			ret = hci_powered_update_sync(hdev);
+			mgmt_power_on(hdev, ret);
 		}
 	} else {
 		/* Init failed, cleanup */
-- 
2.37.3

