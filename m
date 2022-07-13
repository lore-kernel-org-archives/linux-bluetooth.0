Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE8AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jul 2022 07:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiGMH4e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbiGMH4a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 03:56:30 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA539BE0DB
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 00:56:27 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g6so11277789qtu.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MVGW89nKtAHplmAJ+Lx1w9fkc4eeiA0rtEwERswA6yY=;
        b=KJLapxghK5KzxoA6794Pwl68L0HKtQRxCrtm3wDwvAFNtVsfF6W19Kvdso7FvaAbUq
         lcJWVFQM2Cy770xuUwB8LCRaL3+v9QHTWd+Qyh19XjXP4vxxfnjnSLsnYmXRz6qX0jRr
         2yMsgVcuVh4MbIKq0zgUzox4nmjxqQgSCYsMSmUP44wSEKxhQISdsVwgon2yK+gD2SBz
         GwHyoKFwX7DIpID9Xr1vqNhXqNHUMwvFpMF4qcO1U9X31qq84DsyoT0hQE5Jl6wVlwBt
         K8h1S3jPUiod7tgnFDgf+pFs6eazVJLjgQI9Lo7P/YmYs3oa53/sA0fPApqEDKyR864G
         Fy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MVGW89nKtAHplmAJ+Lx1w9fkc4eeiA0rtEwERswA6yY=;
        b=uQoP0UA07TB/hrBNaN1yyNDTdfSsD5nHl4DAohleCPNzkBu0MFqZu0P1XrB6bmsGnj
         Ly6yxAKvsWYeAVajqScLAYODYkDcbcFc8JbfHO25nnY9oOk/FlG/hP3eln4cqKTGz+of
         msj9qnkynCRZ0Bt6ru5cfC0oTm4O26sAVuph5CVQcIiUPTXtQKoBwSPhOngGjTiqct8h
         aVlnshUHjRRs1itB2rTaHkfvfWjqiOtJCq1n0FG0LHmCjL/TZRijVBx4NERuGeU0usr/
         +q1u2OEl52+3bB4CI+VG7Cdux30rL+ZoMwWxzV0TvaOzZopgp+R9kghjJ8bmfbH7FUmW
         4L1w==
X-Gm-Message-State: AJIora+O2bHlTg00N9KadKdA1pBcChAtM878upVZlVdlIvNs8FmOnDAS
        b/uwH30hvug5HdG/V+ngjMxOvKfc91M=
X-Google-Smtp-Source: AGRyM1sPg3eCSdAf71P8U+asYV+YHgRzd1OQdruAy1dsUm+fuiHu3JXnyu5dnHYFzs7zqekDswV1Eg==
X-Received: by 2002:a05:622a:546:b0:31e:b237:8ed7 with SMTP id m6-20020a05622a054600b0031eb2378ed7mr1755121qtx.100.1657698986786;
        Wed, 13 Jul 2022 00:56:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.69.253.244])
        by smtp.gmail.com with ESMTPSA id ff8-20020a05622a4d8800b0031eb643c0f5sm2378013qtb.94.2022.07.13.00.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:56:26 -0700 (PDT)
Message-ID: <62ce7aaa.1c69fb81.f47d7.58a8@mx.google.com>
Date:   Wed, 13 Jul 2022 00:56:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6700396480045585551=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: hci_sync: Correct hci_set_event_mask_page_2_sync() event mask
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1657695194-25801-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1657695194-25801-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6700396480045585551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659174

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 PASS      0.82 seconds
BuildKernel                   PASS      29.89 seconds
BuildKernel32                 PASS      25.76 seconds
Incremental Build with patchesPASS      35.02 seconds
TestRunner: Setup             PASS      429.54 seconds
TestRunner: l2cap-tester      PASS      16.44 seconds
TestRunner: bnep-tester       PASS      5.55 seconds
TestRunner: mgmt-tester       PASS      90.61 seconds
TestRunner: rfcomm-tester     PASS      8.67 seconds
TestRunner: sco-tester        PASS      8.44 seconds
TestRunner: smp-tester        PASS      8.60 seconds
TestRunner: userchan-tester   PASS      5.68 seconds



---
Regards,
Linux Bluetooth


--===============6700396480045585551==--
