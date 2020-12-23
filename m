Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E64CC43332
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 02:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331A622A83
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 02:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgLWCtO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgLWCtN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 21:49:13 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F000AC0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 18:48:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s15so3989573plr.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 18:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wxceAbHrG+QCjBzTytmyNX2D15zjk1S0lgoPggdlJc=;
        b=mJOdDEe6UetRm0FbrBpFf2xHVLf9wFF/j4376J4i6So9hVah1v5R4rDg7qUy3j3vD9
         9H9wl12ICipiVBDq+Fft7KzhW9xg56dFK509tgIj38MupYLLquSZoD2030QkWZhl8BpO
         +l8KJ4D+0re54622aMPmL4KHPLK5UoCMOlG34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wxceAbHrG+QCjBzTytmyNX2D15zjk1S0lgoPggdlJc=;
        b=cD0nNepbBmTa2UKfR0ohDqNMtXMgittKH2XKTABxyaBVuB+lZaHn4mk2QMeeRHl63b
         Ja4Kh8+ej1t/Ep3Mn/98q2hHpX5/Ww0ZneiufWKPT/LV3gb/3RipAwwyKQ5sBHX5/V4i
         b0bsn+fBR7kbHNfpxEXm0dBWhT9i/UzkyNlYDL6+Zq67G1MgnRZM7eRj/7/rtFyMbcU9
         2swZwIlI9uFeMSRmYyIFaXMODtWUOpmTQOsKVt098M2N1SCvEDx4siUxY8vb8mFaj+v2
         QaQp0DMLs6tHsinh5FW0V/YkdCSfiKKeoCLqZAaRN/04fGhfxKGooLyiJCnIHidqtXT9
         Mb1g==
X-Gm-Message-State: AOAM531xq12+aFjnhWMU7wrSlsJl01P7wdWoP/HD+pXQ81gQEOpTMsv1
        cRhFEemIYouJ6qhJFyShnBVpxw==
X-Google-Smtp-Source: ABdhPJzF9RZeNCMANXrHlY53rXD4WdbfrHMtZS7GERUgLYC8iaBNClRJod251v2CIVdnaNYa6n6Oxg==
X-Received: by 2002:a17:90a:6604:: with SMTP id l4mr24693719pjj.119.1608691711404;
        Tue, 22 Dec 2020 18:48:31 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id t36sm20149913pfg.55.2020.12.22.18.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 18:48:30 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: btrtl: Add null check in setup
Date:   Tue, 22 Dec 2020 18:48:24 -0800
Message-Id: <20201222184753.1.I9438ef1f79fa1132e74c67b489123291080b9a8c@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

btrtl_dev->ic_info is only available from the controller on cold boot
(the lmp subversion matches the device model and this is used to look up
the ic_info). On warm boots (firmware already loaded),
btrtl_dev->ic_info is null.

Fixes: 05672a2c14a4 (Bluetooth: btrtl: Enable central-peripheral role)
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btrtl.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1abf6a4d672734f..978f3c773856b05 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -719,16 +719,19 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
-	/* Enable central-peripheral role (able to create new connections with
-	 * an existing connection in slave role).
-	 */
-	switch (btrtl_dev->ic_info->lmp_subver) {
-	case RTL_ROM_LMP_8822B:
-		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
-		break;
-	default:
-		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
-		break;
+	if (btrtl_dev->ic_info) {
+		/* Enable central-peripheral role (able to create new
+		 * connections with an existing connection in slave role).
+		 */
+		switch (btrtl_dev->ic_info->lmp_subver) {
+		case RTL_ROM_LMP_8822B:
+			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+			break;
+		default:
+			rtl_dev_dbg(hdev,
+				    "Central-peripheral role not enabled.");
+			break;
+		}
 	}
 
 	btrtl_free(btrtl_dev);
-- 
2.29.2.729.g45daf8777d-goog

