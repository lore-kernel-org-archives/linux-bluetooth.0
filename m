Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE162C77B73
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 01:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjESBPp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 21:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESBPo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 21:15:44 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8ADE4C
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 18:15:42 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75776686671so147000385a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 18:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684458941; x=1687050941;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rAq1k6ZN2O9f/nV1obC3dNu0JcUFJG0+do4qzV4g8mw=;
        b=EIWhplZHsg6NhF80r8Eed4Sl6mKd0pxnbhqtNssjJjei+bKF50wlFgH6WfSojxhagf
         rXIOcvlnp+Y6RqId5rDceQOR+Ty4r7WLmpOpuRptpkPcp0GldF08NF/xseV+/bnr/ob9
         IF0yNJK37FefAB6hcpJISHACPwdGGDqbhQdj2Je3untOJRFQq1o14gatHGSOU44a2Q/W
         VYR+UvZ0hXmFVdSbX5yZ1P8g1Bg1j49m+yRqEEdUR5OFn5g5yLnxI5O5p05Uvl+oN2JW
         Wz/undRSWYuj3Vtsy88G7LI9MTEBHradboBB9QGFExeZ7495av1ZcR/C5Qh0/uPIKUvV
         lNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684458941; x=1687050941;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAq1k6ZN2O9f/nV1obC3dNu0JcUFJG0+do4qzV4g8mw=;
        b=OmBMjFPNd6YPkwU9m51savsBmRGYcq3fOGsEJwog0vazT1czRPSAJwKD1jV0AjTi9D
         yfViIQmdzLBbHZPZBbGshP4ZN69yF5/g7NlIsvrhic37qTvqFKTqjXF6wo6Sd120i6+Z
         o/AHyrVJZZBNWaHJYkVsL95UlwykMmjfeiMwCRuccWG7DaAI0jX0kxonbIhxoRgI+sPd
         Ocn7ZeAfMNOR+99XpeOAqY6aA4TzzM5YwRcDM9AEW5Fo6lZEE4UrxlYS580jYY97sbC0
         Xo1aLe6TKK8ry29wfXZsGcdHtTja8+d/aC6K26G0QcA0BvT+xMEf37u67n7K9ZA8WhZC
         s1lw==
X-Gm-Message-State: AC+VfDy4VaJWid5XDfADtuSahmMPgh1Nw+8f10n2ffEUgi78yyYr23I7
        chUwF40ctBZFpI/irhktvaXtjERj/xQ=
X-Google-Smtp-Source: ACHHUZ40gfaZT/DQIwCbeIbcR8zpEbYO4tnOLO77zsvB7gH7GcUUAxZTkcT5xMDz5FVQh0/GcpJ/DQ==
X-Received: by 2002:a05:6214:766:b0:621:700b:f9ef with SMTP id f6-20020a056214076600b00621700bf9efmr1381606qvz.15.1684458941528;
        Thu, 18 May 2023 18:15:41 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.200.50])
        by smtp.gmail.com with ESMTPSA id ct8-20020a056214178800b0061662aefa27sm931852qvb.128.2023.05.18.18.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:15:41 -0700 (PDT)
Message-ID: <6466cdbd.050a0220.8719f.4ccc@mx.google.com>
Date:   Thu, 18 May 2023 18:15:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5124873222107431347=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, minhuadotchen@gmail.com
Subject: RE: Bluetooth: btqca: use le32_to_cpu for ver.soc_id
In-Reply-To: <20230519002544.3695-1-minhuadotchen@gmail.com>
References: <20230519002544.3695-1-minhuadotchen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5124873222107431347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749075

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      38.18 seconds
CheckAllWarning               PASS      41.17 seconds
CheckSparse                   PASS      46.66 seconds
CheckSmatch                   PASS      126.18 seconds
BuildKernel32                 PASS      36.45 seconds
TestRunnerSetup               PASS      526.26 seconds
TestRunner_l2cap-tester       PASS      19.18 seconds
TestRunner_iso-tester         PASS      24.81 seconds
TestRunner_bnep-tester        PASS      6.70 seconds
TestRunner_mgmt-tester        PASS      132.74 seconds
TestRunner_rfcomm-tester      PASS      10.34 seconds
TestRunner_sco-tester         PASS      9.58 seconds
TestRunner_ioctl-tester       PASS      11.34 seconds
TestRunner_mesh-tester        PASS      8.23 seconds
TestRunner_smp-tester         PASS      9.25 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PASS      35.08 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btqca: use le32_to_cpu for ver.soc_id

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (88>80): "drivers/bluetooth/btqca.c:640:24: sparse: warning: restricted __le32 degrades to integer"


---
Regards,
Linux Bluetooth


--===============5124873222107431347==--
