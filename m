Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC33C47420
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA1C2076D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 18:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjUBSlhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgI2S6g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgI2S6d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 14:58:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50337C061755;
        Tue, 29 Sep 2020 11:58:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so5486159pfa.10;
        Tue, 29 Sep 2020 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZ/FToa3AtOQUQOsb9qJSrILRh6kvTTOmkZ8BW0o6ag=;
        b=cjUBSlhZ6UxY7zZ/tL81xKJQC2TvgjdO4HRMZp3UP623ayNyff2RcBVkImm4i/gX1Y
         E8vN0otEvcaBRFSvMH/7soYlnd5nbvxUCwZiewdQ789yRXxCxeqL0HHuwKDShVWwBbjG
         CcStVRVo9N/N4rKWTUeopfKxnOwrkQt+BlooeaaK37C1LnAdCoHAFc4MczSgufDDutTJ
         Ovvoyd5BK7T+1oLdqoqvykgugZ+bLrEj8TZDSE9zeuXYI8b4/OCvevAvRbsSX0lLIisS
         dWP4oThRfkB5OqpoWbRCxOsxBF2h3ISeP9WCV37vpSgm4XAzqICdiZzrrbrM5Flm/Dds
         b33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZ/FToa3AtOQUQOsb9qJSrILRh6kvTTOmkZ8BW0o6ag=;
        b=lFnB5NMZ9uaE3805ko4Y128majJDOBIIrZXGEqskA4BJI8n3PzeKacn88fERbzaiq4
         UJNVHkGchwDZKonqZk+pGi1E1dRnk3Qj/VMtzC+eJmquf9DXt3gas1iFragzETmzFyw8
         9dSESRpymFJ9VXDgjHe+CEF/Lpgs+4ghdFM0/w+dT+7xh9NGDmadRtk8vwjGrztIcf9e
         Y/neB5L28YNFZkB+lH6wWCfmGwOdmp6Fpj0yKbpsIPShRo+Gmf0HPXEFssSd/t3rMoHk
         qBPS9LDf5+Dje6aXO8GoB75IrCsQOEw4kvKeRdGTksbs8vbaIMUoRRgC7npfwh4E8gXr
         pR9Q==
X-Gm-Message-State: AOAM533cNJ1lEyMAlQR7tQ0nZpq+oXFy2iShUYdZ5O5IsnbJpc2ps4PQ
        7fJYd8Wdf9uFtzn3v6yjfcE=
X-Google-Smtp-Source: ABdhPJyKwhZR3c4Ipym8Bpt1caw0vWJ1Z4f6NSyMSqvkGi3xTPgpjdLmkGO66H3GJheo+MBVnsaTKQ==
X-Received: by 2002:a17:902:74ca:b029:d2:ad1b:332 with SMTP id f10-20020a17090274cab02900d2ad1b0332mr3471411plt.7.1601405912614;
        Tue, 29 Sep 2020 11:58:32 -0700 (PDT)
Received: from localhost.localdomain ([49.207.218.220])
        by smtp.gmail.com with ESMTPSA id c3sm6350181pfn.23.2020.09.29.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:58:31 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees][PATCH] bluetooth: hci_h5: close serdev device and free hu in h5_close
Date:   Wed, 30 Sep 2020 00:28:15 +0530
Message-Id: <20200929185815.12879-1-anant.thazhemadam@gmail.com>
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

Fixes: https://syzkaller.appspot.com/bug?extid=6ce141c55b2f7aafd1c4
Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
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

