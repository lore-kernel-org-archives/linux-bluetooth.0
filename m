Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94AEC7618B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 19:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCNTRG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCNTRF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 15:17:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75DE3B679
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 12:17:04 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b5so6877589iow.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 12:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678821424;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UpU0RljPfIU6YKBYFl774ZiVUhVlWzs5/BN78MZfLZQ=;
        b=ftRH3TIM4Lsr/K75zxuVtnlesR4je0i2Qc+eWSD7Yb875r9kfd8TbQKDSOVTlsnAn2
         fKidMwOq5fM0Gq3HN3rjVOv4hhqEVs2w4BqwCZfjE3ZSjcZA2MsXi0jpHC3YfTNZjSi/
         VcACe6TxguRbHs6PXuYMmsPVnjVQc9SP8bsJzwnY7ZvQ/dQtp3+0dhugfvlf6VOJnb7d
         ZOM51LTSapNSvwK3zYvPqVcFOPmDL5mSWK3i0USBCs3PwFB+dZAVvLkVD75x/AvdQqqd
         JBQw7xpx+hOmpyDnT7TdITdvty0Za3tCWS/1/dYe1nJDlw/cW/V1DdtpkVa+2hPcrfLr
         ixSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678821424;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpU0RljPfIU6YKBYFl774ZiVUhVlWzs5/BN78MZfLZQ=;
        b=t80R91Fl+SzYZqOWwtfobcXDAl5x52s3YPwPAiScUxundx5jZAcqJuYiHgCVaaT6Fw
         VJhuQBo8rX5GBfC1DeLISGV8w6jJSKBd30GGPH4NYAth8+MoU5wmdYeuqALt9zdwpbmM
         EI28xMMEJ/zN00Dmfq2xkoszt4kw3VM58TF78y2XOVozdrhNZj+mVlwdcXx3KoEJowmK
         ZTFImRjieKe5gllaHMPF/sH6ubEAqTquXA69AGG1rmPTxBnQhZoYPEPMsMlJ4tGZ7jCy
         uqf6U3kz14R15r5siQPGTDunPa2M7XKHCU8xKyTjWssWjNFDbv29PfsZ+fPs9e6CTeDr
         ynCg==
X-Gm-Message-State: AO0yUKUhm94VR3FWywF0iBawjmbfsXA9g9Q//AyoejtmZqdF6NPgvPkw
        XFL31tRmzF4ynodkBHAjC0bC8EqTRa8=
X-Google-Smtp-Source: AK7set/v2LmKa7VIn3unucPWp9mJcm3nADU8YoF5J9iZbZH6K6hLEpuL/IdyNZaaZuI90HzfWI0S2A==
X-Received: by 2002:a05:6602:2159:b0:74d:46eb:6a57 with SMTP id y25-20020a056602215900b0074d46eb6a57mr28749167ioy.20.1678821423877;
        Tue, 14 Mar 2023 12:17:03 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.93.2])
        by smtp.gmail.com with ESMTPSA id m6-20020a056602314600b0073fe9d412fasm1046804ioy.33.2023.03.14.12.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:17:03 -0700 (PDT)
Message-ID: <6410c82f.050a0220.e3e55.288b@mx.google.com>
Date:   Tue, 14 Mar 2023 12:17:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0221021770811960098=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: fix Locations, Context to be PACS not PAC properties
In-Reply-To: <3eff7be0f5f2cd5df7585ed2a2dc82bc84ff7f38.1678816865.git.pav@iki.fi>
References: <3eff7be0f5f2cd5df7585ed2a2dc82bc84ff7f38.1678816865.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0221021770811960098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730031

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      26.85 seconds
BluezMake                     PASS      781.36 seconds
MakeCheck                     PASS      10.99 seconds
MakeDistcheck                 PASS      153.30 seconds
CheckValgrind                 PASS      247.99 seconds
CheckSmatch                   PASS      331.01 seconds
bluezmakeextell               PASS      97.69 seconds
IncrementalBuild              PASS      623.45 seconds
ScanBuild                     PASS      1010.53 seconds



---
Regards,
Linux Bluetooth


--===============0221021770811960098==--
