Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26837C77B61
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Apr 2023 13:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDINhz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Apr 2023 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDINhy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Apr 2023 09:37:54 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127A230E1
        for <linux-bluetooth@vger.kernel.org>; Sun,  9 Apr 2023 06:37:54 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c2-20020a056830348200b006a3ab0ba8a2so5685098otu.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Apr 2023 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681047473; x=1683639473;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yHU9x2z3UtKaaX1DhGXiddgo/Y3/2AAsNssxJsR4CFU=;
        b=YE6UnvkNG4Rui/1VbKDpnZaW3oHZEPiHFCt9zYovkj5TpmX4GUpjkitBSrR4mNiOBm
         FCMN2Qr83Xu7KKaTVX8xfzv4ilw80rD968Z0VbDjzNt4CDjUqmWXCbyZWrEdTvSsqpFC
         leXU4Aps+wwzLh7WbUJkqudb8XbPLvv9FhkbWDsQw4S0p+rVZw4J322/dqvn+JOuSSte
         +HmJQZiZD2/WbiXaKfNTv64kmEd6Zb/eMQl8rh7tu4Wspy5XmsK0Iv4U9J3aTI2J6fwt
         o84MEVgI74M90HYbkDM27dn0Zj94lOcC9C806iwfU5pyDtZXDK8DejPMINkFhnO5OEW7
         eNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681047473; x=1683639473;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHU9x2z3UtKaaX1DhGXiddgo/Y3/2AAsNssxJsR4CFU=;
        b=aIi9JkGL+QdcdLuokkTj3D+o9Oi/M+Y5rODgrw8ko1ByzPeMQ4WYq/FxjyNEV2+/lT
         HzJxxFYAGg1g+HJHB7yZToaNPNCGBe5mDs1ih2caix+ePwk3FG7cIBEgP/PPZrQiexFf
         7BVjFHEqgaO+jKSBEumCmBAZdFdNgh/hHAuB9Noo+QVZmotU/Xkv6fLaQY5+WNini9BL
         R3T4lZnuOsRImJLAXBaUTbJG6GZ9BwX3p68/5ch4pNw8EmXRzlMphTL0ajX6DHgtldsF
         7srEDelgPHg3ouCwsuQJP3/FlruzbeNgSVQL0xvgm+7SDglU3NxH+re3PW3gIqUdgUoT
         ag7w==
X-Gm-Message-State: AAQBX9cXfzka+tyh+Z3QZJWg04ISJ804pf5U5oF+Po30DWryyqxQvmQ8
        6LLYkccviCj9Kb2Ud7Hmj+6S+RiyrDw=
X-Google-Smtp-Source: AKy350Zg7YnUaP8VkAK+nWwuWBYbymOlppLAvTS+EmPTqHOmSE9CLTrg+suRupIovCgZvBaDExaHkw==
X-Received: by 2002:a9d:7586:0:b0:69f:8e11:ff36 with SMTP id s6-20020a9d7586000000b0069f8e11ff36mr3784912otk.33.1681047473241;
        Sun, 09 Apr 2023 06:37:53 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.136.39])
        by smtp.gmail.com with ESMTPSA id r20-20020a9d7cd4000000b0069fb87285fdsm3379177otn.59.2023.04.09.06.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 06:37:53 -0700 (PDT)
Message-ID: <6432bfb1.9d0a0220.493ff.d20d@mx.google.com>
Date:   Sun, 09 Apr 2023 06:37:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7402417580774334223=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, u202212060@hust.edu.cn
Subject: RE: Bluetooth: fix inconsistent indenting
In-Reply-To: <20230409130229.2670-1-u202212060@hust.edu.cn>
References: <20230409130229.2670-1-u202212060@hust.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7402417580774334223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=738277

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      41.97 seconds
CheckAllWarning               PASS      45.06 seconds
CheckSparse                   PASS      51.26 seconds
CheckSmatch                   PASS      136.43 seconds
BuildKernel32                 PASS      40.19 seconds
TestRunnerSetup               PASS      557.44 seconds
TestRunner_l2cap-tester       PASS      21.01 seconds
TestRunner_iso-tester         PASS      21.51 seconds
TestRunner_bnep-tester        PASS      6.70 seconds
TestRunner_mgmt-tester        PASS      138.97 seconds
TestRunner_rfcomm-tester      PASS      11.09 seconds
TestRunner_sco-tester         PASS      10.53 seconds
TestRunner_ioctl-tester       PASS      12.39 seconds
TestRunner_mesh-tester        PASS      9.19 seconds
TestRunner_smp-tester         PASS      9.65 seconds
TestRunner_userchan-tester    PASS      7.27 seconds
IncrementalBuild              PASS      36.30 seconds



---
Regards,
Linux Bluetooth


--===============7402417580774334223==--
