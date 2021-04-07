Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760CC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 23:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C57B6108B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 23:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhDGXFI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhDGXFH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 19:05:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163EC061761
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 16:04:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so307400pjv.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 16:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=51lwaj4f132gX1e2O6uPgIF3e0POpMDx8/iVfmyBTjk=;
        b=F1SGR7YlXJrT6FKjJySYf219OOaXDWBng4JBbqLK82RpJQItqknGNfgzfm1cHSVtZO
         pKG+sDGNkZLSCSYXCUjmCQypcEWK9joM+DQZO2VvLffC0uGg2SJhDoMk2LPDaLlZwbGb
         QKrSlxWwPqH/PS4mVaLPrwprbCFnC7ZJkCPP3bz+4OV9ECznET5rDyXVAnDEorWgFVWn
         9sU1C5AY0AoCyPtBHRGgHMXPEvagwDkxeHsrkUdD+DjShkXwR7a0qgKgGx3tiAKC3Vbd
         A9BCV8kK0C4NymzjotXSqaDJePpdySVu9NY/DP1/iS0lesiNY/vdoweCntekoCy717GX
         XodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=51lwaj4f132gX1e2O6uPgIF3e0POpMDx8/iVfmyBTjk=;
        b=jwLMpxQhx3hJ4MXQRl/O+iTjfXCSrqSEYuFljdVRHshe5ZFW2JIJEUuS3Wih5KouuZ
         AWuvZ2K9shyn/gANNg0alAAaG6iYfbcD/k7pBYSFmJHYWjfTfU+Dr1K1xXwaKQjvaNxA
         OyzzxVstiRB828wo+TtvOHEtlXjlfGbjnrY6iWHyecTrrkpCgMM1gIrXLCAzzA0LaVWD
         Dedf05d5xofM66q+rld/ezDK8Y7H41oeCqEcekJ32F2vVe7xd64gzSdKbE1BoFepzbcC
         Fdaqc/kDKhEOTA9KTHHejCk+SaVmsXaOiy+IOOYC5NvmSYm8InF5ExxroznzE+dC9TjQ
         5Bnw==
X-Gm-Message-State: AOAM531ZY8L670+CSadiEiaLdwKb2r5JMaoYsfmIgHR515BQ/8EDNBhz
        D2A9TQI9CZ0pkJZ6kg7hcRWNMd5vFg0=
X-Google-Smtp-Source: ABdhPJwKF1/GlOnyguPCvUtFnqORVCZJ2Ox6RquIiqJ3xiUgDEqKO15zUL/Jp47aU4RH4YEi94Khgw==
X-Received: by 2002:a17:902:c94e:b029:e8:d589:b33 with SMTP id i14-20020a170902c94eb02900e8d5890b33mr4983150pla.53.1617836696994;
        Wed, 07 Apr 2021 16:04:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.61.246])
        by smtp.gmail.com with ESMTPSA id m1sm6434818pjf.8.2021.04.07.16.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:04:56 -0700 (PDT)
Message-ID: <606e3a98.1c69fb81.f7dce.144a@mx.google.com>
Date:   Wed, 07 Apr 2021 16:04:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0982289197896428020=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] input/hog-lib: add error handling when calling into gatt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210407223509.28997-1-sonnysasaka@chromium.org>
References: <20210407223509.28997-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0982289197896428020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=462833

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - PASS



---
Regards,
Linux Bluetooth


--===============0982289197896428020==--
