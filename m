Return-Path: <SRS0=5fpF=AO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F64C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD21208C7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 16:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPTwC4ZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGCQsG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgGCQsG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jul 2020 12:48:06 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB25C061794
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2020 09:48:06 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id ed14so4008636qvb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2020 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=anG1Oo2SNB8vzM8YnvrDtiCG6DNwKsTBaFN00s1SrCk=;
        b=FPTwC4ZAFWvLMGg3RDSlj9UUUnFJzO1uO/lI+RXDR7rzM6T8jR5Ci1ubOH85rETm7L
         sfWLZ1QtsoQZ4wo//YBpP5kIE7e5e2UnfEm1iXpPv3i0VPLg/Vxt1ov1v1y5YGj0Pfvn
         93pWrHKBXf8elbISwweFY8B15NDyk/lJSqnUdhfasAG4yBYKGRAf4ppMD0ctYljmqBtr
         n+Yu0kistjIh7DT/Ko96eYTDCUnBDSKTPaGAEc6hc9Y9PFUid6IBx9SFmOca7qo34CS8
         E8SzU32nnDLnmgvf6ptPipUAN0gD9qAJXWVljCAQlUUVkgR4kF3kCKzr61MfO6xeh3Y9
         NFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=anG1Oo2SNB8vzM8YnvrDtiCG6DNwKsTBaFN00s1SrCk=;
        b=Hp8p4ukRUL9MTS3bB0PSp3YYaCL6jQUnhDTanJjwv6p88daU6b+ozaqvEn9Q/Mxl3u
         viwG20wqgITpOrCtnWI7/XxINU2q/AQ+TTVbCAz8eklRSv/1EfNhu3vJEeikz0l9HRkV
         u8bfwi1QnN5iCMwmBgTUqUXj2aMfQDhHbiMR/mSPjx2ENW4l2Jhfh2R59jc+aWUUZTY7
         vs6nIh5+bVCKdjWXqj5Zy5r12s6VG8J08O/Q4BXWIjS56bVaMONvs1vpZhwdP729S7ph
         qHEL6crhYzoYEmXHFZqh/mYvucZnM5fcDefSsuGzuAZ01xpx88LEkyQFf+xf9tU+5YLG
         /C2g==
X-Gm-Message-State: AOAM530q8jchjvwEhGLTtNf04t/EOG3OUK+BDki6YensYHjD5eZyIyhY
        KFTRutGfSyk/nwFKVFtZZxZbwcjheiA=
X-Google-Smtp-Source: ABdhPJyvrw2adc1hlFo2gwdk4eW+iHlJihdEE4RnYyC+6TU/4/JfEiT0gQ4QCjHjzZ09x7OACuRp3A==
X-Received: by 2002:a05:6214:72c:: with SMTP id c12mr33580149qvz.76.1593794884913;
        Fri, 03 Jul 2020 09:48:04 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.240.96])
        by smtp.gmail.com with ESMTPSA id d13sm10940183qkj.27.2020.07.03.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 09:48:04 -0700 (PDT)
Message-ID: <5eff6144.1c69fb81.489f1.ba81@mx.google.com>
Date:   Fri, 03 Jul 2020 09:48:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1451388738377639551=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Fix Seg Fault - App unattached IVIndex chg
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200703162018.940172-1-brian.gix@intel.com>
References: <20200703162018.940172-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1451388738377639551==
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
#19: 
0  0xb6fbc1dc in strlen () from /usr/lib/arm-linux-gnueabihf/libarmmem-v7l.so

- total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1451388738377639551==--
