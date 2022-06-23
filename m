Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F759C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 08:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiFWII5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiFWIIy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 04:08:54 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBFE47AD3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 01:08:35 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-101ec2d6087so15213574fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8mdWB1OqVq05y0S84yVHcnfN+UvIDA4VxMed814s7wI=;
        b=JhOy6kaZ9uURv8tvtAKjRkbospE0oqK4eEx/a+RZ+a0dFhYm+4P/JGBO0m+Z57rLhJ
         V1MduzhHSyVDxr4GpmSwCIq0MiF1acNGB/dEJ0+pQbehY4Sr1ttGWNziaBLtEgOptVHX
         zUUd/aMhJjghv8Ak5rCdIu8Lx25Ej2I5bWRu6/tiAsQQ9VGFONAEQVmDmwooChg3B4u0
         PMzIYKxpEq+yhsuZFC2EA1u/zs/csHp9jRSVN0mqpcnkprYKZWZPYZllqvxfICkrN3Hl
         gwwCursZWP43JTs6AMC+xA0h5hrJ3HOonSx9/M/03gHAjvLh17W0BegEfyJd9yq8aX0K
         mWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8mdWB1OqVq05y0S84yVHcnfN+UvIDA4VxMed814s7wI=;
        b=ITLONTciXLntr+9kI38U1RAZO74wwy2y47t61Snlu3NyIIquFLJUmBJk+0PFombRz+
         rMfgONirUdfl3XcyjEKWoEA8UXn1hNuUd6KrhIluRQkLXh3cYulla6sR9FtMxpKwY8/x
         AhLDdILny6aXZRvV+F+wUUxUD/nYnRLNiXGGABef8vmTbohl4jcFOuQgjNiylx2AEnk7
         VS2GlZ5aFIFEz+L0k8Rz4izXrYlbjpzgTvx4qR3zjPgUgJPDCr2W1t560yYyk8YBE51g
         NM/+nPxx2I8M7QOAy3+Mu9ajRhEvKovtoTcrZRiiDghINf113c+BAbDkUHRuJNZu5lZC
         NQsA==
X-Gm-Message-State: AJIora858yeFtsQkm5Q7/I6wE0pggelbCKzkW153NZbhQwv21ahppsIR
        q9NNiZvXrdNwabkBm2KMJkxnSydJiso=
X-Google-Smtp-Source: AGRyM1uwB//ilgNooxtCMuukPRwl3mQvlciLCrcVeKTLb+79tfzI94ejoi86vhnb+5mn6WFDa8I/GQ==
X-Received: by 2002:a05:6870:8914:b0:106:9d06:fe63 with SMTP id i20-20020a056870891400b001069d06fe63mr1642635oao.103.1655971714309;
        Thu, 23 Jun 2022 01:08:34 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.22.48])
        by smtp.gmail.com with ESMTPSA id p187-20020acabfc4000000b0033326435494sm8726235oif.41.2022.06.23.01.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 01:08:33 -0700 (PDT)
Message-ID: <62b41f81.1c69fb81.95099.210f@mx.google.com>
Date:   Thu, 23 Jun 2022 01:08:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4855537233971688887=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: device: Fix not removing connected device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220623062953.13419-1-wangyouwan@uniontech.com>
References: <20220623062953.13419-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4855537233971688887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653038

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
GitLint                       PASS      0.75 seconds
Prep - Setup ELL              PASS      51.93 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      10.19 seconds
Build - Make                  PASS      1774.49 seconds
Make Check                    PASS      12.25 seconds
Make Check w/Valgrind         PASS      528.82 seconds
Make Distcheck                PASS      281.37 seconds
Build w/ext ELL - Configure   PASS      10.19 seconds
Build w/ext ELL - Make        PASS      1750.64 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4855537233971688887==--
