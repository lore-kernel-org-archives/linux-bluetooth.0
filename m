Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51BC001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 21:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjHBVmA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjHBVl6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 17:41:58 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092651BC7
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 14:41:58 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63cfd68086dso1692296d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Aug 2023 14:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691012517; x=1691617317;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=swWy2UcYGFUDRHA4F3bQ/RLmeQfTdqsKyqZeHNeuXTk=;
        b=pOBC9zcHq0hg6HoWwZktjCgsFh5Xr6n0LqtBz3Mbq4e4Q4GP6zGgE3FOQt02O0ckNn
         x/EUQhBPRboHmqfXTROb6SX1bYBcKOYd+YVIZ5026FwXGXlqZDazUp2nfPJXllGixmKK
         xqkJIC5cgg9NL0AhO0Cvayi8E1e4tnqJFh3ptoqPEV84UtNbDGLek1MAqettP3osRx0M
         a/fz0v9dtiX6Uxwv6gjlpnXFcD4XdVpEVpa/SwU9ptkW+UkFCqsP6g/z5ZEian4iRcHo
         bIICND+djZzLvQSLNAJaLE17dVWAMaM/yMX1q9BLXBhXivAf83q37Pusa6cesHsxxY0r
         sD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691012517; x=1691617317;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swWy2UcYGFUDRHA4F3bQ/RLmeQfTdqsKyqZeHNeuXTk=;
        b=ZhieDbswu+bD7fD5+D6SV0JvDBkofAEj9CdueG3ynUD8Gn1MzzB68Xk4lE12Rj9mjJ
         zPawQG4VN2zIVVJNLEhl7djNPEv1kcVg8OAO+mkefZ9Ri6GSOpWkWY7Xv1HMLshxvBzb
         gKbgMtd0EptbE7wA6UyWl0M9xiqVbK/waD32YSavVqHAWI8p2FFJfGkZpl00XMQfFjoU
         i78GWGzSs0F61hopUgr2xs2dRUrsccV8kyolrZju4D8pCk9X7Bz5NNMJJP87P3puKovq
         P+NgdlpdVKsMB6tEVQxK5daLL6OtBM70n2vrhcW7TKBTNOPDczGVFOSi4BHtKNWwfgiD
         bIyQ==
X-Gm-Message-State: ABy/qLaa1WC6CN9L8jCoO9T9sKMzGiwj1xkoNokrFcbEpbKDkGR0PJdm
        yaPRtZ+PVvFklPyc3UYsbGSNTNVLaxY=
X-Google-Smtp-Source: APBJJlFyExywQ2O5ZJurhOVCfdNy9uZhkfRjz/lKPkErhCHccKqSD/h7jYWJP9pdZ+cQr5xYaCFySw==
X-Received: by 2002:ad4:57ae:0:b0:63d:2b84:a3b0 with SMTP id g14-20020ad457ae000000b0063d2b84a3b0mr14134636qvx.49.1691012516976;
        Wed, 02 Aug 2023 14:41:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.11.239])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cdb11000000b00626161ea7a3sm5835742qvk.2.2023.08.02.14.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 14:41:56 -0700 (PDT)
Message-ID: <64cacda4.0c0a0220.724d1.71d4@mx.google.com>
Date:   Wed, 02 Aug 2023 14:41:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6232036642602939620=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,RFC] profile: Add probe_on_discover flag
In-Reply-To: <20230802201538.584029-1-luiz.dentz@gmail.com>
References: <20230802201538.584029-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6232036642602939620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=772324

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      27.75 seconds
BluezMake                     PASS      1007.36 seconds
MakeCheck                     PASS      12.02 seconds
MakeDistcheck                 PASS      158.45 seconds
CheckValgrind                 PASS      259.81 seconds
CheckSmatch                   PASS      345.99 seconds
bluezmakeextell               PASS      106.11 seconds
IncrementalBuild              PASS      850.98 seconds
ScanBuild                     PASS      1094.63 seconds



---
Regards,
Linux Bluetooth


--===============6232036642602939620==--
