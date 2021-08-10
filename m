Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB762C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 13:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC8160D07
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 13:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbhHJNQJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbhHJNQJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Aug 2021 09:16:09 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B819C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 06:15:47 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t3so20921152qkg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BkC6Kl9SXMYO7NNJ7Nx1KGNETMECGzsNm3X8V2GsH8I=;
        b=B1axdpOFTTiuSuDBj26y6PrlaDPU9SStUUcB1QJHtSd9YI0DsubT77yJ9afsETWLMH
         1ltmj/XfaCmxR+AL/4XhCFAyL7MPc/Wocltfhyu4jhR1TlKj2uWjPhdoNcR/NVsILU7d
         57KyLc7NQBt+Ou66mWQV/57TYPGDJpcF4juHOqhExh5kNuzl9DuT9t1UymLqdy1fyrdC
         tDzz8CvgrOX9H+ViF2icZZlf9z9a5U2LW9MYBkfbnfDO8AZpI6poxX/KGsAiS/8nzCS0
         jHHs9ohUsR5vstTrAjUfa9mzkdaNOV/JIvELP+ObjSF7GjSacCwnoI7WL1jweBVAJcSS
         WhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BkC6Kl9SXMYO7NNJ7Nx1KGNETMECGzsNm3X8V2GsH8I=;
        b=jvSyy8EqexRsIR6/Kwuotht9tRvEYdgnV8M2+yYkhk50m35SeIbb/roAG4VkIcu10d
         Lzwz5U3YCQSrtndXlcBfLUj9pqGXaz7L7IYZn/7xk4IM4hhQB6SSVOm0nUr9eNOskkg1
         p4FtLaGFGnw2QRwStMCiJ0ai1tfmEGwq2APMjUEF31wBuSEb5OreMyKp/OPDZ6ekW++D
         To2c6YS/x/6bqtZnqA+fTK5Yc0/48jdsUD0JVHm2mGEKKry5RP2YrIRlI2O3tYhqJcw2
         nSjxSOpZbKkga1KIyJ1x2v8saN1jf8wd2tOgP5dee/tzs7BzKOExQztQniHH6CrWX12u
         pqgg==
X-Gm-Message-State: AOAM533CNZRZEMvUMul3MS7WRzHyXMnw1Mz9olzzUCnYtLP9kGF8Ro3Q
        FWX5osGMQhPBZDq8oP/yso6D/a/4IrE=
X-Google-Smtp-Source: ABdhPJyxIDh3ZnPD7vuZ4iZJ9+dzDHEu7ssPwjBEZBmwxDESUDAqLPZStiWrwrKecouYm0MsNav3eA==
X-Received: by 2002:ae9:e30c:: with SMTP id v12mr19506062qkf.206.1628601346320;
        Tue, 10 Aug 2021 06:15:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.59.27])
        by smtp.gmail.com with ESMTPSA id d199sm5687100qkg.74.2021.08.10.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 06:15:45 -0700 (PDT)
Message-ID: <61127c01.1c69fb81.64578.3e24@mx.google.com>
Date:   Tue, 10 Aug 2021 06:15:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3694968410154998571=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v2,1/3] shared/shell: fix missing stdbool in shell.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210810205522.v2.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
References: <20210810205522.v2.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3694968410154998571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=529177

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
GitLint                       PASS      0.31 seconds
Prep - Setup ELL              PASS      39.81 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.03 seconds
Build - Make                  PASS      163.84 seconds
Make Check                    PASS      8.75 seconds
Make Distcheck                PASS      191.40 seconds
Build w/ext ELL - Configure   PASS      7.00 seconds
Build w/ext ELL - Make        PASS      151.44 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============3694968410154998571==--
