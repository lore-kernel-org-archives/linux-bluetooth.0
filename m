Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1529ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 12:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiHaMl6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiHaMlp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 08:41:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F9AC269
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 05:41:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 145so13928507pfw.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=Et4OJOlewHjgjH6iSXywJsZ+i1F7ld+6oDENmehKK+g=;
        b=C0U+Xp8QW/Q9Diw6VNScJeK2l5c/hu1za9v0FL2JZoBpX6A9Vw4OlS0vCbi6DF1dCG
         i8uGA8tHdYBYuqyU4aM4aSKCM+0kf0CExyLFZp8vuWSX+h/hJ6uS2FYoHclEQWDGkhEj
         Wc4OcIuRPCcSRnIhFdAouQsMlep5CbpXYpl5GynW120UoFKhPe5E9ZwWCCQKlzSVmyAh
         hpdr57mLWgVuE5UEh/tBEo7W49DMglf24+EsWb3Oq9rv1drlCmTmOI5if5/rZeRcc7gu
         OKD/okBGJliTPioKgSYpRAu7MV29VUXmu2tBp6C1OLMqUFzhrrUGNLgaCR8XcT2sfgVc
         ceMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Et4OJOlewHjgjH6iSXywJsZ+i1F7ld+6oDENmehKK+g=;
        b=WDqw38LJoexozo+HIqUrJhVTLm4zDTYqOZv53IVsHb+xMyGDWCgthqa18CZp8uM2v1
         NWYhOxUqL9wD5YLneR6HNNuiUNzQ7NKTA/TGmg3QBsjGbfJIN5lK3B+WKFzVGv/Rj+rA
         WUQRbO0sHppVeio+DOfGgBmRoXps+ni+2tHOeERpiFeV34ygbAA3v4rJiGU1Zk1cPRe+
         Xfle488KoP1UzDP8efI77db+VTMPy1piSnogDDMKO+EGXslqr6E0LTPKPZYWO4tuiglW
         kpzR0V8j/Ib2Nj6voQkFhDwqrkm7kZShaFnjQ3tppCTr17iApL6taQMrVF1RWKWj55Uv
         MfEg==
X-Gm-Message-State: ACgBeo3BUiyFyOh/LkNGbFpVB7rRIJJ+IkaYnIDJSx9mgFRWA58DCjIZ
        xzo9flI32MI8ldTlZWQnS7gsxBbvNCA=
X-Google-Smtp-Source: AA6agR7viCV4pD9e6LqApIYzZK9il/kHsU8wYC5Cejk00eQfWqvYeb+FU9x3R8XbcnOUQV5nRo7lEg==
X-Received: by 2002:a63:8948:0:b0:430:3da6:7d45 with SMTP id v69-20020a638948000000b004303da67d45mr1369735pgd.109.1661949703757;
        Wed, 31 Aug 2022 05:41:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.81.13])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b0016be681f008sm7028245pls.290.2022.08.31.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:41:43 -0700 (PDT)
Message-ID: <630f5707.170a0220.44682.cf2e@mx.google.com>
Date:   Wed, 31 Aug 2022 05:41:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8322096226265192708=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v5,1/6] adapter: Keep track of whether the adapter is rfkill'ed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220831113647.85110-1-hadess@hadess.net>
References: <20220831113647.85110-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8322096226265192708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672790

---Test result---

Test Summary:
CheckPatch                    PASS      4.25 seconds
GitLint                       PASS      2.84 seconds
Prep - Setup ELL              PASS      34.13 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      11.35 seconds
Build - Make                  PASS      997.08 seconds
Make Check                    PASS      12.88 seconds
Make Check w/Valgrind         PASS      356.54 seconds
Make Distcheck                PASS      329.05 seconds
Build w/ext ELL - Configure   PASS      11.76 seconds
Build w/ext ELL - Make        PASS      103.97 seconds
Incremental Build w/ patches  PASS      748.41 seconds
Scan Build                    PASS      812.42 seconds



---
Regards,
Linux Bluetooth


--===============8322096226265192708==--
