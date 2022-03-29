Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 22:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbiC2WyF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbiC2WyE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 18:54:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1DA0BF3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 15:52:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso344118pjb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=X51Q2oaGEZk+9G3DnwGGNsAmpD66sfxgajtL2F+euJE=;
        b=LWEjKQpan69iRWl9OdiaSi0yObxRT/r8Nvvv1D2o+8yTzQ8uijYd1vXbbFCvRGdopB
         3SYsof5GQ11R+BA/ymO9tTXqhJGesVplPMWXZAEyRq9kdAIhKaR1OAjVDih5yJaKcggU
         GWuf/BN+S/a1NpaR0ehv7eTZFvMrn5+SJ9PbIjHNx7/bWkMT4z/xZJpZQuPmw5xQtDMn
         zmHS4usl55JUwXjBjaG8QGBtgLOQlp7JniGNnwdOIRcxkGWw2qCBX7mnPAmgWwhNCXAl
         skRP+KvPjtyyulk7+vhtYko1tDP9hwTCtMMLUU4OorfmBfg2XjHDXypNqqTpLD0+5Fkp
         9zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=X51Q2oaGEZk+9G3DnwGGNsAmpD66sfxgajtL2F+euJE=;
        b=b8iVu0WGQSMbuq62B5r6ajP/MsCCrWJEMTlAUPqFnGLibwVum95Spi37uexjNgWXTU
         2THyK2HZ/xWSj8yuMlLSVIUV3386fnEEH/R/DKZ8GC6d55KT70BCjDkk+FW4xBP5YdkV
         FmKxSGHOYQv2qGmV17ahlajN6qvrdDq3oDcJLc5BpumL2Ku+ctCU7Py7aDzpGO3IzRYN
         K17h5y2Ir3kWP6t3r01dl4Kthpk5UHDh0+xEkSJJY4PdsZYrdnafQuZ9cfXXDmBZhgS2
         ymPH3ZlYAVbC1bCsQa5xXsfPEiSlZWxTDBeimlC82HdNS09Tf2UA7D04EvBzweQ5URUC
         qWvA==
X-Gm-Message-State: AOAM532TQasYj727J2svsQLHlm6ugivcZaL1ZYzV9ioTcM3ay7xOrSFR
        VjqY2+CVefXZaPNcUQQpPWvPM8+h0Qo=
X-Google-Smtp-Source: ABdhPJwoRRSWbAzFeXx24QHL2A3MEu1Io2PHCm8VOSPBHYVqTnGqvzyh6fJZ4YZMknVNJ+TG+0adjA==
X-Received: by 2002:a17:902:d2d1:b0:154:45d2:a05d with SMTP id n17-20020a170902d2d100b0015445d2a05dmr32250365plc.74.1648594340064;
        Tue, 29 Mar 2022 15:52:20 -0700 (PDT)
Received: from [172.17.0.2] ([104.42.218.121])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090a660600b001c985b0cb53sm3898181pjj.26.2022.03.29.15.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:52:19 -0700 (PDT)
Message-ID: <62438da3.1c69fb81.ae42c.a929@mx.google.com>
Date:   Tue, 29 Mar 2022 15:52:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3110144288218967587=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4] a2dp: Fix crash when SEP codec has not been initialized
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220329213247.2334757-1-luiz.dentz@gmail.com>
References: <20220329213247.2334757-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3110144288218967587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627319

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.44 seconds
Prep - Setup ELL              PASS      45.94 seconds
Build - Prep                  PASS      0.61 seconds
Build - Configure             PASS      8.87 seconds
Build - Make                  PASS      1623.11 seconds
Make Check                    PASS      12.49 seconds
Make Check w/Valgrind         PASS      499.49 seconds
Make Distcheck                PASS      256.95 seconds
Build w/ext ELL - Configure   PASS      9.23 seconds
Build w/ext ELL - Make        PASS      1636.91 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3110144288218967587==--
