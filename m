Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D674C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 19:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50FC64FA6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 19:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhCKTFx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCKTF3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 14:05:29 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C59C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 11:05:28 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id m7so1972759qtq.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 11:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=do3Dn0TMQ5WMqM7bfY6xcK2cgGfdIGuYZT4cNBzffIA=;
        b=RGSwQkUaTorgQu7GmdLB1naRT4KwldBuPEN4O3D3slmf0FLbE+kOMSZxjvJbapbAZs
         6YLjA2jNcwks6L4eponVmG+cnPtcXrTwrHG5plXHB62ICoj/Hap4yTHzsDw7DsbpqFen
         EX2uDFpvbO6yqOvA/9rBGlcSQcurn1vgzsMAiUDwqNaTPMaPfFmEQK1oPgzqfHDMn5Uu
         63UCz7nNM67GW6JDdBcHjD6ut1EXPTcd6GA/Jr9xh8acmCfFgddbU13GR4mcYVCopxuB
         +DcS+YELdckZRzX7N1BCG4hmC+GQomSQkeZQm63i76LRcSj9lVxjKcz49BJ4bBJEmaRg
         vJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=do3Dn0TMQ5WMqM7bfY6xcK2cgGfdIGuYZT4cNBzffIA=;
        b=mV5WiM06OZ5zNRyKC554xO5XSn4atTrBfjSjPXVE1ga0t7RH64vQJuTC6VyHIAea+A
         03+Ug73h2FIjj6NGJzDx8aU3FjLDcD/obTKB8TGXxRxopjhFCsyMa/cN/yZtVe+1K+oF
         FMrrCgYAuk4I3gU7b4lH60lk6jXfxG5LnToORVLeQzWoYdb/BwfFhb3GxYHdaVBxWUxn
         bMloG01oj44AcL9suP9JAociEpqX1noLXMfYCeY2RnmSvgDRvfTx0auGRG07e3nrChuS
         47x7E175pxEZtlp0iYwkdejPeraMGwHDhrdnWG0qkIhwdLNSiRsQ8aFa/H3qcE8CGzc6
         b+Ng==
X-Gm-Message-State: AOAM532JaNh8dX8Q2/iruawId1bYfybsnQG95JCwPtPU2uwYUQChuUZg
        LtwdbCbGu572FnQ1Oks6zH6UWrMbnmG4sQ==
X-Google-Smtp-Source: ABdhPJx0oHIX9mQVCEi4SkmS54L1og83CHUZYX5+eD9wo4zPHEGbsHmLASX/Ya9yKAXNBGG+xbOtXw==
X-Received: by 2002:ac8:538f:: with SMTP id x15mr8555666qtp.47.1615489527616;
        Thu, 11 Mar 2021 11:05:27 -0800 (PST)
Received: from [172.17.0.2] ([40.71.201.128])
        by smtp.gmail.com with ESMTPSA id e3sm2323635qtj.28.2021.03.11.11.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:05:27 -0800 (PST)
Message-ID: <604a69f7.1c69fb81.885eb.efc8@mx.google.com>
Date:   Thu, 11 Mar 2021 11:05:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1275300044087756451=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, cdwhite13@gmail.com
Subject: RE: [BlueZ,1/1] emulator: Periodic Advertising Command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210311183550.11150-2-cdwhite13@gmail.com>
References: <20210311183550.11150-2-cdwhite13@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1275300044087756451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=446503

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


--===============1275300044087756451==--
