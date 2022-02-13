Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8195BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Feb 2022 00:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiBMABT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 19:01:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiBMABS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 19:01:18 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0395FF3E
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 16:01:13 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id c14so11777654qvl.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 16:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lOtYzAvvzzqNoUzaResSO3j3FQjqTHLpVGD+rfwVmVs=;
        b=Wl0ES6uOCY6wEudVTR6QkptZdjSy3Uu+l6F59IRQK6TALR4MFsBiQV4P3/OW1fcJjS
         Bntc/OyAuTwxD0pDUK6LSk96WOfwrjYuvmCmmXkx7q8kdM42R8EAglHWPSNaOghd+efc
         OInSEdJ/JLCMb3ihmAsUvF3nu9gDeDV4DFEk7n6u4MLwW0taCbtEnHxMfSg9dh/eOviv
         9xEHBox457+4l3N1hVl4Ki2vlR1iPf/etPUS4AoUUgSWVALz3sexnPGgUMucsUdosEvv
         Y+o8bodNXegoGvzVNzHD4rVJdNifkwR8+8j598WR5uHRkPbbXBE0dF0Cxb5ryKbPmVT8
         RDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lOtYzAvvzzqNoUzaResSO3j3FQjqTHLpVGD+rfwVmVs=;
        b=zZMP70iVx6qi7Fl+l9YpqmuBWjIzEJAHSfy8VQHqyWauc5LhZC2OhrcL/rioHz8HEF
         rB4z+2u3w/EcIjLvyf+Vtaq66FZyjjiAUwz2CYgKhb90iwF4PBZTRzxHSbxvtlCp71tY
         lv9UUSnZ5Q9IhgIOv2aUSXPdhSkhZwH98ineMPPYmkHnknZv34p5l/ylYtW6Vn84U6zF
         G2jD23q1hREe8GXSG4vxDApf0YycWuhKKcvlhJTCpLwak/rko+WuFSk+O5zugJzz+0wq
         HClu4JMklHcXH1ZRO/8no/1q/zZwfbRHCPYEDbRpMl+TnMkDsbmflNJIxkZ6W/AmWtQB
         2oGw==
X-Gm-Message-State: AOAM5322EGvLpsz30OqYwOl5U7j9mdyuwilvjF6Le9NeIsCJ1Aivyrhz
        dswT4s1668HBtD4uZ8sa9e0q93hSXAbIPQ==
X-Google-Smtp-Source: ABdhPJxJvJvvynlgK/9e7O5MFaPWpSJf5zf78BF1isfV/Rc1BZwqzGdESWyU6l+T4ocAWe4aZ5Sy0g==
X-Received: by 2002:ad4:5b8c:: with SMTP id 12mr5470887qvp.99.1644710472766;
        Sat, 12 Feb 2022 16:01:12 -0800 (PST)
Received: from [172.17.0.2] ([40.76.40.91])
        by smtp.gmail.com with ESMTPSA id bj24sm13394211qkb.115.2022.02.12.16.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:01:12 -0800 (PST)
Message-ID: <62084a48.1c69fb81.3af62.9670@mx.google.com>
Date:   Sat, 12 Feb 2022 16:01:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0441623399320873376=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, niels.dossche@ugent.be
Subject: RE: Bluetooth: move adv_instance_cnt read within the device lock
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <f181dc17-3b27-436b-15c1-832feb573d25@ugent.be>
References: <f181dc17-3b27-436b-15c1-832feb573d25@ugent.be>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0441623399320873376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613797

---Test result---

Test Summary:
CheckPatch                    PASS      1.68 seconds
GitLint                       PASS      1.07 seconds
SubjectPrefix                 PASS      0.91 seconds
BuildKernel                   PASS      35.36 seconds
BuildKernel32                 PASS      31.22 seconds
Incremental Build with patchesPASS      42.65 seconds
TestRunner: Setup             PASS      553.92 seconds
TestRunner: l2cap-tester      PASS      15.31 seconds
TestRunner: bnep-tester       PASS      7.08 seconds
TestRunner: mgmt-tester       PASS      118.06 seconds
TestRunner: rfcomm-tester     PASS      8.97 seconds
TestRunner: sco-tester        PASS      8.99 seconds
TestRunner: smp-tester        PASS      8.89 seconds
TestRunner: userchan-tester   PASS      7.37 seconds



---
Regards,
Linux Bluetooth


--===============0441623399320873376==--
