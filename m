Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2918C282DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 19:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608FF20821
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 19:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="p8mwQ5E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDST1H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:27:07 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:43492 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfDST1G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Apr 2019 15:27:06 -0400
Received: by mail-lf1-f52.google.com with SMTP id i68so4678963lfi.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzcb+kQosMPCRnF9wrQBTPV/DhH9tQaciFCgRrTK72I=;
        b=p8mwQ5E0DJLUP1ylBfD+qx/qY0GIlRlTLb9RsYxQOPGf5xGoZXPm7lK17sqzgJ6DtX
         Gx6hw9pA/EtExtmV1DHk9JkFLOJvMUDHtK9zQyX2seCnwYMWBJGw2ApwG071j3ULleey
         70x1EuMNrifjBT5AdWZ54+uPvc3+D5aAKzfMyTPZQmcU3sKNzknTvCiEICmHmcawwCws
         8ZRqZ2WIUxvJYDsKSxDVvCdztFQZ1XLbsjrqmFAz2GqJq8zR3tYOLgxv9b5f0IqpJFBW
         8BnTtpPLno1MxS8e0UKfQjLVXHuUeh2jHhOEumn9+IE/uVsudiJ0XB4wmNzzcZVa37AT
         vwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzcb+kQosMPCRnF9wrQBTPV/DhH9tQaciFCgRrTK72I=;
        b=OABkXtxccP8RWqegKMGMAsHj34/KajdYL8UqBN9rvs9zzmrqImLgG5Tij+Zi9U6d7K
         JKJTbGNU6A4qLhTCGe8lvcPWOq/ZkHlwtvW+KxamsVoOfIzVzetwK/65E7O3lkItVs4x
         robZ1Uq9wUA6CkvC95lE9m93I119xiwyyW1+rPVVUL4p5bD7zVE78Xl1aVR6uef8AzSd
         Cus0GyhVY6dadwAQ9RMK2uQRPjuBxrvrGn70ILsag0yw3lhRfpJuWLbEYdhQs/qWK2IQ
         /7KOAbd1tq80sU7T7yvkFOpdnT6HgHGusGtSiB6EmHs8mA4Ti8beY8P4jNNnoD3fsepX
         zB0Q==
X-Gm-Message-State: APjAAAUq+tZ8TerNCPHucIIjsNRHpM5VGXZ4reHl2QQw5NECkqjeYx8j
        hpdorXqZDfmpEmPULpVDih1R0DTKuEo=
X-Google-Smtp-Source: APXvYqxyEPbcYtx3vjQWUTxBu6sJllu7yBcE0mXHgwwI/gAI377AWa5LtpVKJN5E62LCksVLCpuZqg==
X-Received: by 2002:a19:7911:: with SMTP id u17mr1899859lfc.90.1555671540859;
        Fri, 19 Apr 2019 03:59:00 -0700 (PDT)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id l16sm1050056lfk.44.2019.04.19.03.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 03:59:00 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] a2dp: Fix not checking for asprintf return value
Date:   Fri, 19 Apr 2019 12:58:57 +0200
Message-Id: <20190419105857.29781-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

asprintf may return -1 on menmory allocation failure or other error leaving
sep->path with undefined content.

  CC       profiles/audio/bluetoothd-media.o
profiles/audio/a2dp.c: In function ‘register_remote_sep’:
profiles/audio/a2dp.c:1775:2: error: ignoring return value of ‘asprintf’,
    declared with attribute warn_unused_result [-Werror=unused-result]
  asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        avdtp_get_seid(rsep));
        ~~~~~~~~~~~~~~~~~~~~~
---
 profiles/audio/a2dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 8f141739c..481fd7861 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1772,8 +1772,9 @@ static void register_remote_sep(void *data, void *user_data)
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		goto done;
 
-	asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
-							avdtp_get_seid(rsep));
+	if (asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
+						avdtp_get_seid(rsep)) < 0 )
+		goto done;
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				sep->path, MEDIA_ENDPOINT_INTERFACE,
-- 
2.20.1

