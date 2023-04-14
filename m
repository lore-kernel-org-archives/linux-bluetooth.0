Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9128C77B6F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 10:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDNK5O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNK5N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 06:57:13 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1CA35B1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 03:57:09 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k22-20020a9d7016000000b006a43382e5b9so1973317otj.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681469829; x=1684061829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U/JgGzftfi+CvRp1urVSUrt8pEOw11uMYE7AsUcLXPw=;
        b=WqRrfNEXPTS68np6SlAlN38Vb42zOtSWtLShkc5t05njJOK+dWWZZnMu0Yj15UlnZs
         zBZkBT5++ySQEdFf10LWuBs6xJJJ0KtaIem4l0E33hTw0x2+hVnTKu18vHo8LPo14PCm
         mOOsYonSull2mA46Xm4h5Vx+pPO61vcE6Mkhyr+3Qy3Tpg72T6QrcxiaFJbm217OrEjT
         aC4Ta3LqPoATnOO9sbVZ/M5yh6srwXeDwmAPs48TK/Rg/lyuEMgd2hIamGQyfVQ+d688
         eXKetvr9rCyycbk4X3Q7OGSQ5j3mSjcEkDgcbVXivGdXhJ4iRBqCz+YEvMD9qmf285DB
         lpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469829; x=1684061829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/JgGzftfi+CvRp1urVSUrt8pEOw11uMYE7AsUcLXPw=;
        b=kJ3L67Ms+qXQvYxvvIeirB4CD3YfxGmf7M2QTz+YLzY+2z9oC3mc3DFVSTVtKCrEiz
         mc9H3fEhwsNsd6Uc7dsKBdlRsM78KLphvI7akmlhHMeJB8AVnpWHWelEZ1kt3cm4L2M2
         Oxeu2kTyJ3eezqfOpilSZO5TpW/BiuBEEPWnj1MevsJfCTcpUnH80vv1t3HqAPZLwerH
         6USp6ipr17yN3fdwZd29kXKXZTqeHb563FZxs67a3q44cbf6rXuijjMFuagjDpeFcs+D
         gQKYQ37OfZURilpUcpivI+iXNfZsVOsDkI3rVaVqyfAYtnOxXsFgs0f6dxRPbzLVvjJj
         vG6g==
X-Gm-Message-State: AAQBX9eOHysl5ai6R8USKXVCQkhox5Aphm2amszNhp4WUnG4ZDurwgA+
        sIasI0l9T1z1MB0dwCG2EcMG9Gd1yQs=
X-Google-Smtp-Source: AKy350Yr7PcVvLrs0MXsJgrfqlLfDvAAfYXF68baQVS6xHWId3UsqdkZxp+tK60op0ZaR18znPvJ2w==
X-Received: by 2002:a9d:5881:0:b0:68d:3fc8:7c11 with SMTP id x1-20020a9d5881000000b0068d3fc87c11mr4673298otg.12.1681469828835;
        Fri, 14 Apr 2023 03:57:08 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.136.35])
        by smtp.gmail.com with ESMTPSA id r13-20020a9d7ccd000000b006a13dd5c8a2sm1571237otn.5.2023.04.14.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:57:08 -0700 (PDT)
Message-ID: <64393184.9d0a0220.1088.88c8@mx.google.com>
Date:   Fri, 14 Apr 2023 03:57:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7151842551317032214=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, liujian56@huawei.com
Subject: RE: Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"
In-Reply-To: <20230414103006.200788-1-liujian56@huawei.com>
References: <20230414103006.200788-1-liujian56@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7151842551317032214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=739791

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.15 seconds
CheckAllWarning               PASS      35.17 seconds
CheckSparse                   PASS      40.25 seconds
CheckSmatch                   PASS      109.91 seconds
BuildKernel32                 PASS      31.43 seconds
TestRunnerSetup               PASS      457.42 seconds
TestRunner_l2cap-tester       PASS      16.86 seconds
TestRunner_iso-tester         PASS      17.21 seconds
TestRunner_bnep-tester        PASS      5.52 seconds
TestRunner_mgmt-tester        PASS      114.03 seconds
TestRunner_rfcomm-tester      PASS      8.90 seconds
TestRunner_sco-tester         PASS      8.15 seconds
TestRunner_ioctl-tester       PASS      9.67 seconds
TestRunner_mesh-tester        PASS      7.05 seconds
TestRunner_smp-tester         PASS      7.96 seconds
TestRunner_userchan-tester    PASS      5.82 seconds
IncrementalBuild              PASS      29.42 seconds



---
Regards,
Linux Bluetooth


--===============7151842551317032214==--
