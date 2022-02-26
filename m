Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C023C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Feb 2022 08:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiBZIZZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Feb 2022 03:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBZIZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Feb 2022 03:25:23 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6352AFF6B
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 00:24:50 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id bt3so4630676qtb.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 00:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EMs8uf1KQpLfxAROu+ZwA/IaVQapZTTHwLnWEzb9Kfg=;
        b=XSIPYqucp8NhA/ByH3IUl9fMM0wVagE9QXl2RiFvt7FL9V9Tq9rFNOEhwoSwLGxOO1
         gbYYr/LjeKoUelU6tkR9ATMu2Z9cfLAhK06jfdYifkB1xrBv3SGGHo5rM7izwcPEHd4h
         /zgUsoIPHNpyguoot4JH6CgjB4P35XDiC36fx4kWofpqC7SrfQJVle7dyK2Gc8N2VGjJ
         nnq1aUqFyGJHEJNZe686ReYFWP6uIhnI9c4dUanLhjccDL27jYRKilpcHgQHdX7DYH04
         Lyf5gwuTmGJzM0Npd7jW8Q/VUv9g+e1zTtnayGHJCfOkXvXVLaaaqYqBXFLiFcM98ZAp
         nByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EMs8uf1KQpLfxAROu+ZwA/IaVQapZTTHwLnWEzb9Kfg=;
        b=D5PhPd+T48HN4BsfRFejwjNvJzxxCMnWPKnE+4p54eH7K7gZZGycks21a8xHrVWo92
         /WQRFwBB+P8E74/hjDhMm+FI/9omUA9QadmROCydvjQU2f1Qtebq4weoqGQNckmhR7d4
         FQVLElmqcV5SFVBbLWCRoXAcVVyRRD7baBCLWJS58Rl695Re++9qeh1ypPUP+UsT6KXk
         XcN08/hAkXTyszAMTt+xqRXtcUncGZjNFFepkVM6zKBDwJ/5W8gGj6LNeF/kFjQjxS3d
         Y2CTBx+BXwOE9v+ek/gUX5FpWMJv2K6ndKRUXtmrW7A3XGKXbQavzjaS5lTCTW/9DiuH
         FwQg==
X-Gm-Message-State: AOAM530AEBB0R243Q6JGHsmexJ6JIvoK4+/RU2mH6yohRfY10JtnUkr4
        bZp7PKwUuoFCCW17RtA4KEnyYVG2AVXKuA==
X-Google-Smtp-Source: ABdhPJzfP1V93YuK0VnviB+cxWo+wDdEsNCrue7RBoAdpFpzBKn1Ig8a6Bb24heeC/iI8x7Cr0YeeA==
X-Received: by 2002:a05:622a:8:b0:2d7:ae4a:8434 with SMTP id x8-20020a05622a000800b002d7ae4a8434mr9734481qtw.212.1645863889220;
        Sat, 26 Feb 2022 00:24:49 -0800 (PST)
Received: from [172.17.0.2] ([40.121.146.86])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a111200b00508188ead26sm2251277qkk.97.2022.02.26.00.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 00:24:49 -0800 (PST)
Message-ID: <6219e3d1.1c69fb81.90a9b.e4cf@mx.google.com>
Date:   Sat, 26 Feb 2022 00:24:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0317349868952219169=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,BlueZ] hog-lib: Fix not waiting for UHID_START
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220225223905.571204-1-luiz.dentz@gmail.com>
References: <20220225223905.571204-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0317349868952219169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618207

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      48.60 seconds
Build - Prep                  PASS      0.77 seconds
Build - Configure             PASS      9.84 seconds
Build - Make                  PASS      1447.35 seconds
Make Check                    PASS      13.06 seconds
Make Check w/Valgrind         PASS      514.12 seconds
Make Distcheck                PASS      269.49 seconds
Build w/ext ELL - Configure   PASS      9.91 seconds
Build w/ext ELL - Make        PASS      1414.84 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============0317349868952219169==--
