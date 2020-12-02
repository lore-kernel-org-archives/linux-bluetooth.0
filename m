Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447E7C8300F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10E62064B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgLBBtZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgLBBtY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 20:49:24 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36031C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 17:48:44 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id t5so10960qtp.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 17:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5l30U+PjQIIVGRvb8gMu/wldGOHuFMMqboFB/C/GKIU=;
        b=LKHXuFuguBUApP+qI2L5wnVpgOJFkrTpDbylIslqoZVSSiepSGhzM2DRK3pYye+xO8
         ddh/RMl6uZU2FQ9X7Jx5DrrFeBxIlxoxPpius1FHeUo0CpxF50c12tadqrTYzE9TZg02
         NmA+cG0/svHUC9dcw34/HtYWXAv/sqUK6q7ekQYYe9jJJpicmxfx6HAO5atN82AoAfeo
         mlVOE0HN+Y0m1r9YcvZoX20UM8LA3Tu5jQ7VC2O6/+VubfHtHIgTb/9WAnKJyRMY6qb7
         +7fI3TqcmkI7SqWvNeZCvZMvbmYFDUsPZduo4q9bcOKwB80UijBqKQ0lXUTnUaNAmOLd
         BCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5l30U+PjQIIVGRvb8gMu/wldGOHuFMMqboFB/C/GKIU=;
        b=OjjDhwqaLxD/mVwj1oiliG55H2M1tDreAlRsHAoxhZbZjfQvw7ZsCyC2kxzYSshKu5
         ZYhxN/BrKYOsEcs9HuMSmsU/HJKAamCGjnSCRbLRefIf4m1egxds1ty0a2QIfGVBnpdr
         v8ENUXlO6P5QCZZuufe497nr/rgPBiiOWfeulbVwW4CN9BTR1S2qUHr9rUMNTRpKzwLO
         tB55H+3+Ji/4YZC3hqr5pvbekWpheBOBD77yzihpA6FokEN78jUGIu5BFsS2sU12ovuW
         viG5mCihxDEkmRIOr7XfqMwBGO/jTRogwfbY2HaEtflPNfx4Q5SdMRqK0eKjlErFHBep
         mAZQ==
X-Gm-Message-State: AOAM532JybHO7fPh50taFCyShxv2CenWcQqet+ypaZxF70F7zCXtTJGD
        kyiDjxCCbsZ2uOmW9L8mLxqrkuxj+GcqNw==
X-Google-Smtp-Source: ABdhPJyBGc6k2tWU0Uua5Lly2wnVz+6SDMKuKNEwSVNAgWIrX5WRXrGnRH3Gshbcpq720VEs+HB6ZA==
X-Received: by 2002:aed:29e6:: with SMTP id o93mr412561qtd.95.1606873723137;
        Tue, 01 Dec 2020 17:48:43 -0800 (PST)
Received: from [172.17.0.2] ([52.232.190.170])
        by smtp.gmail.com with ESMTPSA id l10sm142385qti.37.2020.12.01.17.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 17:48:42 -0800 (PST)
Message-ID: <5fc6f27a.1c69fb81.49b2d.088f@mx.google.com>
Date:   Tue, 01 Dec 2020 17:48:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5094150767344755163=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: Emit InterfacesAdded/InterfacesRemoved at correct root path
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201201171838.bluez.v1.1.Idce75740a54d8a860450da8a7a21d55777c87ae9@changeid>
References: <20201201171838.bluez.v1.1.Idce75740a54d8a860450da8a7a21d55777c87ae9@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5094150767344755163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=394297

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5094150767344755163==--
