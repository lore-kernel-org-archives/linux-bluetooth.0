Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7102C46466
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 03:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93258208C3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 03:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQhdUYRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgJGDsO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 23:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGDsO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 23:48:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B6C061755;
        Tue,  6 Oct 2020 20:48:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p11so318328pld.5;
        Tue, 06 Oct 2020 20:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Qdx62KWZf1nPo9Ih2aKKNk8LPzzmbhXJHycwoOuA94=;
        b=sQhdUYRDBs+nsw5SJqm5Q2foj91zdZpv1W/j4vfiedoA/PfPCnbPG7OXVuMuF6Kwr3
         uSxwR9Xkp1HYKXlchub92cPfqpseYSI1MAnE4ODpSYF/B/joerweJ1w38V/AxcGE91OW
         RdoatsmerFtzvht9u4MwhVk48nUhu76DYS3RVaEJNHDooQK4mYLX5DNH/kLqfakP9o5q
         XYzDXd0XWE+SvYFS5BUf87Cgr8XpwtMuqRkOm42EgNy00fU+Fn5jY5ycrwWzsyxmah+U
         7B3pEN2Y+fA7/vD+TQF3O7Izte3W73b4ttksh/A/Qko/blrJ3gVouQd2jvz7b9K1ahwe
         JmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Qdx62KWZf1nPo9Ih2aKKNk8LPzzmbhXJHycwoOuA94=;
        b=dQSC4olyRGmd5Rz6cClyl5sdkl1OMw3IcDCVBBT5Yl9oh1xfJJmGlmUxAm7nANoiiy
         3gIVC1Vft7w7C5gR2TOC9VcwnWBQmUB+k43JYSqFuNarCrgrlztRrpLPbvJc4n3w/7WS
         Xmvo5eZIrI8NySupz7zyTpnOs5++oZI05sE++0ygdmk4kaM3eJTPKM0ZDFT0m2VomZyN
         Gd2y4xQdkUr3Z7mbaDOxqhz7HP4UmPu9F4eFMiMNgB5vEAj+Zg3tKsBZIzeUJCXEhPWA
         My9b24/8wuVI9IpjbtRbWA+wetPLj3L2MlntV8RAEQvEj1rQK81fCSOmK7/uw0zFhudh
         RFjg==
X-Gm-Message-State: AOAM533d38rffw37s0j9ABROtCpOGDw2uBrk6Kkv//CftV6bDOEALDIp
        TqKBvtJuOkp0pm9RoNBUMyA=
X-Google-Smtp-Source: ABdhPJxOc5OSXQScJCLtc+Envon1PPr2mfos8ODF5ioLMG+tMdMiIhiZss/3wC1NRmm9HXJ/g8sW4Q==
X-Received: by 2002:a17:902:a9cc:b029:d3:77f7:3ca9 with SMTP id b12-20020a170902a9ccb02900d377f73ca9mr1051026plr.75.1602042493511;
        Tue, 06 Oct 2020 20:48:13 -0700 (PDT)
Received: from localhost.localdomain ([49.207.207.135])
        by smtp.gmail.com with ESMTPSA id k206sm867586pfd.126.2020.10.06.20.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 20:48:12 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] bluetooth: hci_h5: fix memory leak in h5_close
Date:   Wed,  7 Oct 2020 09:18:03 +0530
Message-Id: <20201007034803.7554-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If h5_close is called when !hu->serdev, h5 is directly freed.
However, h5->rx_skb is not freed, which causes a memory leak.

Freeing h5->rx_skb fixes this memory leak.

In case hu->serdev exists, h5->rx_skb is then set to NULL,
since we do not want to risk a potential NULL pointer 
dereference.

Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>h5_close v4
---
Changes in v4:
	* Free h5->rx_skb even when hu->serdev
	(Suggested by Hans de Goede <hdegoede@redhat.com>)
	* If hu->serdev, then assign h5->rx_skb = NULL

Changes in v3:
	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
	* Do not incorrectly and unnecessarily call serdev_device_close()

Changes in v2:
	* Fixed the Fixes tag

 drivers/bluetooth/hci_h5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index e41854e0d79a..39f9553caa5c 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -245,11 +245,15 @@ static int h5_close(struct hci_uart *hu)
 	skb_queue_purge(&h5->rel);
 	skb_queue_purge(&h5->unrel);
 
+	kfree_skb(h5->rx_skb);
+
 	if (h5->vnd && h5->vnd->close)
 		h5->vnd->close(h5);
 
 	if (!hu->serdev)
 		kfree(h5);
+	else
+		h5->rx_skb = NULL;
 
 	return 0;
 }
-- 
2.25.1

