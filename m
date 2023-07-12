Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB5FEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 18:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGLSVG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLSVF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 14:21:05 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1DD173C
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 11:21:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4039f7e1d3aso47028291cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689186062; x=1691778062;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sByOhXEGuO/az592aH/DccrRSOVwP+gcb3glzPV95fs=;
        b=L1xVaDu93j/FmxEmYCsWHisqQyr+YYHGpt/VX8tYgLLwUjO17DuRjuHtIUwAZNlBdT
         684T4u4tVYivqWTWHjyvPQIKzbW75vsU5pyh4KCwfkmBRHvCxfk3G8sPmGP+FyRzIJpS
         qVcuKdiA+FoJHIed/9nZawSRuvAHdfpEa6Wp5pf6hvROb+4t84tFp8rxG1x8mfJ5YjWu
         TECxAyXCod5es2WKZQZbkJ5rBnebG1Hy83uBxZKGEnjaHNePy+vg2Nbf3UXRPG+kvTd4
         2Wn6UK+LATvAqOkX7/n+5XVxUPIsZpnST69XYhnyoVHsOqdGyzio8CpZFa+GAF4gtJW1
         nnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689186062; x=1691778062;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sByOhXEGuO/az592aH/DccrRSOVwP+gcb3glzPV95fs=;
        b=CDvDvWvwNSzU7SoBvlkB6+DMRnzVJHrZKQSzi9IsdzjpuIE4UITHmdkDPhkWT/uiMM
         nnj/JvfWVSm5y/BG8W1ChBuUGp/VhsM857ZCRasxpAaIKRbLbsMMa87wQueDrXzz3p76
         vFxDXWxh2K+ygZUnFy+j8Doe/rk/+fWijR6OJCeltIgaZ3PtZlkdYWf0v5VG+VDVmeLi
         HiGMHuPqhMdkk6U9fi7dFu+4Tf8loiVlF6YoDu6RmlucCGRRWgM9sLQC3qKx9p3JPWGK
         RD3/YAU1qCh8hQHJ7XJ9IE52BiNZSNQ1iaWzA9XzcrcJwXDtZrpx7lXdMjppGhAgw3rr
         4Bhg==
X-Gm-Message-State: ABy/qLY20FLSzeGDF5aLxQnJKo6N9PjFnQKQdODBraSTc0Mqkr9OWPIO
        vUmwY0U6Oq1IFdfaRfJarzD9qjt71HABcQ==
X-Google-Smtp-Source: APBJJlHF9BXtbj9fpay1iPPHjv7qRSv7wIDbd0+mbjABqvSnM+1L1LA8m5AB2VzKGUgumLVV432vUw==
X-Received: by 2002:ac8:584d:0:b0:403:9be1:c969 with SMTP id h13-20020ac8584d000000b004039be1c969mr25899529qth.62.1689186061981;
        Wed, 12 Jul 2023 11:21:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.75.128])
        by smtp.gmail.com with ESMTPSA id f13-20020ac87f0d000000b00401217aa51dsm2448031qtk.76.2023.07.12.11.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 11:21:01 -0700 (PDT)
Message-ID: <64aeef0d.c80a0220.14547.9284@mx.google.com>
Date:   Wed, 12 Jul 2023 11:21:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8820049603435659340=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] test-runner: set non-quiet printk before running tests
In-Reply-To: <859a1c176765dbb9ea394dde387b8ed072365ca8.1689180344.git.pav@iki.fi>
References: <859a1c176765dbb9ea394dde387b8ed072365ca8.1689180344.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8820049603435659340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764973

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      26.62 seconds
BluezMake                     PASS      771.59 seconds
MakeCheck                     PASS      11.94 seconds
MakeDistcheck                 PASS      155.03 seconds
CheckValgrind                 PASS      250.24 seconds
CheckSmatch                   PASS      335.90 seconds
bluezmakeextell               PASS      101.43 seconds
IncrementalBuild              PASS      1295.86 seconds
ScanBuild                     WARNING   1024.62 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/test-runner.c:941:2: warning: 2nd function call argument is an uninitialized value
        printf("Running command %s\n", cmdname ? cmdname : argv[0]);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============8820049603435659340==--
