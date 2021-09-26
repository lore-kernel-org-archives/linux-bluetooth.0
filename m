Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93847C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 17:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E1260FC1
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 17:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhIZRkE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Sep 2021 13:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhIZRkD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Sep 2021 13:40:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3287EC061570
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 10:38:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bj3-20020a17090b088300b0019e6603fe89so10024094pjb.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ALeQqce+2CWGu2hv391s8TQ8cj9sCrAlHf0KFNtNX2I=;
        b=D9NRI9sAJ4173WYQ81KrhnBmVcHFhE0adpUI5cldV8/LqwYydSKE/YakQQ64p50eCY
         VyrJNa7xNqzlAI2D8xAeWwNIAAx5ANRaYbpCka16zFhmtDNpvyFUJw1fkKXuA94B8gzS
         V/j5p6cfM1aSXIPeDnoexOLrO1o0soRJwrH/E7v8M6InqWduPCFLkuJd+BlusI1wD2Ds
         86DQPwOXqhuLIJjOSQOWMwmgF8T96u+Cozic65n1DJPYQydbbzduLsOfwHk1nliw2kTJ
         JCcKX5wNDOdNjM77j0/ZV6gxHz1jo7acwmr0+nl+3E+srf8L1sNSK6UBq9innrFnKPIj
         uJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ALeQqce+2CWGu2hv391s8TQ8cj9sCrAlHf0KFNtNX2I=;
        b=JYLSJZEvmeTPX0lHfakQk16C0f3BWccnMoR3zRBJJ+BBNE7EG5XhUojiUJOLmK/w/s
         7OEwk76sjyuPEImey/9P1k2YJF/fsXTiKsB3zXm9UCWhk3fV65dHKQoBze+FyKmJQ9Zf
         Rsixon8pTZuUv0qomAl448DogBZgoT65xGE27TvkCoD2d3yTd90mmpn5kjFqaU53Spfe
         6TyOVTX81zfgxp9D6m2PaVXdSTcMwVkKRNcIQdDH+e5LEKRBqw6z6MiRijwKwsQh9Sev
         ll1vSsnlLa4j4Z0PNG7FNwNK3CaOiLqKhDu/K3Hn9Lr9aNAwcf0Mq4DmSoSzGMqTml9n
         Fbzw==
X-Gm-Message-State: AOAM532iAePQrLgeGwnE4RHM6W/hdI1BJKJFzqNVanAVg5HN4JmY55Ru
        6vO1aExt/rkpE7A0HgO8d6n9KZv5eaE=
X-Google-Smtp-Source: ABdhPJwS1/BONHepW6j192adI8htlVNk3ud/HtOh1q1qX2MAkgD/XIcPhe+ro52q6SAZ39m6PQbKyQ==
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr14999037pjl.150.1632677906396;
        Sun, 26 Sep 2021 10:38:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.9.191])
        by smtp.gmail.com with ESMTPSA id u16sm14537002pfn.68.2021.09.26.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 10:38:26 -0700 (PDT)
Message-ID: <6150b012.1c69fb81.98232.f6ef@mx.google.com>
Date:   Sun, 26 Sep 2021 10:38:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3138402987975510484=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, martinez.dagan@gmail.com
Subject: RE: gatt: remove superfluous extended properties
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210926170039.49865-2-martinez.dagan@gmail.com>
References: <20210926170039.49865-2-martinez.dagan@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3138402987975510484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=553055

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.29 seconds
Prep - Setup ELL              PASS      50.88 seconds
Build - Prep                  PASS      0.24 seconds
Build - Configure             PASS      9.15 seconds
Build - Make                  PASS      219.00 seconds
Make Check                    PASS      9.85 seconds
Make Distcheck                PASS      256.92 seconds
Build w/ext ELL - Configure   PASS      8.96 seconds
Build w/ext ELL - Make        PASS      207.23 seconds



---
Regards,
Linux Bluetooth


--===============3138402987975510484==--
