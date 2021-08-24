Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C30AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6830661002
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 19:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhHXTbG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhHXTbF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Aug 2021 15:31:05 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E3C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 12:30:21 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t190so24474712qke.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CFHRm5AEQaMPKxShC7tLSYUP9rhpjGLAT8cQchswzh4=;
        b=lI4KNBulU/nDltCn/HciEUJ3XSCT0+irfblAM1VgKmTWQgjyVBW5dCKFbVBHZQMxJ6
         vwjEC6HFJ+BF5gBivL/90lwodrHElRL7XdlvGjexmiQA/vuSdJmVUequaAauJ+Z9EGx+
         OReu+xvHoUz973LaoDDjMc9VkOXuMzRjyfBt8gFQLLPuvnTmXkluU0Y5HF8DsoAJNRMr
         YINK0D2crLD50ng9Lif6gSTctQQaAcfg5y2z/vgwlXxbF5sBLbdiOzIkzqrFmcFoR6tT
         NfZfU+JXl3s7jN9cc9bc0sXbnpACF+rq9a/HZOS0/5CvzWRG1uxQT8q288jE+36eRbI4
         CV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CFHRm5AEQaMPKxShC7tLSYUP9rhpjGLAT8cQchswzh4=;
        b=Om28Ovxu7zo7iWUpqYhGeyB2yA9G6S9G4D/MfiWSAYK6A61w4tb/EFauAnzHv+Qi9p
         nx3mxxfG+XJ2/EtMHhKvt764wRhDSZ50cBapAvI6st1KRIbdSUhaIbVnU1eS1rHxrm8i
         XMrs23OJ64VV/qSs8WOXtDRjI29Dz/ch0EbAaw/Bh2/ai4LFMLpiN9ooy57QPdx30169
         ADSoGh4zt0mgXMYLl81SxaqC7Sa+v2jHmgIkRAocMFFj83fcY91Ew3luW4k/eOdisiFb
         645dAaBa0PhbxDdRr5hsquG7kfN7shYPyFdX3SYmUADsuUJ3CrH4jxCAUD4ZQj8UZIyT
         1o1A==
X-Gm-Message-State: AOAM53087Md6hzMX9urEI8mZPIhuYbstzceSBXA/6bOp7LZNQDW6NkPM
        IzYXsKWmbfGNqXYWzy14GltDEtv9li6k7g==
X-Google-Smtp-Source: ABdhPJxnjjcb944kDHZ5AUJwhx2f6oSn3Oob6/Cp5+HFf6YKYKoia0pdUbbIUO44JiN1nKieEjv0pQ==
X-Received: by 2002:a05:620a:15e8:: with SMTP id p8mr28047780qkm.27.1629833420067;
        Tue, 24 Aug 2021 12:30:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.82.123.31])
        by smtp.gmail.com with ESMTPSA id w6sm7925452qkw.91.2021.08.24.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 12:30:19 -0700 (PDT)
Message-ID: <612548cb.1c69fb81.91b77.60e4@mx.google.com>
Date:   Tue, 24 Aug 2021 12:30:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3639919212785107264=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, david@lechnology.com
Subject: RE: [BlueZ] device: fix advertising data UUIDs ignored when Cache = yes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210824182916.2569317-1-david@lechnology.com>
References: <20210824182916.2569317-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3639919212785107264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=536697

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      40.29 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.06 seconds
Build - Make                  PASS      176.14 seconds
Make Check                    PASS      8.49 seconds
Make Distcheck                PASS      206.82 seconds
Build w/ext ELL - Configure   PASS      7.13 seconds
Build w/ext ELL - Make        PASS      165.68 seconds

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


--===============3639919212785107264==--
