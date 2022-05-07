Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 02:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445296AbiEGCHZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 22:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445295AbiEGCHY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 22:07:24 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6934606C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 19:03:38 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a76so7147542qkg.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 19:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=35KFD7ZTTqJhAlmYebtseCoj/LSgykLTjBBpnuJLpcU=;
        b=dbLDBso8I5Chv9KwgHdCuz7nOtA3YM1ZIsWkU65L6hoovN9DjN/8l80uQ+8ulMbzoT
         OV4DDN6O1rDHyhtnUUwfjyTXyuYsO8k0P/IBFkopNd/D+jy4rIL+Jf81irON+RxtKwif
         8eodm0uqVXnTB2+ioZB25jsmcDwWOakebpyucVmo0t2u/tvUxMzFovP1bD+DdgrNjIXu
         fkBjICbiGqVOn232ayrjLgMMjWqTeWw88Xs19fQjpeOWHY3LOBELgugKaZTqzOY4nreW
         uqlVz2N2jR41CdjQVvUbfG/FNPBaJIfwHciOceA4AVxOWehl7ljTrgBejnP+agj+dz2s
         VEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=35KFD7ZTTqJhAlmYebtseCoj/LSgykLTjBBpnuJLpcU=;
        b=MnR6mLevIBauAhqf2+GDRraxXl1bbRKqwKjHbQKvSMDahqo6Yhfg9QiJedL2PvoEia
         kYoTF1cf2arlIRdiIV/QFGOeH9DI3CdhwoOSrQnsNxs+K+sCmDu2KnqWvYFKN4GJJLbh
         pkEPc88v+LfP2bYolif3mEDb9owxa7tlNEpzJSTCymx0vLuW5KZabJWOdsJgMLGL7to7
         PrbDA/SG5nxXBik3eyQ5paAq3Hm6iQd0G2c3W2YaA3rY6kcKuqo61c6FZhtl9yG7nSD5
         6pJbyPdQLOAxnzVQaaKC6MHlqbUBQJSBADr5nmK1hygkeCkQxVJqwUUofGe6bSnEVfS1
         Chkg==
X-Gm-Message-State: AOAM532Ysk5FqO5p1WhG9PISHkON5r8iVa0G1/vfYh/Bdmetp9NR0V+2
        be6LcfGS014udfngdfNsTWa4D+yxXKipSA==
X-Google-Smtp-Source: ABdhPJxopSPjBoepSTYY3TIkguXHEunU1EHV51IqqHvPpt8E+hymB/g8LORzUKATCZ9F59cPtzYK/w==
X-Received: by 2002:ae9:ed0a:0:b0:69f:ae24:87e0 with SMTP id c10-20020ae9ed0a000000b0069fae2487e0mr4574409qkg.705.1651889017977;
        Fri, 06 May 2022 19:03:37 -0700 (PDT)
Received: from [172.17.0.2] ([40.87.25.103])
        by smtp.gmail.com with ESMTPSA id t134-20020a37aa8c000000b0069fc13ce23bsm3341278qke.108.2022.05.06.19.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 19:03:37 -0700 (PDT)
Message-ID: <6275d379.1c69fb81.651ad.233a@mx.google.com>
Date:   Fri, 06 May 2022 19:03:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6132503075366029321=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,BlueZ,1/7] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220506221818.3933843-1-luiz.dentz@gmail.com>
References: <20220506221818.3933843-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6132503075366029321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639253

---Test result---

Test Summary:
CheckPatch                    FAIL      12.99 seconds
GitLint                       PASS      7.20 seconds
Prep - Setup ELL              PASS      40.08 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.26 seconds
Build - Make                  PASS      1347.34 seconds
Make Check                    PASS      11.18 seconds
Make Check w/Valgrind         PASS      407.45 seconds
Make Distcheck                PASS      217.19 seconds
Build w/ext ELL - Configure   PASS      8.40 seconds
Build w/ext ELL - Make        PASS      1337.26 seconds
Incremental Build with patchesPASS      9576.02 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2,BlueZ,6/7] tools: Add isotest tool
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1222: FILE: tools/isotest.c:1106:
+		/* fall through */

/github/workspace/src/12841684.patch total: 0 errors, 1 warnings, 1219 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12841684.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6132503075366029321==--
