Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A424CC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 03:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCVDiY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 23:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVDiW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 23:38:22 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F793EE
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 20:38:20 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id hf2so17085475qtb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 20:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679456300;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NInRew1FujOmuF/AvcMLTxWdgz9e0tRtGDq6A51e6SI=;
        b=H/XX1uCMDOWR2C7vjLXHwz4/JXRcjnjUW63zU2/5Crbkjlf3EX6LpRoxuTys7BKlNd
         0wVbNGqW8r6M3nfAAZanrszndjfEN2AanLg3jPkVgZkvs4fN+V3kiY9AuXmBM30LpRIL
         erE4uTcKAleyRmCTslzyUTCuIqTsbWXxBZY38Zec5ZzJRKsZ5kJWzJN6rGodeZWA/+9E
         W3/9H9Xt1WPGRBDc3u+/A2yqz6LQQKzUDIcDkX6Dv++2CP45CPDzUoUSJcYH+w/9SMAF
         LpRivw859BVk/HM80taIXHWSa4d2hXeO0h2IAD5z+npGn7SSOHZ1Jo4KtFmPSJIWt/bD
         UTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679456300;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NInRew1FujOmuF/AvcMLTxWdgz9e0tRtGDq6A51e6SI=;
        b=UrxAQPLgfSFI89WIsM1TmfcWLBZckjYt3rTjPwLXI+7Em5FWyYIs3XmOsG08KDNO3b
         c1aj65jwWHdgMdknmwAO6CCO6GneFng2x7+BHV64GI5sYMwhEqJam/mHOXhMKVpp6fI9
         HkStGqOP2ubDwQ1K3ouVr/qRz/0ubBNVWwsMu9BqNgNiSrANEExYNBs0tmUlqvc/WSmn
         1gHdGPmmkdjjCZs6k5uhHw37eL7UHBUxUkZmQCzeH31jePfqvSaQ7i3CNfjB9oTf/t3s
         mlFxlgClj/kMoAuEX1niFCYTF85FcEjXgyrhMvvnE0E0BdwQrILyh8FvxT5XMw/AOCOu
         9jiA==
X-Gm-Message-State: AO0yUKVZ1QDd4gipG05AkWkq85jVMHfvh2IzDPN+baJS9+AuhG2KgyLZ
        KHxJycCe99hQCRtlZiXxVutDsEzrupbrxg==
X-Google-Smtp-Source: AK7set+JYRB/+E/saFuKpIcHII/DdkoiTzVMwe929NWhFqMvTqJvEcoDRdvxlTpyQYywjcCIDWc9uw==
X-Received: by 2002:a05:622a:188b:b0:3c0:40c1:8408 with SMTP id v11-20020a05622a188b00b003c040c18408mr2902222qtc.63.1679456299895;
        Tue, 21 Mar 2023 20:38:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.24.72])
        by smtp.gmail.com with ESMTPSA id s188-20020ae9dec5000000b00742a23cada8sm10418277qkf.131.2023.03.21.20.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 20:38:19 -0700 (PDT)
Message-ID: <641a782b.e90a0220.e1bc0.500e@mx.google.com>
Date:   Tue, 21 Mar 2023 20:38:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8193119170162264472=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] shared/shell: Add support for -i/--init-script
In-Reply-To: <20230322011349.2763404-1-luiz.dentz@gmail.com>
References: <20230322011349.2763404-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8193119170162264472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732537

---Test result---

Test Summary:
CheckPatch                    FAIL      1.39 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      27.31 seconds
BluezMake                     PASS      969.44 seconds
MakeCheck                     PASS      11.74 seconds
MakeDistcheck                 PASS      150.88 seconds
CheckValgrind                 PASS      249.36 seconds
CheckSmatch                   WARNING   331.54 seconds
bluezmakeextell               PASS      99.48 seconds
IncrementalBuild              PASS      1621.23 seconds
ScanBuild                     WARNING   1047.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] shared/shell: Add support for -i/--init-script
ERROR:SPACING: space required after that ',' (ctx:VxV)
#188: FILE: src/shared/shell.c:1131:
+	{ "init-script",required_argument, 0, 'i' },
 	               ^

/github/workspace/src/src/13183442.patch total: 1 errors, 0 warnings, 290 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13183442.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c:615:21: warning: non-ANSI function declaration of function 'bt_shell_usage'src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c:615:21: warning: non-ANSI function declaration of function 'bt_shell_usage'src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c:615:21: warning: non-ANSI function declaration of function 'bt_shell_usage'
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/shell.c:1228:13: warning: Access to field 'options' results in a dereference of a null pointer (loaded from variable 'opt')
                        if (c != opt->options[index - offset].val) {
                                 ^~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============8193119170162264472==--
