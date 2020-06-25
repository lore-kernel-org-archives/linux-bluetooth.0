Return-Path: <SRS0=OFBO=AG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44122C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 23:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1720768
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 23:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BC5QnNm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390827AbgFYX0f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389740AbgFYX0e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jun 2020 19:26:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9FCC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 16:26:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j12so3770038pfn.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcg6bLKAHJ0/BxsC+brekPNOiBl21FKQYq+hY1Ge/R8=;
        b=BC5QnNm/L9fi0/7m8QzEN2dxwRm+UEWAUD0wfyKtJN3dH3RSF2OfNu+WtclANsPrj0
         tccUpSmsJU6AXH4UrZsO6uoZhCt2UkUkc+F3mD5CpUKXZYyuWLUNOGBNl2XGZYTF3WZr
         ijY/VFyXQ74HchwLZNMFyPvcLQOxOcA/UoQ0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcg6bLKAHJ0/BxsC+brekPNOiBl21FKQYq+hY1Ge/R8=;
        b=gV07oxG4aJVTbGbKMcwnei6MGeNZDM0vsYgSw3GljvuRxfUR//NXwNXggO+IsXKJ6D
         DJrgRQQp8UgJpn+zbcGZj1gsKnJZcmcdNuA4SLY/9/jt00wg6wTbmXa89ESFAByRCDfy
         KWZMXiMbj51O8vM9i0huxw2nuSA8WmYSgo55dBplr9TetjCbNEWBv7epYBCO7fG0vhY/
         +W6J0FBFOo0Emg5134xaCnzwdx6FewcOGwhK4PcEkcl4i8JKX840P23O4RQaATm0S5hB
         gY6M6K3B/R9hIiUG1/chZaVUFV5rlBPn6aRZcLYZSBuWZtI1bctmuT+tB+FtinHFrgoU
         6Eog==
X-Gm-Message-State: AOAM532YJEgY6yL5JwAH9Al0yUv+FkjVwrpYoCAOn4mx8jwuYjFwGP60
        FcV1w0gaKm4gOi9302qLAUJgNQ==
X-Google-Smtp-Source: ABdhPJxbIKdpaqZK2+wHlfbZwwz6bF78GirDWwQUzayQq/pWbTr2e2gviyY7c0WS4IBaYh/15HOjxg==
X-Received: by 2002:a63:182:: with SMTP id 124mr232820pgb.288.1593127594156;
        Thu, 25 Jun 2020 16:26:34 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id f207sm8901936pfa.107.2020.06.25.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:26:33 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, Oliver Neukum <oneukum@suse.com>,
        linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Comment on unbalanced pm reference
Date:   Thu, 25 Jun 2020 16:26:27 -0700
Message-Id: <20200625162544.1.Iea2fbf7a284191c0f09c2ffbe8c14b872d0f68b2@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a comment clarifying that a PM reference in btusb_qca_cmd_timeout is
not unbalanced because it results in a device reset.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f8a71fdabb3d1b..0e143c0cecf2a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -581,6 +581,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
+	/* This is not an unbalanced PM reference since the device will reset */
 	err = usb_autopm_get_interface(data->intf);
 	if (!err)
 		usb_queue_reset_device(data->intf);
-- 
2.27.0.111.gc72c7da667-goog

