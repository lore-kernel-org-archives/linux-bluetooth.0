Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3015C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15802064C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw5B9sVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgGQTUg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgGQTUe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 15:20:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB79C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:20:33 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b185so9792988qkg.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=u5hRoThFh+STXopp9GkDd8ZQnBsDrBPQnBCJRE9Iqp0=;
        b=iw5B9sVSI2FUImHMkCOYLWlb5NgjsoKyXgL9/pr2H0q4p4aDtxhtVzAPsQUOXdlHV4
         1hRVg0e3XVEPSE6pM3Zcn90/UMUZvX9VeIKC5UQMNwwiAgsbJauoJB5/qn+IiVlM9mAI
         gJc7nvdHWIXuWjf65Ep2kRnsK4v1fU7u4mfSfq9K759F8P/idP+Hty+6VTcWCINlNY7V
         2RXIp2gwNCl1qVkMoPxrgUaqY53NXxuinYRYCcQ6falki19aDEyDn5GIM/fO+BVFp5l8
         17+64jfktp4uytO2bv+v0XGR+BhsxKRaeCa3ix/dAoAR0xOBGKX2k/9S6DKSWHt2kV7o
         rHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=u5hRoThFh+STXopp9GkDd8ZQnBsDrBPQnBCJRE9Iqp0=;
        b=IWzAvfOFRcG3rGpgWZL3YN+EIBJg0NKNYomfjwCEWnYoAM8mbhXhwP+cqblcd9zan0
         2wwCGxfrp9JqwXdErleXnBXLevBqCwRF+kYzn6UtNTqzSUksCmPhzdHsrI1VeUnz33IR
         MoJgsie2tWpwba8i/ApkUnJrx16XS4y8jcEFnjRQqEGn71SW7gqW+PaWXKBr4ZUU4opt
         OdcoXxFhXqX6DewXIeAl3SkJAlksDHPZMIExX3K7vyuf63HKE9Wq7v7LrBCRvqBabuFe
         qTvHpXhYxZ7FfcYD+1tO0YEoT+giRhzJ3CrYdILl1kQVuoOTZeGfV3TgDY4R45cngO5M
         UEeQ==
X-Gm-Message-State: AOAM530HaPlNP/aNc/tB4KxbWYp+dUkfgMj6wHsUglklInNhxi71u27C
        R2YeNfAoX5L8F86e6A0wTC24focTV0g=
X-Google-Smtp-Source: ABdhPJwd/e0TIDIrHl/xVK0PIU6JjP7ALhoOyXssIXUPy9D9MHa92PCLNkp4kbE5oyIMN/iyQcQx5w==
X-Received: by 2002:a37:9dd3:: with SMTP id g202mr9972585qke.432.1595013632766;
        Fri, 17 Jul 2020 12:20:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.1.183])
        by smtp.gmail.com with ESMTPSA id r18sm11840457qtf.62.2020.07.17.12.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:20:32 -0700 (PDT)
Message-ID: <5f11fa00.1c69fb81.e4b2b.c619@mx.google.com>
Date:   Fri, 17 Jul 2020 12:20:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2169838713756071571=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] shared/att: Fix possible crash on disconnect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200717191515.220621-1-luiz.dentz@gmail.com>
References: <20200717191515.220621-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2169838713756071571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#17: 
   by 0x48E963B: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.6400.4)

- total: 0 errors, 1 warnings, 83 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============2169838713756071571==--
