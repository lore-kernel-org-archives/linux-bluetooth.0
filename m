Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E833DC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 02:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377584AbiFWCsj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 22:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbiFWCs3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 22:48:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D03B12AFF
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 19:48:24 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p128so19579212iof.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=GuA5K3irYgB2NhF9lQ1COy+9zyoOzSh/Trt0FToOJ8A=;
        b=gN2Lz9vwBQt2EvnbnUIuii/eqY40EiPYpaXvR50pp48RG0wFgV4WvJuUwESltoZHnl
         Z9X52KzGYk8RmZ/SG7U79FwRmnRMa6nZ9Hqq99eWoNRiok2I3uENFiZbMXoqzR5kiFvP
         4xqxalOwgCzlKQXsjP5Vo7i0tSFX9k2E+Fr//T+pCu7jKAXvRd0YSZbpuvRRq0YwxIUg
         yZ4/WpKBRvdrgJ+U9RXDQAu+gt17Q3rhLBJC1Exz1tmqsk6vtz5WOgMzxBGKOqRQhjCW
         9ZQsXdooqViNkxFw/gB3GdMYuq7uKWcg3ylYNNmL1LBIyoKEoYxHzvTsm8rzWC8rIERK
         dMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=GuA5K3irYgB2NhF9lQ1COy+9zyoOzSh/Trt0FToOJ8A=;
        b=ZnlpoR2KkYqRQf/XdSC6FlyOw9oXwBHPFqprlwyjBEI5oYzVY87F6bAdLTmT3OZ4e6
         z86jsLtN5SiE9eRI5mQGH7h+BhPpOgStEmfDs2OqFfa4NWfxRmlKRoWldZni8BXWy36P
         UbpAMhYGZkuwgi9Q8Uyrn5wUwKRQs5xKH+eKcHuaJX/pL7vfLbHY2Iuf7LFczGu8ZbeJ
         /ViH6VnOY0ouxC0Q0Rp5D9+rHyeJysAiZbfZ1NSsmPdXnX7wsTiXVZFpdk7bmjfAojTU
         Z7Nneyc8fQtgddAQfJat8znn0iZHtWz6uSBs5rzWnxUMO8Aah19JxvdhO7Nj9T2YJlMt
         XSgQ==
X-Gm-Message-State: AJIora9xQ2YFzE1YkHFFx1RE6rUPqYbuarADIF+O5zF1Vfmrz1Mg/wCE
        u+ISJ8K5z5sOW5OOdAsQgSEo77lY15o=
X-Google-Smtp-Source: AGRyM1t39MCjVApiwjh0fSZHg0QvFSOfgYAaPvjitBhHuO7lfXKtJ522VMDcmOVg6AUllBckwKQlcQ==
X-Received: by 2002:a05:6638:480f:b0:339:b0ed:749e with SMTP id cp15-20020a056638480f00b00339b0ed749emr4084046jab.150.1655952503269;
        Wed, 22 Jun 2022 19:48:23 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.84.20])
        by smtp.gmail.com with ESMTPSA id x5-20020a0566022c4500b0065a47e16f49sm10116227iov.27.2022.06.22.19.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 19:48:22 -0700 (PDT)
Message-ID: <62b3d476.1c69fb81.a6035.cf43@mx.google.com>
Date:   Wed, 22 Jun 2022 19:48:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7165231824755464524=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v7,1/8] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220622222801.2676431-1-luiz.dentz@gmail.com>
References: <20220622222801.2676431-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7165231824755464524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652952

---Test result---

Test Summary:
CheckPatch                    FAIL      11.43 seconds
GitLint                       PASS      6.04 seconds
Prep - Setup ELL              PASS      39.41 seconds
Build - Prep                  PASS      0.55 seconds
Build - Configure             PASS      7.67 seconds
Build - Make                  PASS      1383.85 seconds
Make Check                    PASS      11.42 seconds
Make Check w/Valgrind         PASS      419.42 seconds
Make Distcheck                PASS      215.01 seconds
Build w/ext ELL - Configure   PASS      7.90 seconds
Build w/ext ELL - Make        PASS      1346.91 seconds
Incremental Build with patchesPASS      11082.79 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v7,7/8] tools: Add isotest tool
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1235: FILE: tools/isotest.c:1118:
+		/* fall through */

/github/workspace/src/12891547.patch total: 0 errors, 1 warnings, 1233 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12891547.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7165231824755464524==--
