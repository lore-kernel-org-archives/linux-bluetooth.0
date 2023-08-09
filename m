Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0068C001DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 02:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjHICYJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 22:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHICYI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 22:24:08 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA1E1980
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 19:24:05 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63cf28db24cso37861706d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Aug 2023 19:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691547844; x=1692152644;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ow1bV+7nP6gkAxO4IjLWJIVkpCqddpZ3VLx8idMmDVY=;
        b=pVmW7Q+hse4SMxj/urzrZvd1kj+0njumY9S29/x5aMzL769VCLZFxUV+XsMduBQaqz
         01JSdFIoFdivwHgMmSEA1XbTZhSeM7YTYVWuLqtfKl7vukQDJmGbMXJkZqZ3I8IOIbmW
         TyUBfKyLc8LFGux93aW9VbxUFiahuvaDxo4ED3xz63zJ+DvemJ0pjUZKgSX04P7WMaj9
         9YT4X5oBA8Qq9gla5I8zWT2MgAzax3Ru7UPXsmKPoGk05N9wYWbxV7jE0pGxaH5TXZgJ
         RZnY3TZ3Kf3B2MGSN1QdSkZZjeb0gs8DCdn0sPrSxTCR3HeaMlVgZsnQfgpwPkvoaMfx
         cXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691547844; x=1692152644;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ow1bV+7nP6gkAxO4IjLWJIVkpCqddpZ3VLx8idMmDVY=;
        b=TZqa17x0ySegpzmin5kfVR2t15yEGWSbolnnSoIK6n5C/oLZX6p2ekBVwqi2taOxsi
         J/xJAvC2eN4ppFt7BQMo+MPDh5KIB4KK5EffJG8xx5jEJZBsjXaSKQzGK00zdQXfG4st
         oVz2nvBkBGyrDxAS49xy5uXWAPWPiX7FoRELLZhFTJPpzQa6/Okds7/c75Dod9JOmNfz
         u2GmyWd5Z1AvR9X2RMm/PT27LgIYWJmp0y3fberunXrYIU09bPddECOIPhwDb62YQ2Gu
         hKn+fbImyy2/04EoGMj8XmYA3c7/GyHJn3pwOb6GsZOEjL9dn1drKvZ9nP/h6t2OG+Em
         fozQ==
X-Gm-Message-State: AOJu0Yz9P6+aMryWipSGtFfnqSP1niZfadmZKl/GRGJMagD74IkPm/g7
        uXs5TjuG9y1w5u2d3bZD8wVlyPNgrd4=
X-Google-Smtp-Source: AGHT+IEGFSysfQYE8xmvSDYqGQVTR4U9SyL4T6DOgn3p8svFZ+uQSZPp9h1eSwUrf2avCU5smYnYyA==
X-Received: by 2002:a05:6214:1648:b0:63c:b1a6:2a39 with SMTP id f8-20020a056214164800b0063cb1a62a39mr1064031qvw.63.1691547844017;
        Tue, 08 Aug 2023 19:24:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.229.16])
        by smtp.gmail.com with ESMTPSA id n3-20020a0ce543000000b00632209f7157sm4056302qvm.143.2023.08.08.19.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:24:03 -0700 (PDT)
Message-ID: <64d2f8c3.0c0a0220.7ae79.0af9@mx.google.com>
Date:   Tue, 08 Aug 2023 19:24:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1257878748708523969=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: RE: [v2] bluetooth: Add device 0bda:4853 to device tables
In-Reply-To: <20230809010403.24612-1-Larry.Finger@lwfinger.net>
References: <20230809010403.24612-1-Larry.Finger@lwfinger.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1257878748708523969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774317

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 FAIL      0.31 seconds
BuildKernel                   PASS      32.44 seconds
CheckAllWarning               PASS      35.90 seconds
CheckSparse                   PASS      40.84 seconds
CheckSmatch                   PASS      113.59 seconds
BuildKernel32                 PASS      31.60 seconds
TestRunnerSetup               PASS      478.91 seconds
TestRunner_l2cap-tester       PASS      22.21 seconds
TestRunner_iso-tester         PASS      45.12 seconds
TestRunner_bnep-tester        PASS      10.05 seconds
TestRunner_mgmt-tester        PASS      212.22 seconds
TestRunner_rfcomm-tester      PASS      15.32 seconds
TestRunner_sco-tester         PASS      18.29 seconds
TestRunner_ioctl-tester       PASS      17.10 seconds
TestRunner_mesh-tester        PASS      12.73 seconds
TestRunner_smp-tester         PASS      13.63 seconds
TestRunner_userchan-tester    PASS      10.51 seconds
IncrementalBuild              PASS      30.03 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============1257878748708523969==--
