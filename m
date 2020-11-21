Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5ECC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF99C2237B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsVtPDvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgKUBbY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgKUBbX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 20:31:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723BC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:31:23 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 11so10897519qkd.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8DrPjG+48WQDOGizdtWL10kyfYdgmXX4M2OtKjDl1ok=;
        b=XsVtPDvKnA9r2E6F0l8BIv0HmbF2ECnDJtKNBiiaxJWoWVlnJFWHp5n465cOndUg1z
         HsLaHkv4YPwdlvA/Dzb44DYpunzSMwijHls/CFXKE4w+EyBIG4Etz1zZ+Y2KGXibzIkS
         5lkJHfFqIYCiRCJK8P27Is7mXPICAp2X0kbINUD351nACLo6yGhXUZYBS16c67nB0Za8
         2D8OVHtZ5BkmGhdcK9npFjwuO6t/ky387mFtF45A+5p3G7dACuGDcCyiDBMMtnt9XqQq
         dhiqZtF6i5EOP8tf2Ing5DLfMMkxchap+Gxg5iOyMW/XKNLFtF//vG/CxqdwtySxliWU
         VJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8DrPjG+48WQDOGizdtWL10kyfYdgmXX4M2OtKjDl1ok=;
        b=ES3cf154Mao/iDNBGX1S3oIRXCilL1aN7oDY6A0SEptqgYknpZYDPdRJpZfuWdgDnr
         xUj11j9B0Du4rd+3XptB4VCf6bCRi3kKOuysl0bg4465reQfiK13Sz3m7V/1cuAL1+oW
         /Fj1t6ZU6FPz07ylJ3IkM0H1hsAT3MUrob8tD8qL/6AqyOod2a0HU7WcFjviYn7dMjjw
         fCrV2zdycfUrV1sL8vCGsWcgPE6doySvU90tMWdsAvQZxY4LYj5w3LryT28QTEtAjO3w
         M3P5WvFRjZCqIDxhIRD1csTZ9Be+2tgEQdBUFGo6wninXhYgEs71tP7Lj7e7A91d9dHp
         gKvw==
X-Gm-Message-State: AOAM531aktRXirPSPxlgiEFR6E73WNfCQ/i4MnwjrDrO1QgtPU7ZOVHm
        R7Akpcy8/+EkzoyZuXF/gFdHHp8EuKrIDQ==
X-Google-Smtp-Source: ABdhPJw56bnJgyM5l/N7UtkenUlI/YyFwzDMTNmq6bDQjmv1oV7onNS7QW6doUjsuoFFoFBo74Qm0Q==
X-Received: by 2002:a37:4c4a:: with SMTP id z71mr5145950qka.2.1605922282031;
        Fri, 20 Nov 2020 17:31:22 -0800 (PST)
Received: from [172.17.0.2] ([52.242.90.189])
        by smtp.gmail.com with ESMTPSA id q34sm3636524qtq.45.2020.11.20.17.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:31:21 -0800 (PST)
Message-ID: <5fb86de9.1c69fb81.e4b7d.8090@mx.google.com>
Date:   Fri, 20 Nov 2020 17:31:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2754034483334793228=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v8,1/5] Bluetooth: btintel: Fix endianness issue for TLV version information
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201119113943.13839-1-kiran.k@intel.com>
References: <20201119113943.13839-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2754034483334793228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=387475

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: btusb: Add *setup* function for new generation Intel controllers
1: T1 Title exceeds max length (75>72): "Bluetooth: btusb: Add *setup* function for new generation Intel controllers"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============2754034483334793228==--
