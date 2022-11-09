Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13429C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 16:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiKIQLk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 11:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKIQL0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 11:11:26 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57BFD7
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 08:11:20 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y6so14259634iof.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4bNTUsx366XE0skRXgf9iovRloymT7myDVfAN6AqzBE=;
        b=kdjQOTgqOdAmartBoWNKstSGlSi31aPZZfDzOlC+r4QwleHJhsgGrJazW2GxVy4G2n
         wCB60X4+5KHuDE2aZUK3AFEZXcUBZ28jcDWfprKzzLp3u5Zod4PvClDMkkaokPu1PQ2L
         ISfs80pi5/MoriIDlzC8EVKjSJt1/Yi8iAM3CMeTDwqEL7mA3FlJ6AQitB9c/8nSMUFQ
         ZpTZizNiJ7N6/L6AepuQ4QkbJXWgEfGHHpQ+ChmUYFCoRLeHs2qrmqQeA7XnJabtqSEg
         dJnYzQDJiSszUcOHLJeMKFiQEkyeRNDxk6WX5zkC2NBgRpaUvWNVhA5YeAJyJ/XNtj5d
         fMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bNTUsx366XE0skRXgf9iovRloymT7myDVfAN6AqzBE=;
        b=k0PCl/46xGLIoKE7a5Nl/3uLvDdrklS8+BsU3biK7k92jiQG/hWRf/q8pLVhJeow02
         2zweQexXgv5zzdDVT2535U3HotQfhU6ec5grKdcRwyNJTk5RG4PXQczE97Xkqlyh92tK
         ndT4DJK9+3JsL/XnuPkIM8KanEpbQjn7Y29vALuFB3AoRNJnJkhNJC+ZmIus0voPt2ag
         HMvbkSCqU1Hs3Dqvfm5IcxBr5SX2A+T2OLkX4S2XyXP7c5VmrOh4VVe/PoDckrNIw3+r
         lE0rAcYi/0keZE9gM4FzRB26FVucrCS+AwG2ugrv9VUv6J+7Ab0Gz7fxKiZBz+uKUskb
         G4rg==
X-Gm-Message-State: ACrzQf0PgTsfEnKLx/7EJnsT7nS1561NtkF8zgEeb7gKkiqjNiq48sHj
        Ther+bwAzrrqLJYW+SusUvxnR4SyAAM=
X-Google-Smtp-Source: AMsMyM6VFbZ8hfynPrjN1hiqsI617n9DKMkkkUhH1dzvR0ejHD8/lcU8/KGoViAJZzt6BSxwIpAI1w==
X-Received: by 2002:a6b:fe13:0:b0:6d2:da5f:304c with SMTP id x19-20020a6bfe13000000b006d2da5f304cmr1872743ioh.17.1668010279213;
        Wed, 09 Nov 2022 08:11:19 -0800 (PST)
Received: from [172.17.0.2] ([40.77.7.100])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b002f9a7dc2e1fsm4942742ili.53.2022.11.09.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:11:18 -0800 (PST)
Message-ID: <636bd126.920a0220.d21e9.95fa@mx.google.com>
Date:   Wed, 09 Nov 2022 08:11:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0126223150557914229=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/2] hostname: Add '' around printed strings
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221109151756.96673-1-hadess@hadess.net>
References: <20221109151756.96673-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0126223150557914229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693693

---Test result---

Test Summary:
CheckPatch                    FAIL      2.47 seconds
GitLint                       PASS      1.55 seconds
Prep - Setup ELL              PASS      27.77 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      8.90 seconds
Build - Make                  PASS      897.96 seconds
Make Check                    PASS      11.55 seconds
Make Check w/Valgrind         PASS      297.53 seconds
Make Distcheck                PASS      245.83 seconds
Build w/ext ELL - Configure   PASS      8.99 seconds
Build w/ext ELL - Make        PASS      87.66 seconds
Incremental Build w/ patches  PASS      205.65 seconds
Scan Build                    PASS      519.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/2] hostname: Fallback to transient hostname
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#57: 
https://www.freedesktop.org/software/systemd/man/org.freedesktop.hostname1.html

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#80: FILE: plugins/hostname.c:48:
+static char *pretty_hostname    = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#81: FILE: plugins/hostname.c:49:
+static char *static_hostname    = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#82: FILE: plugins/hostname.c:50:
+static char *transient_hostname = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#83: FILE: plugins/hostname.c:51:
+static guint hostname_id = 0;

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#147: FILE: plugins/hostname.c:327:
+	hostname_io = g_io_channel_new_file("/proc/sys/kernel/hostname", "r", NULL);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#149: FILE: plugins/hostname.c:329:
+		hostname_id = g_io_add_watch(hostname_io, G_IO_ERR, hostname_cb, NULL);

/github/workspace/src/13037643.patch total: 4 errors, 3 warnings, 100 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13037643.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0126223150557914229==--
