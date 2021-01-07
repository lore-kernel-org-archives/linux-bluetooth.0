Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F21AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 02:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D506F22D75
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 02:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAGCuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 21:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbhAGCuF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 21:50:05 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72B9C0612EF
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 18:49:24 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id 14so4083931ilq.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 18:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nQy4SmSX4/stJ5XIZxhwYZgikzu4gKd1zN01awRvrw8=;
        b=tb3pOwOti5yqclmyfzXEPt3jd8t42tAJCBghTQ2o9JCC3Ae33IVZnXmR2ipJtcDu9w
         R9r5M4Vu4RgZyPdfwJUZ8IWC5wz4VXFOpAGlIMhyeHNidf5sJRCsnm0RTb4x0bkFpb+x
         +W1qoJo98GJXFU4YffHDVRgCKN9W8KOcSHQgtp5iil7gaPqwCFeh3SA/zzgUOzPr0e6g
         +dgQEZzYU+5kIUAA2ybf5l/p807cpiLOXejICGy9J6NSe4TYkTYIOR5J4XaXkN4/0Cay
         +uonNGND+WSNPrOhMf66oQVNWbL5momfVTo1micK3pPRSfXIGn5IHOEoq3dtjRR1bHr5
         taSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nQy4SmSX4/stJ5XIZxhwYZgikzu4gKd1zN01awRvrw8=;
        b=bg+ehZxDbFmW/q4v3DHZf02+ALBirAfn9SQsxQQ/BGi000Jm3j4CRTXa+ePRbt0nxe
         YqMTIR13DAWEm9c/XjJHXQaXJjR9ZDqyz8dEPVvXK9nuyJ2vO/oXEIY3Xkb3AKoXxC75
         8Zu5vIn4nEuelfQT85V1YYjAbIn3DZxiPPqURtqe+MfogYq0kF+xU+vc7eK/e1gfS0AS
         VdfIEKgY+okx1UdxsUqaLgV69mDVWdakURYvtcpjlVgNlvtR6x+mBsngTn1U7A5iCQBn
         J2CIgU4lzDVQoT/7wcvBVwRWc1wZ/xWao/eI454vvHfxcKqTjhSa/S7Hk0gnZb587orF
         WI8g==
X-Gm-Message-State: AOAM533QpVDM5lmTK7vCQZfbr1JT7MSgktXLeXXrR0UJYR1/P2VDGlG2
        nNYo55URhHb4pF15Dl3ZP9rudbDdb8E=
X-Google-Smtp-Source: ABdhPJzJQpATvUPlBBvJDlXAIzkX5tIeq5NZLfCX9eL/o/0LDgDfmBfzZA4QcEaNSEhUr8S3t1DrNA==
X-Received: by 2002:a92:180b:: with SMTP id 11mr7267878ily.30.1609987764207;
        Wed, 06 Jan 2021 18:49:24 -0800 (PST)
Received: from [172.17.0.2] ([40.79.23.203])
        by smtp.gmail.com with ESMTPSA id k9sm1871542iob.13.2021.01.06.18.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 18:49:23 -0800 (PST)
Message-ID: <5ff676b3.1c69fb81.8a2b4.8179@mx.google.com>
Date:   Wed, 06 Jan 2021 18:49:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7437572887555693300=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] shared/gatt-server: Fix not accepting multiple requests
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210107014811.3812318-1-luiz.dentz@gmail.com>
References: <20210107014811.3812318-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7437572887555693300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=410281

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


--===============7437572887555693300==--
