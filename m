Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60161C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 03:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCPDuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 23:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCPDt3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 23:49:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E1AA25B
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 20:48:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso288801pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 20:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678938517;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3ioDdsASKRhf94b/TiX1RYr9dEBLlZeU7U1NKOQ/AI=;
        b=V9hPvrZikKBel8CWr2MVYf1j8yLskpBAo0ZOAprzrb8urWQowA54nAeZUt7ViJ0f1P
         zidS+I0/tB3LEanUwzs/Hu3NW7pAOlrvBSLZxxuX2AnPMgb3TCQHIemzautuHpsXjFMo
         ROygGY92YAt7h1cVY63/9tl/Xo77Ynex8ZptqAQh8cgoqjp7SKV9Lrh4ZXsojs42VfBU
         B1XSV4djYg+M4zNX7Ez1rklc/Zw4e0kLixvK4dQAT/TO1P707UaLCEQEOBixQO72cnHz
         aq4YdEvmbZCfo/P6Cp/Bs1qwh00ZZxtkFMrMU3H+5wsIocBr9V1Z7ZMdakdBgPI3HAEf
         1m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678938517;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3ioDdsASKRhf94b/TiX1RYr9dEBLlZeU7U1NKOQ/AI=;
        b=DsxUsg93IgdG61XfSofqzrciaagAo8vxV9qoPXI7dYKJWhysL2/1afF1AAgDfdzL2d
         hJnvebFQD6mOH9VQ05nM7YkyrmUSmFibyKTx5HL+m8aoY3wpWWbUo0XmyaMIHhvA2GEn
         IXkr/t1B1oMZVj3TOBZ8zjmzliCGdo6GGfCESfVlY3/GaGVeLbbmjc9EmCrrvdWNQOvo
         7OhafWjn6qJYpPtXVtvAbCs+mNvQSYSqwBoVmK2bSMSUhBj4Rko4YKbkMGZ3HOpe7RTN
         SWpJ+lfrBkHsQ0Y2SYA2D0Mdm+ch40On+gINALkKMulnkg2NS4cqTC/l2wErdV+Tb1//
         ChrA==
X-Gm-Message-State: AO0yUKVx69QPEeJGYLqznH5LyXIdozeyM+2FzBpld39fgtdQ/CsR84rB
        9v9+Nf+S89I4G2KRX9wdiLTP49U+jPM=
X-Google-Smtp-Source: AK7set+uzVos/uLrMsw8dIGhaWbFmQGwupNy02KbvhilF8HU1f7obdVRS8MiwWbtDnZ6BQtd7WhJPQ==
X-Received: by 2002:a17:902:e749:b0:19f:3d59:e0ac with SMTP id p9-20020a170902e74900b0019f3d59e0acmr2019258plf.44.1678938517444;
        Wed, 15 Mar 2023 20:48:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.59.208])
        by smtp.gmail.com with ESMTPSA id kf16-20020a17090305d000b0019309be03e7sm4388379plb.66.2023.03.15.20.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 20:48:37 -0700 (PDT)
Message-ID: <64129195.170a0220.93594.a590@mx.google.com>
Date:   Wed, 15 Mar 2023 20:48:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0523974768575949572=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: [BlueZ,v2,1/3] mesh: Filter originated Provisioning Data packets
In-Reply-To: <20230316011627.27322-1-brian.gix@gmail.com>
References: <20230316011627.27322-1-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0523974768575949572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730563

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       PASS      0.76 seconds
BuildEll                      PASS      27.50 seconds
BluezMake                     PASS      838.66 seconds
MakeCheck                     PASS      11.01 seconds
MakeDistcheck                 PASS      152.90 seconds
CheckValgrind                 PASS      244.64 seconds
CheckSmatch                   WARNING   320.77 seconds
bluezmakeextell               PASS      99.34 seconds
IncrementalBuild              PASS      1957.65 seconds
ScanBuild                     PASS      1036.46 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
mesh/mesh-io-mgmt.c:537:67: warning: Variable length array is used.mesh/mesh-io-mgmt.c:537:67: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============0523974768575949572==--
