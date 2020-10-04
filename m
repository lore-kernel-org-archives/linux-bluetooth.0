Return-Path: <SRS0=39yq=DL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114BDC4363D
	for <linux-bluetooth@archiver.kernel.org>; Sun,  4 Oct 2020 05:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA9E2073A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  4 Oct 2020 05:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUEuRNL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgJDFTV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 4 Oct 2020 01:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgJDFTV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 4 Oct 2020 01:19:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A7C0613CE;
        Sat,  3 Oct 2020 22:19:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y14so1068114pfp.13;
        Sat, 03 Oct 2020 22:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YY5pMYpevGR839B5cx54Fulu2YjKsLgJpNccuay8eNE=;
        b=QUEuRNL2/f0vNDU811IkT8oJy65EEA5RLHx/EyzEou/dIw7Lgap4gMEklNC57gOplN
         l8xHJPahvprG2NoUvBsKTxugOIajPKlLNe4hUz3uTfYvznGIqSnlILhN/Jr5ev8iKq4F
         +y95QpfGDXoFfakhC46uVWWING9y39BpumyjKdZWKuhlDWyNCeRwxDaINRf/lm+7Mv52
         Fur8S5xlSIVKZcdcgUptMXD6aK72qo3mc/HYciHrbSqXpzNmHpIMdUNd4FbvcPY/n4BH
         CMKEMLzgi3TsqIZKnbBy8AnPpCQQigMtYEx9rFqzqW7c4TRylecFScgYdI+JiWHF69VF
         dZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YY5pMYpevGR839B5cx54Fulu2YjKsLgJpNccuay8eNE=;
        b=spVVKf7HcRcPEM+gcvkCL3MeuLn44Z3oraw750qKMmhAsWTAc/Lqsay4r+hZGgC1Zb
         QRWABl86elAdBLXZwbiLUbw/6+cPRcfu3oVKmL2aNDCOEXTWnSIgBdJ/oFt/z8x0jmzU
         62Dfq+gr/apVSwuAU7ZOXC1iE/71MVgTyUMNwQ6oUjgRh7mPNaSZXDPVKY9mSfqOdrCN
         5cxhCWV/VRfZ9yxyV3txyRTO9mJBjXn/rjw27nVqkao+8mcwbsa/anR8LvsUTvvQBXUC
         8L1gEJbBCRzf89kghVHt4XbKBqee3L5JyvqzZT21YlQFyOmCEvzUQvv81fqgdHiwlRZf
         ic8g==
X-Gm-Message-State: AOAM532gnwpOG2RnZRtp76SuLxWhzSEmpUiJWXjLEjW2wxvy+4rJtJnB
        j0rGw856XOLka2J2NCL4UbbOUHcd6NGcBX3o8W0=
X-Google-Smtp-Source: ABdhPJyskOIiX+/6se3/zqc3U0Q28Gujo8gH9xebEuSsgrqq8f7Y8JyUZFinX4uREXcqoI6J6OpzQQ==
X-Received: by 2002:a63:f345:: with SMTP id t5mr8807996pgj.147.1601788760553;
        Sat, 03 Oct 2020 22:19:20 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.69])
        by smtp.gmail.com with ESMTPSA id d9sm6263859pjx.47.2020.10.03.22.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:19:19 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] bluetooth: hci_h5: fix memory leak in h5_close
Date:   Sun,  4 Oct 2020 10:47:08 +0530
Message-Id: <20201004051708.21985-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
References: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When h5_close() is called and !hu->serdev, h5 is directly freed.
However, h5->rx_skb is not freed before h5 is freed, which causes
a memory leak.
Freeing h5->rx_skb (when !hu->serdev) fixes this memory leak before
freeing h5.

Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
Changes in v3:
	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
	* Do not incorrectly and unnecessarily call serdev_device_close()

Changes in v2:
	* Fixed the Fixes tag

Hans de Goede also suggested calling h5_reset_rx() on close (for both, !hu->serdev
and hu->serdev cases). 
However, doing so seems to lead to a null-ptr-dereference error,
        https://syzkaller.appspot.com/text?tag=CrashReport&x=136a9a5d900000,
and for this reason, it has not been implemented.

Instead, directly freeing h5->rx_skb seems to suffice in preventing the memory leak
reported. 
And since h5 is freed immediately after freeing h5->rx_skb, assigning h5->rx_skb to
be NULL isn't necessary.

 drivers/bluetooth/hci_h5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index e41854e0d79a..171e55c080ce 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -248,8 +248,10 @@ static int h5_close(struct hci_uart *hu)
 	if (h5->vnd && h5->vnd->close)
 		h5->vnd->close(h5);
 
-	if (!hu->serdev)
+	if (!hu->serdev){
+		kfree_skb(h5->rx_skb);
 		kfree(h5);
+	}
 
 	return 0;
 }
-- 
2.25.1

