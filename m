Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90F0C54EBC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 02:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjAKCiB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 21:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjAKCiA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 21:38:00 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8012D01
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 18:37:59 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id jr10so5460980qtb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 18:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oVvpVXcYqpDkXamgKreoMSRWEX86YnyldGtOwULhEDw=;
        b=EMbAEYz04oWu8kMW1pHRZ4D0Ioi5FvmqullDIxZTc/gy/QESNhkqaPKH9wAhyKwvMb
         /ThJLQYS4/Eshn/e20RlzWpZWtU+DSCG50TvAjL5umUz/WERW7PyXHHXsreUf5oRvQ/h
         nMXKa7bYWpvgV3HaMwFWFbUF8nBlg5cPyWHJ4M4IsZBr3HJ21niFr9GNQTsZ19ZtLdt1
         NX2pNTIK08H5fUydf1Mw/hwm702MVxaL55QbrD/g+hFdOukXUK9zSk4Zd359Wrpl/V86
         KaSQl4bCAD0hs6p/e2WvpYfPLgbHMeqbD4P/2ggjXbBh0HO5vxWPkgA88WXJBiI3/1KQ
         EodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVvpVXcYqpDkXamgKreoMSRWEX86YnyldGtOwULhEDw=;
        b=GltPJ16DQEYqnmm8yn+tD+sYS6wy2i+BQ/BZrAZjzyyqxikUYAF1dwlJLkEstHCyFS
         z8eld9HReyzzvZOKBSw4LBHY1MBuLC13PJZ+a4eikYGP4KMSf/+cBfOQjWzPV/BFaIFj
         EDH8yuMSwAtRny5R2h5o1a8XaAxk6l6ZJUSwmKncQ2Za+TW/kpz3iuWz+GKU2rYnF0zi
         9ase25z2Cwqgb7BMPAXCQHU/tW88FOmVVcPr7wyK9TNVU9KC91tx2tJ1MydmcVHdjADO
         lo4ul/eRpiwf/y/+wN0GDEPyhYMIvwopk8fU2ELUzwz5vV58Ju38nngJxyydQxgTaKFH
         2m/w==
X-Gm-Message-State: AFqh2koG42mA6cQjjrWCBhQ5mmDx97TMu20NG70GmV2OWckwxCGcBwBn
        3CNfCbRTFGVv3blLBvHGpDL05JiZdNBJpw==
X-Google-Smtp-Source: AMrXdXtL0MLPWN/Yxnr5hHahAGu8ePnFju8Fj7ksUxWkNHFKPIoMEFT5lbloKpyWGbG1VAS/2qF3lA==
X-Received: by 2002:a05:622a:4d0c:b0:3ab:d932:6c4e with SMTP id fd12-20020a05622a4d0c00b003abd9326c4emr25124161qtb.18.1673404678936;
        Tue, 10 Jan 2023 18:37:58 -0800 (PST)
Received: from [172.17.0.2] ([172.177.129.241])
        by smtp.gmail.com with ESMTPSA id bx6-20020a05622a090600b003a81029654csm7004421qtb.31.2023.01.10.18.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 18:37:58 -0800 (PST)
Message-ID: <63be2106.050a0220.1ff9b.80ad@mx.google.com>
Date:   Tue, 10 Jan 2023 18:37:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1856374626068335675=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Fix possible circular locking dependency
In-Reply-To: <20230111012254.3724082-2-luiz.dentz@gmail.com>
References: <20230111012254.3724082-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1856374626068335675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=710752

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.25 seconds
CheckAllWarning               PASS      34.92 seconds
CheckSparse                   PASS      39.21 seconds
CheckSmatch                   PASS      106.04 seconds
BuildKernel32                 PASS      30.40 seconds
TestRunnerSetup               PASS      438.76 seconds
TestRunner_l2cap-tester       PASS      16.56 seconds
TestRunner_iso-tester         PASS      17.06 seconds
TestRunner_bnep-tester        PASS      5.80 seconds
TestRunner_mgmt-tester        PASS      110.88 seconds
TestRunner_rfcomm-tester      PASS      9.18 seconds
TestRunner_sco-tester         PASS      8.42 seconds
TestRunner_ioctl-tester       PASS      9.76 seconds
TestRunner_mesh-tester        PASS      7.38 seconds
TestRunner_smp-tester         PASS      8.28 seconds
TestRunner_userchan-tester    PASS      6.06 seconds
IncrementalBuild              PASS      28.85 seconds



---
Regards,
Linux Bluetooth


--===============1856374626068335675==--
