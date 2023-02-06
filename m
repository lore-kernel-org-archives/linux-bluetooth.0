Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE85C05027
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 07:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBFHc6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 02:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBFHc4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 02:32:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A5D619C
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 23:32:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w5so1205838plg.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Feb 2023 23:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/IA8e8pV9iPZ/SKtC7wzYKa75s/o6AqcmaAk32R+Zhs=;
        b=pTEp+jmxHFvzH4qoH9C4hH5NVH8+o2Avl/bJ27L1wTCLsIvjriQ5NZ8yjuIDpIQqIn
         svStfycpZAULNA3wwT1PqXj7KB4/QFVZ8VLeE3SfMXb7ME8LOUI7iAyTHAboHQwUqzk6
         APe/hsKVALscg2imFBVb79IraA1PG9nUXyYE1mNulqSLlXfMy2mrDjOAPaqJ+9uQSRt8
         UHHU8x2WxDHr2jLO0EUEBzD+QOqGQaXp4PovoEwffMfeR41CqPwJr1xHzraR6bwiAqFF
         SMQYG9Cg90n9by9aTF6Py/bKGQXuhTKmDGRZ3QjhPue3JjSKwuNcX5/Ap3yXODrQCDBQ
         0mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IA8e8pV9iPZ/SKtC7wzYKa75s/o6AqcmaAk32R+Zhs=;
        b=iQLESbrzov11JevgM8Bj1bdViX+Arb0MiEKrq+IQlawRX1LtsNWrwj/+fzcn49Z4OL
         44D6vdVn6FvNIhAh/6VklpAtLAyTwpy3dFHnCbXP9XmhtQE+zpDJu0J5g/bK6EsihCGA
         SKqEwVOa0RhQSI3piEWiCMkKQ6T2bGldYN0GfpN+XoFQn6AtgQqhbPQMHumLQffGpIBQ
         Rhbo22nkXmvBspG9/BlUKfPVHiZ52Dp+CE//MW1OtCSSmWrmPDhQvDOZfjkHAPY2UDOY
         +mkwpmxbOT4Jw13vgKbBVB/f5Z/uZrySibmXXMVkD7fwSPvEol+3wtewGqbWBtm7up/A
         xnBA==
X-Gm-Message-State: AO0yUKWG5OOqkYf1+TiGizwUWvi/fvFZe7IuXeYTfThL3CLv97v3mnvI
        LppJeiakZTD8SGTth0ImVgHKCFOCt68=
X-Google-Smtp-Source: AK7set+5RBKXAe895zlAgyCIR96GtgEyPsZB7BP6eBFnZ6XEovGPi8QDFAcC+xY0qO2Ec9tHK6xFEw==
X-Received: by 2002:a17:902:f392:b0:198:f0ec:18ad with SMTP id f18-20020a170902f39200b00198f0ec18admr6086032ple.60.1675668774434;
        Sun, 05 Feb 2023 23:32:54 -0800 (PST)
Received: from [172.17.0.2] ([20.172.43.81])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d70400b00198d7b52eefsm6079304ply.257.2023.02.05.23.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 23:32:54 -0800 (PST)
Message-ID: <63e0ad26.170a0220.5b1d3.9c2e@mx.google.com>
Date:   Sun, 05 Feb 2023 23:32:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2127278208470477037=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3] Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)
In-Reply-To: <20230206065144.28322-1-kiran.k@intel.com>
References: <20230206065144.28322-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2127278208470477037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=719011

---Test result---

Test Summary:
CheckPatch                    FAIL      1.62 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      31.77 seconds
CheckAllWarning               PASS      34.63 seconds
CheckSparse                   PASS      38.56 seconds
CheckSmatch                   PASS      107.45 seconds
BuildKernel32                 PASS      30.17 seconds
TestRunnerSetup               PASS      434.62 seconds
TestRunner_l2cap-tester       PASS      16.45 seconds
TestRunner_iso-tester         PASS      16.84 seconds
TestRunner_bnep-tester        PASS      5.40 seconds
TestRunner_mgmt-tester        PASS      108.59 seconds
TestRunner_rfcomm-tester      PASS      8.62 seconds
TestRunner_sco-tester         PASS      7.92 seconds
TestRunner_ioctl-tester       PASS      9.25 seconds
TestRunner_mesh-tester        PASS      6.83 seconds
TestRunner_smp-tester         PASS      7.91 seconds
TestRunner_userchan-tester    PASS      5.68 seconds
IncrementalBuild              PASS      27.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#92: 
< HCI Command: Intel Configure Per Platform Antenna Gain (0x3f|0x0219) plen 12

total: 0 errors, 1 warnings, 165 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13129360.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2127278208470477037==--
