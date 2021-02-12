Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A332CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A1A64E36
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhBLV4y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhBLV4I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Feb 2021 16:56:08 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350E9C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 13:55:30 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id c25so504204qvb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 13:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1cx768U0qUDlVBupRZ1+ppZC7UO7T+agwoxL1clpNKs=;
        b=lLS0CPuIXYw1k1kcE4iRYLV0zZsReBgYebyQXBQHgt+UZf9uGSPFsxVK8qvl5cSNH9
         H1eEEqN9TvzTUDWD5huHG9NM7LJseHDA8Zl5TFvogCrSEDEgwiae7BaD39Yz1JYSD60N
         GrEGFBW10kVP3S1QxnF3ddc1EG6gErG8EEPUQiS2jYjW0JG9nbgfrYgpKZJYVK4LR5iG
         C6BA+qXh3W1B0m3zeNpF4o6ETTUVNYRda7ZFIp89OfcResA9Mux35wIMIolR923vfOWH
         Hju4bzyaYxlaC0QWcDjvZUQy1WTbaAhZ3YzzLYTbGXCbs4JiX+xrmUPYHk1N+Kmg81yS
         LCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1cx768U0qUDlVBupRZ1+ppZC7UO7T+agwoxL1clpNKs=;
        b=aK8zkwA4nlVY8tw7rJfFrwPzkgOFoLgY//oti89xQ1ZmkVWC/Svk25w5TNBo7Qonh5
         fIb7Ags0HZMSA9RNWQeVTrjh89FamqZO/K5nyPiYjNsW8WUaOMpq7mda1NtCHQsCz7JS
         1Mz7ImDyymjPY/FfLalNG/ZeizGvgFpPN72W1FRWa38dUKgN4OMktdP7ZDVXS1U6HBpo
         sAQNCYkasMJqFF1csSuJrUCMVGdmpSHeSyBIgCpWkV8L+aOX1EMl9hu4DRsKv2hLESYI
         VUDnGiyB+HKKyPBX84z5bsunkVh4w1wHiAfdmCQKGC9FwgYROqYju6CD4OM3bRZEA8xT
         +gLA==
X-Gm-Message-State: AOAM530CYDWGiGWcYOACWDKYqnLC4e+w+favFOFPp9iNIFPteyW39jil
        +Aw/Dax31NSuzWfI9kZyHs00WRfAw9Q=
X-Google-Smtp-Source: ABdhPJxuRUDldKD0MJ8LUiJPDldvaag86kASYwLvjOlUszbKEGs0H6a8d5zd1cAQLRFI7GnYoH8FzA==
X-Received: by 2002:a0c:83a4:: with SMTP id k33mr4472835qva.1.1613166929341;
        Fri, 12 Feb 2021 13:55:29 -0800 (PST)
Received: from [172.17.0.2] ([20.36.180.199])
        by smtp.gmail.com with ESMTPSA id c7sm6396910qtc.82.2021.02.12.13.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 13:55:28 -0800 (PST)
Message-ID: <6026f950.1c69fb81.62e4a.85d2@mx.google.com>
Date:   Fri, 12 Feb 2021 13:55:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0339579620572844331=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Use compliant UUID for mesh
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210212214244.74995-2-inga.stotland@intel.com>
References: <20210212214244.74995-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0339579620572844331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=433001

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
tools/mesh-cfg-client:
1: T3 Title has trailing punctuation (:): "tools/mesh-cfg-client:"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0339579620572844331==--
