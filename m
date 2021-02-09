Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97BDC433E9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D3364EB1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhBINx6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhBINx2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 08:53:28 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354BEC061788
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 05:52:44 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id m144so2133753qke.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=x4GJWxwZrb4lMzDD720ufxU3wYDlUbHzKobWph8lqn8=;
        b=qPeYIO7sh8pMmScAyI9C/cyH0wPM1yzhj5ps7mNMLAS1yVg9yk2QUaotsVZjaQHaGa
         K9LLkLOMjkYfZVGxZrpt8rFB/0FIX2bJevBEqwdfDMnGjmE/WZ9uUb5X4+Vb4XqIzvm8
         jAu+vnxVdBZXNg9xSWapabFKlTSb4aLrHeb4vx3SxAasrM5HJpQA8vu1EBP9/FhhzNVo
         w1M7uJQpr3ZqtM1+B/mOTFxZvwrSml1MbZ7f6Nlag9BSnmr9sE0WYq3Ct+GdEm8bdN8/
         fIgN6nqj7VnLii6UI9LLsXUCToH24vCmVjX3ywrcMOXGifdT5PRk18H2iQBtSUSqcgS8
         OZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=x4GJWxwZrb4lMzDD720ufxU3wYDlUbHzKobWph8lqn8=;
        b=f42ZyOXKxN1oUBxCkhEjYpjG3LLHGZcCiYUKv5OE+ABuGkMWudHJQ9LJW8JtaMbKMR
         C+3xwgrvdsUCaK3grLrXRItFHZXJAePy9L35R0GvrWK0uV+/uS3ggf4rFl6XeNFKDy9M
         Nm+leh1rokh8AcPUhGuZFSqubyu7eTTxF5cSUgfiOJSmThBiZlel27nG764AHlcZYfAQ
         N91HHsuRMiNGQo4LYAkr5GUrFdqBpzGqiRzK1K5mY9c6WhUnFq234vHWApbJ1UOwht3c
         IZZYgYILHizMUkxMEhIrGP87QyK6/uj6OyOzkfPa+tGEWhlQi+OUxjLuUtNoMZG64r7Y
         TNlA==
X-Gm-Message-State: AOAM5309xsWkc36JryL0X0uFAsiN6B6lN2Qgho/j13D1IFlJCnz1JYbn
        0L0xQUrJMlRPNi48vT27UHExmSV7OoE=
X-Google-Smtp-Source: ABdhPJy2GSIWehlCZIrUxUgapxoLf29R2r3lAVdpXyj27/U85b35WLp1PhayB384ZL2EmSYUWKfscw==
X-Received: by 2002:a05:620a:120f:: with SMTP id u15mr21943449qkj.5.1612878763349;
        Tue, 09 Feb 2021 05:52:43 -0800 (PST)
Received: from [172.17.0.2] ([52.254.1.213])
        by smtp.gmail.com with ESMTPSA id l128sm18630773qkf.68.2021.02.09.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:52:42 -0800 (PST)
Message-ID: <602293aa.1c69fb81.13026.9690@mx.google.com>
Date:   Tue, 09 Feb 2021 05:52:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8011254249214946093=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hui.wang@canonical.com
Subject: RE: [Bluez] btmgmt: add a new command reset_hci via experimental feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210209133629.12784-5-hui.wang@canonical.com>
References: <20210209133629.12784-5-hui.wang@canonical.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8011254249214946093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=430721

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8011254249214946093==--
