Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 14:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9379061078
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 14:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhKAOiW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhKAOiR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 10:38:17 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBB2C061764
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 07:35:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id b11so7930831qvm.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lm+L4c3ceuIZB42RJCrKWMpjaiFaH8mNTk+QGpiCLH0=;
        b=LNJBdsy3o5tlIGQdu9tsK3j1AGl3Mry6YxFgyp1PGZNnINyEUV29klkHo+34oPNXZp
         93lGlj5aCvlV0EIQMxWR915aGW0t0v9exCiIGo8mLdf4gKRjzo+ay1MhCmHCUkJNDrdF
         RnpUGlclnLWbxE2KTI14MSCNOnCeVKJkp8u9VdEQ5g2d7wkd17cbYkT26c9fH8aX5eyK
         Mgca+MjF9N3XHDNJCH68KWAu/ADX+l+2jK2Qpf6nXcO+xFw6mekJfOip4czAzKOCk3Rm
         cnwVA2jhABHPtU7PqNcHg+ajOlRcjVqF+MV3nY61Ff7fUkcsqyXE26iaoCrwkmPt9Bzc
         7nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lm+L4c3ceuIZB42RJCrKWMpjaiFaH8mNTk+QGpiCLH0=;
        b=edQMFaz+TwBeuoLSX2GKEWxMf4fue8Lwg3+TJCUgnqovxxrwSHJgYclTYdvGawfNBs
         PKGSinfBr4MrrcXRoBJL79qYlTbsJNE47CR5loSTnr6+reQ1KjBp3Z6LTGdOSeM/wgjn
         9o4pG3nX7GchMaRvw7JqvYMSQJDMpMc0dYIpdDNmaSlDWErRN5dakY2C3wg4PZaOv29C
         R/ueFDfSlqCQcEqR9KoqEEnaJELG+80dJKLvVffTIlKAoDDAcwG+2PEt2nE+6DsXB8M1
         Tw3hbbjFdsVR8cE7IHIFy/Qfi0HjO3uUjAQWXMtMCeQvcLORHOI7R/TZ+Wm5mErdFjK8
         4u4g==
X-Gm-Message-State: AOAM532s2iAU/yx4RllCQ4Nh6SVi0pmKDeyoEk5zu5gLB6bg7soqIPzI
        +ZqQhF8E0tK+Ojw4UN2yRQrzSEIRsy4YnA==
X-Google-Smtp-Source: ABdhPJxPSoWyflBKKnGG/YwzFPupQaLsAwJ9fZT2/gddgllXDeLTpTcNtsS8Qzv2qtxbYaevl0Azhg==
X-Received: by 2002:ad4:4ea6:: with SMTP id ed6mr11050079qvb.54.1635777342897;
        Mon, 01 Nov 2021 07:35:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.120.117.22])
        by smtp.gmail.com with ESMTPSA id o8sm8575309qtk.77.2021.11.01.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:35:42 -0700 (PDT)
Message-ID: <617ffb3e.1c69fb81.5a7dc.15f7@mx.google.com>
Date:   Mon, 01 Nov 2021 07:35:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1846700533259454500=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jajcus@jajcus.net
Subject: RE: Free ALSA seq resources in midi_device_remove()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211101134918.69565-2-jajcus@jajcus.net>
References: <20211101134918.69565-2-jajcus@jajcus.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1846700533259454500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=573565

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.89 seconds
Prep - Setup ELL              PASS      46.37 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      8.57 seconds
Build - Make                  PASS      202.34 seconds
Make Check                    PASS      9.49 seconds
Make Distcheck                PASS      242.98 seconds
Build w/ext ELL - Configure   PASS      8.72 seconds
Build w/ext ELL - Make        PASS      191.05 seconds



---
Regards,
Linux Bluetooth


--===============1846700533259454500==--
