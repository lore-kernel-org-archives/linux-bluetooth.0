Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E526C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Apr 2022 12:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358818AbiD2MDi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Apr 2022 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiD2MDh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Apr 2022 08:03:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5384634F
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Apr 2022 05:00:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id fu47so5480075qtb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Apr 2022 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bD3gxFzdmAvEXuCoCFNGMzmXW/zHd99k8bbRUdtaoM0=;
        b=WskkV4GvQiupgl+FnT4peNVxY1IWFBmslX4p+DIMU7OmNA+Azmo2NbZkiS4NGcEGbx
         4Dg25F6gZkbJba+hlX/R9O0soe3qqkhUiYODu2we8GDfxz5UfIha3v59354x1ic28Wv5
         7ioolPd9BQduyrvK/vi2Vb3oWiXQRIsYjCMhF6LN8uM9vEX29mh9w8QBRWccC+7XgQbK
         Bn88u7Do8NKGcOTC0P8lo6D0psuaa+pD9PBeL02Y4BBNmSt15SclGLeCmrP1VvlkjW1t
         St8Awg8ttfqYKYOCVaALm1F0aR1j9aIqCQOy54u54GZNpfBi4WuIYm7Y5PF8LAXwipaS
         eqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bD3gxFzdmAvEXuCoCFNGMzmXW/zHd99k8bbRUdtaoM0=;
        b=H9VYg0dq2EPMoU0jMhv9nc5cipuigrxfzvjBYiiegTukoOhfz+qxPJSng8HKZMZoqE
         grnPaEG17ecXOvqv/IrTBrbgh8koNA++kUIw7UxpP5PjQCx3/59t/CRjQUyA2Jjrgiln
         /Ak/9jRYsqx8f6wP9z9w4DMCH5M2CAf7luZlyjGh4MMReFJa1WJ5XXYhhnVck92Ez6HM
         NTYeCVk1jM1oA7mSzu+nyanMbWvk88OZdQNO1ocBm3FCzAhd+F/4PlGDoDk7WraVoIpT
         uTfH6gUUHVOHPGeOJnYCYiJjzA9onro6R77xeM+CSiTMdYWI5lpsFwDbvzhf27mpP5o/
         ufdw==
X-Gm-Message-State: AOAM533LyReFerYBTFYPqPJ+aPDlckR7/SUEw8TKqvLJRFSgX84Re0un
        bljkfxd+fbWxKqYeh9R1GT3AC7TveTGYWg==
X-Google-Smtp-Source: ABdhPJxHY3FzR4+aFvQkQgUDmXG2x/MaauABGWZGvBn4+ZeRBztlOGwUuTHtoHptIiKqJ/rTqADxTA==
X-Received: by 2002:a05:622a:613:b0:2f3:64b5:82d with SMTP id z19-20020a05622a061300b002f364b5082dmr19283247qta.176.1651233614638;
        Fri, 29 Apr 2022 05:00:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.152.170.76])
        by smtp.gmail.com with ESMTPSA id l5-20020a05622a174500b002f369c846f0sm1652708qtk.74.2022.04.29.05.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:00:14 -0700 (PDT)
Message-ID: <626bd34e.1c69fb81.4e13d.9a46@mx.google.com>
Date:   Fri, 29 Apr 2022 05:00:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0638094853053801494=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_bgodavar@quicinc.com
Subject: RE: WAR to handle WCN6750 hardware issue
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1651228073-1999-2-git-send-email-quic_bgodavar@quicinc.com>
References: <1651228073-1999-2-git-send-email-quic_bgodavar@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0638094853053801494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=636918

---Test result---

Test Summary:
CheckPatch                    PASS      4.79 seconds
GitLint                       PASS      3.01 seconds
SubjectPrefix                 FAIL      1.73 seconds
BuildKernel                   PASS      31.70 seconds
BuildKernel32                 PASS      28.95 seconds
Incremental Build with patchesPASS      49.95 seconds
TestRunner: Setup             PASS      484.37 seconds
TestRunner: l2cap-tester      PASS      17.17 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      102.27 seconds
TestRunner: rfcomm-tester     PASS      9.76 seconds
TestRunner: sco-tester        PASS      9.61 seconds
TestRunner: smp-tester        PASS      9.27 seconds
TestRunner: userchan-tester   PASS      6.42 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 1.73 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============0638094853053801494==--
