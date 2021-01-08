Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C64C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 19:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C3E23A9B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbhAHTWR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbhAHTWR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jan 2021 14:22:17 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B0C061380
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jan 2021 11:21:36 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id d11so4784944qvo.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jan 2021 11:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6WtoCclTruRLHF4aUfp/V/ahEJPvILTlWBZsc1WWMgk=;
        b=ZYKiS2BOpjtmPx88M0BIgXfXOzTAsiguoHWLwiI4f9reJq5UQ/k/mG8/q/vT2evfaN
         D8NQoMpyShfgRRVcftg16LLDoQz1yzLyZs6F96QEJYgGgIJ2QDDzsth6Lmn9rnJEuoaO
         nAuFU95tZOgPt0q4v/AKrr8Ltyigv5gIfth8l2Q4dtKw3BPXIfXZFnydjcD0LwoOwZwW
         8cNkv/QJ2qXP4UGsQomTfFxd8PeOeET2sCE/OZky4C5NJrX/GaTqum899E51eYHPb71i
         k6UaPbDQ2Y2DPXbA+Cv+AYL8HFauwkEtNexD0QZvPbMl/l0nHF48dFQ3lNFGx1LiQZfJ
         lT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6WtoCclTruRLHF4aUfp/V/ahEJPvILTlWBZsc1WWMgk=;
        b=dpoM2WtHv9VQBh1tRmJUhs4ivPccE8PJZBu9jyCmgUpwzd1g7xpyWFrFpRdQn9dKdj
         WBvoy4rstolmxCf+r8PT9TzFPoEecAnOM4AFwKNlCxAibDUVTylUkM0PBoTp2EBxoRVW
         EJXdcJM4SXOv2gvRFBeH3rtt9OHXNXQiA/QzCnBJoYUyXnAwKwivKOpwF5U7+rirMamd
         k6gV5g6pEUNXGHFjh/f1mYWEBarU/W1D7YkfXvOAd3BWRZpb+9+EBjqeXqw+iQINAoFR
         IdkI70A5HQhLdPGgXApj086wHt6ZhDNBkhi9E7cSBa31/yHi/0yqWyQL4Y0CQq8pAJfI
         s1yw==
X-Gm-Message-State: AOAM531BPmg7rJ6qL63eC+KCjp5Fgv9MuCMlnxxsRb0MginFZA21kRNP
        X2pGcpFq/kASRuiCGAb75T3Z5fBfG2dEgA==
X-Google-Smtp-Source: ABdhPJw+ef+88GzERfMicvxQLIRb96GxBGs6D3Xbf+zziFKZyZLka5CwnoHsRnub90FqvXjMniTqEQ==
X-Received: by 2002:ad4:5188:: with SMTP id b8mr8213120qvp.55.1610133695809;
        Fri, 08 Jan 2021 11:21:35 -0800 (PST)
Received: from [172.17.0.2] ([40.75.82.200])
        by smtp.gmail.com with ESMTPSA id o5sm4917922qti.47.2021.01.08.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 11:21:35 -0800 (PST)
Message-ID: <5ff8b0bf.1c69fb81.b8c6.f40c@mx.google.com>
Date:   Fri, 08 Jan 2021 11:21:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1235213214285160350=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] util: Introduce util_debug_va
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210108190423.4185474-1-luiz.dentz@gmail.com>
References: <20210108190423.4185474-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1235213214285160350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=411447

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


--===============1235213214285160350==--
