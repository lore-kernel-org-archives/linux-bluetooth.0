Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB4CC77B61
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Apr 2023 10:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDJKd2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Apr 2023 06:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJKd1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Apr 2023 06:33:27 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF3030EE
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Apr 2023 03:33:24 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id gb12so3836708qtb.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Apr 2023 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681122804; x=1683714804;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S6OylC1h3oVY53tST5WALZJ6lQxjF1bZi/R7iWS/3as=;
        b=DszNf0UxlzR+YofutKwdKNBmo5tAyqn1tRwG5CwZQ5oRzfq6vzf8ARucjSbdugNV/k
         Ez6vf32Vz599bWqDMYpvbkb+wQG4p3IudzDybe48fR4r9WYq1J9E93N6Nm+emhEbl1wx
         +BCy95C+l8rw5W9UM3t8A0wB8FFZqVEYYzXYh+Va8rNxkmVW8SLx3P+ljlbaFbQe7mci
         hjISn1ujRDy+uiW04KDnqRu9g84P7jAk48nXhNnUccjaqkG4okwnnlbjIgnXJBaqCm6S
         DqD4gibqoLrKSLjxUkMCZjEEUajJ554Q7U7+PEGDU4U34LybEixV0YGZF1R4qvEr5tTS
         GKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681122804; x=1683714804;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6OylC1h3oVY53tST5WALZJ6lQxjF1bZi/R7iWS/3as=;
        b=5QTKE55pWGcai+7YsN+13VnlqNKU2ZYIKLWQVIN5K81z8JRqdDoPDgEAAUM3Mq2LdL
         cdSx1cAH3FgerseOO+DBzD0jtZkxaTz4K/loIS78v3uQ//ykAWKxEBw+DJs6BXqm8cwh
         7gOe981IVgqXjKDbNb58CGWDKp8oHMA01QEpnKhXGQiuN9Kkqi66qqeBq/Zt+eRVFBLR
         RrQmCBcsH0+tkhO5z1L5N1GPEAqpp3xbcPosUeX9EGAdB5MJvPVyvfpc6LxzSBmPxnMm
         8FU3SUP9k4vRFFfpcpPpMJw4dJL8d9IvT+67MpgaIk1TFF3CepF5EYrevDu0C643hCQW
         etSQ==
X-Gm-Message-State: AAQBX9c63C8q1oYgsWL1O67qiGyWldyf8YCbh08F/+fXRz3rYLPTm2Px
        2Dp/57pMFnTzxGxUMYpThM15fLxcUkk=
X-Google-Smtp-Source: AKy350ZW+Cw7YdqY/QgsDHR5m0Nd9U8sQLKp0s3OedSBO3uQlImB+Om+Bm+qDZUT1ro7RHsuXeuRig==
X-Received: by 2002:ac8:5a51:0:b0:3e3:876c:bcda with SMTP id o17-20020ac85a51000000b003e3876cbcdamr12253265qta.2.1681122804046;
        Mon, 10 Apr 2023 03:33:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.17.172])
        by smtp.gmail.com with ESMTPSA id w25-20020ac843d9000000b003e693d92781sm1904597qtn.70.2023.04.10.03.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 03:33:23 -0700 (PDT)
Message-ID: <6433e5f3.c80a0220.3bb5d.5609@mx.google.com>
Date:   Mon, 10 Apr 2023 03:33:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7230396827024844201=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v2] Bluetooth: btusb: Add WCN6855 devcoredump support
In-Reply-To: <20230410095324.11292-1-quic_tjiang@quicinc.com>
References: <20230410095324.11292-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7230396827024844201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=738383

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.15 seconds
CheckAllWarning               PASS      34.95 seconds
CheckSparse                   PASS      39.76 seconds
CheckSmatch                   PASS      108.92 seconds
BuildKernel32                 PASS      31.11 seconds
TestRunnerSetup               PASS      435.81 seconds
TestRunner_l2cap-tester       PASS      16.93 seconds
TestRunner_iso-tester         PASS      16.96 seconds
TestRunner_bnep-tester        PASS      5.57 seconds
TestRunner_mgmt-tester        PASS      115.74 seconds
TestRunner_rfcomm-tester      PASS      8.83 seconds
TestRunner_sco-tester         PASS      8.14 seconds
TestRunner_ioctl-tester       PASS      9.61 seconds
TestRunner_mesh-tester        PASS      7.02 seconds
TestRunner_smp-tester         PASS      8.02 seconds
TestRunner_userchan-tester    PASS      5.84 seconds
IncrementalBuild              PASS      29.34 seconds



---
Regards,
Linux Bluetooth


--===============7230396827024844201==--
