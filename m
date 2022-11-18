Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C707C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 08:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbiKRIfM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbiKRIev (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 03:34:51 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685E08EB67
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:34:08 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id x18so2968462qki.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8vMHCRW66gC2dQ2hf1iI8QWGaczjGibipBk7JXrT8P8=;
        b=SRktq0HvykqcBVLdqXUyZvOl3Uod/7zpVcaPGy3UpI8obUbtTpgJfLUrpwsTAvMjbq
         ypLiYCIYWXikiYVmbCK6XPJn53NTWreWgqrAYlt4+jYQ1WlZknqNFB8GxCHFsgiiIFVn
         wIJ6VJFyKjE0r9HraSNNYLd7y2sH2TTcNkKHlXrvd7lE3m/VDsZ0qdBnCsN0pszwWO0j
         e7ztQutLizEi0i8n7BdMZeyLIpucuUh7ruOQpEE/L/0OQOkpjM8dyeDyVj6ME2y/SsWy
         e9SR8Aq0cLF+ca4c6ewOegygkwql5qWxx0YUcCK0dTWY3lV2ij3QMgwAednOJV4HkhfT
         alGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vMHCRW66gC2dQ2hf1iI8QWGaczjGibipBk7JXrT8P8=;
        b=6DL3qjZI1UuIroQNYn1JrCWbMlU3hsVc/GB+kxh4ODWLHN6dQHmwe5l3yixIjONRLO
         e6wQfnKKWO7SU1o3msX3d2VjpejAQtzvxMkIIx1HinYB1o/p1cszXsOAHBNGfnNxkde3
         QtSaJhRI/lEysVO6+RP0HUURsABhCVsJkNWWiSjluk+VVKvnPFPDO3P4OvAqkl247qMY
         mwqa806v4uJTfs8OJuL/dMMKV6RtFilXICe8qmYo4qESRO8r3YvZ7pEVRAIgDVvfTTmZ
         S5Hqh+MjcOiyqxBBcFNKdXzCym5ksn9UVdi4koQXh9ynUzguGtobwwByst7KbfxuMvhW
         33ww==
X-Gm-Message-State: ANoB5pl54N2CcUdOYymQtte//itttJtV4TMmC5xzVAI/XTq1G9XJ8ORV
        OHV8dSBlSj2DArgSSDSX7H8TtBtvlpjAIQ==
X-Google-Smtp-Source: AA0mqf5F4oqNtFz2eQnMjMD98Jjcd6ay5g4yqPliwaqZKnCf4O/vJaREKv4r+WmnkUVmgmtnGjH1Uw==
X-Received: by 2002:a05:620a:2044:b0:6e7:2a1a:e756 with SMTP id d4-20020a05620a204400b006e72a1ae756mr4906783qka.569.1668760447797;
        Fri, 18 Nov 2022 00:34:07 -0800 (PST)
Received: from [172.17.0.2] ([23.102.119.203])
        by smtp.gmail.com with ESMTPSA id ed13-20020a05620a490d00b006eeae49537bsm1943496qkb.98.2022.11.18.00.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:34:07 -0800 (PST)
Message-ID: <6377437f.050a0220.1fc9d.a0eb@mx.google.com>
Date:   Fri, 18 Nov 2022 00:34:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1166180429813319527=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1166180429813319527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695798

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.95 seconds
BuildKernel32                 PASS      29.46 seconds
TestRunnerSetup               PASS      415.03 seconds
TestRunner_l2cap-tester       PASS      15.43 seconds
TestRunner_iso-tester         PASS      14.99 seconds
TestRunner_bnep-tester        PASS      5.26 seconds
TestRunner_mgmt-tester        PASS      102.98 seconds
TestRunner_rfcomm-tester      PASS      9.07 seconds
TestRunner_sco-tester         PASS      8.56 seconds
TestRunner_ioctl-tester       PASS      9.72 seconds
TestRunner_mesh-tester        PASS      6.69 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      30.49 seconds



---
Regards,
Linux Bluetooth


--===============1166180429813319527==--
