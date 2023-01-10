Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4024DC46467
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 21:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjAJV5V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjAJV5S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 16:57:18 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CF55DE73
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 13:57:16 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id d10so7085531ilc.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 13:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ODBVc115z0fOK+N9Te8HTPpaRLwffHqpmLFByrnUR0=;
        b=L9nYiNExTgnlWn5oJPioX3huDczr3C8wS6Q2ChFmEf9daweOVIa0eCwLHA/yRwQhTH
         +1pFn3Ly8lHUcqdmVhDHR3SaKoKYpfgaIf5ZIqOTrEh1VsxscsB1tTB4x7RP8ypabCgR
         2MnpU/1W+dNmPSSJo0UDmxHBxh/lXPlQ+O5HfBGnr21lQRLlT5vqg7A2pBWb2V0YNiYi
         rELaGC/Hv6FDoKjHwrMjN1zG5lrA8Jxo41eps9FTdw34IFmwFqmQSJUvjPgNrgzz9xlm
         kqfqn9wrR9yeKHP+um8s+6KlP+Acwya2sRmdP33dhgbd3BlCM4vXXAS2jXFN36LcSjE3
         Pt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ODBVc115z0fOK+N9Te8HTPpaRLwffHqpmLFByrnUR0=;
        b=H4OMBt/R3BuiRHRxueFTSoxiT3fGI01YyE2UXOBTDQJ4bSI6uShdIAzynEG+UQYFH7
         JAjOAwA/A/MFQibFne39SrzfiQhZSvn7g3NNWbn0EtYM85NLxx1ECIERikqgIJCrOd/4
         G6aijAQxSfE5JI4nsnMm3OIG9HaLZ6RH6moi+Bsxy6/nUrhNZzuk3TmJp3HQ6Sj8hufS
         4+tvsGbx/qQ1sg334eMpSGdhO0ZF+pIrCsaVsggRrO4erwb3mUi90QqjWDPBL9GroEqe
         m8CJKFk77klb5YE6wmOqIu/Yc2PeUxQKD+TDX3zf6B+zFra8BhK+/6IR7AXz2PZPzUqx
         z2tw==
X-Gm-Message-State: AFqh2kq01TzRtYw0Fz7Z38c/q3GXIFMWRuug50SE0y4rWX7jEcSgKY84
        +RAEf0YSmcSfQ2H7jr/hudmfMzX56jc=
X-Google-Smtp-Source: AMrXdXsaFtgUlfyVrKBBO9gghSbYNMjcNrcOB4HAIrYspG+XQ/7Ekp9ANP6ou4f5GIl6IqY9Ah3CNQ==
X-Received: by 2002:a92:6a10:0:b0:30d:b08b:259c with SMTP id f16-20020a926a10000000b0030db08b259cmr4822647ilc.5.1673387835916;
        Tue, 10 Jan 2023 13:57:15 -0800 (PST)
Received: from [172.17.0.2] ([40.122.243.242])
        by smtp.gmail.com with ESMTPSA id n45-20020a02712d000000b00388b6508ec8sm3915821jac.115.2023.01.10.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 13:57:15 -0800 (PST)
Message-ID: <63bddf3b.020a0220.404ae.6d7a@mx.google.com>
Date:   Tue, 10 Jan 2023 13:57:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6001924688383950835=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Fix possible circular locking dependency
In-Reply-To: <20230110213034.3629396-1-luiz.dentz@gmail.com>
References: <20230110213034.3629396-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6001924688383950835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=710698

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.83 seconds
CheckAllWarning               PASS      35.21 seconds
CheckSparse                   PASS      39.26 seconds
CheckSmatch                   PASS      107.05 seconds
BuildKernel32                 PASS      30.59 seconds
TestRunnerSetup               PASS      441.39 seconds
TestRunner_l2cap-tester       PASS      16.59 seconds
TestRunner_iso-tester         PASS      17.17 seconds
TestRunner_bnep-tester        PASS      5.83 seconds
TestRunner_mgmt-tester        PASS      111.56 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      8.40 seconds
TestRunner_ioctl-tester       PASS      9.85 seconds
TestRunner_mesh-tester        PASS      7.22 seconds
TestRunner_smp-tester         PASS      8.31 seconds
TestRunner_userchan-tester    PASS      6.11 seconds
IncrementalBuild              PASS      29.04 seconds



---
Regards,
Linux Bluetooth


--===============6001924688383950835==--
