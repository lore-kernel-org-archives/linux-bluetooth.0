Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A4FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FCC610A0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 20:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhCaUKY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Mar 2021 16:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbhCaUJu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Mar 2021 16:09:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B123C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 13:09:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x7so20857788wrw.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=6NTjszTg2wFRoMrFVkLuJ6uVZrFuIhaG3jaNqlNFbD0=;
        b=ddHRtw5bFwk6RvHIFzmza8L3CaY2dHsgimfSdCd1DDnpQB/2frk40ejrQlwPozVSXE
         z8IQAh6JCzQIVZAfUdKasf4MfgsecPw5hEl49RoHV/myKqbm5HpOErjco0/6cVFBvA1g
         4lmRWKUHwq9f12mpYDbRHTcvCuTeS7gDWKE5KD/FubNPWqkm155D1B8WLxVrayez8Erg
         2OmvlWzQBRp8hARc6pXkjfrLpTz9L7HV4P/U5TRAEI89Al09HGvN5q7+QGV+AJMN2TRv
         MSXmFzbAw2UUfPruVxXtFWKDpHGea72IooliDZKDByTBP/D3H/Z+W6EINosY+52TzzEW
         T7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=6NTjszTg2wFRoMrFVkLuJ6uVZrFuIhaG3jaNqlNFbD0=;
        b=MEBPZ/QKdZ76GIhthrFTVwtPWqKmTiu4FmAgOLR43QG29fuk169L+d0fgHmczw8LS1
         qVfBrN3gQ7LaH1V5PBoUH36PIXG0weEdoSoIduLjfTn69xfctceERueYZtL6xB6Rvg1M
         6Jy/6LZuJHjMx4xyygTg11eolHkD2WpRcjE8qmozH8HQ+jrTELevvZ1WvXLbXWHvcUiS
         L77+RuUJdbNzkmIfPKHXcv6zNnu7oydAXc4opTwHUx2uWhH4lc4rwsb4CtV8LpVBlIi1
         izHTvKCfR8zO9lBf0jR66AwXir76y2F74wMvRgRSkQL5CB+k7Mnjmm7yMOOLtWBfjPhO
         /u+Q==
X-Gm-Message-State: AOAM533c+syIPLqesKzu19lQqF1AM2jxC3o7h0H2uvuCFcoBXsvb0aIG
        EroigRrqh98Xu0MmYXzDCg==
X-Google-Smtp-Source: ABdhPJwo3Psbz54hQuxGGkk6A5/jH2TmStUmIqM+Hyw9lbFonRIhQYCA0Yu9b43mK440rukGxX0Niw==
X-Received: by 2002:a05:6000:5:: with SMTP id h5mr5668250wrx.97.1617221388929;
        Wed, 31 Mar 2021 13:09:48 -0700 (PDT)
Received: from [192.168.1.125] (ip-37-201-4-244.hsi13.unitymediagroup.de. [37.201.4.244])
        by smtp.gmail.com with ESMTPSA id c16sm7736465wrs.81.2021.03.31.13.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 13:09:48 -0700 (PDT)
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From:   Feryllt Pryderi <feryllt@gmail.com>
Subject: [PATCH BlueZ v2] audio/transport: Emit Volume changed if endpoint is
 source
Message-ID: <c06b781d-2bd3-2cc2-03ac-a512305ab389@gmail.com>
Date:   Wed, 31 Mar 2021 22:11:06 +0200
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
 profiles/audio/transport.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 8248014ae..2d6c0201b 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -644,7 +644,6 @@ static void set_volume(const GDBusPropertyTable *property,
        struct a2dp_transport *a2dp = transport->data;
        uint16_t arg;
        int8_t volume;
-       bool notify;

        if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
                goto error;
@@ -661,8 +660,7 @@ static void set_volume(const GDBusPropertyTable *property,

        a2dp->volume = volume;

-       notify = transport->source_watch ? true : false;
-       if (notify)
+       if (transport->source_watch || transport->sink_watch)
                g_dbus_emit_property_changed(btd_get_dbus_connection(),
                                                transport->path,
                                                MEDIA_TRANSPORT_INTERFACE,
--
2.31.0

