Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBCCC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 01:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F16F611C8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 01:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhHFBaG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhHFBaG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 21:30:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483EFC061798
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 18:29:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mt6so13384748pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 18:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=u/cVZDvo4Lu6/YI2jf/KCevAzQ3nBF6RvaCx8jqKGdY=;
        b=IN03segXa/WlD8BgkVF4LqfOoCs1auOx//o8GMo0ApZ6BOd1TXQt0nQGNbOiP4/fs/
         IeElSFyfEY/dDEiyGjs5DxffNiWnu2Bcyn6VPiTGEylxFBVGH2++LgWOkXU5fKMeNBkh
         HgG/nSrtJLQ7RuzmlEBfDZFR69m/Bri6ilzlpjVwZ1EqukSAEN4Zse0SPEN6p7ONEUnr
         ipJug9g9ujkylQfpYeWVTOwvAmG15JU7YblE50oL7QT5KZas8FQeS/fM5M7eudgjt3iN
         FkYs+2Od/HUP08b/Klxcsb1D4pmOIMCY103uvFNf0s5lyVYJxj2FrOFBKMwj/2ALWRyE
         8a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=u/cVZDvo4Lu6/YI2jf/KCevAzQ3nBF6RvaCx8jqKGdY=;
        b=YKo8R+YAw59kO4LaNG84OkoDiuGOhkCKV3vFPgfpFHd2SKN0pJdgaGQfTnKjT4zdkk
         Od1MLE1ENWMv3VF+vuow8LIPnVED1yHTRaNft3+Ywo7XXwf+SEwEPzKHibiXf0uiNMDi
         ER2Oi+5wfi2Ih2UuSzxGx/kysMIBzinMsAeqyOMGvnJI2q2N3QrLfV+7KwykRZQfmFJJ
         PaDsvO9EvRjRFuk6yQp14NyAzbqgLKrQl8tekYGVkCMgBHYliCtx3FcREum7BlkPrYnx
         dAmXZv2waF5SOd/6027yWrdfaicQdblNC4ccVy2A7thGW2DTx3IER7Q/xaW3f8sTquzH
         F5KQ==
X-Gm-Message-State: AOAM531sYTUDjKIS1sFWsflb9jHJSo0/Asry+lV59/Ac9cFuRoeqq49m
        xPTqR+dDVlHg/QXZkqprbnKemKbNiwg=
X-Google-Smtp-Source: ABdhPJycsSppO/nRYFLRA7kBRwbugU3RH2kd5NY8ZHoIX6GRG3AJ2ld80YDbwFit15nSsItz9iSvGw==
X-Received: by 2002:a63:580c:: with SMTP id m12mr337786pgb.157.1628213390382;
        Thu, 05 Aug 2021 18:29:50 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.255.71])
        by smtp.gmail.com with ESMTPSA id o9sm8774696pfh.217.2021.08.05.18.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 18:29:50 -0700 (PDT)
Message-ID: <610c908e.1c69fb81.ad721.a4e1@mx.google.com>
Date:   Thu, 05 Aug 2021 18:29:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8769082270709060137=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] doc: Add a doc for Intel hardware variants
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210806003352.49664-1-hj.tedd.an@gmail.com>
References: <20210806003352.49664-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8769082270709060137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=527247

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      49.20 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.51 seconds
Build - Make                  PASS      219.62 seconds
Make Check                    PASS      8.86 seconds
Make Distcheck                PASS      256.34 seconds
Build w/ext ELL - Configure   PASS      8.54 seconds
Build w/ext ELL - Make        PASS      206.84 seconds

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


--===============8769082270709060137==--
