Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C82FC54EBD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Jan 2023 02:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjAICiK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Jan 2023 21:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjAICiJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Jan 2023 21:38:09 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217CCA45D
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jan 2023 18:38:08 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id j130so6082422oif.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Jan 2023 18:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y9jh/ycef+3G5tjWuALoc0diTuFr7W+NbiPHKj+q1o8=;
        b=DLlH5vYdKMhQl9kWk6ujeEIYl98yAtLE/vnGvLVAjMkWcFgUqiDj4/poRuM1sWNaNE
         8r4sxAI821E6gMI7zkJZpRJEMc3oGnzd+CNxPZ5nvl2o/zwPL3XhD6QngGnEsPRGIMSc
         ndbyhDqY2OtYO+QkTqt/ZNrrch9n28nKmsPnjm3oNNxOBe8AM7/aa+VG4+uLKsBKiujv
         EclaXQZybW4pqQm9/6vXRJ4rcpk3L7VS2kQw/60Znh/m1KpLm3oLCvFFqd/ci97CG8Kf
         Gc0XeapogXGO0wRcBst9qZ5gqiQRhZZJ0iwMwGWovXLAPSqlKVU7AOJ40p8HtDaMvMTv
         xtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9jh/ycef+3G5tjWuALoc0diTuFr7W+NbiPHKj+q1o8=;
        b=rXF4F0VFxNPMpS9AjrXEXyqBxVwtVM4CQRYjd8YoNDakoH+hnAc6radd5h4SA+EpYz
         PkgLZJHdGZl1weYPB1yrRoOK9HSNpPeJVwX7N2WbJqp+jXRdFgXvCTny9h9qa3S67Aad
         apshUc4wEN4NKFh07vp6ymVsoyc66E3Fhj9Zf6qTdXl/FC1b7Jf33/064r+rdYGDhTos
         4srLg3+7MhuYthtQ2QFzl8t6GwllHFI2TQET7Ie8bd4R3eGGh/ZLqvBZknz5Ho6uNrnK
         G0xOTPtBJj8gWS1peAXMKEv9l8/z6BWGvoLAST1rXKWoulBVpKDsw0bb3ITdy01qnvvy
         0eAw==
X-Gm-Message-State: AFqh2kpN7pI4ynZcFCpR82G3vK6SKIP7U4eyylNr6v0FOu2Z/Ovs99Oc
        BUaZARk+S68i1BHdnn8UV/srd6a71Sk=
X-Google-Smtp-Source: AMrXdXt3xgRGhBcu3qEnY7tKz7QY1m1afKhbksbWFqSgfWd9QEGpFZOiDF7+g5PGxtnrLxzNJCfY3A==
X-Received: by 2002:a05:6808:9bb:b0:35a:6cc2:21bd with SMTP id e27-20020a05680809bb00b0035a6cc221bdmr27043111oig.30.1673231887369;
        Sun, 08 Jan 2023 18:38:07 -0800 (PST)
Received: from [172.17.0.2] ([13.66.72.33])
        by smtp.gmail.com with ESMTPSA id bg31-20020a056808179f00b00363b5a6bc9esm3369562oib.12.2023.01.08.18.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 18:38:07 -0800 (PST)
Message-ID: <63bb7e0f.050a0220.4082a.9a36@mx.google.com>
Date:   Sun, 08 Jan 2023 18:38:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0426561017546014440=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, shaozhengchao@huawei.com
Subject: RE: Bluetooth: hci_sync: fix memory leak in hci_update_adv_data()
In-Reply-To: <20230109012651.3127529-1-shaozhengchao@huawei.com>
References: <20230109012651.3127529-1-shaozhengchao@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0426561017546014440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=709918

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      38.84 seconds
CheckAllWarning               PASS      41.58 seconds
CheckSparse                   PASS      47.14 seconds
CheckSmatch                   PASS      125.03 seconds
BuildKernel32                 PASS      36.81 seconds
TestRunnerSetup               PASS      530.67 seconds
TestRunner_l2cap-tester       PASS      18.93 seconds
TestRunner_iso-tester         PASS      20.55 seconds
TestRunner_bnep-tester        PASS      6.73 seconds
TestRunner_mgmt-tester        PASS      130.79 seconds
TestRunner_rfcomm-tester      PASS      10.78 seconds
TestRunner_sco-tester         PASS      9.96 seconds
TestRunner_ioctl-tester       PASS      12.30 seconds
TestRunner_mesh-tester        PASS      8.37 seconds
TestRunner_smp-tester         PASS      9.40 seconds
TestRunner_userchan-tester    PASS      6.94 seconds
IncrementalBuild              PASS      34.65 seconds



---
Regards,
Linux Bluetooth


--===============0426561017546014440==--
