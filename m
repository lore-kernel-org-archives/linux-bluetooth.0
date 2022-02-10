Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE81C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 07:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiBJHlA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 02:41:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiBJHk7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 02:40:59 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500D3C58
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 23:41:01 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o12so4003546qke.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lt2WBcoRk6Ks+HkwWgL1a3OSDlZ7DQWLR6KpdFlHZbo=;
        b=AOKisn63wYCGDiYmCxYzzzLqhBJd60+N4zOpoDICVUdY7K2i98DFXoXHqgR+EfSvh/
         B4GN3ikPcTJx+2nQMVATxW48lkKBXHuiig7sANIGeXbpOzghzNO4zEz5EV5tzJKDDTnS
         dhQM3pO3CgaotIPDHgBS+ecNWAw+3wGor3PEeMy4QrZdWwW6ZMcD44WBYkJ0GrF7vOza
         ndOp1R4LPpE/OSJpga0L9vsezW3rJpIsemzY5/DExjEU27CupG34rw2JzNI9NQtGAPie
         CWy7Wa2lAFDgWNwX6iBTBpAHrjenWJsp0hY6xHaTPGkd8f8Z8q3EdlCy4XPGqh0uvQf4
         AtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lt2WBcoRk6Ks+HkwWgL1a3OSDlZ7DQWLR6KpdFlHZbo=;
        b=fI3/62XKHC6I1dnp0VnrkY8r540UyqpHlVCHoZX/sDw7/XYCMUjMXN5kTEbnlE/jBA
         VA8XARR26QMAMgcNArAM0XQciyrpZGRaOcfBBawnq4GUSjf060uKnUP2PAylrPna9ywf
         Jp+HfUegVm1mxrXSZLAb/pQWcrIlVsguhMbwtVZj1XMRX7vX2e+RmjBl28sOn9HVS143
         VtNIm8eDbwaooD/SQb8JtxM/SC34sK6Ima/pNz8TSwL2Lr4ay1ZpubzfbAaN7Skpz196
         bRMoRlpKR7ENsfdNzNp9YBLWZsuObrCng4aD2K96azIs1EY2UVeUqtRhMv+7sPWrR+5/
         pBLg==
X-Gm-Message-State: AOAM531o0anV+Rcg6EV0GZKIFFm08ZlJ56FFwGWK0ibMoAhnXqBvN1Sc
        4vh3l2G0hLkmITFd0qoV3eFAA8+JhdxfCQ==
X-Google-Smtp-Source: ABdhPJwWQgwIQGwGUA768vK6sX6Hx7tq9naRswoBWr8zFXBLvY4uVFuLIDyJ+Hcjlwd8NROwq5hdRA==
X-Received: by 2002:a37:4648:: with SMTP id t69mr3041929qka.702.1644478860231;
        Wed, 09 Feb 2022 23:41:00 -0800 (PST)
Received: from [172.17.0.2] ([20.65.66.178])
        by smtp.gmail.com with ESMTPSA id u21sm10173512qtw.80.2022.02.09.23.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 23:40:59 -0800 (PST)
Message-ID: <6204c18b.1c69fb81.291de.8000@mx.google.com>
Date:   Wed, 09 Feb 2022 23:40:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2356654166305401615=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] monitor/sdp: Fixes out-of-bounds array access
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220210060917.50156-1-hj.tedd.an@gmail.com>
References: <20220210060917.50156-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2356654166305401615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612901

---Test result---

Test Summary:
CheckPatch                    FAIL      1.41 seconds
GitLint                       FAIL      1.05 seconds
Prep - Setup ELL              PASS      51.63 seconds
Build - Prep                  PASS      0.86 seconds
Build - Configure             PASS      10.23 seconds
Build - Make                  PASS      1681.24 seconds
Make Check                    PASS      12.47 seconds
Make Check w/Valgrind         PASS      530.25 seconds
Make Distcheck                PASS      281.65 seconds
Build w/ext ELL - Configure   PASS      10.50 seconds
Build w/ext ELL - Make        PASS      1733.06 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] monitor/sdp: Fixes out-of-bounds array access
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
==4180==ERROR: AddressSanitizer: global-buffer-overflow on address 0x7fe2d271a542 at pc 0x7fe2d174a57d bp 0x7ffc6dcac1d0 sp 0x7ffc6dcab978

/github/workspace/src/12741392.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12741392.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] monitor/sdp: Fixes out-of-bounds array access
7: B1 Line exceeds max length (83>80): "monitor/sdp.c:497:19: runtime error: index 8 out of bounds for type 'cont_data [8]'"
9: B1 Line exceeds max length (138>80): "==4180==ERROR: AddressSanitizer: global-buffer-overflow on address 0x7fe2d271a542 at pc 0x7fe2d174a57d bp 0x7ffc6dcac1d0 sp 0x7ffc6dcab978"
20: B1 Line exceeds max length (82>80): "    #9 0x7fe2d2449306 in mainloop_run_with_signal src/shared/mainloop-notify.c:188"
22: B1 Line exceeds max length (85>80): "    #11 0x7fe2d0b440b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)"
23: B1 Line exceeds max length (83>80): "    #12 0x7fe2d2303b7d in _start (/home/han1/work/dev/bluez/monitor/btmon+0x1dbb7d)"
25: B1 Line exceeds max length (138>80): "0x7fe2d271a542 is located 30 bytes to the left of global variable 'tid_list' defined in 'monitor/sdp.c:43:24' (0x7fe2d271a560) of size 384"
26: B1 Line exceeds max length (140>80): "0x7fe2d271a542 is located 2 bytes to the right of global variable 'cont_list' defined in 'monitor/sdp.c:424:25' (0x7fe2d271a400) of size 320"
27: B1 Line exceeds max length (94>80): "SUMMARY: AddressSanitizer: global-buffer-overflow (/lib/x86_64-linux-gnu/libasan.so.5+0x9b57c)"




---
Regards,
Linux Bluetooth


--===============2356654166305401615==--
