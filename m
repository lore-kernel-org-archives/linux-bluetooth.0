Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E01EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 12:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFSMn6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjFSMns (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 08:43:48 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AA81991
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 05:43:21 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1a9ae7cc01dso2085207fac.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687178590; x=1689770590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zjpWbmglcjMZ3Iwlv4RFx5OifgEQXXcBsXm1NzVWLMI=;
        b=K7i22ASrj7+P6QjxznoSm819SW/BtgdPH9ZuatOvSJ3UeD0bvMaUBkwV5keClXlnKq
         q4eaUehxLX6DoyCNH+R86Xe/iK2MUQ+qHKQ3cO8wf3QmEJbav9mFI27ZB8C3gya17Fln
         4GB3UqiU/VD1O7rn98STVu9JCw/reQ7Pfc425z1A4khzaG0KAQg08FJv+JHp9PWvEuBO
         g7IXJo1cGCL07VR0Z5oqqjNEVVeuPyrwOB/T+YhEN/2t0qIOCA0EV9anJk3jzxQYHfd8
         3gwNca6SWdgdTC+OaXk8cb6+i3DzBA3C2yZlesaCFvVNR44pfHkzJEU5QxSYRmWPDGeK
         Wugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687178590; x=1689770590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjpWbmglcjMZ3Iwlv4RFx5OifgEQXXcBsXm1NzVWLMI=;
        b=Ig4Aa0BKZSlCWzYz+5UDEezZcIDTouR2KDcVQMdxtuxvshsUxOCCgfD8IVx3+oyNni
         nKsjlj5GM2ZFqQuxCgf4Ep2yqV0WyTRYadPJ5eRoWjVrNtpA1x3sVICHxFpIKY0kYrzI
         7nKHRtMVJC0SJZbU65cOo8FPq5EnGDBOMKZevgYr6JY2CTxD4s0carPjmnR0Y0YkHhG6
         wPCIRVrv/py3LFTDCHP0uqWgvhyTgcWE2/3vrmcuzISSDDVcVpwGC2eLuAr5b2lq7C9N
         jGn0JcXuDwzBqsbKt3GBU8bEQpcLdwTjiPIyh9DPSWaLkYuwwphmVcLwTLiP2YcQ57KZ
         LmBA==
X-Gm-Message-State: AC+VfDyLHog5+KPrEKGkn2L0rMD7rs6NTPizLSQ6CPMA468Yg+h+j1M1
        lXkLYbk9JlPqTbgNy+vePtV1l1Ldm1o=
X-Google-Smtp-Source: ACHHUZ4z6o4iWJijtnmXw4dZ4ArpuuBhAGGKRGEeQibN6Iq+tyYmT3KCY8tHnIeClXGkR5Tj5NXUJw==
X-Received: by 2002:a05:6870:56a8:b0:180:857:d47d with SMTP id p40-20020a05687056a800b001800857d47dmr5967856oao.57.1687178589698;
        Mon, 19 Jun 2023 05:43:09 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.219.149])
        by smtp.gmail.com with ESMTPSA id i4-20020a4adf04000000b0055e2127ea72sm2176340oou.34.2023.06.19.05.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 05:43:08 -0700 (PDT)
Message-ID: <64904d5c.4a0a0220.85dae.7d07@mx.google.com>
Date:   Mon, 19 Jun 2023 05:43:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1475738193030027342=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, peter.tsao@mediatek.com
Subject: RE: [v1] Bluetooth: btusb: Add support Mediatek MT7925
In-Reply-To: <20230619120053.7780-1-peter.tsao@mediatek.com>
References: <20230619120053.7780-1-peter.tsao@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1475738193030027342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758356

---Test result---

Test Summary:
CheckPatch                    FAIL      1.34 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      32.91 seconds
CheckAllWarning               PASS      36.02 seconds
CheckSparse                   PASS      41.64 seconds
CheckSmatch                   PASS      111.39 seconds
BuildKernel32                 PASS      32.09 seconds
TestRunnerSetup               PASS      455.16 seconds
TestRunner_l2cap-tester       PASS      17.26 seconds
TestRunner_iso-tester         PASS      23.51 seconds
TestRunner_bnep-tester        PASS      5.71 seconds
TestRunner_mgmt-tester        PASS      117.37 seconds
TestRunner_rfcomm-tester      PASS      9.18 seconds
TestRunner_sco-tester         PASS      8.50 seconds
TestRunner_ioctl-tester       PASS      9.86 seconds
TestRunner_mesh-tester        PASS      7.18 seconds
TestRunner_smp-tester         PASS      8.29 seconds
TestRunner_userchan-tester    PASS      6.02 seconds
IncrementalBuild              PASS      30.51 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: btusb: Add support Mediatek MT7925
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
Add Mediatek private data in hdev to record the device for handle MT7925 flow.

WARNING: 'infomation' may be misspelled - perhaps 'information'?
#86: 
The infomation in /sys/kernel/debug/usb/devices about the MT7925U
    ^^^^^^^^^^

total: 0 errors, 2 warnings, 151 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13284386.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1475738193030027342==--
