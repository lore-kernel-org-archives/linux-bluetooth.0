Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F7C04E69
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 16:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjHPQi2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344865AbjHPQhz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 12:37:55 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93242D41
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:37:16 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a80e665410so2171394b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692203835; x=1692808635;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss9yuJisZEYMmCiy+BIRxhWXaLe7LGvA4InOib6KNrE=;
        b=ernE3XwIUgkghc/l/rZ0tusF+FN0GW739OLjNwuNTEvah1yf1O7JKHC0WfeeuofRNr
         c63zLYZfq/ljM9NhU7rLlZerpECn0WpwcAbVTP15G/5Fo3/+jHWbpFSsvta4zfnvWlWu
         aHgq+V0xhpmzhMiBrXg/dMCRw97POEJc77syle5boSGEVdjXjMtFtJg2kcKFOo5CV6Lb
         cYmmZXtkn/sp3xmDcYmqRRB0hzkAYwptI1sVzMwuIvG0D6Ww6/TuJIL1oqSTBnU7vgWr
         U3JhoSAFNnTjW4mxopYjMRmUTpryGKM7BMiZMr45VDgNJD0IEZyS8L5HqwNtCSeO+olw
         EpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203835; x=1692808635;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ss9yuJisZEYMmCiy+BIRxhWXaLe7LGvA4InOib6KNrE=;
        b=cbfP6TeBRNcWNJ+bD+DRkW9TrNOdFa20ob47qJKs0+jpbHr57I5QNrHVeD7GhqEIaM
         4jc2088CnARx9sF5x0VWHY98aZDjm0VSFva08vmlYwd+CZ+LsSgjTAApH7bIPJeQTFGu
         n7KUjAOt0kfu5TcUZP7dEOneWJRwgMI4Hwo4+r2uqgQaImvhtef3H93D8tk/lULXzsIi
         NlXlsrCQens7UH16h6c4XnwT/j7Dt9sSyfoSdpf/v63xIBE19AFcB2PokjwA2isPY97n
         3O5GvkrxAWAcfzIiluxmxBqu3DSNXWzOmyId1YKGa4E3kHEQXjtUzZlB5hxfApvq0mDQ
         pbfg==
X-Gm-Message-State: AOJu0YwTiUhO/36m/2YAK8VXtacC8jbSQ8PijX1UK1mV10l33FiAlrtH
        hJByWtTODlaAsmtS+ByzE7xMSGmMWvU=
X-Google-Smtp-Source: AGHT+IF06nLYeKQvMjM31YWhvISPS0GNP/+Vqxn76pFS9SR1aogAxB2OFlFAFdqOimhSceoq9mel1w==
X-Received: by 2002:aca:1001:0:b0:3a7:250a:7948 with SMTP id 1-20020aca1001000000b003a7250a7948mr2858852oiq.13.1692203834683;
        Wed, 16 Aug 2023 09:37:14 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.166.1])
        by smtp.gmail.com with ESMTPSA id v13-20020a63bf0d000000b00564b313d526sm11155631pgf.54.2023.08.16.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:37:14 -0700 (PDT)
Message-ID: <64dcfb3a.630a0220.59b96.2eb8@mx.google.com>
Date:   Wed, 16 Aug 2023 09:37:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6528425613037642425=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast receiver defer setup
In-Reply-To: <20230816150917.7896-2-iulia.tanasescu@nxp.com>
References: <20230816150917.7896-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6528425613037642425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776679

---Test result---

Test Summary:
CheckPatch                    FAIL      0.76 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      35.28 seconds
BluezMake                     PASS      1255.12 seconds
MakeCheck                     PASS      13.33 seconds
MakeDistcheck                 PASS      201.74 seconds
CheckValgrind                 PASS      326.91 seconds
CheckSmatch                   PASS      458.96 seconds
bluezmakeextell               PASS      136.65 seconds
IncrementalBuild              PASS      1078.93 seconds
ScanBuild                     PASS      1460.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] iso-tester: Add test for bcast receiver defer setup
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#131: FILE: tools/iso-tester.c:2353:
+static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
                                          ^

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#150: FILE: tools/iso-tester.c:2386:
+		data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_accept_cb, NULL);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#153: FILE: tools/iso-tester.c:2389:
+		data->io_id[0] = g_io_add_watch(io, G_IO_OUT, iso_connect_cb, NULL);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#182: FILE: tools/iso-tester.c:2991:
+	test_iso("ISO Broadcaster Receiver Defer - Success", &bcast_16_2_1_recv_defer,

/github/workspace/src/src/13355383.patch total: 1 errors, 3 warnings, 71 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13355383.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6528425613037642425==--
