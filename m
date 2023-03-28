Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E637FC76196
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 17:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjC1RUO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjC1RUN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 13:20:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B280B46A
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 10:20:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so15841975pjt.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680024012;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CSanx1GOz4GCpq+YLB0sEcHqFmR9X8q7qFCCKLg45Bg=;
        b=VoYcpxgena7DNEdxWJtowi5I+gpUeoMQn+P/aiIvFxr4LiBj6h+q0ax/aRb1cgLcGE
         6ppdXkgQo0+BMPv+NrFjOCiR6r4q6N7BwKQDrGjKvg0/aCZ6TsS7rKaTqj0E/SU918qj
         R+JKqDP42YXnLkurw34haAdmntWO708Ct9j2XRNr/CEGkLKapm6s0b7+PjouljQmE2Ig
         KmNCWHRL7CYnpRoY3A9yC6AmPaQHktl7B54qFPp21AOGYLcZxlMv1X4gQIZONPa0jhtD
         5GuGJ4a+OGvDQw3Yk+orA2isp8YsWXdgqCo09F+wpfQbR/NC+sjWvM5GvF1eHM/l2gjl
         zT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024012;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSanx1GOz4GCpq+YLB0sEcHqFmR9X8q7qFCCKLg45Bg=;
        b=COwn25vDKYZk45bs15llQ2EBoeoKt9LEIbtc8hc+L0kBxqSMJBiIZ1Ch+zkVesD+s+
         NeiojniBALQEy36Eh2mL3Fpvdw1RkZRupD1zi+jG8TFErJmBKkAcus+X/HFoYRivEZgT
         kEVHprvFYMqT5xkWK505hk9AyOaxdee+VEGI8drWtcEkoT/Te9oIvXnRp72XAHkcTz30
         KmEO1R6H5VbqPiEFiYniy3D3pYG/2Z5wSzM1bML/6SyaH+ZIyKgNZS30/gfZU7tmdmqi
         96f0zLIeKzITsFwK840L42L364gpBX6qD3IOtjjg1/jepHHO9xPmHfJvH8CVCK9Nn1ij
         EN4A==
X-Gm-Message-State: AAQBX9clj/OVgVQhv+p+WLEqx0B5eAM6LAUd67t+CSk6eHisVqJ8Co+Y
        SljM5ELC+xVYUHRenRz8CdkvT6Gcp8Y=
X-Google-Smtp-Source: AKy350awOV37YapKnQ4aAvNeozrJUm6T3Hws7ddnCy5PQqKsSIZme7Nm8AkgXv/NBpYaufnNYHEBVQ==
X-Received: by 2002:a17:90b:1b4d:b0:23f:9196:c038 with SMTP id nv13-20020a17090b1b4d00b0023f9196c038mr18836770pjb.37.1680024011914;
        Tue, 28 Mar 2023 10:20:11 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.5.205])
        by smtp.gmail.com with ESMTPSA id t16-20020a17090ad15000b002339195a47bsm6301666pjw.53.2023.03.28.10.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:20:11 -0700 (PDT)
Message-ID: <642321cb.170a0220.3cb3a.b088@mx.google.com>
Date:   Tue, 28 Mar 2023 10:20:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6832050416544143052=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v11,1/4] Bluetooth: Add support for hci devcoredump
In-Reply-To: <20230328094207.v11.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
References: <20230328094207.v11.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6832050416544143052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=734698

---Test result---

Test Summary:
CheckPatch                    FAIL      5.87 seconds
GitLint                       PASS      1.06 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      43.18 seconds
CheckAllWarning               PASS      46.44 seconds
CheckSparse                   PASS      54.07 seconds
CheckSmatch                   PASS      141.49 seconds
BuildKernel32                 PASS      41.80 seconds
TestRunnerSetup               PASS      597.38 seconds
TestRunner_l2cap-tester       PASS      20.18 seconds
TestRunner_iso-tester         PASS      21.52 seconds
TestRunner_bnep-tester        PASS      6.96 seconds
TestRunner_mgmt-tester        PASS      131.11 seconds
TestRunner_rfcomm-tester      PASS      10.70 seconds
TestRunner_sco-tester         PASS      9.61 seconds
TestRunner_ioctl-tester       PASS      11.48 seconds
TestRunner_mesh-tester        PASS      8.38 seconds
TestRunner_smp-tester         PASS      9.89 seconds
TestRunner_userchan-tester    PASS      7.43 seconds
IncrementalBuild              PASS      61.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v11,1/4] Bluetooth: Add support for hci devcoredump
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#162: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 692 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13191355.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6832050416544143052==--
