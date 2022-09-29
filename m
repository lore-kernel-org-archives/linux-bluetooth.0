Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839DDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 17:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiI2ROz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiI2ROx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 13:14:53 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032905208D
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 10:14:51 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i17so1250972qkk.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=shZxo1qQb1aA9oViUWF3K2l4jaFcEnqLTvQyj0O9FLY=;
        b=Z+tTQe4dew6NMUYVoLJRZVVUGk1uIRswOSH1QAFMIMOtOILH7GHDJj5U+XSkI2OYtf
         T59it1GdjMP1bVaUUAL0YdXAGw7WW/T+osdlsqcFWl5VL7HtYkcXOGiLxx7OCHGo8cRj
         2JuRwGDrJQwtDtJz//h0UAV1mRunm7shrcebOsrNsj51fbfiQhKus1CVam3apbPM6dNy
         aq3nxecqBpL/vwCcDfHTePL6Xoh5rllDiiJDjfga+QYqAc/ksOScMR91nW9eniEGKGtL
         vSzL9vqViBjJ01zCOgx73dUaGk4P/yuIbeLI0uS06X5LljSRAoWEpAWrze6TI4sHSC2D
         ebWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=shZxo1qQb1aA9oViUWF3K2l4jaFcEnqLTvQyj0O9FLY=;
        b=V5vq3KuA9a6z7KzV3Pu3HHL3D4CT4wwpEJCeRAgXmmG2AvYxVo11WDguBVYmLQF8Xn
         TeIEfzEpvcBn9meXWudLrzE5C5slA5Wm3jAKc2qHAx5hybbzdzuNt4RgA6EQrzcps3My
         jlpkajFZXKPKuoqjP3WL1YZDULNQInrhuL5dSolRARt73AEYbXk06U6b/4A/TcibtkYh
         wmFjJhfKpixaBvgCUHuZbIDI7dYSpx4+ZXtVXCg2D4xpDPbuKIJnpUo7R19KYWSsv0bg
         cyqbMBJ3Y23+uDCi5HvESw0goYtif+FhQjUvy/mTZsj9lkDMw9R05lxdKH+FbLU2SNxL
         YUpw==
X-Gm-Message-State: ACrzQf2C/cuHocZ+yb5T53b2LDifcxS6tI2mzXcjUq0W125TqwIBhn75
        ZSP2HFiL2Pq5kgsrWFXwBbRJDpw5cRokag==
X-Google-Smtp-Source: AMsMyM7KCibTSqsaNAo3Z5i9cUGNQ0RuyOPoTNmHH96SREak42NRxU38uEdk4VMcNM72ug8LJK/nOw==
X-Received: by 2002:a05:620a:1272:b0:6cd:f04f:f114 with SMTP id b18-20020a05620a127200b006cdf04ff114mr3058354qkl.581.1664471689826;
        Thu, 29 Sep 2022 10:14:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.139.35])
        by smtp.gmail.com with ESMTPSA id l19-20020ac84593000000b003437a694049sm5956206qtn.96.2022.09.29.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:14:48 -0700 (PDT)
Message-ID: <6335d288.c80a0220.8834e.26f1@mx.google.com>
Date:   Thu, 29 Sep 2022 10:14:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2363260145417144808=="
MIME-Version: 1.0
Subject: RE: KASAN: use-after-free in __mutex_lock
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
In-Reply-To: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
References: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2363260145417144808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 6
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2363260145417144808==--
