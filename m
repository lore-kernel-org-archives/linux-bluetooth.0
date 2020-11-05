Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A24C388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 23:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3415A20704
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 23:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzjHPkVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgKEXYM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbgKEXYM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 18:24:12 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33627C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2020 15:24:12 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id r7so2961704qkf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 15:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XYIhT4+fQO+5hAJk3iDoLk75s2ITzzyhyIQAN8E4qC8=;
        b=HzjHPkViDhwWKMAGxR8VFL2M3/p1C7oZuBOVePrlLrjHtw2u/tFCH9eCcJJF5/a2oI
         fUJ4sWY1arUzRiDuMFckpgpidM0fpnOgqt9vedaLWjhjJGxI44SrxDzsCdlE7poBDhKI
         S25QvnwbVWDcOfAQhKUTdXzDI2xyNaRQmu/aNm36tKZT6+IpGw+0ExgojUYpeLQ5604C
         Jnz8fil7J+LTx12FL20bVEcYc0wBQaYiYZSQhT1kDxJWOo2WvWpqVUd30gRDt699XhyC
         BzulgaackrmlfLUvxRfKSXMRejbihcjDkMHx0j3Bevla1HGBfsyinATeNdGUIUZrLlTF
         ImgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XYIhT4+fQO+5hAJk3iDoLk75s2ITzzyhyIQAN8E4qC8=;
        b=WmJIhyl3h2zldmISoknIrAfmNM6Xu5W2qNx/5CCZXA/9RPJ6ciErrW9QXkmKrikGbl
         6A952lldbsEWOVmD2JJGYYzxfq/ZSwArFcQxYTrGwtmP5N+ckK3q8cdZYKDobBH4z6C9
         gzIkwPkzhkDvF0RF7yRtYxc8P1bAhk/J943CBDD7gzFBX+cHotjZDt/MBVd8X76cTIZF
         c4BoDU3mVteV9O7/Zesk8mwHy2+BmHlJyfVXBfHtPP1NNkgP9VS4VJYyMew83Oe+xh92
         mkDkQBLxn05iMa8QSIIvxf2k0M5aymYGx0MemxvvGYsutGjY/wUfCanwarqFDOexp+tP
         Zb/g==
X-Gm-Message-State: AOAM531XM91Nce6mphY7TBfUVlG9FraCxMkKtjnUwWnJhw6SkP9s/4YA
        JmiNUrB1OT6fq76VLcCrydIwOzawAcIg1w==
X-Google-Smtp-Source: ABdhPJwKfLVeEaofhV/53gAQ6X/BiZ4WaGMTK06cT2/UQISdNhG72IN5g8s4O4fht008Q7mguRmnng==
X-Received: by 2002:ae9:e314:: with SMTP id v20mr4639856qkf.93.1604618650783;
        Thu, 05 Nov 2020 15:24:10 -0800 (PST)
Received: from [172.17.0.2] ([52.254.10.173])
        by smtp.gmail.com with ESMTPSA id r62sm2135707qkd.80.2020.11.05.15.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 15:24:10 -0800 (PST)
Message-ID: <5fa4899a.1c69fb81.db7b6.d0e1@mx.google.com>
Date:   Thu, 05 Nov 2020 15:24:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5361770915687156730=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] Cancel GATT client operations when cleaning up GATT cache
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201105224923.377-1-sonnysasaka@chromium.org>
References: <20201105224923.377-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5361770915687156730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=378543

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
Cancel GATT client operations when cleaning up GATT cache
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#15: 
0  gatt_db_service_get_handles (service=0x1751130, service=0x1751130, end_handle=0x7ffcd600806e, start_handle=0x7ffcd600806c) at src/shared/gatt-db.c:569

ERROR:GERRIT_CHANGE_ID: Remove Gerrit Change-Id's before submitting upstream
#31: 
Change-Id: I17b8ccc5322b0a83fc63d711e83c9f4a58a0374c

- total: 1 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Cancel GATT client operations when cleaning up GATT cache" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
Cancel GATT client operations when cleaning up GATT cache
12: B1 Line exceeds max length (153>80): "0  gatt_db_service_get_handles (service=0x1751130, service=0x1751130, end_handle=0x7ffcd600806e, start_handle=0x7ffcd600806c) at src/shared/gatt-db.c:569"
13: B1 Line exceeds max length (170>80): "1  gatt_db_attribute_get_service_data (attrib=<optimized out>, start_handle=0x7ffcd600806c, end_handle=0x7ffcd600806e, primary=0x0, uuid=0x0) at src/shared/gatt-db.c:1657"
14: B1 Line exceeds max length (150>80): "2  0x00000000004983a8 in discovery_op_complete (op=op@entry=0x173b320, success=<optimized out>, err=err@entry=10 '\n') at src/shared/gatt-client.c:406"
15: B1 Line exceeds max length (172>80): "3  0x000000000049a548 in discover_descs_cb (success=<optimized out>, att_ecode=<optimized out>, result=<optimized out>, user_data=0x173b320) at src/shared/gatt-client.c:915"
16: B1 Line exceeds max length (142>80): "4  0x00000000004a1d87 in discovery_op_complete (op=0x1748450, success=<optimized out>, ecode=<optimized out>) at src/shared/gatt-helpers.c:615"
17: B1 Line exceeds max length (161>80): "5  0x00000000004a2379 in discover_descs_cb (opcode=<optimized out>, pdu=0x174d551, length=<optimized out>, user_data=0x1748450) at src/shared/gatt-helpers.c:1465"
18: B1 Line exceeds max length (132>80): "6  0x00000000004966db in handle_rsp (pdu_len=4, pdu=<optimized out>, opcode=<optimized out>, chan=0x17483c0) at src/shared/att.c:814"
19: B1 Line exceeds max length (83>80): "7  can_read_data (io=<optimized out>, user_data=0x17483c0) at src/shared/att.c:1011"
20: B1 Line exceeds max length (142>80): "8  0x00000000004a0853 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:157"
21: B1 Line exceeds max length (84>80): "9  0x00007fb3f2d7fe87 in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0"
25: B1 Line exceeds max length (161>80): "13 0x00000000004a11f2 in mainloop_run_with_signal (func=func@entry=0x43f200 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188"
26: B1 Line exceeds max length (92>80): "14 0x000000000040c72e in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:959"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5361770915687156730==--
