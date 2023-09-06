Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD779EB8FDD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 14:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbjIFOhP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjIFOhP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 10:37:15 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA7198A
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 07:37:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7926a450a0aso145643239f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Sep 2023 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694011029; x=1694615829; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0wHYEKNwmh4wpopXU4LOum0wMDEgRCaALbF76ltYGbY=;
        b=kKtO+x76JyzXOj8SKO2qzVbDAY5wdf3LL1NEFQ2Wbrc9G8LZLiGgn9LUcNVrIVDMzf
         ghN3l5kiMZ7vnGkQvjnZC0GHXq6W4sPJWEluMnRZAoqspXuoNoymoP++M9TY84FaElit
         E/uMvIQ1pFjOJmYIOcOnL4lBhWPDM785rcZXVx7BavBDDO92vKvGOw649HHqXt+245aH
         hNo/4D+qErO4jNsLdhzmMO0dL/wAaiqLfoWfI5d4vWafwR7EJlmnChfcuB/c8dOQcQJN
         BhYsSI5J44OiflH6YKnPp1jLUIze0AoTxBUVzS+IKrXinXRZz4nPmOz7Vc5bl7vxYg8W
         7W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694011029; x=1694615829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wHYEKNwmh4wpopXU4LOum0wMDEgRCaALbF76ltYGbY=;
        b=lfxUvCheziqAgCqKFZtb2dIsYi2kueRfs9kzPXqfyrK0m9SXNMpJG/beMBhrWWujC6
         PjNwP2juiwhj7sWi/qIOUk0Fd3AmtCjfEmndtJ2/FUdwtTbTcLS/y8aEU03IlwoNxpxk
         sZWD6onFzOY2BPNHRJ3ewDYAuAjNnmb0m+7kyBOempAj6+v8kJ+8xw07nGQKKpYOJpHS
         2Fw/2SNXMC3YY5yukLwqEPndQqV2K5kBIPg31Jfn0qNdW7Qy4BaPl2nOAJdAoKd2ry8h
         4HK/ylV8PP+7JPA6B5ybTLu7ROJUxTxfP8nGo3cw087Wa7XOxH6sErr5yFcWTOXmYt3j
         PjHA==
X-Gm-Message-State: AOJu0YxuViK4SkXqGT396+ZWqTQ2YDuGZwqkCwLD3LPMXXD/yMORZVNx
        yh4npDZmK/oOVzIqIodPKSw3MUh8c+U=
X-Google-Smtp-Source: AGHT+IEm25SPG4VqEMJb7HXAnjHaNn/xPUOVryHZ+u+hv1Qa/nvQHxpXlYhRyZaE9dRdt/hI26Cahw==
X-Received: by 2002:a5e:aa03:0:b0:792:9406:a453 with SMTP id s3-20020a5eaa03000000b007929406a453mr17684121ioe.14.1694011029137;
        Wed, 06 Sep 2023 07:37:09 -0700 (PDT)
Received: from [172.17.0.2] ([13.67.150.244])
        by smtp.gmail.com with ESMTPSA id z9-20020a02cea9000000b00430996b3604sm4882108jaq.125.2023.09.06.07.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:37:08 -0700 (PDT)
Message-ID: <64f88e94.020a0220.5c5e3.52f0@mx.google.com>
Date:   Wed, 06 Sep 2023 07:37:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6914910345622312427=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Fix BIS cleanup
In-Reply-To: <20230906135954.9165-2-iulia.tanasescu@nxp.com>
References: <20230906135954.9165-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6914910345622312427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782008

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.79 seconds
CheckAllWarning               PASS      36.51 seconds
CheckSparse                   PASS      42.30 seconds
CheckSmatch                   PASS      113.23 seconds
BuildKernel32                 PASS      32.19 seconds
TestRunnerSetup               PASS      491.47 seconds
TestRunner_l2cap-tester       PASS      28.54 seconds
TestRunner_iso-tester         PASS      50.90 seconds
TestRunner_bnep-tester        PASS      11.24 seconds
TestRunner_mgmt-tester        PASS      226.03 seconds
TestRunner_rfcomm-tester      PASS      17.05 seconds
TestRunner_sco-tester         PASS      20.13 seconds
TestRunner_ioctl-tester       PASS      18.93 seconds
TestRunner_mesh-tester        PASS      14.16 seconds
TestRunner_smp-tester         PASS      14.98 seconds
TestRunner_userchan-tester    PASS      11.83 seconds
IncrementalBuild              PASS      30.66 seconds



---
Regards,
Linux Bluetooth


--===============6914910345622312427==--
