Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D4C0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 18:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHASxQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjHASxO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 14:53:14 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762CAE71
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 11:53:10 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76ad8892d49so526754685a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690915989; x=1691520789;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=An4Pg3cd/SgFneX/Yw2mfLBPeNkIGtK5mw1G7OYbGac=;
        b=ZFuo4qLLC9upbx8HsFCPIAspaHNky3ma7lJBQruKNCD5g8jLW5blT/w4ByQXEcw77O
         DC9c17VbJIIHkgkbFeEPN8EYac8AASONYDWDxKCepk0dyPF5qaiheASKEyd8vz+Yj+wC
         FpBJtm3sbWYAeZF1L38PGYuGaiN1+6FQ6Y6XKBR9awdVD5KsbDRhbht2rWGr1tVta8R9
         K16F83YKZXQ/itmxbd4ZvGSjORIlzcWDlKVcsjgMv61cHbAgeMNYO9pD0XoAwdLfPh8U
         LQ1+I2kdN1CTG38mWhPntS73m7VvnHe3QKwFq6O1zOFPR8ttpPT4VxP9qNxNC/yaczyY
         mEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915989; x=1691520789;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=An4Pg3cd/SgFneX/Yw2mfLBPeNkIGtK5mw1G7OYbGac=;
        b=KUjA2lESvgQPwU5G/7PJRJh15dTzslXQcO/Xg/lgc1OEeAcPbduvetpdqY1TVbwOT2
         XsKwbaC1aelV2RCU5xC3FeWLWlKIYCPiFUsTzzNT1wDog1f+XB77cVNoxWSeNqhf1EAA
         7X2Ngjvfd9Fi8H84w8NzY/0F0zUryrxOtGDRXfrEl1QsIyAfG5PECWRxg+FKNVhQajNF
         gQ+hHS+2ltR0vW+A5Y7fPVymroJVd1emGKcFkKLCN9RawMzdelYlDpT9OP/eLsEF9FJm
         k5ao5F0U/jqA9a2wsnLpYz4tXpQG1M6E4Bz5Xdqr4EokgVhpQNmxUoCTqdJPWFoSbVFg
         WE3Q==
X-Gm-Message-State: ABy/qLYkvrirr31y5YQKi8ZHjqvjA/LHYPR92sbiK+kIRwwIAW1DcG/k
        4zvDXXHtUWNnKMtMvGEcNgzD62u5Nyo=
X-Google-Smtp-Source: APBJJlErnzkKCqLDyx5xb3UVhvGL2TWvwPIi6ASmwME+ykukTqlRxmCb/Pk6BredukR2kDhlS+hHVQ==
X-Received: by 2002:a05:620a:19a3:b0:76c:c99b:8d5 with SMTP id bm35-20020a05620a19a300b0076cc99b08d5mr1536177qkb.40.1690915989464;
        Tue, 01 Aug 2023 11:53:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.46.128])
        by smtp.gmail.com with ESMTPSA id g3-20020a37e203000000b00767ed2e6436sm4349532qki.78.2023.08.01.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 11:53:09 -0700 (PDT)
Message-ID: <64c95495.370a0220.f7320.10ab@mx.google.com>
Date:   Tue, 01 Aug 2023 11:53:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3317596285371219651=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Additional tests for ISO and hci_sync
In-Reply-To: <5eca51146b08a512052261b88ae5c8a7437af5fc.1690907478.git.pav@iki.fi>
References: <5eca51146b08a512052261b88ae5c8a7437af5fc.1690907478.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3317596285371219651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=771771

---Test result---

Test Summary:
CheckPatch                    FAIL      3.01 seconds
GitLint                       FAIL      1.95 seconds
BuildEll                      PASS      26.83 seconds
BluezMake                     PASS      785.29 seconds
MakeCheck                     PASS      12.26 seconds
MakeDistcheck                 PASS      156.24 seconds
CheckValgrind                 PASS      251.21 seconds
CheckSmatch                   WARNING   341.55 seconds
bluezmakeextell               PASS      109.60 seconds
IncrementalBuild              PASS      3312.84 seconds
ScanBuild                     WARNING   1019.24 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/5] btdev: check error conditions for HCI_Create_Connection_Cancel
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#277: FILE: monitor/bt.h:596:
+} __attribute__ ((packed));

/github/workspace/src/src/13337000.patch total: 0 errors, 1 warnings, 163 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13337000.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,3/5] sco-tester: test local and remote disconnecting simultaneously

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B3 Line contains hard tab characters (\t): "	[controller] > HCI Synchronous Connect Complete"
7: B3 Line contains hard tab characters (\t): "	[controller] > HCI Disconnection Complete (from remote)"
8: B3 Line contains hard tab characters (\t): "	[user] shutdown(sco_socket)"
9: B3 Line contains hard tab characters (\t): "	[kernel] hci_conn_abort(SCO handle)"
10: B3 Line contains hard tab characters (\t): "	[kernel] > HCI Create Connection Cancel"
11: B3 Line contains hard tab characters (\t): "	[kernel] < HCI Synchronous Connect Complete"
12: B3 Line contains hard tab characters (\t): "	[kernel] < HCI Disconnect Complete"
13: B3 Line contains hard tab characters (\t): "	[controller] < HCI Create Connection Cancel"
14: B3 Line contains hard tab characters (\t): "	[controller] > HCI Command Status (Create Connection Cancel)"
15: B3 Line contains hard tab characters (\t): "	[kernel] < HCI Command Status (Create Connection Cancel)"
31: B2 Line has trailing whitespace: "    "
35: B2 Line has trailing whitespace: "    "
36: B1 Line exceeds max length (84>80): "    CPU: 0 PID: 35 Comm: kworker/u3:2 Not tainted 6.5.0-rc1-00520-gf57f797eebfe #152"
37: B1 Line exceeds max length (85>80): "    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"
64: B2 Line has trailing whitespace: "    "
76: B2 Line has trailing whitespace: "    "
92: B2 Line has trailing whitespace: "    "
105: B2 Line has trailing whitespace: "    "
110: B2 Line has trailing whitespace: "    "
112: B1 Line exceeds max length (93>80): "    page:ffffea00000a7800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29e0"
119: B2 Line has trailing whitespace: "    "
[BlueZ,v2,4/5] iso-tester: test with large CIS_ID and invalid CIG_ID/CIS_ID

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B2 Line has trailing whitespace: "    "
21: B2 Line has trailing whitespace: "    "
22: B1 Line exceeds max length (83>80): "    ISO QoS CIG 0xF0 - Invalid                           Timed out    2.301 seconds"
23: B1 Line exceeds max length (83>80): "    ISO QoS CIS 0xF0 - Invalid                           Failed       0.117 seconds"
24: B1 Line exceeds max length (83>80): "    ISO Connect2 CIG 0x01 - Success/Invalid              Failed       0.189 seconds"
25: B1 Line exceeds max length (83>80): "    ISO AC 6(ii) CIS 0xEF/auto - Success                 Failed       0.196 seconds"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:420:29: warning: Variable length array is used.emulator/btdev.c:420:29: warning: Variable length array is used.tools/sco-tester.c: note: in included file:./lib/bluetooth.h:216:15: warning: array of flexible structures./lib/bluetooth.h:221:31: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1083:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1334:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1456:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============3317596285371219651==--
