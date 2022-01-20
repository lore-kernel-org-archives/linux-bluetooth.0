Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1601C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 05:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiATFJl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jan 2022 00:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiATFJl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jan 2022 00:09:41 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7DFC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 21:09:40 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id p9so5176747qkh.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 21:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jwLLG5uDrNv9NA0GwXWq7FYXknkLQjstLVmX5BPUR6U=;
        b=PdXIbENUri02/qnX+vU+Q+CK0jx++pVvYRcU+pEZfhmpOIf9gnEnyVAlnf7ZJdfmUD
         vZsqtk0zvAQio+3aEIR/XO6gngRptYP+AsYzXdnK84G/x8mtAr6MuMPMs7lOXsSICNHv
         j58fBDns8CQEybLOyD6wbpTpchQffmpY5JoIBg8gtLO3Puqwv00yrUwkww7dQE44OAZE
         DF3f4lBmb4YRz4hFV4g1CxyjaNN8bRPhiRr/XkGvIluOmBf02DtD/SA2egaWWh2cpWsN
         cCGsEszEwIJk+wvfNa7cA1TdxqiCNo64W4waTs8ru4KDsfxoOnLm7cfNqQWGLDWP3CX2
         qEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jwLLG5uDrNv9NA0GwXWq7FYXknkLQjstLVmX5BPUR6U=;
        b=OxzaFoA/qc6FXKla5prFGyOQeVlN7hoioexr/ajH3tcb/BNRO8Nn7/F2+zkFWMekmG
         CMiRWPGDk8VMM3kKO4cTBc7BTfoFaVrWDQPH0GI6H0wgtBLtXeULl2NmD3CvWgU4cmrh
         38fkTNJuF7OEGZNeTT1FtU9lVjC6LYmgxct/A5pCdtDnq8fAJjIDbuHao39bfzJOKj46
         sj7lGSfet35xqoS1Fph6c3WTOZRmGgybnx1rUy8WAK4NGqMlAJrnfg8afbZx8VW9hhl5
         EMRJejW0SU2LAMz7zwGjIIffdHNXb3/MuD1mgVv9kig1iqp9sZN/XuGjpkUKYjDg5zhL
         elEg==
X-Gm-Message-State: AOAM532dqRoyimcx3WUoJ3jLmYk3EczulzcoB1S33GwliU0u5G/KDqCH
        E18EuZM3nEXsdm4cr1yzg0kEo6nUL55cZQ==
X-Google-Smtp-Source: ABdhPJw4lw5Eiupam9beFSxxnaOa0DXZ3E6FnH2RtARNJSqvZy+Ww8aYBhSPYwsjEuHeAnm+kYL7yQ==
X-Received: by 2002:ae9:ef51:: with SMTP id d78mr23981113qkg.198.1642655379354;
        Wed, 19 Jan 2022 21:09:39 -0800 (PST)
Received: from [172.17.0.2] ([20.110.86.89])
        by smtp.gmail.com with ESMTPSA id u63sm974017qkh.43.2022.01.19.21.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 21:09:39 -0800 (PST)
Message-ID: <61e8ee93.1c69fb81.a2e78.6c58@mx.google.com>
Date:   Wed, 19 Jan 2022 21:09:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4827639375015202265=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM] Bluetooth: Build: Test patch - Do Not Merge
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220108035630.273898-1-hj.tedd.an@gmail.com>
References: <20220108035630.273898-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4827639375015202265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=603721

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      0.97 seconds
SubjectPrefix                 PASS      0.81 seconds
BuildKernel                   PASS      29.85 seconds
BuildKernel32                 PASS      26.35 seconds
Incremental Build with patchesPASS      36.64 seconds
TestRunner: Setup             PASS      459.12 seconds
TestRunner: l2cap-tester      PASS      13.25 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      102.35 seconds
TestRunner: rfcomm-tester     PASS      7.31 seconds
TestRunner: sco-tester        PASS      7.46 seconds
TestRunner: smp-tester        PASS      7.39 seconds
TestRunner: userchan-tester   PASS      6.22 seconds



---
Regards,
Linux Bluetooth


--===============4827639375015202265==--
