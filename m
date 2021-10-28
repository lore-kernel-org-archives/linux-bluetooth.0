Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Oct 2021 21:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C1D610C8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Oct 2021 21:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhJ1V4I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Oct 2021 17:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhJ1V4I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Oct 2021 17:56:08 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B9C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Oct 2021 14:53:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id u25so5090881qve.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Oct 2021 14:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TYF9bvmYhHMXwHrXSsNrq0cI74H+ouTRBtvu9ROJ5TE=;
        b=HWMQH74TxwhXnY1PqBrhoPZfuyylGGbmKaSUJ0quabjh7fRFodNA2nfCrHRiQy9vvo
         FhEheEkn5jnzMERSrHKu1NF6h7EPfC//OcjcJHpqbgld4JBI84iiA729ayqJyGSI6r9D
         M7SLKKZcCZcaV0DMFtBMDimrhjKNIzbRrzFbrIfG1X+EuySA/8CNkQwGDqRib76kt6XB
         oB16AMRHqHURlR9SdO3S5vPsWUgF4ZKzRvvL/8++XKgGvQlyJzOzrvC5OmYfT3Cu2nMv
         5TJmKcq9X+uDzv7tz6SbDZYxHZNjmW7fGqB2h6JieMcJlA1j3KmUO4cKZBafYXKTH46a
         R7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TYF9bvmYhHMXwHrXSsNrq0cI74H+ouTRBtvu9ROJ5TE=;
        b=r6CPn0LBqF2u/6zTHa8kZwq6R5wW+MgsMUcaGdjXLzjGlYKW6hd2CBZWK3TPmknNh4
         ro7SH6urKIvvbJkK/mQeZ3oXWkjsp/8VCZqZUp45w+Lwwc/FTKk9ZMI80ehBkKvewTge
         0cIfM4cs8hoJBsEO/qAtXPk0thkDQCEn/hJuIQnwRc+/zIZZtH6Je1kX13aAj7zMoyEr
         /ipN3HpqgM2HOM1L9i3a93hiCFdFEEiaNgLIUFf6RedMujZO2A0GvNG5QFAdzvz9mSFh
         9bOjwu7K+SMowJ9PCCmpbKqAxVY9SxofSWFHcd35Y6nsDeqDffxGrO5cLrv55guPZPbR
         LLPQ==
X-Gm-Message-State: AOAM532/Per76+OKilB2aQ8cupek4d1hi73OD77t22kk6wVTk2dq+bYU
        SdoevEVVjkNBIu+pBAS/VK2tA3B3zyg=
X-Google-Smtp-Source: ABdhPJzXUsH9JTmMttAMaGh6NuJZAEIG2x7p473q0U/DKXuA3TZ0Q1yL87m4GDkyyLToNfFhBrFEAQ==
X-Received: by 2002:ad4:5dce:: with SMTP id m14mr6722543qvh.29.1635458019993;
        Thu, 28 Oct 2021 14:53:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.96.28.138])
        by smtp.gmail.com with ESMTPSA id d9sm2913776qtd.76.2021.10.28.14.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:53:39 -0700 (PDT)
Message-ID: <617b1be3.1c69fb81.cb33e.52a8@mx.google.com>
Date:   Thu, 28 Oct 2021 14:53:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6976183777227140485=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,BlueZ] device: Fix not clearing error on update_bredr_services
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211028213712.2045457-1-luiz.dentz@gmail.com>
References: <20211028213712.2045457-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6976183777227140485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=572167

---Test result---

Test Summary:
CheckPatch                    PASS      1.35 seconds
GitLint                       PASS      0.95 seconds
Prep - Setup ELL              PASS      41.40 seconds
Build - Prep                  PASS      0.46 seconds
Build - Configure             PASS      7.71 seconds
Build - Make                  PASS      178.31 seconds
Make Check                    PASS      9.05 seconds
Make Distcheck                PASS      212.02 seconds
Build w/ext ELL - Configure   PASS      7.82 seconds
Build w/ext ELL - Make        PASS      168.61 seconds



---
Regards,
Linux Bluetooth


--===============6976183777227140485==--
