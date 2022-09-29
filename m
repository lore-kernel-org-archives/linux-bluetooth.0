Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC2DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiI2TB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiI2TBx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:01:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD95AEDA4
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:01:52 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id u28so1462701qku.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=bNTdPTimawTHl7zbErP5Q/OeG/+/FEaQmKvI781fQ4U=;
        b=LVChkjKXxlQIpeXleMk4AP4r2UcUNIotDQcmRB0uXaU5b7iioKDAdM1SX4LVzEcm16
         kL7P+cSMkh2QjUN3IXgOwT8Myc4FxkC+qEgPE1SzW1yaamWL7Jgeqf9figV6Z4bqCW/S
         kGkryoeVWiPf6APgBMd2nwMX2jn44SedRNBuJfcm5JG+SdrU+tBW3fwJiGa117R7BXce
         whToyFK1nIXEio48d4VffeOy2jkl/09XVCh4asELUAMMKgRF9XG8GNWU1rKFhhaGAWW8
         tfGlgQTUsEgDcVyPDM1Wx1R8kDxww7uU7qwcE5oJbdtKDVRArjcfEbahYWIF2Gt6Yord
         IpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=bNTdPTimawTHl7zbErP5Q/OeG/+/FEaQmKvI781fQ4U=;
        b=sQFrN3rDJy+pnDYZUJmynbAbrmwIVD/d/byRgMUGjT0keAhcPkxSNL2yyw9qmdt9os
         7iMXjKK94TuuoeiaeEhiXqZlnjMqFaTaxB8H4wiibvbXyrR/QODngVxxqGblFdAw+RbS
         1IW27ek2a8PKSB8swON98RHW+ZYO1dGxHmtiQQ6ZE5c5OqMMRlNcg9o7/OpLQFVVfm20
         J7TlaCLTQyMro9erby0DW31C02Q5DlglOu9C/QKJecUJ6DPill5gHwz9yDF6gGW2lMB3
         XsaLAIKwwVowRosTJbt+VEdRcDF0f9IY3A8pYggWSMVFYRXORDnHFydGqvgiEZ4UVH0R
         jubA==
X-Gm-Message-State: ACrzQf1qMBbT2r35VosMrLNzRw0OWSTpxYVhwootLGs4ZHfzwHhVTu/D
        xBQKPSUYl4TtWcYUbj0QD0s76y4EoscRbg==
X-Google-Smtp-Source: AMsMyM4nKrizVQZ5PSmi77/IhIFyJKIJXpl3DjaXwazIOzPcMtRAwJAQFUcl7LcJZpREfyK9kmbvNw==
X-Received: by 2002:a05:620a:472a:b0:6ce:d97a:fcc2 with SMTP id bs42-20020a05620a472a00b006ced97afcc2mr3494685qkb.96.1664478110761;
        Thu, 29 Sep 2022 12:01:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.14.151.55])
        by smtp.gmail.com with ESMTPSA id f21-20020a05620a409500b006bbc3724affsm172170qko.45.2022.09.29.12.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:01:50 -0700 (PDT)
Message-ID: <6335eb9e.050a0220.cfd47.0864@mx.google.com>
Date:   Thu, 29 Sep 2022 12:01:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7017356502625849940=="
MIME-Version: 1.0
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7017356502625849940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/advertising.c:1055
error: src/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7017356502625849940==--
