Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5ABC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 07:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiKPHN1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 02:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiKPHNU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 02:13:20 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7613420BEE
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 23:13:14 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x21so11120292qkj.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 23:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VLILD5VdFX9qQ6uLBBOqvW9F5g742Y61kauzHubLp4M=;
        b=DUMTM/BsIdMfN6qXJMsmSQnss3YAh8jpBmAjOpgeD2gUYLpm7E9hDKIMrb5VQAEWyZ
         fHDGFjUye8yps3VyX5BtNAT/X8Xeet8599snTzQCjqZROXZ3ysQcekY5DTCGuwzBFco6
         ylu7MbqyKdcv+4Rq+EblbqOSDOBB2zjnW3wlKaueZHxxc0MMh0nTYeVLl0TO75qyLxnf
         pPMzCq3DffHMdoKBH0bAvxwlQgtGFam4sd/q6rRSaXlwcyIb00UyfSeq7O8P9dYaZY6F
         62HoLglWJ0hzNof93WJ1nPeReJkMTlPv4LPkulghMf+wLTtigf3emGNjz3gDcMaLAs/V
         h+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLILD5VdFX9qQ6uLBBOqvW9F5g742Y61kauzHubLp4M=;
        b=CHthS+QYQpPoTLdVXV7PImAHKSbJCTMOWYrb6bll8tpVn+pkZ7KdoTKk5+xZIm2V87
         rygvnKA10e6sOjpg14nk9KxlUQGf153APP46mq+F9qB3uRS1TUOkJiXsqX5RO0tjnMcH
         Un+3WaWZftA8TvA8Ilsw/6oLg6UtLpOILFB6Z3mMWGWXabkdoFidvpj4KEsMGs1dnDpe
         ZpMr/vT+m06maX8JyMyQwxmgaypWDISTlZJM6be+q5iyfIa4ZSz65+QPFsw2ySjf0pse
         vMBd/UTR7JaK4kjUEo0FvGXaYt7U75JxmBfAmKrlsEwjgdaOzu4Gd9O02dUCXRyUD2kM
         x5zA==
X-Gm-Message-State: ANoB5pnF2c9LU+6z0aFem+X/JoRKsf25NTKD0l3bVYQuvsS4A8EdakmK
        5L8ifSplnqcZNvxm2uLfgIKDWQzwu+2qBw==
X-Google-Smtp-Source: AA0mqf4DlC4rPouh5PXr0VrK/W76NwdbhZ9a8fk//0M6UW1L7WGj11EXVSOSB13nAvMmuWxgqDQSmA==
X-Received: by 2002:a05:620a:144a:b0:6f9:ddab:11b0 with SMTP id i10-20020a05620a144a00b006f9ddab11b0mr17956006qkl.193.1668582793419;
        Tue, 15 Nov 2022 23:13:13 -0800 (PST)
Received: from [172.17.0.2] ([172.173.249.78])
        by smtp.gmail.com with ESMTPSA id ff5-20020a05622a4d8500b0039cc47752casm8342086qtb.77.2022.11.15.23.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 23:13:13 -0800 (PST)
Message-ID: <63748d89.050a0220.b0adc.c737@mx.google.com>
Date:   Tue, 15 Nov 2022 23:13:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0127279570933907091=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: Remove codec id field in vendor codec definition
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221116062918.11879-1-kiran.k@intel.com>
References: <20221116062918.11879-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0127279570933907091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695805

---Test result---

Test Summary:
CheckPatch                    PASS      3.39 seconds
GitLint                       PASS      2.01 seconds
SubjectPrefix                 PASS      1.70 seconds
BuildKernel                   PASS      35.36 seconds
BuildKernel32                 PASS      31.71 seconds
Incremental Build with patchesPASS      55.47 seconds
TestRunner: Setup             PASS      528.98 seconds
TestRunner: l2cap-tester      PASS      17.63 seconds
TestRunner: iso-tester        PASS      17.38 seconds
TestRunner: bnep-tester       PASS      6.74 seconds
TestRunner: mgmt-tester       PASS      108.48 seconds
TestRunner: rfcomm-tester     PASS      10.64 seconds
TestRunner: sco-tester        PASS      10.09 seconds
TestRunner: ioctl-tester      PASS      11.46 seconds
TestRunner: mesh-tester       PASS      8.16 seconds
TestRunner: smp-tester        PASS      10.10 seconds
TestRunner: userchan-tester   PASS      7.03 seconds



---
Regards,
Linux Bluetooth


--===============0127279570933907091==--
