Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E145C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461C1611CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhJMTdu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhJMTdt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 15:33:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC950C061749
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:31:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa4so3039948pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=P2HfFWUncSbM5+MSRIGdTUxrIsPmuLqa9M7a6zwyxjE=;
        b=auW+6Z5t5z8oSQ4PcJXMCWkB3U4MNdzVpJIX5opSD++em5ErW089bkCzaF98El+8uH
         H4FfJbY4si8QAGZFpxhigqaC8GWUNAfpRy8F5SQ1fF/UyV9OIevOeg0CChs99j7lj2bi
         lBNytAyeKvjNokRYyB0cfA6t8Bb8eIEpD1FLtO0FnoyDAY6KACtJmZDeCTAPkkVfJ63G
         fUDS+KDnU7qnUWU0Dz7skD2ctpIoJ+7hDAFmfVOu3emYPnuaSf2+1sWdzs51ScZU6Wyj
         O3WzjjCAxwLnBrWMSztfua3wWTvREK02Ls91JjpXxw6EXHaxYvzwu5pvhtrhS+qJoH53
         44Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=P2HfFWUncSbM5+MSRIGdTUxrIsPmuLqa9M7a6zwyxjE=;
        b=OFxCXUmdo/fndNK9/TQGac8Mk2bOX7fQyE+PnyGsCj+uVc3mWil+1MfCfZPr9vBbTY
         Ov1olNdj4u/DoZw4dFI4hW4HK8eZYlIoEa5vTzTJi1+L0k+ppnvGlC+Tv8919XhBanCL
         Bmb2VwD0zkd4lYl3e30iWi+PB9eYkqCSb4tkovrGh1M44U8e3s94bWApWCuRPiJ8J015
         D0mNhsNpWdW4Gubke/+ys/JIQieZ+Cwzp4kMP7MYwfZRTsYpSs3XuW7t4wa6Ps4/ZUxc
         58eKRdAsLkzV7itb2eIEMWYjYi61MCL17LYnpQ/LNdAzG5xrdmQNBlWdi4Ses747LZDZ
         nG8w==
X-Gm-Message-State: AOAM532vPvagm8aN3k5nc6zMa03Q5+ROYiFwrYyIQ7hmVFC7/gxaPYiH
        sLWdLman8ntULad1La3716wZ3U6S0wo=
X-Google-Smtp-Source: ABdhPJxBMvEDHB2NQxSVqvOk/eVG0bgVsdw/2UJa7UoGyNIL0lZ+kTlz1w3DU+AGrN2MFyS9gz3C7g==
X-Received: by 2002:a17:903:120e:b0:138:d732:3b01 with SMTP id l14-20020a170903120e00b00138d7323b01mr1022286plh.21.1634153505004;
        Wed, 13 Oct 2021 12:31:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.69.106.69])
        by smtp.gmail.com with ESMTPSA id j13sm250866pff.213.2021.10.13.12.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:31:44 -0700 (PDT)
Message-ID: <61673420.1c69fb81.1a3f0.1111@mx.google.com>
Date:   Wed, 13 Oct 2021 12:31:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1853679467273730717=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: Add Advertisement Monitor Device Lost event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211013115927.BlueZ.v3.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
References: <20211013115927.BlueZ.v3.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1853679467273730717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=562967

---Test result---

Test Summary:
CheckPatch                    PASS      1.30 seconds
GitLint                       PASS      0.85 seconds
Prep - Setup ELL              PASS      48.42 seconds
Build - Prep                  PASS      0.25 seconds
Build - Configure             PASS      8.57 seconds
Build - Make                  PASS      202.56 seconds
Make Check                    PASS      9.36 seconds
Make Distcheck                PASS      243.99 seconds
Build w/ext ELL - Configure   PASS      8.72 seconds
Build w/ext ELL - Make        PASS      191.73 seconds



---
Regards,
Linux Bluetooth


--===============1853679467273730717==--
