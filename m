Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B34DC25B47
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Oct 2023 07:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbjJ0H3M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Oct 2023 03:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345351AbjJ0H3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Oct 2023 03:29:11 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AC5192
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Oct 2023 00:29:09 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7789a4c01easo135266685a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Oct 2023 00:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698391748; x=1698996548; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zwcIeM/NENdFh8N3Ybu9IPPxFayGb+rVRQTFKJYqzg8=;
        b=KEQZhjjWCqQRtIguGV/aCyXOC75VVBbQofhzL6kUiTwvObEd3j1DVMOhoA62p+zXHe
         dy1Y3OtF/vCJCP3k0alfeXoE43A7AcRgHKYJOQnI78o4DlAy4cWy1GwcgjCLSizwXcR0
         618QhENO0nko3rRkSt4g6L6u8ORNuEK9hq0x5XGGgogx0Pua34a36DpwXW+TLOhv7PQs
         6ptf9hKK+uQ45jeZ8GIPQOKuyUmF2ZBnH5t+Du6UOXSzCHW9Pt1z4FRGj1vjIqIJoajX
         M48FnDV7pEgwKMETXeSvd7kgmRdURvfMv59G7pE9X1UNVsNUmZXdWfvlrkyhU/Y/K4MQ
         hBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698391748; x=1698996548;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwcIeM/NENdFh8N3Ybu9IPPxFayGb+rVRQTFKJYqzg8=;
        b=eLLTuo6xW5znp19ij+jdY5sM8qCpjBx7hC6Se1mPKp5bdHsWImCPeguAvCeAyzRL6r
         zrE3d7om1yYpDc5k2+hCachMpHg28ArbETqI/eqpJeNYf2SCYdaYwmgth6EbJUSxYrMp
         kp2KUUNX9xdtetS3YHvD2jgYDoh5PbHQT4HDSRiddW7+xbpYvzyJBUN3JQh8/mwWtype
         bdW9bniGaAWIyNhdctco+BEtWDTus/0/dwH7CSIl9sgQ+LJrjA/0PjsBeUIlzxbECAFM
         rIcARQFegEdMj3qlhz95JW6LwcVHLwQE72P03+upMk7qMmLONMzlVI4aRPaUApnTuE6y
         XfYw==
X-Gm-Message-State: AOJu0YwbRkulbVesEOij+ACCazZH7UBDSfEwgVFD1FmllbTTFpgq9Lzn
        TtG8Q5akhI6E0QmE/tc7qg/arxGEhqE=
X-Google-Smtp-Source: AGHT+IFngPZO5U81eVshbHpCTDrssDO72QYAllKavpev19Aaxi43U+XkfOYPxkKuNIFJafXxvnlXbQ==
X-Received: by 2002:a05:620a:1aa2:b0:76f:1268:9e26 with SMTP id bl34-20020a05620a1aa200b0076f12689e26mr2009105qkb.24.1698391747848;
        Fri, 27 Oct 2023 00:29:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.43.171])
        by smtp.gmail.com with ESMTPSA id p21-20020a05620a057500b0077a02b8b504sm341659qkp.52.2023.10.27.00.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 00:29:07 -0700 (PDT)
Message-ID: <653b66c3.050a0220.d5d0e.22c2@mx.google.com>
Date:   Fri, 27 Oct 2023 00:29:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7088141712524279297=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, juerg.haefliger@canonical.com
Subject: RE: [BlueZ] shared/shell: Fix --init-script commandline option
In-Reply-To: <20231027055423.13617-1-juerg.haefliger@canonical.com>
References: <20231027055423.13617-1-juerg.haefliger@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7088141712524279297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=797007

---Test result---

Test Summary:
CheckPatch                    FAIL      0.75 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      34.28 seconds
BluezMake                     PASS      998.57 seconds
MakeCheck                     PASS      13.63 seconds
MakeDistcheck                 PASS      204.73 seconds
CheckValgrind                 PASS      320.96 seconds
CheckSmatch                   WARNING   423.94 seconds
bluezmakeextell               PASS      141.24 seconds
IncrementalBuild              PASS      838.70 seconds
ScanBuild                     PASS      1271.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/shell: Fix --init-script commandline option
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'f2f7c742ad0b', maybe rebased or not pulled?
#105: 
Fixes: f2f7c742ad0b ("shared/shell: Add support for -i/--init-script")

/github/workspace/src/src/13438114.patch total: 0 errors, 1 warnings, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13438114.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============7088141712524279297==--
