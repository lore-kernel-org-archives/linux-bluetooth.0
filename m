Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75208C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 20:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A6C22573
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 20:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgLVU7v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 15:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgLVU7v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 15:59:51 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA44C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 12:59:10 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 2so9903960qtt.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 12:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TvTJMCPgq6k/vEFGUSRtC3cgIV6LXj2faA/RiguonYQ=;
        b=hyqHeoxHygvfha42cnraGbVbLTn23SJUFI6NbYKePyx7epxMuWezxBUs3xfJ9NKgII
         NwNDrdYlE2LWFBCFTdBn+Vx7AyKlVetrfqyuPkmf4e95bQo25FyiOzGfGwXe9Vq39hR1
         5u6sFa7yB4tPDkkCzeAOBhJzr8na4kdcbf0YSPqiAuITpNq4Qj3BXKW0MnseaxwUGInU
         UZwH1vrn06UCH3d4JAeuytZnx4F8oorHW/V/mnn6u2FC5tlJ79crsWDn+Z5foAS1vkqH
         r3dAWKLmKPUjbMiZCXS/egSU4j1u53NyqteOogv69wzLPbHPdYrhR8QGLmAkLG350WQu
         wbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TvTJMCPgq6k/vEFGUSRtC3cgIV6LXj2faA/RiguonYQ=;
        b=WPuhrEVn+CcSfk9j+AoGOnC3mKchrnwwJmvTI7BEZzOkh5rrSs+VQmJOOiwMs/gNBg
         hz6Zm5DfdDOm5XmCKbj72A/M8iP0Cs7MFhSTwyA/lue/25ngKvnkEtYMLfEXug7R7w1l
         7U/wNUybyqmWcdlFaSVq1z9Z9soPcKBl3T3xfUKrviu2p4PAGFcD41jUMZJb4EYoNVxN
         iaa6eVyHyJfhp9nZAw5cHr2qGjYf/E76LSXeeefjDPcTDfOxN87Pe1MppUppfciRmS6/
         rwuN2uybuQ46V0Ky6TC3JaVOhAg0sYn0omvMPgzGHixsrFDoXlOAtwW/2TrVgG4ClR1L
         2q1A==
X-Gm-Message-State: AOAM532DJbQGBrVSn8suCyuMic65LsH5t04x1Qmh/atpnH+pY8e1apZw
        CKvcIyR7Z2WVUD4MRS1yzSZTzDiEPFshaQ==
X-Google-Smtp-Source: ABdhPJwqnCU9NFiS0INl2GRBs/vgm9FVL3zoyduBt9Zozy2e+2Jk19iXh7Y5Yk8v7Wo0DcOu5aZMxg==
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr22859536qta.158.1608670749253;
        Tue, 22 Dec 2020 12:59:09 -0800 (PST)
Received: from [172.17.0.2] ([13.68.81.134])
        by smtp.gmail.com with ESMTPSA id s65sm3174626qkh.91.2020.12.22.12.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 12:59:08 -0800 (PST)
Message-ID: <5fe25e1c.1c69fb81.113cd.5f32@mx.google.com>
Date:   Tue, 22 Dec 2020 12:59:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4185996215083936032=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jacob@teenage.engineering
Subject: RE: [BlueZ] btmon: fix buffer bound checks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201222204547.27839-1-jacob@teenage.engineering>
References: <20201222204547.27839-1-jacob@teenage.engineering>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4185996215083936032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=405519

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


--===============4185996215083936032==--
