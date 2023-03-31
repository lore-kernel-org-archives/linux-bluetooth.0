Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67103C761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 21:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCaVRS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 17:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaVRR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 17:17:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4909E1EA27
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 14:17:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id hf2so22941960qtb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680297435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JlN1QMt9opeSrTqZ1CtrjjIM9SYWpp8o2ods/woOz48=;
        b=aYBOPsukSnVgbb55Mnt4DCG74znwcnhRW09bJt/D1uQ5s41ZnLQd+lvXx6NXcVZxp7
         xtApV9b9wlG0rncdh5/ej+imW3GqWvh2alBH3J9MMfwUMHiDiYrVNHPD+9ika+epp7D0
         cFbKqWdSPBY3z7dX/AQO6cIq+lKxH9ln84yTI80pmQUHilSzkV3pwVhxEn+dOU+cnZiZ
         91FHFt2p6HaHOaQBIXzLsYPBHRAaMjsTiXpKtUUyiUDdAsCHdzDlOz7RDGJ31nB0HBma
         g7l8icS5u+RYsBr02Lc6d8h1bmRWrdQfdHErRH3Wkdq4cST2b001zGCgt3+oPbzkGsna
         x43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680297435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlN1QMt9opeSrTqZ1CtrjjIM9SYWpp8o2ods/woOz48=;
        b=h6pHxm75Mp+3GzczHJdkyTPycfUi8awk8d5+EkixpB98Tt93iByJ2Hu647AzcfNehK
         ihbSn3fwggtlQmaQg2+nNF9lazPcsvrinawHbQgWkqNlK+IxwfAsLUHut1Icip8JxT54
         vtGBc5NuUk+FmcNezxsLVRNVjd8+HUOPFdmfO1/3ZaaopsE5nTj0IPhfh5COMMfduHjA
         WslukRjZrC/LJpbHreHSdx7JJ8+VyOcoccJO1iOLAOul5kmn3IQImnLkAs7AcTq+x0MR
         uID4QXkrT3PjZ03iPyv7rGWqt4WPqKZX0xPQG+HYvB0s+sz/pznKmy5xkeQQOWw5wBPe
         vPJg==
X-Gm-Message-State: AAQBX9dhuCVx0L4T5pFO9luD7YXOnE8ahxpMbH0nwS8Cuo9CYtyEkFtE
        kKWoZeGJ98SbgLgeIEoD7zJ2+k9WTHQ=
X-Google-Smtp-Source: AKy350YAooZdc0kRPmOlz5NqLIkyfDe19lB96Q2QBqzmpVnngI8TbLEIYiAlw6IJXbJOXHDPHMa0jA==
X-Received: by 2002:ac8:58d2:0:b0:3b9:bc8c:c1f6 with SMTP id u18-20020ac858d2000000b003b9bc8cc1f6mr20500672qta.1.1680297435334;
        Fri, 31 Mar 2023 14:17:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.50])
        by smtp.gmail.com with ESMTPSA id i63-20020a378642000000b007486fc7a74csm909942qkd.135.2023.03.31.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:17:15 -0700 (PDT)
Message-ID: <64274ddb.370a0220.96076.4d5b@mx.google.com>
Date:   Fri, 31 Mar 2023 14:17:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0943456519975681535=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: [BlueZ,v2] adapter: Use regular discovery for filters which only have discoverable set
In-Reply-To: <20230331200329.461355-1-hdegoede@redhat.com>
References: <20230331200329.461355-1-hdegoede@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0943456519975681535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735968

---Test result---

Test Summary:
CheckPatch                    FAIL      0.78 seconds
GitLint                       FAIL      0.74 seconds
BuildEll                      PASS      30.08 seconds
BluezMake                     PASS      959.28 seconds
MakeCheck                     PASS      11.70 seconds
MakeDistcheck                 PASS      163.67 seconds
CheckValgrind                 PASS      265.82 seconds
CheckSmatch                   PASS      357.50 seconds
bluezmakeextell               PASS      109.16 seconds
IncrementalBuild              PASS      767.40 seconds
ScanBuild                     PASS      1090.61 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] adapter: Use regular discovery for filters which only have discoverable set
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#100: 
        UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)

/github/workspace/src/src/13196553.patch total: 0 errors, 1 warnings, 35 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13196553.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] adapter: Use regular discovery for filters which only have discoverable set

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[BlueZ,v2] adapter: Use regular discovery for filters which only have discoverable set"


---
Regards,
Linux Bluetooth


--===============0943456519975681535==--
