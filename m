Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF2BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 18:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiI2SGp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 14:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiI2SGo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 14:06:44 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39BB1B95E1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:06:43 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c19so1353962qkm.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=OKzbksKTu0mRWhYOiM4dacAXmzMEdPru6iMKEHYpebA=;
        b=IiWNMaGk1t5qS7x7muDqPyck84PuDVZi5nc4EpWlmIxQH9uKeAPYrzGk/PLCuCPsHV
         kofGL11pJ+7/htk8htuQ/JU+6Gmd1VRtNrxTufB5uj2IBEqbxFadEPNb3TcuixEyGAgW
         3QcJ94EuzdAQbdnTp9SQl4TxJe50I9W6wPzEmbJ9BXqGWvyAjbf045YekjteZwD+cIce
         v6cObezJMAFrjH+EozmrhVqXdRIo+7W7coHrnbZySOnDXBHJHX6w3f4+SxNMrdszLHrO
         r+qKc8YBw2e1kpids9inQzDTwmiZ9lmsQCvLGge11NB2rZwo/yqRiD06MBDg5SEvlHS5
         JQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=OKzbksKTu0mRWhYOiM4dacAXmzMEdPru6iMKEHYpebA=;
        b=vm/YQrJP4qLjI/SbFns5O5LF53ldt4XcXpw7jQvaDOFxDrXHRUmTI2HZQMDsuOgcGQ
         ZW/IWrZMD6vWkVd4FYY5kH4JamJFgunlB+5g5qL2ggWT0l5gLVtcXmHB7tfZ4/ujcBDr
         SHJY2iULNEppBHxAlVhGXSxw6xzPdGkagebNY4nb4IpeuhlcfBodhSRZ754vwoRNqSrV
         EjbWU//RjwzGHEbZLH7U+yHfSE6Udmj2kSUc/z3oFx71vj9DUerbFzOMmMlRNeBfn98l
         oo/Ch2BrXR6CI1w7Tl3c1E+plJRwM7cddVOTAlmngnYvP6+iGWELfjp6qEtcqSxzH0vW
         BXbA==
X-Gm-Message-State: ACrzQf2W7bA87fA1gqKhJKk6FOQvHPV4uh5s2ymN3DXWoR1ZbeQ0ujrz
        IBW9khup7imEQ2ovCyZtfMlSAkLQoFAw3w==
X-Google-Smtp-Source: AMsMyM7w/bkEGzsW2dQS+mGcHsIjH0rSEVxTCRaRrBay7Xv6TP/SrqwORGhNC3Ni6g/tMbZm2Sqkrw==
X-Received: by 2002:a05:620a:254e:b0:6c9:cc85:c41a with SMTP id s14-20020a05620a254e00b006c9cc85c41amr3311815qko.260.1664474802658;
        Thu, 29 Sep 2022 11:06:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.199.222])
        by smtp.gmail.com with ESMTPSA id d14-20020ac800ce000000b00342f8143599sm6247150qtg.13.2022.09.29.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:06:42 -0700 (PDT)
Message-ID: <6335deb2.c80a0220.a655f.39e7@mx.google.com>
Date:   Thu, 29 Sep 2022 11:06:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5494037215540513351=="
MIME-Version: 1.0
Subject: RE: [v4,03/18] Bluetooth: RFCOMM: remove define-only RFCOMM_TTY_MAGIC ex-magic-number
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nabijaczleweli@nabijaczleweli.xyz
In-Reply-To: <f6d375201dfd99416ea03b49b3dd40af56c1537e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <f6d375201dfd99416ea03b49b3dd40af56c1537e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5494037215540513351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: Documentation/process/magic-number.rst:78
error: Documentation/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/it_IT/process/magic-number.rst:84
error: Documentation/translations/it_IT/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/zh_CN/process/magic-number.rst:67
error: Documentation/translations/zh_CN/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/zh_TW/process/magic-number.rst:70
error: Documentation/translations/zh_TW/process/magic-number.rst: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5494037215540513351==--
