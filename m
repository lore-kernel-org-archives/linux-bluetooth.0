Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039B8C47095
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB2F21707
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 17:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoc0UYj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgJGRdT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Oct 2020 13:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJGRdT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Oct 2020 13:33:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF85C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2020 10:33:17 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d1so2624573qtr.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2020 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EsA/f4JDdlKFl+qdXESGSiftEfplXQzx50Cuyp1ygBg=;
        b=eoc0UYj8lZmoxNPduAwrZOl9/X73a6s+xMro8395WzNmVXh5YcL96b7jAVbEo7v6G+
         Wqfl5q+8NU7GdHUxaXEwNkMsEpwJ3bHaIexlXjAyYsjLaZSzr0VvBRbCnzlUKnzVaNSu
         Dd3Pxc3mqi+aBn0yuQam8j4eivAM+94tRfFS26esnKrASd45NqLq75vT4XV3eGW92Lb7
         2f/NyxN6+i/lTfmJAT5XyQfoqfSCAXlYPD2gVz8Yq7MHfNVU9OHEbc31QqSRv8zvsNem
         B7WuTy3tZjNvTErmWIL+asyqGtiHJQTImVA0rD3fA6LJLvXxeWfgB+sGSbeO8OfJX1rS
         aHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EsA/f4JDdlKFl+qdXESGSiftEfplXQzx50Cuyp1ygBg=;
        b=Mzhxoi9Xs5BXaRLCkiq5YJHzXrMf1yMd0TwK8US0AyY5tdEI+MwteA7MO9cdLkBBFA
         hVj7BRjW/kRbI+cjPd7sVqgqPH8b17kxqUAR5AskTfOOk3JGkVZjOPt1Fg+MyYnco+2/
         F79BJ22sYcl4XJBTK7Zc+WuPNVv1cI8XKQtpiwxz94bxszcZzOMuCkffSjgM8c/Lt/RK
         R6f7bMLXE/dIb4JUuc/Jzm7VPuHoG5c1+xYLKD7PGcpbfEIHJEegDOuxrRasLqYNVHQv
         f3M0qldh8Sdk75GYqetZAFrZ8/tGzgUIz/hvDSsmR6kALVjkqCzjTAF5h4zwarF2tWgh
         1AFA==
X-Gm-Message-State: AOAM533Jm2TmgJ4sJt8IO5IXBaKvo8VciF91DrnocToQUBo7ur05i4gT
        +9l+3LFkNpQ1fn9ta/px7PZ0Pyu8hDQdAA==
X-Google-Smtp-Source: ABdhPJwP+6oK0OqqaxNtQ7rlPhIoH18mAQQzEm62bloFjNhzYms5j6a2RVrF7bW6Z2aJnyLDrhaOBA==
X-Received: by 2002:ac8:c44:: with SMTP id l4mr4400637qti.2.1602091996423;
        Wed, 07 Oct 2020 10:33:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.2.64])
        by smtp.gmail.com with ESMTPSA id l12sm1858072qkg.54.2020.10.07.10.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 10:33:16 -0700 (PDT)
Message-ID: <5f7dfbdc.1c69fb81.ce543.89cd@mx.google.com>
Date:   Wed, 07 Oct 2020 10:33:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3921364606669485108=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2] mesh: Re-arrange Join/Create/Import/Attach page saving
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201007163305.584272-1-brian.gix@intel.com>
References: <20201007163305.584272-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3921364606669485108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=361039

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


--===============3921364606669485108==--
