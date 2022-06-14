Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54E6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 20:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357165AbiFNUQr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357170AbiFNUQg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 16:16:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE3C4DF59
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 13:14:49 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 129so9504816pgc.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Z7IdfvjEqeEQcx6uNTzHSCZgfm01bjIu7F+5wYNb5bg=;
        b=gAbJ9uSof2pqJjc6SdxW0/W4KE0uL4efjGHKBwC+1t2WK1PwN7iYswUDHpUFN+N1Oj
         TfXumaBSfjcr8AyHoNtj6mcerV2cpK2Kl75kakkqqwMuITlrRq6fAxjHQDUR7ALeGted
         Wl+xJGxKBae7rjmuFymN4BxxaDcxXOzhDe/aij2VsOSuBsvhUPBOH+sbZpQnEUWabfVs
         skKnmYe9VOQgegTWZVmbdeNL8sOjBAmn6clg4B2OKc+TDHJ6lCNRcwO7A1WLv4WoL1hQ
         9ZLG2hKBQsPog6PspfG+PfpF0q8EGj+gghbFaIBAajssfHLOprWztS5GiH29Fq/sTdKH
         s/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Z7IdfvjEqeEQcx6uNTzHSCZgfm01bjIu7F+5wYNb5bg=;
        b=dL0R5Z/kDxCQZ2VEEIcBWzGRUVh4uGtQAOA/2nPGuy+AOg5+svXFFfidyiD+1h+chb
         o/nJK2bPdQMuA6C1OndiZjxz6FETcDuDK4gAfIOicvODaYJ1xdNpBcrMqEcAZFGMEFev
         gQ43VDO/T4gGff7vvzNuqHGfoURPMNUZAkWBoIvlWyrylUctiMERoR1UId/hGd/f5fAM
         vJNagwCGP2xyTZUgM1PJFMoi/dSyiUc5rnFke3ZNRJzb+4hEBTTJh6Ryq816xGLkSZzw
         jsZ03rXDWw+DtT7owK/ANsGxLiQfiF1Yc+g9xCgPtL1Nn7idwyNAgAOfld8a7WGJDmK9
         +k6A==
X-Gm-Message-State: AOAM533q7qBshPhRP26ftf/4giMn/y7C4zhCC49M9SbwbdwZDuuKdnOd
        ke9LFaWwvZ/sOB43JXIU7i41/T8gkx4=
X-Google-Smtp-Source: ABdhPJwsQm6/8+2kxD2XWl9CMxtHEhfVWMlxazKWrSZ6LQ8S+FYYh8nAHiWYbu2MSdnyjYsn5fi0kA==
X-Received: by 2002:a63:1819:0:b0:3fd:ac29:e9e9 with SMTP id y25-20020a631819000000b003fdac29e9e9mr5892817pgl.171.1655237689255;
        Tue, 14 Jun 2022 13:14:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.124.213])
        by smtp.gmail.com with ESMTPSA id bi7-20020a170902bf0700b00161ccdc172dsm7633570plb.300.2022.06.14.13.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:14:48 -0700 (PDT)
Message-ID: <62a8ec38.1c69fb81.41b8f.9857@mx.google.com>
Date:   Tue, 14 Jun 2022 13:14:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8279082146898383513=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] advertising: Fix attempting to set scan_rsp
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220614185140.535390-1-luiz.dentz@gmail.com>
References: <20220614185140.535390-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8279082146898383513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650321

---Test result---

Test Summary:
CheckPatch                    FAIL      0.77 seconds
GitLint                       FAIL      0.55 seconds
Prep - Setup ELL              PASS      41.57 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      7.95 seconds
Build - Make                  PASS      1199.70 seconds
Make Check                    PASS      11.30 seconds
Make Check w/Valgrind         PASS      438.74 seconds
Make Distcheck                PASS      228.21 seconds
Build w/ext ELL - Configure   PASS      8.03 seconds
Build w/ext ELL - Make        PASS      1169.13 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] advertising: Fix attempting to set scan_rsp
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#99: 
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)

/github/workspace/src/12881378.patch total: 0 errors, 1 warnings, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12881378.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] advertising: Fix attempting to set scan_rsp
23: B1 Line exceeds max length (89>80): "        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)"




---
Regards,
Linux Bluetooth


--===============8279082146898383513==--
