Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FDBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 04:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiKVEfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 23:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVEfE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 23:35:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D825A20BE8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 20:35:03 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g5so3748414pjp.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 20:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R5aG/wEYfONl7SAZel1ouTBpW212i/fTkSIvu25VyPs=;
        b=LgBjoep7UMLQL+kXdV3ECUrDt79DZ+dcg5GQ3HJuLfygbPC7FTynV90rBIT4e9Pwq0
         4D3ygT+alH/4A8lfFPe6RutSheC+vJ5SBmLuCJO23gIktx4+nFFdXeLBayF31mBr3J/w
         xsHlq4BBu1xiiAaU0gG1O5/cD8dKUo8vnD9Q7QZCRa7FRmqLGe/sVQuHmMbWSIJDDmrZ
         U8Egz1eOzdcxFU3dIhKPQqWChXnb7JhjzSfQ97lDxTMsfSQptqtpEPAX1bYzscVi/iAl
         B4GfcN8z4u1BtBEH8ivlnyGbrGthZOpE9hqaXmonuk5GrCgrZwiRvsVM47KZta6jLlIQ
         sclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5aG/wEYfONl7SAZel1ouTBpW212i/fTkSIvu25VyPs=;
        b=es9Ibij5/id234Fye3bHbKKZRoG7EGt4ggcpesEjsOuQzY1SXZ7tjfln5r7HlbFfss
         w4kqx6YIvHAicJVXViMW44On7yNoEUPkN55/MR7gPKSIQYtBQYd5a9qhwCaz+B5y5pgF
         K7BDeOqSl2oP6VMpjAuxoHegnLo3CRnmJ4WNPdSlLoCPA/qbEnaV8Tj3/777Zhgq6vhn
         qdAHYV2vmvBTC9YfX7FHAtwb2SLOIhbMnyaB4WWMboDn05Ng6/5kSDSzX9R9NMA5yJA2
         fkyZDM0bXzwZzcCkLsUMowLpX3b0ce0ZB1gFFXvFsROyJafLYM7xc5XLjlMAbPoMdAFw
         Yvaw==
X-Gm-Message-State: ANoB5pll+vRM2Cz/nGerQcfNBngwfDZ8gkU26/noShweimQ3YZpwikt6
        Wj3BQ1ayS30wZKIB9V/7zQc7EyuJFFk=
X-Google-Smtp-Source: AA0mqf4iBnk7xQLYDxCrTRJLZr2iYgTFDUwusIiyEAPpvtDzESpMM1jWBUt24uSwma5eRHUpZ+5BeQ==
X-Received: by 2002:a17:90b:23cc:b0:218:c83e:476b with SMTP id md12-20020a17090b23cc00b00218c83e476bmr3491433pjb.40.1669091703166;
        Mon, 21 Nov 2022 20:35:03 -0800 (PST)
Received: from [172.17.0.2] ([104.42.58.42])
        by smtp.gmail.com with ESMTPSA id c191-20020a624ec8000000b00571cdbd0771sm9515750pfb.102.2022.11.21.20.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 20:35:02 -0800 (PST)
Message-ID: <637c5176.620a0220.6f57.eb88@mx.google.com>
Date:   Mon, 21 Nov 2022 20:35:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2279831115815188409=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yuehaibing@huawei.com
Subject: RE: [-next] Bluetooth: Fix Kconfig warning for BT_HIDP
In-Reply-To: <20221122034246.24408-1-yuehaibing@huawei.com>
References: <20221122034246.24408-1-yuehaibing@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2279831115815188409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697915

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      36.21 seconds
BuildKernel32                 PASS      32.77 seconds
TestRunnerSetup               PASS      466.59 seconds
TestRunner_l2cap-tester       PASS      16.68 seconds
TestRunner_iso-tester         PASS      17.23 seconds
TestRunner_bnep-tester        PASS      5.85 seconds
TestRunner_mgmt-tester        PASS      112.07 seconds
TestRunner_rfcomm-tester      PASS      10.06 seconds
TestRunner_sco-tester         PASS      9.36 seconds
TestRunner_ioctl-tester       PASS      11.30 seconds
TestRunner_mesh-tester        PASS      8.08 seconds
TestRunner_smp-tester         PASS      9.84 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PASS      35.96 seconds



---
Regards,
Linux Bluetooth


--===============2279831115815188409==--
