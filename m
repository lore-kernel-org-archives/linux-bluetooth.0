Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557CFEEAA71
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 21:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjINVnO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINVnO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 17:43:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB567270A
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:43:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0d5b16aacso12319025ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694727789; x=1695332589; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ru4xN9cLh1lmJcCF8Wp5i9EZz5IleTMmQ8NV5OvrJ24=;
        b=ZSNLfIR1Z8aaSlGrp09mLtuslFZ1Mk14lV8Ykp1XmpxT1gCaalltc1yZDxuZu/QjKu
         eWvjKEwdD7J5gpPF7yWUBB3LWMvmMrrnDL3mQksFwR7BhuJFc0VEXARJdU0zjh7OLVtv
         dZyrWjPrwFro0kuc+7qIl5NwTZyE7lzkwOXAFix1YPtzIaDU3iAsFz9DNzeyvHXDxNOY
         dHvzEYD7nNDc3QpfxdPenKwQge1OBoFtq1thBBvB//iDIPQPEMRQZoe1NrZUrQJTcpf6
         /kGDfM3anPY950fMpD43UJ3/odfed62szcaMTiMk+UP2glT/36/OF1V6X0X+MRwxwpp6
         RnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694727789; x=1695332589;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ru4xN9cLh1lmJcCF8Wp5i9EZz5IleTMmQ8NV5OvrJ24=;
        b=oBaUvPfS71X+NQ0QgYmnipA1PMS82pEp1rv9v6P/hlWQFmMJlaGEswiiko0CfGeex6
         q0ymQFCV8+7d7AXF3KdjA/vbNg8yILp7+UjlGR2Rl3qL5v/MMduksfb+YFKzxrMJcpg7
         TDhwJDz+eTFlxrb5ty4ZOcxkt820+s1GudfqrgESEMbWOG7jESj/EKaUkPRagZ9pGZ45
         9vJQCx6IsiyaPRTarITh5LmSXVSspfztI16CyDAL6kTVwhuSezOlglWDoQTd9S8ETIhl
         5p9+QMGhI5iEnB23wdYnNXmqj66GxlcWwjyTWPYHXC7GU33KvDpmc7VdMqBLHYCphwm8
         QOFg==
X-Gm-Message-State: AOJu0Yy4s4ZXywcm6VzD6luVeYcZ74tl+bI7D0idZcR+UqdfNhH73O74
        unmEDeks4BlWRa9cSymkZK1AyPJpVLI=
X-Google-Smtp-Source: AGHT+IGQpornEetwuwSTFOx46onZTiG0ALMWVt5vBTMYwl2YDlMeSfHrL/vBqrieNWohpKsuw13o8Q==
X-Received: by 2002:a17:902:7488:b0:1c3:ebfc:5198 with SMTP id h8-20020a170902748800b001c3ebfc5198mr5042562pll.11.1694727789153;
        Thu, 14 Sep 2023 14:43:09 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.244.152])
        by smtp.gmail.com with ESMTPSA id jn3-20020a170903050300b001c0ce518e98sm2022897plb.224.2023.09.14.14.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:43:08 -0700 (PDT)
Message-ID: <65037e6c.170a0220.4be43.868b@mx.google.com>
Date:   Thu, 14 Sep 2023 14:43:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1240748129096018987=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, andrej.skvortzov@gmail.com
Subject: RE: Bluetooth: btrtl: reuse define enumeration values
In-Reply-To: <20230914204404.1253141-1-andrej.skvortzov@gmail.com>
References: <20230914204404.1253141-1-andrej.skvortzov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1240748129096018987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=784337

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      46.04 seconds
CheckAllWarning               PASS      50.73 seconds
CheckSparse                   PASS      56.82 seconds
CheckSmatch                   PASS      152.69 seconds
BuildKernel32                 PASS      44.25 seconds
TestRunnerSetup               PASS      676.26 seconds
TestRunner_l2cap-tester       PASS      36.32 seconds
TestRunner_iso-tester         PASS      85.71 seconds
TestRunner_bnep-tester        PASS      13.89 seconds
TestRunner_mgmt-tester        PASS      275.52 seconds
TestRunner_rfcomm-tester      PASS      21.80 seconds
TestRunner_sco-tester         PASS      25.37 seconds
TestRunner_ioctl-tester       PASS      25.02 seconds
TestRunner_mesh-tester        PASS      18.35 seconds
TestRunner_smp-tester         PASS      19.78 seconds
TestRunner_userchan-tester    PASS      15.20 seconds
IncrementalBuild              PASS      41.39 seconds



---
Regards,
Linux Bluetooth


--===============1240748129096018987==--
