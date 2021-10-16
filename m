Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504D9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Oct 2021 18:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EDF61152
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Oct 2021 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbhJPSlU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbhJPSlT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 Oct 2021 14:41:19 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE52C061765
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Oct 2021 11:39:11 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id v17so11857854qtp.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Oct 2021 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HNN4rCvl/7PBGTEEnQadspwIR+mIFn95OmykfoSdS+E=;
        b=jVvoP9jGi4KQm/ao/7qBDoy9Gc3CjwZ5bijy/kxYpQMJkW3zddviMow5xeY+X/Hszk
         TNrfqK0vJWkW2qxaaUE69L9Nx3mgHMn1b1cdPelAjCQIjL7FyDqGDSMC/AeDvldZfdaQ
         j5/75c1OusX+3oBTh4dNdVNXlPvZ/qYHTeTUk6rV97SUDB9AUkrmBtTIuABbQyUXr4+T
         7D8eHToUx2qDChVWSScnKM1gquFo8KIlIqLPr+Uj0kHlgABQ3rm8Idgmi1rsO7ubW2qY
         kKV7/OIxoCpdqfkP5i0c/dIzDcXKHCbwhKVEszStukRTaULqxXEkOkuFtPou4Hy4vIoG
         hSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HNN4rCvl/7PBGTEEnQadspwIR+mIFn95OmykfoSdS+E=;
        b=ynt94cRFQS1TqYe+KYKFm5cwAW9Gmti620LfZ2fkzOqDwknbS1HPVVfpDEUUPb3Umr
         bN4fATSSZoCzASAPDHPmKJlNYhiqVnFrqoTB2qE7pmIQyy+L+pjTCzGobllX+al+yUD1
         3CxZFabzMOsMxmywrsgs+H4Su9vVO4DiFnQVYWmD3DnEWJuzQqgpP/N4amqAeKelqLU0
         huY/Ydw5uQnuRu0YYYV591whmNXiOfQH5xwi2lO/7GCNEKe4lsG3UQ1k6IaQNyESxO2/
         gG/nk9MJflvhnx4H39Cinv/0i85trQjgJAgcpqmF0XoiPjPXRsAJyNz5haNpItWrxVhD
         Idww==
X-Gm-Message-State: AOAM531G9BhtPnKwxVwOvadwNLBgvwZ+jpWTpY3Wvb9w8lyLpWnJEG11
        /O6fYPb/bDZko13+eO96ArGGYEh/YKhuhA==
X-Google-Smtp-Source: ABdhPJw72n2uQfwxyh/5gbDe2eR77Lp2MPS+dFb2mIjVW42kNWzNkHHJTBG5HdhhbBHETepoKj1/dg==
X-Received: by 2002:ac8:5f54:: with SMTP id y20mr20987061qta.324.1634409549735;
        Sat, 16 Oct 2021 11:39:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.224.160.204])
        by smtp.gmail.com with ESMTPSA id z6sm4591056qta.31.2021.10.16.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 11:39:08 -0700 (PDT)
Message-ID: <616b1c4c.1c69fb81.3ef4f.1876@mx.google.com>
Date:   Sat, 16 Oct 2021 11:39:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6014087286140686849=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] build: Fix build error with ell/cleanup.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211016180041.477315-1-hj.tedd.an@gmail.com>
References: <20211016180041.477315-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6014087286140686849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=564817

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      0.87 seconds
Prep - Setup ELL              PASS      42.41 seconds
Build - Prep                  PASS      0.44 seconds
Build - Configure             PASS      7.81 seconds
Build - Make                  PASS      180.80 seconds
Make Check                    PASS      9.24 seconds
Make Distcheck                PASS      214.93 seconds
Build w/ext ELL - Configure   PASS      7.97 seconds
Build w/ext ELL - Make        PASS      171.36 seconds



---
Regards,
Linux Bluetooth


--===============6014087286140686849==--
