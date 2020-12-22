Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F3C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 18:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E31C22510
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 18:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgLVSRP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 13:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgLVSRP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 13:17:15 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D58C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 10:16:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i7so8881494pgc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 10:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0bpRNUW0sMX67i76nSxzJVA0UXv2Ge/HrRVpArz6Og=;
        b=lKRfKAiPlfWevqIDZpQSTkPSL/bZXtYdbMRQIw4G8nvyx8Vn5G4bekPGEX1q/WUrY/
         Lo+2s1XFmkvboKIQ7jQGoWz2ZktBkV72EuStOBXiebt7ZtJndehOLBpY6DPSn4/vs1dX
         p1iD6aGW57yuLqmVW6CQ36mgpNOjIohIXgPGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0bpRNUW0sMX67i76nSxzJVA0UXv2Ge/HrRVpArz6Og=;
        b=dtk6ztv1H7t6FYMbDel/yrLg3yik3wtfZGxrULrcN5ietXRWwDwS+Md9syYjIF71G8
         c+z4kOP9fDaTtFr6mBN3Egoq/9vgs4Y9hm971TCx9IQEPY+Zbo6Ul8qpoiHWWhgKdl4H
         SVBnAKNIiwcMiX1jr4VESTRi2hkKDrIDm+zC4zsSKav6FalqxpMzIQvno9RvFQfv0gmv
         ZIAypzzsGv731VDGZnnK0uh3UMSVkB7GWxcfLgvJUdxJGZtDH0iBH3p9vTqWgoKPQI5t
         QumALy7cpBk/GbCVwip7TipH5r7L+SHjalhdjx2Y9AwJFgrOEukP/WDD69zx65BAG2LQ
         RbqA==
X-Gm-Message-State: AOAM530OJQjanEUF6QI8Fp4hWqQCyLF2YOA84dWs4IvSfWwBSYRuvPaV
        A/YdE466bF2F5NhbkiTis/z/vA==
X-Google-Smtp-Source: ABdhPJykTpZupV+No5FAvI4pY9PaCiMKPvgnZy9HVOOI83xtRywNlB9mZlTohp4nNs0m55RsxRn/Rg==
X-Received: by 2002:a62:184e:0:b029:19e:c636:17f9 with SMTP id 75-20020a62184e0000b029019ec63617f9mr20599968pfy.23.1608660994487;
        Tue, 22 Dec 2020 10:16:34 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 193sm21107111pfz.36.2020.12.22.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:16:33 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: Enable central-peripheral role
Date:   Tue, 22 Dec 2020 10:16:27 -0800
Message-Id: <20201222101603.1.I94935e7936550207ae745d3670890541c792c35e@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Enable the central-peripheral role on RTL8822CE. This enables creating
connections while there is an existing connection in the slave role.

This change can be confirmed in userspace via `bluetoothctl show` which
will now show "Roles: central-peripheral".

Reviewed-by: Daniel Winkler <danielwinkler@google.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btrtl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 94df4e94999d5c8..1abf6a4d672734f 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -714,13 +714,24 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 
 	ret = btrtl_download_firmware(hdev, btrtl_dev);
 
-	btrtl_free(btrtl_dev);
-
 	/* Enable controller to do both LE scan and BR/EDR inquiry
 	 * simultaneously.
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
+	/* Enable central-peripheral role (able to create new connections with
+	 * an existing connection in slave role).
+	 */
+	switch (btrtl_dev->ic_info->lmp_subver) {
+	case RTL_ROM_LMP_8822B:
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		break;
+	default:
+		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
+		break;
+	}
+
+	btrtl_free(btrtl_dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(btrtl_setup_realtek);
-- 
2.29.2.729.g45daf8777d-goog

