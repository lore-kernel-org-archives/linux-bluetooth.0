Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104C4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Mar 2022 16:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiCHQE3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbiCHQE2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 11:04:28 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926754F46C
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Mar 2022 08:03:30 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a1so16470031qta.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Mar 2022 08:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3gsRRfcty1n5hv8YwMqOrCHerUb+tMyO1FJwojfPeNM=;
        b=lhLWWpLrvwB9GPtcWfJPViU4DpOlPPjlDYSBWQJMbYbu/fqaoybMo6x35+FrFFmk+t
         QbetV40O7rCElGuJ3zD7E7fL/qYdI7so3VW7aublGU54ddnFkeJ0NZ/jSafhc7uRTqku
         DG4KR9394xd1H/E59SN3dHh9rcKTKbzsrR2DTmWwrjX347M6+FTO2i2EbUu4JsZ3wAYx
         MjT/K8eOA4ELK2d8S0MYszQJ2cjN1UrtH6P7FU6ELs5ZNKbjXXSSMbN02kXiP1Fwk/8E
         DJ2Jfj9AmKuPU28+BDSvkMHDZK3cSq4Yd9aoqve2VAPPTCGmTnfi3jnef+dMKtug4zwk
         kyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3gsRRfcty1n5hv8YwMqOrCHerUb+tMyO1FJwojfPeNM=;
        b=6tdWnammhHNB7qJ8TVLckH8ZblcCXZp5JxUW+Pubh+zvSMjrwtoK4dQ5ofHTJPAIRp
         2TrGc1r+O7Mm+WoB0InqmbGs3OQunO+9K4Znor4+tL6ra9JOLUxyp6BNTI+3UAZM0UNS
         LeYCnS41FkLInUb5uPn6r2k4osp6aZTmh9GsjgNfNDWx11ynVcr/SLVzXoW4Dmj7tpwP
         0QAy5MxNyLxihgWO9TYhlVkyxxxPmHGoDmiHFoxKbcC70AJrBgcoqucK1uVLWkCxPvSq
         +WQKH1daPhV8DQmMGnwAfuaUU2rYcIfcRzmJP7eNX7pTPf2iq5c0U8YISHcKPixkmxKS
         k1KQ==
X-Gm-Message-State: AOAM531MwiUYNJXvHVMDZLmQUQhwGgKhM6AQJBFUuKscDsQhqb/FlKVo
        X6iNp1GAtHOAeyzf80szKKr79CQ3agc=
X-Google-Smtp-Source: ABdhPJwOgiYSQ1NBsOO0q3PEtUk/4xeHFb+n3rc7qHcgsux9U2GJoxaBXM/j7wo9pSqUATHGJz3cDA==
X-Received: by 2002:a05:622a:60d:b0:2df:f4f2:c85e with SMTP id z13-20020a05622a060d00b002dff4f2c85emr13883813qta.250.1646755409404;
        Tue, 08 Mar 2022 08:03:29 -0800 (PST)
Received: from [172.17.0.2] ([52.177.3.156])
        by smtp.gmail.com with ESMTPSA id g5-20020ac87f45000000b002e125ef0ba3sm197723qtk.82.2022.03.08.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:03:29 -0800 (PST)
Message-ID: <62277e51.1c69fb81.9ac77.1f85@mx.google.com>
Date:   Tue, 08 Mar 2022 08:03:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7281096726661577437=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tiwai@suse.de
Subject: RE: Bluetooth: btusb: Add missing Chicony device for Realtek RTL8723BE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220308145731.23166-1-tiwai@suse.de>
References: <20220308145731.23166-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7281096726661577437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=621551

---Test result---

Test Summary:
CheckPatch                    PASS      1.59 seconds
GitLint                       PASS      0.96 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      29.65 seconds
BuildKernel32                 PASS      26.22 seconds
Incremental Build with patchesPASS      36.07 seconds
TestRunner: Setup             PASS      459.59 seconds
TestRunner: l2cap-tester      PASS      15.03 seconds
TestRunner: bnep-tester       PASS      5.66 seconds
TestRunner: mgmt-tester       PASS      100.04 seconds
TestRunner: rfcomm-tester     PASS      7.94 seconds
TestRunner: sco-tester        PASS      7.12 seconds
TestRunner: smp-tester        PASS      7.75 seconds
TestRunner: userchan-tester   PASS      5.91 seconds



---
Regards,
Linux Bluetooth


--===============7281096726661577437==--
