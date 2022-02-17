Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 22:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbiBQWDx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:03:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbiBQWDw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 17:03:52 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F4B606F3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 14:03:37 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id x3so11049270qvd.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 14:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/RoqlcHM8dRCBr/yGJpVGhW4SwQKVi7//V/O63T1dQo=;
        b=eQbjNAlah8L2t+XpKd6xbts6qbBgE/sRZti0CGSeSnS4M3vQu4ruyulZbVMbUivKt7
         AqrT0tvXUN2bAhshvgV//dCaIGEW+N4Ce3F+q4bIfZCGXoNXi9Bky8OKv5w483VV9EmL
         qWfU9gg4lIbSR2zsLEGwC8quJM61iq/7y1kMZ+psyR6ITSwD0ko1t0qyFtER+9njMBYf
         7nYOiUT1o4DPePJuuvSgceI2hEokPGGSGxAAusYKpOBE2RA5hPDUlNaRZtgXssx0PVNr
         RBRhxQCYgz5nIiIzkcdhBiu2VNaAdB+pBXdu5ZBqCMM3Y64ez6msMXUbOSUb/E3AXUTJ
         JjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/RoqlcHM8dRCBr/yGJpVGhW4SwQKVi7//V/O63T1dQo=;
        b=WwQMnYR3qBNCpPdf+EJcuUc/DXKYrosB8qdR2B3Sbn5Ym4aPMWbrwDVM3aJQtU15WY
         GUIEIXicqDeZh8sdyARxjpuUN432KkYkYiZVM3a4sXz0SjUewk4MpwSHyJGDT1aJ2C5i
         sYIG+uSLogbNf3jiQBV6YGjYtfaaQa4+72nTNy12QtoG/acXyvI5VAf4X5SPGpgJMY/c
         Q0Q9WM0gAfwGudDXcImJBDJYF4k/5T7EWbHoodxkSrZWim/Czyxu1x0LsRdzq9pLZwX5
         hIDeJXlJkNQKGNn5PRrRpB48LA3e2UVux88SyLNIukoeIUAfvkXIxPM2O/xVuNZuVynm
         qECA==
X-Gm-Message-State: AOAM531kbV2V+O7hO1xiGtkv28jpwMgagqi8XtADYOCYgYTp7IKv0qw+
        ITN8fRhgSjzQ5hfhfCrppN5F5gQLcws=
X-Google-Smtp-Source: ABdhPJy7d0tKttV2PcQ2q8thZ2Sn3xw+YMZTLlAD80uLKQAv6yXdpKnxzvu1s6UXDCnYNLtjYtV8cg==
X-Received: by 2002:a0c:e6c5:0:b0:42c:d5f:7e4c with SMTP id l5-20020a0ce6c5000000b0042c0d5f7e4cmr3871447qvn.93.1645135416223;
        Thu, 17 Feb 2022 14:03:36 -0800 (PST)
Received: from [172.17.0.2] ([20.122.153.51])
        by smtp.gmail.com with ESMTPSA id y20sm23409913qta.9.2022.02.17.14.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:03:36 -0800 (PST)
Message-ID: <620ec638.1c69fb81.384e.44a4@mx.google.com>
Date:   Thu, 17 Feb 2022 14:03:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6177634134978283405=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix not using conn_timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220217211038.3064096-1-luiz.dentz@gmail.com>
References: <20220217211038.3064096-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6177634134978283405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615561

---Test result---

Test Summary:
CheckPatch                    PASS      2.07 seconds
GitLint                       PASS      1.09 seconds
SubjectPrefix                 PASS      0.94 seconds
BuildKernel                   PASS      41.71 seconds
BuildKernel32                 PASS      37.32 seconds
Incremental Build with patchesPASS      49.92 seconds
TestRunner: Setup             PASS      648.93 seconds
TestRunner: l2cap-tester      PASS      20.15 seconds
TestRunner: bnep-tester       PASS      8.38 seconds
TestRunner: mgmt-tester       PASS      135.98 seconds
TestRunner: rfcomm-tester     PASS      10.65 seconds
TestRunner: sco-tester        PASS      10.41 seconds
TestRunner: smp-tester        PASS      10.17 seconds
TestRunner: userchan-tester   PASS      8.55 seconds



---
Regards,
Linux Bluetooth


--===============6177634134978283405==--
