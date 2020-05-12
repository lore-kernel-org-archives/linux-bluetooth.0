Return-Path: <SRS0=//f6=62=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C93CA90AF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC3C206B8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncjGuY1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgELRhP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELRhO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 13:37:14 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B945BC061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 10:37:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j2so11510735qtr.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=QuviFHtNP5VrV9I00xTziCY15tRUQxGaabFma1ucedU=;
        b=ncjGuY1B0T3SrBXjDFA5SMuPpwYgE8Co6M5hqb8W7glA0zwNyaA6YJJvUPW+vgbV48
         Zcupdu5agQ+jtR2dVn+FaC7+oFyt8Ie3flBacQQrwntKuAHoQtHqGLzQFuXTu12yFf+/
         0p2jRGXMCa1lchUhD5hgKP5Xy+CFrDOAFQyrBZFv0TjbY32NDmNZwZrko561AN99S1ZA
         zB8F432pKgBY1Zbx6JH87tDp/KoJ79/8k7a6mU28Fk8BSnJ8BEKga1wnrPikmDH6KuzJ
         p3Ph2MWAWrrJuY4s/judLco3ebspzSlYPgjSeLw19dicITQZhwt37VGlxTAvZuz4tgwE
         Wytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=QuviFHtNP5VrV9I00xTziCY15tRUQxGaabFma1ucedU=;
        b=SU6qrQZfuFgE1LfnNcowHuPUjePcAzhCtO87TGIEpy18HpZEWfgBSGPS3AfrKkoxuI
         t4I9WN2IQJLnzeZU6M+b13Dh/1QMDmfUpb6nnyaL2YTUGcSqHqrtmz1DaizxVHsQJcGv
         nIK0BvRsNKKYPCPkguIqOnfK5selXu+vrTW8yCZnZUvykd8WQKLpslKxmwHm0SaK1Fs6
         7UpUQ2K5JMrXkrxyz2VCAr70R5isMV+7qK23juCnJxwPT2Lk/8AOKb8aGBeWKWy+pIpF
         43hjc9FkbKOt9C4KyBggdqmPOM3p8PFiIFG7z19LlAQh1SbVWBqBOyE/lMNyxgRQhYOE
         SHsw==
X-Gm-Message-State: AGi0PuakLflW5IfkrRZ3mWiI9EVXrXAvDI1Ng/AAPlvlDXoys+dGF04D
        CUb8Ca86T69t/T8f4fMSB0IWziZG5Fo=
X-Google-Smtp-Source: APiQypLbRM+SF1BTDlXa0UzmEub8PI5V3M79MR/Q4h9sXmaZLR+hcwJug1YVbdCnwoD9JDmQ2zGKGw==
X-Received: by 2002:ac8:1090:: with SMTP id a16mr23244255qtj.181.1589305033766;
        Tue, 12 May 2020 10:37:13 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.72.185])
        by smtp.gmail.com with ESMTPSA id x55sm13003361qtk.3.2020.05.12.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 10:37:12 -0700 (PDT)
Message-ID: <5ebadec8.1c69fb81.27d0b.39e1@mx.google.com>
Date:   Tue, 12 May 2020 10:37:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1863416027549945323=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pali@kernel.org
Subject: RE: avinfo: Print more A/V capabilities
In-Reply-To: <20200512165112.24006-1-pali@kernel.org>
References: <20200512165112.24006-1-pali@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1863416027549945323==
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
WARNING:LONG_LINE: line over 80 characters
#49: FILE: tools/avinfo.c:723:
+				printf("\tUnknown category: %d\n", cap->category);

- total: 0 errors, 1 warnings, 43 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1863416027549945323==--
