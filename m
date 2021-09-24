Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3250C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A679D611C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347290AbhIXVUC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhIXVUB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Sep 2021 17:20:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D8EC061571
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 14:18:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y1so7336976plk.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVgcto0G1nPAGGzSlr64oP9Jssuk90Nd0uHAd0BwbwQ=;
        b=Qu8kMm6W2gVQta3XhMadaKPPaN5zt+oRw9pu51XojBD6THFE7k7HVIQeQZd6E1/r2f
         tdg6GOarwZiDO213NF1MT9GpEo7NspOI6KrWI7CcFgjDEUXKtxtyP70pw9bprGTHbO0O
         QoNhsgdQTXSQRztdrLJnE5CurXyLj7ZysPiK9/ehV6Gs9AMOvpj+NytQdcdaCgqbvM0j
         I2Hrb2wfolcYO+JqRHh+EfwxZ8+xTFKcpGPLY/N0J6VwQb5MEiupjSfWziKQWPYyZ92j
         6nLwhCRWNWRb/L1RfEiQzHTSFeCMR1s8KAvj0qbuuRGZi0TbOmG39bTx8hxfPkWHo0V4
         sweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVgcto0G1nPAGGzSlr64oP9Jssuk90Nd0uHAd0BwbwQ=;
        b=qKorZcJfbdYiNgUpUtG3Vk3UNnseUlfeD8eiB7LfW5toHNV43WMWepp30mC3+QMV5P
         bgFGBnbTgnGv/EjJuPN6L2vpM5qFa2qoPEwc/+RAtUltOdMToM01zc4FzMb774w4YCIr
         RXLCSe0yHOy50dsX1T70E+aoJq4KZoxayXln1lNx9vUziY7tJFXhZ9Z3RdUyFSzibfxB
         GbkGiGa13dOaAl3OSOUp3EISeVJy2rjhibIgVe88xtnC+gkFuWUuqrYT7a8Mb905Hec1
         PEloPGSiRP8f7/kRPfHk5NaWXe3FlhDjhMtfwv66fU4MzMuTuMHRMQuwuUPxqgAbVOTD
         BBdg==
X-Gm-Message-State: AOAM533Job3ebP5PuIvZ9ZLyh9yosaBDyUSNzqoTZEE3iSUt6Fm4iu8r
        n9wL0+drgrvrgNoWQYKHEEiY8BHUmbg=
X-Google-Smtp-Source: ABdhPJykHyt8A45sZ7Sd2kSxdF+Biyrtoex4ojlyG3t2MT9W58TwKJd7z9jNaqhwfj7rD1XnyeMH7g==
X-Received: by 2002:a17:902:c612:b0:13c:9801:a336 with SMTP id r18-20020a170902c61200b0013c9801a336mr10812350plr.27.1632518307435;
        Fri, 24 Sep 2021 14:18:27 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h18sm9946138pfr.89.2021.09.24.14.18.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:18:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] avctp: Fix not handling when kernel has ERTM disabled
Date:   Fri, 24 Sep 2021 14:18:23 -0700
Message-Id: <20210924211824.2318562-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If kernel module is loaded with disable_ertm ERTM won't be available
thus browsing channel won't be able to be created, but it shall be
possible to still use AVRCP without it.

Fixes: https://github.com/bluez/bluez/issues/209
---
 profiles/audio/avctp.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 702ded136..81320de1b 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1651,15 +1651,6 @@ int avctp_register(struct btd_adapter *adapter, gboolean central)
 	}
 	server->browsing_io = avctp_server_socket(src, central, BT_IO_MODE_ERTM,
 							AVCTP_BROWSING_PSM);
-	if (!server->browsing_io) {
-		if (server->control_io) {
-			g_io_channel_shutdown(server->control_io, TRUE, NULL);
-			g_io_channel_unref(server->control_io);
-			server->control_io = NULL;
-		}
-		g_free(server);
-		return -1;
-	}
 
 	server->adapter = btd_adapter_ref(adapter);
 
@@ -1681,9 +1672,11 @@ void avctp_unregister(struct btd_adapter *adapter)
 
 	servers = g_slist_remove(servers, server);
 
-	g_io_channel_shutdown(server->browsing_io, TRUE, NULL);
-	g_io_channel_unref(server->browsing_io);
-	server->browsing_io = NULL;
+	if (server->browsing_io) {
+		g_io_channel_shutdown(server->browsing_io, TRUE, NULL);
+		g_io_channel_unref(server->browsing_io);
+		server->browsing_io = NULL;
+	}
 
 	g_io_channel_shutdown(server->control_io, TRUE, NULL);
 	g_io_channel_unref(server->control_io);
-- 
2.31.1

