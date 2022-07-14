Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25609C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 19:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiGNTLx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGNTLv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 15:11:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179A66BBE
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 12:11:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so3988228pjl.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Gox744wVF/0DrUjh20L67R8rtyxlLheQ5Kco324/Ujw=;
        b=LkVL6r5nWxPUY7PDvu/4+k6oXpyI3Fa6PbdON/E1UQnWki9MVkWAtmo9/J+l8NRyqa
         +Wd0F+9NxaxC5Nhns6crjwHX9g9IpXeHK9sODFPmgMeHAmLn4l4IqJ9wQiKlEaRhq54A
         zgliPM9c80p7rPGcAe+2aFhjvaj4brtG6M4QWxXasNWPNYETxJ0wTIBAbM8D/aIX4P2T
         tobslVhKYwGR2EkQP0NrPBnZgcGm0JXHnoIsB/Xxwl0bny04bYJ16EFNzXO4E/H1mAFN
         RLDGH4JPC4qCQUhMT0xXX4ltSGueDcvTKsQj19/YloDt1gtsnsFs9Bz2M76glqKPag3v
         0RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Gox744wVF/0DrUjh20L67R8rtyxlLheQ5Kco324/Ujw=;
        b=U65fonabnuQdhlUN16N3ZMlIrqu6CFQN7Wfqw/pa8DyFznT7+zIo9aFWYOIkt3r2cZ
         ih1OUiaEx6KqD2p8QqWZ8Ie2qkteqQM/H1KHtEdXuYsElkNtLE3+8FjtiTfs9M0npFO5
         1AgkFI7B6Jrdexhq9JIjLVJA2eLjHs0c5liVEZLxwvn6NxoMgFpeWksNZQqinMuEv+2V
         qizwvtKCaKtbWvdVqeM4cQd5KgoXaDaz6V601WB738daP7XiN1NPxitLpMP1ewF1Jsey
         4TdNI2Ev7sXshuUw5P3+fTb9v7KZWSePaMmPhRda67zxm3U/hjBgZyEEJFWw52IzHYp/
         7ISQ==
X-Gm-Message-State: AJIora9FYGUxsXhn3vQ9SFA/MroFPR5iM02eJr2vl9lzqIWJMfAGZ7QW
        kYoJ8Oj3cMmu3h00qylksBL/drJa/Mc=
X-Google-Smtp-Source: AGRyM1uHTaHZmnRgGX2+g1N6rCwW/rtd61yAXiqDn0okkVqr/1SbJWxCZVgTsOJhPj7Pj3OsV5I0lQ==
X-Received: by 2002:a17:902:b488:b0:16a:7013:69f0 with SMTP id y8-20020a170902b48800b0016a701369f0mr9784297plr.118.1657825909831;
        Thu, 14 Jul 2022 12:11:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.125.71])
        by smtp.gmail.com with ESMTPSA id w24-20020aa79558000000b0052af2e8bba3sm2065287pfq.37.2022.07.14.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:11:49 -0700 (PDT)
Message-ID: <62d06a75.1c69fb81.6498d.33a2@mx.google.com>
Date:   Thu, 14 Jul 2022 12:11:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8599613610172385486=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: hci_sync: Fix not updating privacy_mode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220714181224.3793757-1-luiz.dentz@gmail.com>
References: <20220714181224.3793757-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8599613610172385486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659825

---Test result---

Test Summary:
CheckPatch                    PASS      1.84 seconds
GitLint                       PASS      0.88 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      38.85 seconds
BuildKernel32                 PASS      34.10 seconds
Incremental Build with patchesPASS      56.43 seconds
TestRunner: Setup             PASS      576.79 seconds
TestRunner: l2cap-tester      PASS      18.82 seconds
TestRunner: bnep-tester       PASS      6.65 seconds
TestRunner: mgmt-tester       PASS      112.16 seconds
TestRunner: rfcomm-tester     PASS      10.48 seconds
TestRunner: sco-tester        PASS      10.12 seconds
TestRunner: smp-tester        PASS      10.37 seconds
TestRunner: userchan-tester   PASS      6.86 seconds



---
Regards,
Linux Bluetooth


--===============8599613610172385486==--
