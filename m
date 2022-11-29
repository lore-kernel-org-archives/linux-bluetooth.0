Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC82C4167B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 20:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiK2UqH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 15:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiK2UqF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 15:46:05 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AED2D750
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:46:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s196so14146084pgs.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrUIIPrBTmjyCzYKfPEzVfSCr2e2mHMZ7ZkF84d/32s=;
        b=LJGbEhNHBXgz3Z00yyXf9eaIZScNuqmvgveZsbb6mZuvaUB++bUemzfOQV6Z+KA1ux
         ZHA+zdYisisfo14GmRkrdpNq8PmJlXh/Mt69I0rxMJpiYSlGicexEreqGE+8HRU/fG79
         nWQpOIN1JfmFlg5GtwgyB0YG4Ku00su4TfW5hZSCibZqe+wwx+7hFTwr4LZncYIsxpeh
         axAyFwFp9xU9KQE8W8NH+BA2dCmuosKEfcQ9dh1YG4LI9BiRq2ZY9xfMFYL8lDFTFvXS
         +Mxrxa8sfbN30mZLSZerYyBAynwptcvlbuBeeNA6HU5LeFYZL2yG0mspST5thazUkZ4S
         yC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrUIIPrBTmjyCzYKfPEzVfSCr2e2mHMZ7ZkF84d/32s=;
        b=BMRAgDdAB2B6vrjn4OigmkQZO0TJhhPm28L5P34JolvqFjZo66rssO8rypGFFFrepQ
         J9HthT2fKWrQvHMcXXhycJGr17WkcFTyqIcnyunQTvrflUaJuEI42FuQEjZD5UZiwGcz
         SH+H7dg8NUg6kyGfeFfj5U1vBsfHLs5MCKtYOzs1r5Qyn4/xe1E5q88DHKX1gXkr3ahH
         hNnBwflWTXYdae+JCQzAiTxFxCcR3DdV8UYAMY01baULcXbaggyPRU4qRxwv2xDfpMDX
         pKv4dMdlU9DicNe9zN6CGyReoYaaOKCtu5K4QnZZjNSmXfpwjFIX6X6c9aH47INt/nNx
         RP5A==
X-Gm-Message-State: ANoB5plxSXBdOnXPptjiSuWsABA72RBV8RVukQlpCbMbD3/gYvSpVeS1
        ADvAZi8MwWh9L4tCUNVt0V2uxrlhIQhyYw==
X-Google-Smtp-Source: AA0mqf627YRw/6klxq43+QuZZuKQttt8eW8dORVG4CtuUtbDlyIoUA8ZV+GaSLj82TydMuwhVwGhHQ==
X-Received: by 2002:aa7:96d2:0:b0:574:2447:947d with SMTP id h18-20020aa796d2000000b005742447947dmr35929082pfq.32.1669754763418;
        Tue, 29 Nov 2022 12:46:03 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001887e30b9ddsm11216214plr.257.2022.11.29.12.46.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:46:02 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] media: Fix crash when transport configuration changes
Date:   Tue, 29 Nov 2022 12:45:56 -0800
Message-Id: <20221129204556.1535821-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129204556.1535821-1-luiz.dentz@gmail.com>
References: <20221129204556.1535821-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of BAP the same transport may be reconfigured multiple times
which means it would appears multiple times on endpoint->transports
leading to a crash when disconnecting as the code would attempt to
destroy the same object multiple times.
---
 profiles/audio/media.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index c9328ab9bd6e..6947cf96392e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1057,6 +1057,8 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 
 		path = media_transport_get_path(transport);
 		bt_bap_stream_set_user_data(stream, (void *)path);
+		endpoint->transports = g_slist_append(endpoint->transports,
+								transport);
 	}
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
@@ -1064,7 +1066,7 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 						"SetConfiguration");
 	if (msg == NULL) {
 		error("Couldn't allocate D-Bus message");
-		media_transport_destroy(transport);
+		endpoint_remove_transport(endpoint, transport);
 		return FALSE;
 	}
 
@@ -1073,8 +1075,6 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	data->cb = cb;
 	data->user_data = user_data;
 
-	endpoint->transports = g_slist_append(endpoint->transports, transport);
-
 	dbus_message_iter_init_append(msg, &iter);
 
 	path = media_transport_get_path(transport);
-- 
2.37.3

