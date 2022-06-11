Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jun 2022 00:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiFKAhf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 20:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKAhe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 20:37:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C576E31232
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 17:37:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x7so507359qta.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=A2OHLdESiCfBsTpenHX5hyf6FK86YY6cTSpomgp3LFQ=;
        b=BI6fmD05JmDJuIsgWXN1KF3NG6xIXPaQtBnMIlB3ECMoMIpT8RKJWd9KzaMun9ANCL
         RTwr+DaaGla6XcO1P2jHUWA09J9J8tYtlCd5LaV6yQH3bZMhZMKfCmjTj4MirsFx+9yI
         7utbgOMVGOwbico6l5GH6091cnJWPop6Zwi60VPtmYFSamB/OgBt+8UhjM1pipN+kHiJ
         gFKN9c1gQVNFfAWcf6fEEyvsNbhU3EdRuw/hnpBsPK8fluiyww01QQH4QTEGzZLSsyCQ
         BwtKBPPfAlMPqcMvJ67Kn4yOjKHC0jnPviPauG1th6bb4K4lgsVyc0ncg6yyT1UWiVQM
         MTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=A2OHLdESiCfBsTpenHX5hyf6FK86YY6cTSpomgp3LFQ=;
        b=KB97zxd7isbAIrfjROeqdS69+bHzRijclHtcWkEG3uWb7+NMVTIE3UiM+0iZp1+JH7
         MYU5gSFK9syGEql5mndvKGow5wkxGoKYA+q35kHYcHl12SKPCGnK9Q1Ezow1DvB4n/Jt
         R4cSr+6gInD2H9xqssQv1J94LP7yDiAkR3x/6UWgV7xTqS+VqfdY0+VFjEZ6pxIL2xnT
         QYAOHhhqC+NqcxhDWTpDugM0zkew0Fc9TQUs2yu+Qb8+JEjdPUwX22eckzvYxvK8WpdC
         yrtUMhc83uucHTVfwQyrPVD74sVALFRQrVg4bd8DsgRKH12dH6NbE9EW/rvPYlle6gHF
         ALHg==
X-Gm-Message-State: AOAM531fMLk9MvCifuCICeJ4RONkRX2F9J0g8sELSYHu6TwIZdEbQjmb
        lztEhp5BdmqgLp2viPLbk2C3vprJQYHH2w==
X-Google-Smtp-Source: ABdhPJzhje/FuXmnBh4xD0sn5FQt7qfu0HRUrLqp2S/Xbo8H258vgZaGO6OM+jbyk3qiAA3YgkxXhA==
X-Received: by 2002:a05:622a:1749:b0:304:f43c:d7c with SMTP id l9-20020a05622a174900b00304f43c0d7cmr20559765qtk.91.1654907851663;
        Fri, 10 Jun 2022 17:37:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.188.117])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a255200b006a76a939dbasm96136qko.112.2022.06.10.17.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 17:37:31 -0700 (PDT)
Message-ID: <62a3e3cb.1c69fb81.6a9f7.023b@mx.google.com>
Date:   Fri, 10 Jun 2022 17:37:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4365974123598858539=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, puffy.taco@gmail.com
Subject: RE: LE OOB pairing support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220610221124.18591-2-puffy.taco@gmail.com>
References: <20220610221124.18591-2-puffy.taco@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4365974123598858539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649437

---Test result---

Test Summary:
CheckPatch                    FAIL      4.40 seconds
GitLint                       PASS      2.99 seconds
Prep - Setup ELL              PASS      43.55 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      8.77 seconds
Build - Make                  PASS      1434.98 seconds
Make Check                    PASS      11.93 seconds
Make Check w/Valgrind         PASS      450.60 seconds
Make Distcheck                PASS      234.96 seconds
Build w/ext ELL - Configure   PASS      8.77 seconds
Build w/ext ELL - Make        PASS      1408.11 seconds
Incremental Build with patchesPASS      4282.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2,1/3] eir: parse data types for LE OOB pairing
WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#202: FILE: src/eir.h:40:
+#define EIR_LE_SC_CONF              0x22  /* LE: Secure Connections Confirmation Value */

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#203: FILE: src/eir.h:41:
+#define EIR_LE_SC_RAND              0x23  /* LE: Secure Connections Random Value */

/github/workspace/src/12878130.patch total: 0 errors, 2 warnings, 111 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12878130.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,2/3] Accept LE formatted EIR data with neard plugin
WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#184: FILE: plugins/neard.c:581:
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#193: FILE: plugins/neard.c:599:
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#206: FILE: plugins/neard.c:617:
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#243: FILE: plugins/neard.c:750:
+								remote.address_type);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#252: FILE: plugins/neard.c:774:
+							remote.address_type, io_cap);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#322: FILE: src/adapter.h:216:
+					const bdaddr_t *bdaddr, uint8_t bdaddr_type,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#323: FILE: src/adapter.h:217:
+					uint8_t *hash192, uint8_t *randomizer192,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#324: FILE: src/adapter.h:218:
+					uint8_t *hash256, uint8_t *randomizer256);

/github/workspace/src/12878131.patch total: 0 errors, 8 warnings, 206 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12878131.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4365974123598858539==--
