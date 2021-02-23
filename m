Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A88C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CCE64E6B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhBWTid (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBWTiQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:38:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901DC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 11:37:36 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id p21so13029485pgl.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 11:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zTrMo1m1tTy7CNb4749Vkbhk8ZquQkNoHkif0w5CugQ=;
        b=BaCOd/+vgSMImYu9Vo4Jqf7yYI3FhSmMPXbmbX1pJfFSPOMZSA4/NgBgM0sOZPmDN3
         nYPrxNhl4+w5yKO9DyMCFW3TYSBeryCc7vXxj5cSWx43m7/u1NNeZ4fatnWn1DVToRvb
         qnireqXV9fQOikKSnEh4I+qWtoLbaZ+K5N/9ER+RgL9iIfa+OJt2CW3sudsAU6btPMDX
         vfQWuVy/Yw1Xz3zkN6X8+x6IGlUiT7OU5itw8jFON3xcSMrcN3FMLsbr+ZLmL9a5npw3
         LMZT4/udFkzAckucULrwIq3i2nv3+kwyC2RptZ4Lx7jNVN0smg0Ih4coKhpLIgStwDoN
         Zv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zTrMo1m1tTy7CNb4749Vkbhk8ZquQkNoHkif0w5CugQ=;
        b=X236BZQjVv6kEWYjqR/RrRWB+hufrROyudYBgoIiRZz23U+sa27DZSWEUWt/l37+UE
         raOTxEBlnHUEz4+cofo24BvuZeamJC5P5FshDypZqjVEEr2FzMHPaU3bNvpwInoE4hKN
         HOqmc3Gj9gkxAhoc9YMH1BE2N6j2htC4FR8mEgn01zMWKP77ix1YcBuy1iI0Q8p7uFJa
         K7CCjm3WOye7JCOrKVKzrFsroMI/vkSuIOgt1wK6pNUpSDd8fyk+c0r8/cNqlToC+em1
         wGAPDy/t12ZsxKjUSMW+rfsiXZ7ifFHlSoG8wktrhvf8e1bjZGTfWGsf1m/RGaADrbiN
         EPag==
X-Gm-Message-State: AOAM5301G/KBlpfdQ8I5dPzk/RzzscB698hNtXNPNAi+plZ1BplrmiWR
        GTLy02ZmA+hX6GWfG4ydkukEdhEgBds=
X-Google-Smtp-Source: ABdhPJxav4mcARfx1XbiLs5GhQPpCTbSlwaFLWGQHN3TA/Or/UZ9haF3tB0H+D6WSfDNkyqY/XlxQA==
X-Received: by 2002:a62:1e41:0:b029:1e6:fe13:b78e with SMTP id e62-20020a621e410000b02901e6fe13b78emr27832358pfe.26.1614109055904;
        Tue, 23 Feb 2021 11:37:35 -0800 (PST)
Received: from [172.17.0.2] ([40.125.66.126])
        by smtp.gmail.com with ESMTPSA id z2sm23898203pfa.121.2021.02.23.11.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:37:35 -0800 (PST)
Message-ID: <6035597f.1c69fb81.b6540.2f16@mx.google.com>
Date:   Tue, 23 Feb 2021 11:37:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7033508752805749196=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor: Fix handling of BT_HCI_EVT_LE_BIG_COMPLETE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210223190904.1718994-1-luiz.dentz@gmail.com>
References: <20210223190904.1718994-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7033508752805749196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=437331

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - FAIL
Output:
configure.ac:21: installing './compile'
configure.ac:33: installing './config.guess'
configure.ac:33: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
configure: error: Embedded Linux library >= 0.37 is required


##############################
Test: MakeCheck - SKIPPED
Output:
checkbuild not success



---
Regards,
Linux Bluetooth


--===============7033508752805749196==--
