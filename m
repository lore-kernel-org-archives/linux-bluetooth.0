Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 11:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63CC64E7C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 11:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhBILoR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhBILlo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 06:41:44 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E87C06178C
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 03:41:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f14so30715375ejc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXHoTm+PPnAHUvPgdEpwgL6qQ7mHz3fHL7GR6b4o620=;
        b=sa6bQ8hogq+2QaCF7IBjuHc8TrjVcXvLo/XomyMpB+zaSEhcIOh0jcDBO2yv8sJnGM
         aO0UMl8S616gkYLtE9Zwk1uzCPLbRHk3kiFfLJvY7tQDAjjNwauzwOCkk20WwGZXFn15
         MwbwJviclGpDhJJzFrztqcR35SbUxOGK3XKnQoXu4I8wCoveP1m4uwV7r7RHt9g33XB4
         ZZNHIz8Nldg0Vyjf8jVka/BoKv8JH+RhLVHayv8ClaETbvoA4adWgnOi9kH9vVfMGGUh
         mH7Si0rZC92ZXb58O/rxiS1ZciTOCtmN5E6WBqJKXWhQYSjFGsB4u+zLYA2SLE4YSoEG
         yDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXHoTm+PPnAHUvPgdEpwgL6qQ7mHz3fHL7GR6b4o620=;
        b=AgbHXGjA6fhQKIgrzl7y6qhPt7vZHZEEwCuNV5icqpjahAae99NS70SLUaGdp8u+Po
         j/uKvWA2RL/YKlaRLHpjreokjXdUys71XMlaJ6zY/nQuQs1IHzjYJEPOYJWOGkzg/0ra
         KtzO22Q0/5L5UUmqU7LI3aEpiIG2OzKsWmiN6le526T/N+NbUNBhG110pzUjm9/s0903
         G6EzQlIeFOd8xQcZu0G3oVSxVpcDum0bnM8xoH1t3RTreED1R6YxXyc/OzE1Y+9lRX7R
         hj9d+Vt5Jlmv7ZlOIk8NQ9vUZTQP1A+b/R9muSORViIojFV1fOr/RaYNeFpn/uPA0vcb
         1wGw==
X-Gm-Message-State: AOAM532bG3YRDI/iT9VGHdltWEgeFpAzr7YHHARdhsD5PisdX3xRzXSA
        m6CZAqK4VoHDPar3hVZbSid/lgE3PDmVfg==
X-Google-Smtp-Source: ABdhPJyyEbuAqv+MoY9A6+OB6rOXeVyO7CTD+CIUMTsyyJvCW1EP47yHcWUJb3pdEqTdzIi75A9iyA==
X-Received: by 2002:a17:906:2495:: with SMTP id e21mr21801199ejb.280.1612870860937;
        Tue, 09 Feb 2021 03:41:00 -0800 (PST)
Received: from localhost.localdomain (ipb218f30b.dynamic.kabel-deutschland.de. [178.24.243.11])
        by smtp.gmail.com with ESMTPSA id e16sm5700248eja.85.2021.02.09.03.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 03:40:59 -0800 (PST)
From:   Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org
Subject: [Regression] Linux v5.10 breaks AR3011 fw loading
Date:   Tue,  9 Feb 2021 12:40:23 +0100
Message-Id: <20210209114024.2910-1-falbrechtskirchinger@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey everyone,

Linux v5.10 broke firmware loading for my AR3011 Bluetooth USB adapter.
A git bisect identified the following commit as the culprit:

> commit b40f58b973865ee98ead884d2bdc7880b896ddb8
> Author: Rocky Liao <rjliao@codeaurora.org>
> Date:   Tue Sep 29 12:23:51 2020 +0800
>
>     Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855 support
>   
>     This patch add support for WCN6855 i.e. patch and nvm download
>     support.

The accompanying patch describes the issue further and attempts to offer
a fix based on my superficial understanding, which may or may not be
adequate.

Regards,
Florian

