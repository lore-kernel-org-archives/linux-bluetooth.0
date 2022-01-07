Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A6AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 00:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbiAGAQL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 19:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbiAGAQK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 19:16:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD5C061245
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 16:16:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so10283055pjf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jan 2022 16:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KsPAo5i4wJUZtF1pdjkp3gUi6anjo7RdAhsV4mb4Orw=;
        b=nZfTxU0niL95llyZND5NCF1krg/UtT1RA0YqyAxScdzyZRQF4MFW6H+q+wJCIYHbWB
         AiMzSFddTOgCzIkAyoEg+6UpORJROMWK3yKRla1RmX3AkTUqxddfbmKfgLPKddY4Wp+I
         tJwBmldSAt4EbmtD8rpSc/TUUGl7YQd6X3YH5/PM11oOhDgaHAyWL8OUqufxcOOU4PD/
         914tr9uYP6kunSrlSCZBEVIPOmRUGqCnWTeCL79lnisrt2y4l/kFJmKfKiroALVRz2LK
         qA9SJveS0GnaLsARdTix2R7upt4W58DSpy5hjKreH9IA8uGiSyFbT2fP+m1HH1nVmYob
         uARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KsPAo5i4wJUZtF1pdjkp3gUi6anjo7RdAhsV4mb4Orw=;
        b=ORhjrsAvi9pLT6tM2bqXlmcsv2298mVbzRaGdpd17HZ7Ogfo51HEe6jvD+fGyz7Krp
         vxrlT6hykyHdl/GOvMw9RBQ/Ohvgr7MpNSpmExc2Ju904v14Sjc3K5tUdSPnXOy57/gF
         qVzCRlUvfOohRq16Y7lg0cWaPHaz5ivbZf5P+hLv1muBGlj5k65sk/RPb3eNeQfj/OXX
         uf96HR5hHeQH4+gAmpgSKi6YiUjx/L+FTa+1jR7sfEsFfuU6dAWkOIce///O7tL+K/cy
         kPdYKICMb9n2OXMl+c0YmJgrVOoPeFx0fFf53IyhV6x5hF4rwCuJA8caEvxcfDLbOWVJ
         xtMA==
X-Gm-Message-State: AOAM530nREQqe8HqhlLoeQKoD6XoFdRXJwgsdyWymaYK8V/AAv2sY1B3
        bfvCVbhM0fWPyxd2ngFKQLonRSgVtbY=
X-Google-Smtp-Source: ABdhPJygYxIsXGtugdkN4QSkNp+L/Zp7ik79slBvAypzNdm6CbPOikysebyUjH+AVIcg2p07Z1elHg==
X-Received: by 2002:a17:902:f693:b0:149:e52b:1733 with SMTP id l19-20020a170902f69300b00149e52b1733mr7951245plg.5.1641514569102;
        Thu, 06 Jan 2022 16:16:09 -0800 (PST)
Received: from [172.17.0.2] ([20.98.75.78])
        by smtp.gmail.com with ESMTPSA id t5sm2855957pgj.85.2022.01.06.16.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:16:08 -0800 (PST)
Message-ID: <61d78648.1c69fb81.3e92.7dca@mx.google.com>
Date:   Thu, 06 Jan 2022 16:16:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7261585695926281615=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/util: Rename btd_malloc to util_malloc
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220106210319.3620823-1-luiz.dentz@gmail.com>
References: <20220106210319.3620823-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7261585695926281615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=603319

---Test result---

Test Summary:
CheckPatch                    PASS      2.96 seconds
GitLint                       PASS      1.42 seconds
Prep - Setup ELL              PASS      44.08 seconds
Build - Prep                  PASS      0.55 seconds
Build - Configure             PASS      9.53 seconds
Build - Make                  PASS      1586.93 seconds
Make Check                    PASS      10.98 seconds
Make Check w/Valgrind         PASS      454.25 seconds
Make Distcheck                PASS      242.18 seconds
Build w/ext ELL - Configure   PASS      9.33 seconds
Build w/ext ELL - Make        PASS      1548.57 seconds
Incremental Build with patchesPASS      6454.71 seconds



---
Regards,
Linux Bluetooth


--===============7261585695926281615==--
