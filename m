Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02634C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 15:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJKPd2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiJKPcs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 11:32:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06AEB3B3C
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 08:22:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q9so13070878pgq.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UhFhl+S8MelDuY5YVWiIJxgubDB0Zf5ST6oJZkzOYtg=;
        b=MoDRDv/G2xnv0vkJmBg7uvPunFdi5+X2PeV1va7aNNbfayX8FouRzaAjyKGE3AANn2
         4n3QBovyWwYPreOaGecw2UnrzwfFufnX+gDFrX+t0ofX38yACrJ8QPtxswPQ9S8s+PzK
         mtXokUHMxUbBkKbiqywuUIRgASvP0JXr4kg11zwF7rPKpbHMRBwkGUhGvCn9MpDoee99
         opikDAlN4PJp0AeU+Hb/OOBIDkvs31cN0bhws4/+wzEXx4v2h3OswiaK7CgApbkZJQD1
         XWJ963+40/COjFdOX5L9xoAQEbHEuN8VM20UZqA7Ngs2oMElPrYs0463jki0D1QHRTuX
         qmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhFhl+S8MelDuY5YVWiIJxgubDB0Zf5ST6oJZkzOYtg=;
        b=DPQm//fn949PW6WaFR4mhK1yigoJ55WqYq08Qownfnshl7pxt5C+e69yxjT8yu7Ncb
         fDMi/bbfWAwbX0ehUOvCgUWvX4YUBa+u9H2bLp6FFxkWbjFeCgjNzzh25SQUYEe1bfTC
         qMALbhfKRtMeokR5T1fpaG3mvMVrDx5rMZ4tmFQ0eLTXUOvoM42Ji0Qj/s3s7ocbrz/a
         o5qvutyUSBCiYJvzJ1XbZziOMW888eGs+A7/rYH/Eidd/fE+3Jgp8CxIUXKci9tvwVtX
         LjtqyJHqaiCGCEZ4gz5EJIbsSsqWeC+jA3L/9X/JW5bPBCtS07bFfCO0rkekHKt9tKch
         zFmA==
X-Gm-Message-State: ACrzQf2WmMaOs6jPuhph23T2Xr4uwbFfffslLsonR8N2EFx1Mo0pF9Vb
        NGD3qZ7Jov9bt0UAbuaR0tHwYU5J3Kw=
X-Google-Smtp-Source: AMsMyM6z+W5vQYrPfljR5P5IrJF6KVCHwa0NUDMLv1RnCTl8sRHeKDFWGHeBIHBi/SHriuqWMCwZ7A==
X-Received: by 2002:aa7:88d6:0:b0:563:9fe9:5da8 with SMTP id k22-20020aa788d6000000b005639fe95da8mr6157335pff.74.1665501742009;
        Tue, 11 Oct 2022 08:22:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.155.123])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b00172fc5b0764sm8648837ple.270.2022.10.11.08.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:22:21 -0700 (PDT)
Message-ID: <63458a2d.170a0220.646dc.e7de@mx.google.com>
Date:   Tue, 11 Oct 2022 08:22:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5282328818321565329=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@loytec.com
Subject: RE: [BlueZ,v3] mesh: Keep cancelled SAR data for at least 10 sec
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221011140612.2478-1-isak.westin@loytec.com>
References: <20221011140612.2478-1-isak.westin@loytec.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5282328818321565329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=684527

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.52 seconds
Prep - Setup ELL              PASS      35.00 seconds
Build - Prep                  PASS      0.73 seconds
Build - Configure             PASS      11.49 seconds
Build - Make                  PASS      1046.65 seconds
Make Check                    PASS      12.63 seconds
Make Check w/Valgrind         PASS      375.77 seconds
Make Distcheck                PASS      322.10 seconds
Build w/ext ELL - Configure   PASS      11.91 seconds
Build w/ext ELL - Make        PASS      108.72 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      661.18 seconds



---
Regards,
Linux Bluetooth


--===============5282328818321565329==--
