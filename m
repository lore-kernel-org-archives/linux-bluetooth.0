Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE0C2D0EA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 05:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABC720692
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 05:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU4s1bnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDHFYr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 01:24:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33182 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgDHFYq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 01:24:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17so2835490pgo.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 22:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/WdzM4gehWEq0juzki6u6jMgpBZk76c7dk3Ij+r66hw=;
        b=rU4s1bnlRnjr5WBO9Low3v7/VV3qkQbWFMCPZ8jnYUc3ooXwcOgQ3zvdHpSHK0+y1Z
         rAKyXvHxnCiywtSBovoPgbaG13FKgPzBggEVSUVweF2b3iAAbAdB9mTvTowKnRsd4Oml
         Zck1v4y6VqERjjqRixiYN9awoaLtyofOK3NK/A4OfQJjAejO+lGECxb/6GAAgxe0oVnz
         hQvrfMrORHTYPLioFMLF+9dZoDdsRqssXNv1wVyhWg1cGNyT4Vx+rlUR/oKjQu/hHIF1
         d+NTedupk/gdwJJ3uV+ji/FCCIHnPjDQycOsCb8m/LNX4AxQDjj2lBzaaC+n3IePEp2u
         xeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/WdzM4gehWEq0juzki6u6jMgpBZk76c7dk3Ij+r66hw=;
        b=Coa9Tam3J93BgsFpVtV2R0Xc28i2rvZsAqfkn03RbKG+60JVdSmDbyzgu2ipI/Bkjd
         EbABG2CTH8HY5Ge9JUdRb4s3xXA5RTRQy1BniJkY+D4Qo2W26c7gd2iEvek3XNM87uIE
         G8NZawaBtm5Ogt/G1LfVsRb30ukTwq+UPziVZJEoCuzHHoIbqQb886uM21OiFcNWEtsM
         hpehz0fJA05aF+x+/8Fszq7Sj0mZ7vyOeh8z5+/cqTfTdUE50iCAOFvnSfAT16ZXCnEr
         i9ZBfg0b9p8iB4ocTmCqLJ/f+Fby8DVDaqRzECXLgVWKj9opfjG4qA/0eE7Eda065PNb
         w3fQ==
X-Gm-Message-State: AGi0PubW2JM5CJIkQ3a+x8r8oMuF0RuFsO4n7fdJpmmfbpqyAUIj7Wkc
        2E+QRBnqXN5LLJ85PJ8nnHvSc9BPz+Y=
X-Google-Smtp-Source: APiQypIH1MFG4oXAI98Jzzrnf7K4vYHzFRdWf4yBgUBI/WvoMaaix9SO7jEBKt9QFr3oC0iFZkKHWQ==
X-Received: by 2002:a63:d801:: with SMTP id b1mr5475515pgh.49.1586323485628;
        Tue, 07 Apr 2020 22:24:45 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id mq18sm3505750pjb.6.2020.04.07.22.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 22:24:45 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH] bluetooth: btusb: check for NULL in btusb_find_altsetting()
Date:   Wed,  8 Apr 2020 10:57:03 +0530
Message-Id: <20200408052703.7351-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The new btusb_find_altsetting() dereferences it without checking
the check is added in this patch

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 110e96b245e5..2e715a6232dc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1622,6 +1622,9 @@ static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data,
 
 	BT_DBG("Looking for Alt no :%d", alt);
 
+	if (!intf)
+		return NULL;
+
 	for (i = 0; i < intf->num_altsetting; i++) {
 		if (intf->altsetting[i].desc.bAlternateSetting == alt)
 			return &intf->altsetting[i];
-- 
2.17.1

