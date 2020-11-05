Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5167C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 00:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8152621734
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 00:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUyLhPPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbgKEAxt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730623AbgKEAxt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 19:53:49 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB57C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 16:53:49 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h12so23097qtu.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 16:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lXf6+nA947DTqqyE+5/hnw1R1r16mxdr4M9peAEhwXQ=;
        b=iUyLhPPamoJEjbyIj/Ob6VFU5LUQ0aEYOT1HTEiOkfZKogHQZZmPNvxPmhjAvLOvjL
         5F7/wlbg2eSWyUtiLaPYFZ+SoYgoXNNBWuT0NlmbVjb31priLKsILQOXHema4o63msta
         cRdJ0L29/K+4OYlel7UgV+lZpdTOlRTTvO1Rcpk1aJk1qck+vpj5gljyIPgmvD4J7mu4
         uJhGq36M5Ljh2b/sLisd+9WzTAJTOsHjbPG+b6NYffRWChqC+42yZS+SF3S3xKRGJoSt
         Tk/SYdvmRRidB8om+SK9Cs+Jk5kmFaUne5K9ww9FKO2F0iTJ1Y7Cw1y6rN/TzUMxwjwH
         FURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lXf6+nA947DTqqyE+5/hnw1R1r16mxdr4M9peAEhwXQ=;
        b=DvrjbgmL3p3/krCOgW+4nzKKu9aGe0p3JaKx9dAZw7ue+3jalVWFeRTH9ELWdw8j/b
         KHNiRHV/vLX7czdDKd4/ePUwQmctwyF/6LMpSVXWiwmhl9QnabwI4Id9NIFu5lpeD3V3
         IGhn//JT6DUy20aorQG3e5cbZwMngW2WF4iJvSrc/z+khh1XdsxmlUE/bF/smrXdr/vi
         mz/EifyzzUwDVv1ObBKCLIm0AhJLdStfoaTAnrE/BYbln/yJmzBvmU4Teu5EbhcPzk5h
         ndRNzzOtPrs9h4W1sJUgBHlzG/KUBXGthurblrG/nIvyftsfiDzZsxRW5upAehpFfCDp
         FAog==
X-Gm-Message-State: AOAM531/NOQDsLY6nqp9uZuk8ZhXYwMvTrs053/quLY3gYzEA12DsTRs
        2MIo4bv3hfRwUAI4tWeV0KOqQ5G5tU+1+Q==
X-Google-Smtp-Source: ABdhPJyxLsRy99Ro1w5G8FwORdGiFopqNZ3oFtPnR2e5QyB4kbAEsEZXyYN303rzsolpscErOSwWqA==
X-Received: by 2002:a05:622a:18f:: with SMTP id s15mr725399qtw.160.1604537628356;
        Wed, 04 Nov 2020 16:53:48 -0800 (PST)
Received: from [172.17.0.2] ([52.251.57.101])
        by smtp.gmail.com with ESMTPSA id q3sm4051237qkf.24.2020.11.04.16.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:53:47 -0800 (PST)
Message-ID: <5fa34d1b.1c69fb81.5765.5fbb@mx.google.com>
Date:   Wed, 04 Nov 2020 16:53:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2630476086937727165=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] gatt-client: Do not continue service discovery if disconnected
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201105002412.37720-1-sonnysasaka@chromium.org>
References: <20201105002412.37720-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2630476086937727165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=377767

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
gatt-client: Do not continue service discovery if disconnected
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#12: 
0  gatt_db_service_get_handles (service=0x1751130, service=0x1751130, end_handle=0x7ffcd600806e, start_handle=0x7ffcd600806c) at src/shared/gatt-db.c:569

WARNING:BAD_SIGN_OFF: 'Reviewed-by:' is the preferred signature form
#28: 
Reviewed-By: Archie Pusaka <apusaka@chromium.org>

- total: 0 errors, 2 warnings, 73 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] gatt-client: Do not continue service discovery if" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
gatt-client: Do not continue service discovery if disconnected
8: B1 Line exceeds max length (153>80): "0  gatt_db_service_get_handles (service=0x1751130, service=0x1751130, end_handle=0x7ffcd600806e, start_handle=0x7ffcd600806c) at src/shared/gatt-db.c:569"
9: B1 Line exceeds max length (170>80): "1  gatt_db_attribute_get_service_data (attrib=<optimized out>, start_handle=0x7ffcd600806c, end_handle=0x7ffcd600806e, primary=0x0, uuid=0x0) at src/shared/gatt-db.c:1657"
10: B1 Line exceeds max length (150>80): "2  0x00000000004983a8 in discovery_op_complete (op=op@entry=0x173b320, success=<optimized out>, err=err@entry=10 '\n') at src/shared/gatt-client.c:406"
11: B1 Line exceeds max length (172>80): "3  0x000000000049a548 in discover_descs_cb (success=<optimized out>, att_ecode=<optimized out>, result=<optimized out>, user_data=0x173b320) at src/shared/gatt-client.c:915"
12: B1 Line exceeds max length (142>80): "4  0x00000000004a1d87 in discovery_op_complete (op=0x1748450, success=<optimized out>, ecode=<optimized out>) at src/shared/gatt-helpers.c:615"
13: B1 Line exceeds max length (161>80): "5  0x00000000004a2379 in discover_descs_cb (opcode=<optimized out>, pdu=0x174d551, length=<optimized out>, user_data=0x1748450) at src/shared/gatt-helpers.c:1465"
14: B1 Line exceeds max length (132>80): "6  0x00000000004966db in handle_rsp (pdu_len=4, pdu=<optimized out>, opcode=<optimized out>, chan=0x17483c0) at src/shared/att.c:814"
15: B1 Line exceeds max length (83>80): "7  can_read_data (io=<optimized out>, user_data=0x17483c0) at src/shared/att.c:1011"
16: B1 Line exceeds max length (142>80): "8  0x00000000004a0853 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:157"
17: B1 Line exceeds max length (84>80): "9  0x00007fb3f2d7fe87 in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0"
21: B1 Line exceeds max length (161>80): "13 0x00000000004a11f2 in mainloop_run_with_signal (func=func@entry=0x43f200 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188"
22: B1 Line exceeds max length (92>80): "14 0x000000000040c72e in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:959"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2630476086937727165==--
