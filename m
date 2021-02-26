Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EF0C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A974A64EED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 13:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBZNqj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 08:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZNqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 08:46:38 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7554C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 05:45:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id jx13so2550422pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=X8+PiIVeDVwwn+PzfijfItUCIy9kJfPVlXm1rDk9SEc=;
        b=h0IzSmVoZsCOg3Y2lRzXC74nC4ms4IfbjLGTiJRjMOqk6h+WG1WSJGhdX1vm/sc0lU
         qFGvjGBKi5ktgfcYceMUtNPslveJmLRzrdDy0YbUXZH7b3i6w/MLRbD8KgmzyOqwhwMn
         dhb6N8NgUa65c2UBdct/Bi4OdpgyPSDkl5hiYCeQAIxkECaiHFUyvACEt0ydpbIKlTAM
         YoZlDglCAWDtt6w20poDMSxsk0wrQCyDC3lx5ajay86IRXdvSBDKGHo+ErFQPlD9NFSN
         idXZjRmyLHm1RkRwC8fAISJuRhQO98/hcKSsM4Hkpzlx4Yt9UGUWFbmAOAYhfKNqOYIl
         uGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=X8+PiIVeDVwwn+PzfijfItUCIy9kJfPVlXm1rDk9SEc=;
        b=fZWWdkAHyCfO+zUHezAgt94Mxc+XQKfHkGHGTgc7En8qvAzy7RVfqS4b10FFC4y4Sl
         Xu8PANeVlgQhFr0oMcd03g0/bByXITA9IVs1LW1YhZa+LRJHoiPvIu6UNJ+kD0WXUcKO
         t0lFq24NtHxYJsx5E8qlNMHDZYtgzTcCB1DzOsxK8R2E5muXknj/9Uuov0cIz8YWp7k3
         za+6Hl88gUBFg3mzFXW9FIr+ou5xJ63Ut4s2RAk92HZ4eR5kAUXNKqCaiKGKKMvpJGih
         T4y0vNeW5aRxGlmwyA3zEUTU6sXBtDHpAYDf99RE1RhESVQqxxKPbBKI91sLzmIdlNvu
         VuUA==
X-Gm-Message-State: AOAM532ktBuo1w7hnuNHUCk32cCtVa2eTuagaVgbBesVHdwLYl3Wnz8C
        dCH2C646egPbl+bdazLl5Torskfk3po=
X-Google-Smtp-Source: ABdhPJzumOCnVhwHBRQT2V+SGH8GwACzXhm+CvSovLXUBPkJbB9kGGBuOhUo8uXG6+uCcYSF84nDbA==
X-Received: by 2002:a17:90b:1a84:: with SMTP id ng4mr3540483pjb.59.1614347157277;
        Fri, 26 Feb 2021 05:45:57 -0800 (PST)
Received: from [172.17.0.2] ([20.36.20.182])
        by smtp.gmail.com with ESMTPSA id x9sm8818778pjp.29.2021.02.26.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 05:45:56 -0800 (PST)
Message-ID: <6038fb94.1c69fb81.767b1.3b86@mx.google.com>
Date:   Fri, 26 Feb 2021 05:45:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5293901932270411653=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, przemyslaw.fierek@silvair.com
Subject: RE: [BlueZ] mesh: Fix infinite loop on IVIndex update
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210226132740.56503-1-przemyslaw.fierek@silvair.com>
References: <20210226132740.56503-1-przemyslaw.fierek@silvair.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5293901932270411653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=439005

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


--===============5293901932270411653==--
