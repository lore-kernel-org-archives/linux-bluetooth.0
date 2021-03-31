Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C0C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 11:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FAA61996
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 11:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhCaLhC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbhCaLg5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Mar 2021 07:36:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E33EC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 04:36:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so986983wmj.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=AOcZoBRnKJ1Sm+gu9zdQ817E3kMzHA9eGyEcNRDE+d4=;
        b=ufMLi3gs/P2bg+onMCZid6xIH0JgjJ/aPK4949NaGrkqNZHCTHg9i1vNBNAEKn0xUS
         NHSbjfT+ihpikeDaRSth90HWkLyxx/1kp5XyabWDclgvkJd9LI9kg7gPrQfbnVzyaBLX
         vN4SGq2qP5lDVJqetLw6cI9+iYKmt/wjNE4PgIct2mrUFyiKaAXk2kdXXX4dQeExTS/e
         x7z43LpbZB39EWaRUTzJ8EJVmekQ7OGO1HSS5Iu88JCTtLH1CLP7AXwctj3Xc6pqdLLN
         2FeOwuLm9gyF4b+OsAYiZiSsZNveKGI2yGPjTkVGU1uZt/IqO/DC2y7WoipquAKsKWQ6
         M0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=AOcZoBRnKJ1Sm+gu9zdQ817E3kMzHA9eGyEcNRDE+d4=;
        b=t50y9fWrTb7yyiD/d5Y9PwZV0yeDzmG/V2bGrRibVXzLEZ+3Im7wMvZ4AhcIghqum+
         HzulsajwKin7ijQ/GgiEJWJNlPQxvCzrTNMPf/wvh+cECjpcXFBNU3feJsGr1oyGm2+W
         rHmn8S9BHhO/t4tEbUrrq4yxUVmZS6pcnttbDCy45/J/jrahzX/PnUAFDXuxqNNYo578
         BThT6LkV9wf01/wVxtssTi2MQz8BL+2hw2fbUfXo8deJReyf1kvd8Xhk8M0yhFjxdUPg
         tB1IziEQXNtJ3l2H/zTjc5Bnwxt/q7DhO0IxbW1CfwLLm2iDNlctajpZ1UNF8pxIbxXV
         hGkg==
X-Gm-Message-State: AOAM532F5Xjrc7yrv5ESopXlLs/vwKhOO6LywyMz/UBI2cWptdthAHuW
        2f88d8q2o3egEVKTIxWV/A==
X-Google-Smtp-Source: ABdhPJz8nxIyZCfwundOYnKFlbq9TcgXwpxn+qtkq8CPhquC+Q0rO8vgbkPO9u/DUIceBSiRpF+aSQ==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr2701656wma.141.1617190615417;
        Wed, 31 Mar 2021 04:36:55 -0700 (PDT)
Received: from [192.168.1.125] (ip-37-201-4-244.hsi13.unitymediagroup.de. [37.201.4.244])
        by smtp.gmail.com with ESMTPSA id b17sm3850725wrt.17.2021.03.31.04.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 04:36:55 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
Cc:     feryllt@gmail.com
From:   Feryllt Pryderi <feryllt@gmail.com>
Subject: [PATCH BlueZ] audio/transport: Emit Volume changed if endpoint is
 source
Message-ID: <80f40fbd-c903-6f10-1d9f-e75f0f214db5@gmail.com>
Date:   Wed, 31 Mar 2021 13:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Change set_volume to send a Volume PropertyChanged signal also if
transport->sink_watch is set (and not only if source_watch is set).

This fixes volume changes signals not being sent for devices like speakers and
headphone adapters with volume control (like Bose Soundlink Revolve or Fiio BTR5).
---
 profiles/audio/transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 8248014ae..26aa237a3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -662,6 +662,7 @@ static void set_volume(const GDBusPropertyTable *property,
     a2dp->volume = volume;
 
     notify = transport->source_watch ? true : false;
+    notify = notify || (transport->sink_watch ? true : false);
     if (notify)
         g_dbus_emit_property_changed(btd_get_dbus_connection(),
                         transport->path,
-- 
2.31.0

