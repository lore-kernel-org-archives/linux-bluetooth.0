Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1115EC0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 23:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjGMXhV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 19:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjGMXhU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 19:37:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2211993
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 16:37:19 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-400a39d4ffcso6060381cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689291438; x=1691883438;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WJoVUlzsxJaf1BVPF0pg44yIS4nPCefhgbAJVCKT4Ik=;
        b=L1u+sp3m9tuGqiqa7z7nwNOPA3dtajNJOJPiLv9IuDlGeXzamiauzun+PFswCxv6tu
         r9Uy0Sa2cG9iMPRBEKf7MvCI7ez31VSz1cr1f4/pwfzTq+5Hc6a6REP0pgqKnxqZx/PF
         nb549WVtJdb1RQwp/s1osk4271GB1UkxskyUHdO6OQSuRftsA8G7xtOmy/VRCwXoLaLx
         1wZq8zygBNLacHkN9AHdPAwD2OEHBBr7UOyL1m6EGDm+mmfyowdzsqQ5csuAY2sk8InC
         TnTguGGd3n4GqfIcePHuT98tqpG5hqlxLAo91kVS8v6DhGJSGyBYyslE9m1Hpr0QkiMf
         dI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689291438; x=1691883438;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJoVUlzsxJaf1BVPF0pg44yIS4nPCefhgbAJVCKT4Ik=;
        b=TF1ezK2iPjXqWjxQA2mxb0pxYJTahg7YrHTRZWenPyjx1yRtM4ymHGy/Uz2z0LmF8g
         UkAaOTZFMv1zFIQLCl/FQoACx5x7SGj1dg2RYhD1XMkwercbgxIJLDk4VaTXIByo+VhQ
         pWLl5lTLb55FzIZdQaKn2knbj88HehV76EVecYbWh7hIn7KoVDleEtSdgvYE2rH0Xv1L
         k32/sNXkHCQ/iiGjsQcmLiq0CP2jhHZt9QO5buExuXX/r88opEbxctyDtpWcf4rX4Zjt
         QcDrQwZxIsM0F6kh4xe43q6wVflVXjC/WGN3hWlqKhVfXVtVOzTIzSEGiwZ8Me6XlKCL
         oi2A==
X-Gm-Message-State: ABy/qLbdxnRxfICwMGuu38e7YIXT0pZe3wrJOoGZZhU+mAhtSBbz9iv+
        lTG2zntSbC13HjUymKUuO+ROjXSs6mI=
X-Google-Smtp-Source: APBJJlGGk2MBbbTpwZ1xdaQfS0kWLHKKiuRdszjrLmy3vGOpX05wDyI48fjx/aDLDDFIXYYRIOtwyg==
X-Received: by 2002:a05:622a:190f:b0:403:a261:6cf1 with SMTP id w15-20020a05622a190f00b00403a2616cf1mr1449416qtc.31.1689291438530;
        Thu, 13 Jul 2023 16:37:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.73.32])
        by smtp.gmail.com with ESMTPSA id s19-20020ac85293000000b004035c1062f8sm3481902qtn.10.2023.07.13.16.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 16:37:18 -0700 (PDT)
Message-ID: <64b08aae.c80a0220.c9ada.dac1@mx.google.com>
Date:   Thu, 13 Jul 2023 16:37:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5969144450378925382=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: af_bluetooth: Make BT_PKT_STATUS generic
In-Reply-To: <20230713224239.2286549-1-luiz.dentz@gmail.com>
References: <20230713224239.2286549-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5969144450378925382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=765461

---Test result---

Test Summary:
CheckPatch                    PASS      2.03 seconds
GitLint                       PASS      0.66 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      33.21 seconds
CheckAllWarning               PASS      35.81 seconds
CheckSparse                   WARNING   40.71 seconds
CheckSmatch                   WARNING   113.41 seconds
BuildKernel32                 PASS      31.61 seconds
TestRunnerSetup               PASS      479.01 seconds
TestRunner_l2cap-tester       PASS      22.34 seconds
TestRunner_iso-tester         PASS      39.90 seconds
TestRunner_bnep-tester        PASS      10.06 seconds
TestRunner_mgmt-tester        PASS      211.52 seconds
TestRunner_rfcomm-tester      PASS      15.32 seconds
TestRunner_sco-tester         PASS      16.21 seconds
TestRunner_ioctl-tester       PASS      16.96 seconds
TestRunner_mesh-tester        PASS      12.55 seconds
TestRunner_smp-tester         PASS      13.74 seconds
TestRunner_userchan-tester    PASS      10.56 seconds
IncrementalBuild              PASS      35.20 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:223:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic blocknet/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============5969144450378925382==--
