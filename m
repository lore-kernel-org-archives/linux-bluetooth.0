Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE712C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 03:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiIUDxu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Sep 2022 23:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiIUDxd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Sep 2022 23:53:33 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23857EFC3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Sep 2022 20:53:28 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t62so6437248oie.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Sep 2022 20:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=O9eT6ua78q1k3SO1nb+CC1o09pBgwAsar7lws4WMQ7c=;
        b=aCQ1MMJPXVbp3RmHCGPCep/5WI6tBnUwtEGndII47L3gs8bjPLkltlBzvjy1rhyvFN
         361d49NPfK+B9dlmNczpHad3adNQ+ys2cRI339VWg0x05sdJeadNpslit0QZ+ArQHOmi
         4orkZn+cwKoXEu3RbZGxu+vaHqKU15VP5nbAU/05JSCFhTuIca/CJ/dbymDTUZED/Bsz
         sSHQzqpnuqACfC9AfljO1HKZkV/HP5UkbTIdHPVgZkyD+KMFwg5Zc+6pOUwCW2Dipu7Y
         /0o5X97ZnPn9yyOwRsPcatoA2eKx9UfvwOZB1ZXAmQIPzpMVdWiaK0yU5JYmaNsqdXQF
         CN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=O9eT6ua78q1k3SO1nb+CC1o09pBgwAsar7lws4WMQ7c=;
        b=VzX5xSOolgizz+h4uMHQzCQBLHI4bYL+KTbSVOOMmElbk0ez/beR8dhgj3BD4SHVaq
         F8+kWd/6j0QuZpfW9mp+lNqlQCg/6o+VqHqQzuGKBT1BixDfTbPo+7dSvnoto2v4i+93
         8BmN3qpDdhGz0XX3ryNMjerkQh2OqoDHPyiQKOasib1yrk/GhOqjJr/bILQab2iAGFz/
         r29dWnW0/bxOGa5ydM2yKR5U+SjQXTNBAy2uJFKGLCTCZbqo8ths+SGBmgy9J1z5pmuQ
         uPmiqxLd4MxLEA/UzkgA7Sgkuh41jIxzDuistVYE4qRjiFKWjsteHoNvRy6l6bHWTDpD
         E+fw==
X-Gm-Message-State: ACrzQf1JzmQ1YkRD4fByENWGUyT6Q4A4Bhi5H9Yz51mUA5Ee8PKCTMER
        uXbhp/6AtUkqH4UMd/gkVg8AQkAEKQ90ag==
X-Google-Smtp-Source: AMsMyM5mWx1zwWdlMDyuXGyE1Ru201hA8bCaqjOOzIdoQ5yDr75Yn7AD4gX5ob/hDBw8vz6gjKExtA==
X-Received: by 2002:a05:6808:1a21:b0:350:61ee:832f with SMTP id bk33-20020a0568081a2100b0035061ee832fmr3179363oib.10.1663732408055;
        Tue, 20 Sep 2022 20:53:28 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.145.112])
        by smtp.gmail.com with ESMTPSA id q185-20020a4a33c2000000b0044ae10c5974sm617957ooq.34.2022.09.20.20.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 20:53:27 -0700 (PDT)
Message-ID: <632a8ab7.4a0a0220.a2d79.2969@mx.google.com>
Date:   Tue, 20 Sep 2022 20:53:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5199925744736239723=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/ioctl-tester - Add ioctl-tester
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220921011302.663171-1-hj.tedd.an@gmail.com>
References: <20220921011302.663171-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5199925744736239723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=678840

---Test result---

Test Summary:
CheckPatch                    PASS      2.16 seconds
GitLint                       PASS      0.78 seconds
Prep - Setup ELL              PASS      33.10 seconds
Build - Prep                  PASS      0.93 seconds
Build - Configure             PASS      10.37 seconds
Build - Make                  PASS      1118.93 seconds
Make Check                    PASS      12.50 seconds
Make Check w/Valgrind         PASS      349.69 seconds
Make Distcheck                PASS      291.85 seconds
Build w/ext ELL - Configure   PASS      10.42 seconds
Build w/ext ELL - Make        PASS      106.25 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   735.25 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
tools/ioctl-tester.c:561:17: error: initializer element is not a compile-time constant
        .conn_info = { conn_info_1 },
                       ^~~~~~~~~~~
tools/ioctl-tester.c:572:17: error: initializer element is not a compile-time constant
        .conn_info = { conn_info_1 },
                       ^~~~~~~~~~~
2 errors generated.




---
Regards,
Linux Bluetooth


--===============5199925744736239723==--
