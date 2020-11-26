Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D6AC64E75
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 04:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48CA1206B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 04:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5IGUI+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgKZEWj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Nov 2020 23:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387595AbgKZEWi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Nov 2020 23:22:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EADBC061A04
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 20:22:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u37so1214602ybi.15
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 20:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lXyh67vNMJMfjKfbnDtxJFjlSgopuz07QzIMmNfAPeg=;
        b=L5IGUI+FZGUk7IRBh3HsJdYoxbrewNtuzP7m+REKeCVgqz7N0I0lrS0MsRMyoVpQa7
         rUupJ6W/PyyIfTIZ7qIlWbyVS8w8cbIPMS+oRZCpAWC2iLsciHl5r9WKpslO7SEACbc4
         +cAXXMLHoH+6j2qqnIFzYCljIaTWIEwhG8IrUCxNxmMhVrtzvLXTYXnDgu8B0TmmGBkS
         r5G6DC5RhJF40jPvn9yJGPsJlAmcxvUw2JGJigdXGMvXIRuS1sj8B3ja0qwNI/ra7P8n
         UOCqzTbjdQQ3O7qKaaj2pyWFnLRb5OTo/z1uiRGSroVVw8p2oDJyyhHfUsn7Ns54Le6T
         T4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lXyh67vNMJMfjKfbnDtxJFjlSgopuz07QzIMmNfAPeg=;
        b=JD+A03DYyJwRCWEe7sFlF58/8EJ9gNNIHA1g2z2aMpYWuS+0dAJq4szwiltgQc0qdq
         CpvRTRk+SyzqhQpvS1Wq0H/hYNHPcWUKsDb+qkp7rb4XcQdJuRoRjx5CeyeUcnIcCZyZ
         smFZC95Tj0ZIwT/WCc6cxwFf1S5Qqfvi0A7zauU3u9srSJLe112kyuPT300ijSOPkppu
         pUKr1uTyL9EAq09522GTfO5/reBG+Wjr/HJ3CtlGg7AN3UohGWWTuTCU1528tdJJCEXW
         MhXsCApCBmP7dfWR8tre5wKYKcgFfy0u4VtQbjr2pHDdDHXI+FsLRSpjNI5DMmt92EWL
         vQTQ==
X-Gm-Message-State: AOAM531sbWq/JWno1HxAwclHuCaApnDaA7SliDphIa36Rcux4/DMQv4x
        8h+/4lfPx5g91ddlg3yGLyH010Ll/HxRKn2g0o3weZ82PFZL9YN1k6zfA3nlk/rP4HlNSM84Ur3
        Le2zol+eAXTx55wCNlUK+RjKJWkUHglahHfj7DwrIikoxCnAQ/ZpzjGxNeB+clA40WuF/qAFYWw
        plw3WhtYB6TFI=
X-Google-Smtp-Source: ABdhPJxyZQSIfJZ+DnwHrqeAOax2ApANcUZ22vtXQokHYy/tzbO6GP+SVqLbNOIjzllhmQis9p+wdv8Oao5L9x7YkA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:2845:: with SMTP id
 o66mr1678470ybo.260.1606364557582; Wed, 25 Nov 2020 20:22:37 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:22:22 +0800
In-Reply-To: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201126122109.v11.2.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v11 2/5] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mcchou@chromium.org, mmandlik@chromium.org,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds code to handle the system suspension during interleave
scan. The interleave scan will be canceled when the system is going to
sleep, and will be restarted after waking up.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v5)

Changes in v5:
- Remove the change in hci_req_config_le_suspend_scan

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d6bf1517ddaec..8addb94560013 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1294,8 +1294,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &page_scan);
 
 		/* Disable LE passive scan if enabled */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+			cancel_interleave_scan(hdev);
 			hci_req_add_le_scan_disable(&req, false);
+		}
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
-- 
2.29.2.454.gaff20da3a2-goog

