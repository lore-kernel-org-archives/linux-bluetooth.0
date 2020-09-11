Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B9CC43461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 17:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FE62075B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 17:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bZvtE3Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIKRPF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKRNT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 13:13:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6CCC06179A
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 10:13:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so2003605pji.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14bPozYieqfHUM2JtvGo8R2UBkHMLrvThIi182GvG+I=;
        b=bZvtE3QrEvm8CZ8XtYT0Y3OLqPKCw+nNi8kIGhMnpxuYkmxoyoqIipKuS9Eb/YR4H6
         8/qdKimJJ9GnwRRgF0C64ME4K3+1hGiLEqHCg5uqkP0vF8bbt2r9VBiSKZejlhIgJfT0
         /fQ7Wqe0XuM/zM1zWhY8w3Ju63GauXLQn34Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14bPozYieqfHUM2JtvGo8R2UBkHMLrvThIi182GvG+I=;
        b=NYbUIj4YZQRbD/D+F4inqcMwfF4fKgPeuzrUTYvJKNi2zU9d4XDocm0371ZCNMskX0
         Of/5dxEghk9vT8VKbMWXSacOBDWNHVpxVQN57EesiQlRTrUIBOqWze7lXhi7ABhKkBgC
         MdeY2g+ep/qJy7lKm8Xdw381yoiKPyOlqeuG547xtIpJnAjEjdAggYUwxsHXQFhYr16+
         SgIGujA5cW4Cy9X7Gj7hhlOYxh5uyaajjI9iJkn5MkrZKTfnFIC1sqQSp+tbHNBYDkwl
         b42nNTjrfn33qzBbO23wLtd4vtw1V5pgfod0PbVERnwHwYqt6+QDF/OyeG0USRP8EWg/
         zXVg==
X-Gm-Message-State: AOAM532D91NtFMm+x1ojEX4ZaD1RhU0dg8LBgrOnZWVbrNFAY84VK09n
        SudRzW7Pv8x8ME55Y2To9hpmew==
X-Google-Smtp-Source: ABdhPJzrVoLvmYUJt7gXWG+GlxjSZFaqJNgeBictKPSlRR5p3H8wccaZE1GGSiHdeFUEqMvnqkhAuA==
X-Received: by 2002:a17:90a:4803:: with SMTP id a3mr3088770pjh.192.1599844393419;
        Fri, 11 Sep 2020 10:13:13 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id h9sm2787452pfc.28.2020.09.11.10.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:13:12 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RESEND PATCH 2/3] Bluetooth: Add suspend reason for device disconnect
Date:   Fri, 11 Sep 2020 10:13:05 -0700
Message-Id: <20200911101255.RESEND.2.Ib9bb75b65362d32104df86ffad479761680bb2cb@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911171306.3758642-1-abhishekpandit@chromium.org>
References: <20200911171306.3758642-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update device disconnect event with reason 0x5 to indicate that device
disconnected because the controller is suspending.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/mgmt.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e19e33c7b65c34..a4b8935e0db97a 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -842,6 +842,7 @@ struct mgmt_ev_device_connected {
 #define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
 #define MGMT_DEV_DISCONN_REMOTE		0x03
 #define MGMT_DEV_DISCONN_AUTH_FAILURE	0x04
+#define MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND	0x05
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
 struct mgmt_ev_device_disconnected {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1475a47edb080b..e33f45e20ed1e7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8268,6 +8268,10 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.reason = reason;
 
+	/* Report disconnects due to suspend */
+	if (hdev->suspended)
+		ev.reason = MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND;
+
 	mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev), sk);
 
 	if (sk)
-- 
2.28.0.618.gf4bc123cb7-goog

