Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3029C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 20:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB71A61059
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 20:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhEJUk0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 May 2021 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhEJUk0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 May 2021 16:40:26 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF87C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 13:39:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x8so16757456qkl.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 13:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8xSXGDqwaT2kM/NWR6skyiT8BpsG2B7DRGpPzLz8/d4=;
        b=pNnzQqyQinLPNC89L8NCR8FjFk+4lG/36yGrtQEIjlScotHZPOvL6WfiQLxxse3XcD
         BzTsfrW7gmnBLt5/99kPDIU8A9G7NEfcmIYV42c0OCwXqOSI2f3J4YjKLSmaqWdTPNoM
         zPdyze3DA2OOrIpRyJw1Afvk/a4+DD1uAYAQ0PXqEGaLdoZ/L7YxN4CqJDOLpiUL66Ng
         rRDeTRbQxqtw6Rgg2C7mqt4d5DgHJ3Ny9Toxwub2kfn1bxvuh5HukabN9PjwzrklrIEB
         tj0hVARKfHq1na6lrgmdMYllNYD3QMu5+Yc6ZUHviRjhuLj6aqC7QpYWBNu6elGppnoC
         1Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8xSXGDqwaT2kM/NWR6skyiT8BpsG2B7DRGpPzLz8/d4=;
        b=JO7EeESPNLJi/Z16aKnPTWWTvDVVHmBh+FZXHtVghGv5LIkEkfbPc8Q3JbC3Yq7pBR
         Ff5XA2jMgIP5skhWHq/r2fxAImFt9zf1zP+/0Q9f455cTQzCFPqtI7sSEV33glAM1Gyh
         b8M16U1jZkzVkUQlTj41YNe7zKGUckfoxDzja3EEJKs2FLThOD4H9AE+Z7XnYir1tnjE
         XNGPJrQlYVM4NsZGHE665692aTXxL/nqvCuTuGvZZVvii2i5KttfArXp+5NKYZcQS+fI
         9yzdODcFEeWJy3+UdmoIOzBgO6WUgp9wFa1cMw15zXq4bswjfLSg/YK8bh1bt53ds04R
         OWTQ==
X-Gm-Message-State: AOAM532XqdndMMkxj8I9Gl5fjx0YaPYS3DAMDeUui7jfLduyQSJLrRaD
        gfUtWb8dx4f3gTYsca5vl/MiJ3eFTQ2UqA==
X-Google-Smtp-Source: ABdhPJxeZQWY8bHko5IWQ5p8iEBgc/T4apuLj0v6s9XWwkFXhR1PyR1LH1Ov1lcg7d6yjuA+eSjiJQ==
X-Received: by 2002:a37:9281:: with SMTP id u123mr21442273qkd.447.1620679160203;
        Mon, 10 May 2021 13:39:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.98.135])
        by smtp.gmail.com with ESMTPSA id 129sm12250413qkn.44.2021.05.10.13.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 13:39:20 -0700 (PDT)
Message-ID: <609999f8.1c69fb81.e8800.9e05@mx.google.com>
Date:   Mon, 10 May 2021 13:39:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0228366983362047483=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, david@lechnology.com
Subject: RE: [BlueZ] doc/advmon-api: Clarify Patterns property
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210510194707.300130-1-david@lechnology.com>
References: <20210510194707.300130-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0228366983362047483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=479785

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      41.25 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.20 seconds
Build - Make                  PASS      175.64 seconds
Make Check                    PASS      8.46 seconds
Make Dist                     PASS      11.50 seconds
Make Dist - Configure         PASS      4.49 seconds
Make Dist - Make              PASS      70.64 seconds
Build w/ext ELL - Configure   PASS      7.21 seconds
Build w/ext ELL - Make        PASS      165.05 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============0228366983362047483==--
