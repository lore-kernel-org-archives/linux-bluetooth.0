Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A6C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 03:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A86611BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 03:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhETDza (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 23:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhETDza (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 23:55:30 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6364C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 20:54:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t20so11851370qtx.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 20:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tii1ipOGEVbhLtvBNdSeLpUxpszfgWDVoSk6oNEkxH0=;
        b=ZBnccqt2tUP/8IUs+TQMjwn0GBH2d3Gi/YF7phXa7Xy6nT+T1dblnMX9h7xYi2Ug8J
         A8rYsm73L0loihZJQLW2jFQq1FytqUoafUjk1RwazLHwcwDaSTljw0VMQnV6xFJ5NiBV
         OdSF1y4uEHhyM+3KJzaLG2kQZ/myW+mqp8KeehRmvpp2IxdA2DAImPIjTRT3UD0kPV5n
         47WKe28tE9v8U85evdFizOk6qsTDjNvzTimeexJ0mVrPQzi7KxwtfRjTaYwtZDnMRYCr
         0PI06ac0tv+2xK9gjZalMa/aNVKzEQzcfwq7o/lf6xneyjA+Z7YW6gUiP1rTnr1a77P+
         l5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tii1ipOGEVbhLtvBNdSeLpUxpszfgWDVoSk6oNEkxH0=;
        b=E1eNUCFr9/btdK/KuoV4Q3eK2yie2rSRohr96FohgWPRvu9Si1ZI/tfjvLqvF8fjUP
         VRytTxaPvLq41COP9OCczMnET5ROW4AaDP5X3aEoadAkPi0Ni9PvQT2TWBD9f7c4CT/N
         ej67wmn2uwaHqfV7R3NRVhxXxAIjsejG6jx6nYNlqPLJu2k/nEuy8fpYuvDjfDTBDxFN
         lpXUwBbdzSx4kGqxaUxzdzjA7XGW40wFiocThp04oWVWY3arYHSGD4YgxoUOTanjZSz8
         6t+zHLZTlNE3lMHLKW+O8LccpTsTtzHQs35Pnhcw3AT7SmOj5N0fIOBkpEjCJAVCKLxt
         Qajg==
X-Gm-Message-State: AOAM531zYFuqUVblKYSqXKK4Pr4s+6sdKUASu2J4f57q+1GfHzLqDKbC
        wBOFJuo4F6BmnCRzD9AfLsYujZdOSY0=
X-Google-Smtp-Source: ABdhPJyk4TGhuOapPwxPeWScyBueVd+HqS8Fq0hVT9v0NFFcKNd4jwtrPJRJ+7rJcXGRl8Eb/sC0cw==
X-Received: by 2002:ac8:c86:: with SMTP id n6mr3104978qti.100.1621482847893;
        Wed, 19 May 2021 20:54:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.12.179])
        by smtp.gmail.com with ESMTPSA id w7sm1052154qtn.91.2021.05.19.20.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:54:07 -0700 (PDT)
Message-ID: <60a5dd5f.1c69fb81.503d0.7d3c@mx.google.com>
Date:   Wed, 19 May 2021 20:54:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2818650200191761160=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, eh5@sokka.cn
Subject: RE: [BlueZ] avrcp: Fix unregister AVRCP player
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210520031334.304688-1-eh5@sokka.cn>
References: <20210520031334.304688-1-eh5@sokka.cn>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2818650200191761160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=485435

---Test result---

Test Summary:
CheckPatch                    FAIL      0.32 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      40.94 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      7.27 seconds
Build - Make                  PASS      176.69 seconds
Make Check                    PASS      9.45 seconds
Make Distcheck                PASS      210.25 seconds
Build w/ext ELL - Configure   PASS      7.30 seconds
Build w/ext ELL - Make        PASS      166.44 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
avrcp: Fix unregister AVRCP player
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#9: 
    player->changed_id = g_idle_add(notify_addressed_player_changed, player);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#38: FILE: profiles/audio/avrcp.c:796:
+	if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED && player->addressed_changing) {

- total: 0 errors, 2 warnings, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] avrcp: Fix unregister AVRCP player" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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


--===============2818650200191761160==--
