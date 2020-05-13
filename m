Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C9CA90AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 08:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335E220753
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 08:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="Iaaf7Rrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgEMITI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgEMITI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 04:19:08 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E3FC061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 01:19:08 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r17so9818525lff.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMiL9z/zJ240LuJkCcbR1muu2svqn6tEj6mcSg7lb80=;
        b=Iaaf7RrwvyDR1yJM/OEdWwI7r/xuSxMMWGrdOuKsSpuOKgzopBK1CDsO2tZ8IVbMS/
         OpNQ76CpbJqwGgnvCNXKgxzksYuq/I1G/fjcQ59Qy+/aHIhw4pQ4NvE2pet0h1AxTo/7
         q+tN3anwBRcqOqlY/m4qThuldk1kn8anofjV8ECkWI2K26Z2kJoy+GLDbI76/3FUuxfX
         UOJJVB4QMG9dF3L4hRE4J4t7X4hYcU4BMhXqdEBjHgLV2GMLxYiOm/FSoau61NyJkezj
         mJD7qpzqzQqkFqdc+0mLkxE6LMt/8wQ0Naqm7WE5zDPwy5IQovZoQhY/2BdHn8bIj0Ii
         8EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMiL9z/zJ240LuJkCcbR1muu2svqn6tEj6mcSg7lb80=;
        b=frGBTrLn6OaUoEwTzbNxdkxeuCzuulUBoqcgyDnrED+w22guXKmuLxdAk6eIeFh/Wx
         pOUALxAb9PeEbi5YNkprOA14gSNct0c7H2YLuJInJXrN9kWC+z4fQmMzYgaIl6k4CwCX
         iGUxD3bDye91cOUiCw4VBtgCus7XU/vv9/ST++rf9kDpkvpjfGnAE2GrJ3narlfzRTWR
         pxhc384WvhMjXT6qj0VMObNTzqg3wfd3qGCfonERqIEruk2KYEPdjUaTc6GN21Y33Iso
         rK2Cyoa0PmE9xcBE0pgyqYkU0yPtr+FfO3VGQ6TyO4QkQ0CnwaB+eHCVK40Ar5AF+ayj
         cajA==
X-Gm-Message-State: AOAM530ssNn6KMnntfOgjTM+P4zkIWU6OfQRRc96GIFf/jcTi8onw5UB
        YBlYfghXGy5sF/C/2cCkRMml+RNl+dwCiQ==
X-Google-Smtp-Source: ABdhPJwH3HPDR2QgbRKkl/h8mWQUAHPqTVEvd5jYyhpc9wAAUr3PI6dzQ7AEapTUKH2XobUHhFZ2sw==
X-Received: by 2002:a19:c1cd:: with SMTP id r196mr13348697lff.187.1589357946112;
        Wed, 13 May 2020 01:19:06 -0700 (PDT)
Received: from rymek.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id b28sm13672684ljo.1.2020.05.13.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 01:19:04 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH] bluetooth/smp: Fix for GAP/SEC/SEM/BI-10-C
Date:   Wed, 13 May 2020 10:18:53 +0200
Message-Id: <20200513081853.362-1-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Security Mode 1 level 4, force us to use have key size 16 octects long.
This patch adds check for that.

This is required for the qualification test GAP/SEC/SEM/BI-10-C

Logs from test when ATT is configured with sec level BT_SECURITY_FIPS

< ACL Data TX: Handle 3585 flags 0x00 dlen 11                                                                       #28 [hci0] 3.785965
      SMP: Pairing Request (0x01) len 6
        IO capability: DisplayYesNo (0x01)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
> ACL Data RX: Handle 3585 flags 0x02 dlen 11                                                                       #35 [hci0] 3.883020
      SMP: Pairing Response (0x02) len 6
        IO capability: DisplayYesNo (0x01)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
        Max encryption key size: 7
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
< ACL Data TX: Handle 3585 flags 0x00 dlen 6                                                                        #36 [hci0] 3.883136
      SMP: Pairing Failed (0x05) len 1
        Reason: Encryption key size (0x06)

Signed-off-by: Łukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
---
 net/bluetooth/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5510017cf9ff..b9f5f74cd4a7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -730,6 +730,10 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct smp_chan *smp = chan->data;
 
+	if (conn->hcon->pending_sec_level == BT_SECURITY_FIPS &&
+	    max_key_size != SMP_MAX_ENC_KEY_SIZE)
+		return SMP_ENC_KEY_SIZE;
+
 	if (max_key_size > hdev->le_max_key_size ||
 	    max_key_size < SMP_MIN_ENC_KEY_SIZE)
 		return SMP_ENC_KEY_SIZE;
-- 
2.20.1

