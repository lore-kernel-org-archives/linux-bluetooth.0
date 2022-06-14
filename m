Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42B0CCA47A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 13:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiFNNvO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFNNvN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 09:51:13 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37B3701E
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 06:51:12 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z11so6592022ilq.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=x+mh/OSVjk8/FQPFL27wt3FKCJbGS/QNv7zxnCPnbkk=;
        b=pBNwZ4xxxFAjo97lPpVKEpWSKhmgptIpl8MdbKxqefaStIY4lK5ZNV9ujKfKoNLYev
         3tVCUL0eeaiiOYD/zCabzCPFzsAp4JVDcIYWaXiG+buhbHJ38pisRIcVsTkwJzMTS5jV
         D++6NbU4kzhd8KMP/UrXXAkG8PDglZwweiln23TS7mqXecPlDm+zDaCSjRiR1tR0EeM2
         lQeHfKBbFSn1ESxpSZ0UGwW7lKRwxBHZuLYAro/7Tfh+qWuHPpj3CO9zm66xSVjAX+0Y
         nNLJhM/51pxYgJQjebXQfSMhkfv/FUdFmGEPXKQZPSwlBP/nYfNVnAkHzzyi+qGQdXZL
         Dd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=x+mh/OSVjk8/FQPFL27wt3FKCJbGS/QNv7zxnCPnbkk=;
        b=IePfIT6JQjXSMwrmFuumSyj5xILfK1q64exXKrLE62nVLtBoUL6cjWc7ZuusL+3loo
         tUXew3XQFt0Zcclpi1awMuvLqt2ilNcPRI0QdcsS2SsAlFR9ib6TXCm5UqxA9Hnd2G0W
         Y2MsXuq/a3ggHbGoBPe1M4+JQUEFRxapvtkYEdoL8j2TrIDYmskrfGAcFj1OysF/1bL4
         e6YPYJTWI/9wS8izw5yV+MQTubtcznkJQWnqfKwXzpnlgjskx3flTs5RVrFm3GAbdKXV
         GZs61ROhteuTMVOK4mIc6yE3OsNnDExkbRnj1ZEk98esc6i0rB09JtHTp7+IVMkHbgND
         zd1g==
X-Gm-Message-State: AJIora+ZBeuLwRx/gzqJopu41ZojcT8eRanppcBi3om2VZlMe1F1pxCd
        j78ciF39inatGMCZkL0j4Aha+aJkx872kg==
X-Google-Smtp-Source: AGRyM1vszTi+FRxryHJRX2e/MBFDtDAqePOHFJY3lI+o/YUhrHqKEVC9k9zvdTorS69UI+8PT+0jNQ==
X-Received: by 2002:a05:6e02:1207:b0:2d3:b5fb:a802 with SMTP id a7-20020a056e02120700b002d3b5fba802mr3082961ilq.319.1655214671903;
        Tue, 14 Jun 2022 06:51:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.117.97])
        by smtp.gmail.com with ESMTPSA id y3-20020a02ce83000000b0032e7d0a79basm4850744jaq.158.2022.06.14.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 06:51:11 -0700 (PDT)
Message-ID: <62a8924f.1c69fb81.b559c.4bd8@mx.google.com>
Date:   Tue, 14 Jun 2022 06:51:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6132865025644794441=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: Fix transfer has been free during transfer_abort_response func
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220614114914.30497-1-wangyouwan@uniontech.com>
References: <20220614114914.30497-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6132865025644794441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650185

---Test result---

Test Summary:
CheckPatch                    FAIL      1.06 seconds
GitLint                       FAIL      0.77 seconds
Prep - Setup ELL              PASS      43.82 seconds
Build - Prep                  PASS      0.58 seconds
Build - Configure             PASS      8.55 seconds
Build - Make                  PASS      1426.59 seconds
Make Check                    PASS      12.09 seconds
Make Check w/Valgrind         PASS      440.91 seconds
Make Distcheck                PASS      233.61 seconds
Build w/ext ELL - Configure   PASS      8.59 seconds
Build w/ext ELL - Make        PASS      1391.37 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
obexd: Fix transfer has been free during transfer_abort_response func
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#64: 
Breakpoint 3, transfer_complete (transfer=0x5555555f5f40, err=0x5555555f6d60)

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#158: FILE: gobex/gobex-transfer.c:96:
+		transfer->complete_func(transfer->obex, err, transfer->user_data);

/github/workspace/src/12880945.patch total: 0 errors, 2 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12880945.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
obexd: Fix transfer has been free during transfer_abort_response func
35: B1 Line exceeds max length (82>80): "Breakpoint 5, transfer_free (transfer=0x5555555f5f40) at gobex/gobex-transfer.c:61"
44: B1 Line exceeds max length (88>80): "Breakpoint 2, transfer_abort_response (obex=0x5555555f5b50, err=0x0, rsp=0x5555555f0810,"
54: B1 Line exceeds max length (106>80): "Breakpoint 3, transfer_complete (transfer=0x5555555f5f40, err=0x5555555f6f00) at gobex/gobex-transfer.c:99"
59: B1 Line exceeds max length (95>80): "Breakpoint 4, xfer_complete (obex=0x5555555f5b50, err=0x5555555f6f00, user_data=0x5555555f7000)"




---
Regards,
Linux Bluetooth


--===============6132865025644794441==--
