Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEDBC432BE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D5A60F39
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 16:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhH2QtR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhH2QtM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 12:49:12 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E2C061575
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 09:48:19 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u21so9763553qtw.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nQki2ewsCLrbxYYDCwMd7HuNkBmBNDXGs6QpwRiG0Uo=;
        b=NdqpJGzo2O8otNy99fVI8xsSQEkguGqx/hHyqhfr9DINd49UQVzfBZV0v5M9DNl7Jf
         NR+OGD34C5orO8Gg+zaVp5h+bkZVjHlFTXlfwTmPCJkWnrsp+f0MVacnmk5cUkbt3Gbn
         MEgR40cWFernB8i9puY91wnopEzxfT6DYaHEtCBe9wRa+uFKCVTM4QtliVTO3bmmyyG8
         O2MhnXIB0QkfWK6cq3R4P/yMqoUfqdGv5WsUfhb0o309lqAqMevQDY7LvTNnkCh9qWZX
         +DPcZp/ihqMJI0UNQmg5FzalbEBE91dIQWAGZVjf4k6ckB91TiHGad/uAMxaIbD+W/kI
         bQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nQki2ewsCLrbxYYDCwMd7HuNkBmBNDXGs6QpwRiG0Uo=;
        b=nenG2F2+jOqFjo9D6QodeaNzUtMLq8wWauf3vYjiM3dtnzI2odkBFsq0VUe3CBFfpm
         IqZHUV7JjdcUJBjGCHFDAlWtNKdZgZqd/W8MA1/kqLPKLTeY1NflBDfGXLM+9kFo0pWc
         XyRr5FLj/icjIcJLFZD0i4RtqJHat/w/JlKzfcF96z5AkeZbAvcMUSGitbBaSnKMTnH3
         WubCWGOcR0fwZE4A3nGXNlS4eCXGUQKy5C8a2/OnPSVaLe6NmsRz2d2qzXCvpYRAzd6Q
         gUain1nBcSIsu4OJILfzXHgcLSoR1MUqvxjm18jq7pb6xo2bB0uVNZw049DSs8/bMlkp
         EA8A==
X-Gm-Message-State: AOAM530HXfLPmjlgJgjaASnBcbaXIDZvEuovouBKpMvXwYQ4AzlQkawD
        6egH5gM+/XSzJnfiVkhwC3gihlf0azuv9Q==
X-Google-Smtp-Source: ABdhPJwTvJ5JsnfHyWKBf290KctK+4dZkGdT3fsrXicwY6oT+l1IUY5nklzHDAJX+Ry7Dsjd6HgLjA==
X-Received: by 2002:ac8:7118:: with SMTP id z24mr16699924qto.281.1630255698731;
        Sun, 29 Aug 2021 09:48:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.37.104])
        by smtp.gmail.com with ESMTPSA id h24sm7170441qtp.63.2021.08.29.09.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 09:48:18 -0700 (PDT)
Message-ID: <612bba52.1c69fb81.e6e0e.1425@mx.google.com>
Date:   Sun, 29 Aug 2021 09:48:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2091878487198972643=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: AVDTP SEID pool seems too small
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210829155012.164880-2-pav@iki.fi>
References: <20210829155012.164880-2-pav@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2091878487198972643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=538885

---Test result---

Test Summary:
CheckPatch                    FAIL      0.56 seconds
GitLint                       PASS      0.20 seconds
Prep - Setup ELL              PASS      39.86 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.00 seconds
Build - Make                  PASS      173.79 seconds
Make Check                    PASS      8.45 seconds
Make Distcheck                PASS      207.44 seconds
Build w/ext ELL - Configure   PASS      7.17 seconds
Build w/ext ELL - Make        PASS      165.23 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
avdtp: use separate local SEID pool for each adapter
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#54: FILE: profiles/audio/avdtp.c:417:
+static GHashTable *adapter_seids = NULL;

- total: 1 errors, 0 warnings, 119 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] avdtp: use separate local SEID pool for each adapter" has style problems, please review.

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


--===============2091878487198972643==--
