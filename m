Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157EFC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 23:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCFXFX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 18:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCFXFW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 18:05:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EE64740D
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 15:05:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x34so11493721pjj.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Mar 2023 15:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678143917;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OAReU7eMGT5UQIfT55btaEKiLuDYS11ZaYd1whObDhs=;
        b=oU0a0ww9e8PrECpGcEZzMhG/TnAIINZQMH3awFnG/TKavDzZVAJ7HYhQOn+6hm/81o
         iBXMoXnNCWz4OvJeHMwo7XZE9tsT9utS/KoN8Vxy5EE15EvFqV9P/CEb3rWy3Sx0L9SV
         Krm+KnIQRGpENU3BTWTMxkT4MRrRce0PSWvPwR8JQreXR3T9scYgxbYq5UO7H4aIS9Lt
         1o+0DNf0zXQNP9Kg1Bol+yfEcU1WkctUe8+2maxYJ+RWx84dCeT7SQFV1MUBk5eaE5T6
         ZyGa4S/3ZtcTJqqFkVz8GR6AY1W6RTDoru4ewiVLJsDipOZH3L0UTGWetR4DvOn4bulm
         JL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143917;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAReU7eMGT5UQIfT55btaEKiLuDYS11ZaYd1whObDhs=;
        b=kaB8PMhHZ4U/TqYIAcMiczVDDgwEUfGZMDPUDxaaTnF463Eq2VQAQLmV6e9Ao1bJb6
         kJawJyWg0pp4NfFOyvxOQcF8q89DbAagKzcEjuhCed5im44ulVmy1AnOsKVBpsRt6osS
         4lTKNUBMRuxKy8lW02jEaGTrV9wRZzXhDyjnsWFf5thWJdlMt9pK91t8ag+5nTc6a4L6
         fEmMfDMYTZMcMvxE+AGT1jIDWTiCWZZ6p1qOcFNFjP9FYCeXE63iQ772LQnFkbM0GSiR
         UhdB4ffp+Te247HEBLjXgMtA2GMIq4uXjzxMbhbW9CfYKOYyjF9JTsvoWPpQe9+a00un
         7rpg==
X-Gm-Message-State: AO0yUKV+G///bHD4M+Zq+NuJ2OLuoxkyOZyZuVYMZi/OPSdKYGy5yGxW
        wbQiKYglHVa7rmxr5bl8Ol4dp3qRyog=
X-Google-Smtp-Source: AK7set87rHAq8uofaFFsVV9Zm7C9Q3+u7c6j2CnMdBDuhooIgO62UfYX2qsbQuzevWZVrL9H2u1/Aw==
X-Received: by 2002:a05:6a20:3a97:b0:be:8c7e:4dfc with SMTP id d23-20020a056a203a9700b000be8c7e4dfcmr11366822pzh.20.1678143916998;
        Mon, 06 Mar 2023 15:05:16 -0800 (PST)
Received: from [172.17.0.2] ([13.88.100.113])
        by smtp.gmail.com with ESMTPSA id n127-20020a634085000000b004e28be19d1csm6748279pga.32.2023.03.06.15.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 15:05:16 -0800 (PST)
Message-ID: <640671ac.630a0220.c86c.ca01@mx.google.com>
Date:   Mon, 06 Mar 2023 15:05:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4248422542824810191=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: Bluetooth: Remove "Power-on" check from Mesh feature
In-Reply-To: <20230306223221.536377-1-brian.gix@gmail.com>
References: <20230306223221.536377-1-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4248422542824810191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727113

---Test result---

Test Summary:
CheckPatch                    FAIL      1.05 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      43.10 seconds
CheckAllWarning               PASS      47.38 seconds
CheckSparse                   PASS      52.48 seconds
CheckSmatch                   PASS      142.54 seconds
BuildKernel32                 PASS      41.20 seconds
TestRunnerSetup               PASS      590.44 seconds
TestRunner_l2cap-tester       PASS      19.97 seconds
TestRunner_iso-tester         PASS      23.30 seconds
TestRunner_bnep-tester        PASS      7.69 seconds
TestRunner_mgmt-tester        PASS      142.76 seconds
TestRunner_rfcomm-tester      PASS      12.07 seconds
TestRunner_sco-tester         PASS      10.67 seconds
TestRunner_ioctl-tester       PASS      12.58 seconds
TestRunner_mesh-tester        PASS      9.36 seconds
TestRunner_smp-tester         PASS      10.42 seconds
TestRunner_userchan-tester    PASS      7.90 seconds
IncrementalBuild              PASS      39.43 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Remove "Power-on" check from Mesh feature
WARNING: 'dependancy' may be misspelled - perhaps 'dependency'?
#85: 
Fixes: Unintended Bluetooth startup order dependancy
                                          ^^^^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13162455.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4248422542824810191==--
