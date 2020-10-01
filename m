Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C9C47423
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 19:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA4620759
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 19:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tX1GvFWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbgJATnv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATnt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 15:43:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC020C0613D0;
        Thu,  1 Oct 2020 12:43:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so4855653pgl.2;
        Thu, 01 Oct 2020 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzsQFq5TcOeOYdaiQDeN/QbyXwYMVKi6+YdbJZoiwuY=;
        b=tX1GvFWPwIyzM0OHct28YSx+gEK8MvlEAzCcADfC6X+zLiC0nzFmjpiHc0Cr0oxTEw
         ex5aYR8Whxc7BquvHCD/4e9vKYN9JLw//Hl5iAodd+aa0+cx7ZCtRp/6eXN5C9sfZz2T
         dS3rXbv5C4j9AWNGk9sbKfOiJYae0Gej7QwyqGlnBfppPt+i0FZum05GT9VNuqT8joaq
         MQSgW1AtqxhO9sV/l3/3MkFO3wp/IlutjgjHipK8oT/ngiB0YwuIwQRhtEvmuAdNCtj+
         nMPP62yqIlXLpUzRZril0+xe6f7xANruMG5uzWu0W5/Nh2w6EaP9NRr8J1zdIrwe7aHw
         p9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzsQFq5TcOeOYdaiQDeN/QbyXwYMVKi6+YdbJZoiwuY=;
        b=DaRe5K21qA7EUWF8WE2pZzvsjlFyk1D+M6+KZ+Yy928zWALjShgV8iQWYFYwstW6/l
         nhkbOvTCVd89MqWcgbTOihRupffHg3rWBbaBTxeLB3ZlS5znl4Zh1YTmXZ0XIRxpKm/V
         ys/Tza1m6Bo8LvofyaeoeNRfP92kLAxmtXZq8WABnHESxo8iWJy3cXurjKO+5ERBuaiX
         TW+IRwezJAaRwBmiDNLHuz7/UUa5g2f1AOWGS4AgCioX1V0CqpRqAtd36dyDwHPi0yvo
         UPh3kvciu/yjHv8IImSuxbSFHdAuIb2/YH0WXrEOJ6CdTENr+Qojhb7+wd9NLpRxOTWf
         jcBw==
X-Gm-Message-State: AOAM532QLRIWziflkjkKm/le7v+JEiCQLQykoj/qEPlu8aFoKzdwcNZl
        Np5Hg1gcnts2BO92F7NEEKjKvzNkC29Wrg7TSJE=
X-Google-Smtp-Source: ABdhPJyduhQq86lDaODuQjpM/0yPytt2ShHGue+aD+PiP6gmiSEFi3UuZfNEVSGvFkVs3gvGkZKtCg==
X-Received: by 2002:a63:ef51:: with SMTP id c17mr7403957pgk.36.1601581429050;
        Thu, 01 Oct 2020 12:43:49 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.69])
        by smtp.gmail.com with ESMTPSA id q65sm1591670pfq.219.2020.10.01.12.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:43:48 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees][PATCH v2] bluetooth: hci_h5: close serdev device and free hu in h5_close
Date:   Fri,  2 Oct 2020 01:13:28 +0530
Message-Id: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When h5_close() gets called, the memory allocated for the hu gets 
freed only if hu->serdev doesn't exist. This leads to a memory leak.
So when h5_close() is requested, close the serdev device instance and
free the memory allocated to the hu entirely instead.

Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
Changes in v2:
	* Fixed the Fixes tag

 drivers/bluetooth/hci_h5.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index e41854e0d79a..3d1585add572 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -248,8 +248,12 @@ static int h5_close(struct hci_uart *hu)
 	if (h5->vnd && h5->vnd->close)
 		h5->vnd->close(h5);
 
-	if (!hu->serdev)
-		kfree(h5);
+	if (hu->serdev)
+		serdev_device_close(hu->serdev);
+
+	kfree_skb(h5->rx_skb);
+	kfree(h5);
+	h5 = NULL;
 
 	return 0;
 }
-- 
2.25.1

