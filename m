Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1837C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiESVGY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiESVGX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 17:06:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3DF2FFE9
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 14:06:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so9842850pjb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+3X07w2BBxSN46TNKr0xCm3aZTYardNzQ+ApMsTcSFE=;
        b=S/+63MOGcfkkEzFZW98FIEvKSz36rQxa01dUI3jHhG9zdoDwwtRaZ7BGMHYse7XT5q
         og/n1Fr/nJNqDdKbByX+yuTc0+DXtVSl6xE9qRYQDMN9L+FYqX650ppKoi2kYHjlYBrF
         FixKF18q1yNk494QTAPg7m5npg2vpJ5NODt4EO27u46Ce1pKuXVCpzINPumnA3wxI398
         h16G0X4tbN2J2kmAKEATgfEZZAcgpEu+pN6tHDzqeTbB3vywIjDcmL+6n/UrEbrjkE9g
         CG4P7S0GpwCWr8pehoB3yZpwrTvGAxym8TUCrsykqR9Jt4Yh/JkfIu/7JnET+DWWwbTm
         /m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+3X07w2BBxSN46TNKr0xCm3aZTYardNzQ+ApMsTcSFE=;
        b=jdTZ93+H6G8AXE10LGFPLG8zOPFz0vWMat+44NIxhGH1DGaoGzgBiGjOG9GjXmdFvn
         pgmRCi6BlOtrvnUB5tbTEZaMEctK6IdCMTqTMPaiTqdY3UCoRLVwSKh2+DAThBRL0E6t
         RZhgpU2KMhlLx+nclst+YMtUmJ/ArqpBMNUED5a2Dr4ecviunIxLJay+vV1mf4A/l3jg
         GoWvTgyRYfhnxfQYAU7+1IllA4LnrbLigMrzg1nXyB4EviJCFfSm1tKYwrad+s3SC71v
         Tc1vfi7QZXSFQmC/5jCVT57DuADtwFBgXZIL9WRecvaIZolmSeGo1GZ+HWACdQ7tMsPx
         Ro+w==
X-Gm-Message-State: AOAM533t9STPYCsxq6hkKXaWJw61Fa6txKwqf1Dgd4fEynCsJWb4JoPy
        /DrxFJEwWffEUh/thOoF65BtJH+zlWw=
X-Google-Smtp-Source: ABdhPJwjaU4n6BHQweo53JHHrfHYPORUrfb06Jd/fVDO2RGAaJlSLvDvzN+M4cXcDoYnJDPTbWCXxQ==
X-Received: by 2002:a17:902:f650:b0:15f:3a10:a020 with SMTP id m16-20020a170902f65000b0015f3a10a020mr6403965plg.61.1652994380493;
        Thu, 19 May 2022 14:06:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.237.150.189])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b0015e8d4eb1dbsm4312395plh.37.2022.05.19.14.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 14:06:20 -0700 (PDT)
Message-ID: <6286b14c.1c69fb81.258c6.a395@mx.google.com>
Date:   Thu, 19 May 2022 14:06:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8403390578255379709=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: MGMT: Fix uses of bitmap_from_u64
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220519202345.2459798-1-luiz.dentz@gmail.com>
References: <20220519202345.2459798-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8403390578255379709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=643317

---Test result---

Test Summary:
CheckPatch                    FAIL      0.90 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      41.04 seconds
BuildKernel32                 PASS      36.44 seconds
Incremental Build with patchesPASS      48.72 seconds
TestRunner: Setup             PASS      616.78 seconds
TestRunner: l2cap-tester      PASS      20.33 seconds
TestRunner: bnep-tester       PASS      7.47 seconds
TestRunner: mgmt-tester       PASS      127.78 seconds
TestRunner: rfcomm-tester     PASS      11.61 seconds
TestRunner: sco-tester        PASS      11.41 seconds
TestRunner: smp-tester        PASS      11.21 seconds
TestRunner: userchan-tester   PASS      7.74 seconds

Details
##############################
Test: CheckPatch - FAIL - 0.90 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v3] Bluetooth: MGMT: Fix uses of bitmap_from_u64\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#110: 
 4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);

total: 0 errors, 1 warnings, 0 checks, 107 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12856022.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8403390578255379709==--
