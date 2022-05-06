Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 03:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388474AbiEFDUS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 23:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388465AbiEFDUO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 23:20:14 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0911A816
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 20:16:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h3so5072357qtn.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 20:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=4mexQ/GlM57KRSw+jrxlxJ9K/NlFS0grIfOADe/BCcA=;
        b=G5z1Zp4wkcgqMs/q04lbQ0kdayXFsHX45rWzILca+d3eS+DW37z2h+QugdsmlnYsO2
         YDVsMqIsLTeJyAbqGo729aAqyexfFNzUlnBxeDuvDLkoxrSCJkD9PwdxuZlywnPdvZnp
         sBuVh5EktbSrxgIzamKc5RFbr+Tefiw83PxYdPjajzTguBgGNafYMKGA5qMjEv8BaGM6
         CR5gxYjAe1ODv2QqkIFyEfDnQd0vTy/HtbsOSddQyPOABcoUSW7v7qMYiblx5kjyGBt/
         av5VskEt4RdlzatpSkUPcBRhxLK+WK20rCEXb0f5KOu/32yWPzfUckYolO+ptEvTsSyd
         IAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=4mexQ/GlM57KRSw+jrxlxJ9K/NlFS0grIfOADe/BCcA=;
        b=jqAeQ8jOS50ShNg6oS/4j0FXGe82chJ5d56E4ryAlf+FNFiYeF0uheoewOZUmUnsHG
         JY/pk9DeWY5nGRSSu2U/3zr09zTTz00LQqq78eAxzlHGQM/0jaf8C/80Y5b4U10rev5f
         Y0dPAULU5FTwj7NkIXVRvgxMRPqjsXFgwtxFzAZ2OyfGiDUUOoRs0fISOA93Or7JOSzc
         CCBUsZrcWGrKjrtYjk+n7Hj6VPr7FX+ekTATFpYfSZYSeOyMYUi+euCAZw3Pr6s1ivKg
         zppmVHRV92igzJHVwvxTrYjKgWu6Z2Z6vShmiXf6YSWvNbo7kvXN10reZc8ExwVN8Z6B
         /uOg==
X-Gm-Message-State: AOAM532D/iTt91tkcChxLB0GHfMMwQyXrv1oF9jH/qOIWLkzAynQfO4R
        fFIgrG9w+Zc6uMv5lSNl1H/TYPSM6LM=
X-Google-Smtp-Source: ABdhPJyMssrDaYAZ80bjRgRolqA9HHfzAy/iW/JIJP1N2f3LoYoPIVV4EJR7yE7pGTRAbtkX4J8h1Q==
X-Received: by 2002:ac8:7d4e:0:b0:2e1:ba47:d757 with SMTP id h14-20020ac87d4e000000b002e1ba47d757mr1094418qtb.248.1651806990502;
        Thu, 05 May 2022 20:16:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.66.2])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a0a1300b0069fc13ce226sm1791416qka.87.2022.05.05.20.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:16:30 -0700 (PDT)
Message-ID: <6274930e.1c69fb81.79fcf.a5d5@mx.google.com>
Date:   Thu, 05 May 2022 20:16:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7270095866849796900=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/7] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220505224727.3369989-1-luiz.dentz@gmail.com>
References: <20220505224727.3369989-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7270095866849796900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=638906

---Test result---

Test Summary:
CheckPatch                    FAIL      13.32 seconds
GitLint                       PASS      7.35 seconds
Prep - Setup ELL              PASS      59.71 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.68 seconds
Build - Make                  PASS      1450.44 seconds
Make Check                    PASS      11.91 seconds
Make Check w/Valgrind         PASS      454.93 seconds
Make Distcheck                FAIL      191.58 seconds
Build w/ext ELL - Configure   PASS      9.59 seconds
Build w/ext ELL - Make        PASS      1400.13 seconds
Incremental Build with patchesPASS      10106.17 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,6/7] tools: Add isotest tool
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#182: FILE: tools/isotest.c:65:
+static int defer_setup = 0;

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#183: FILE: tools/isotest.c:66:
+static int sndbuf = 0;

ERROR:INITIALISED_STATIC: do not initialise statics to false
#185: FILE: tools/isotest.c:68:
+static bool quiet = false;

ERROR:GLOBAL_INITIALISERS: do not initialise globals to NULL
#187: FILE: tools/isotest.c:70:
+struct bt_iso_qos *iso_qos = NULL;

ERROR:SPACING: space required after that ',' (ctx:VxV)
#709: FILE: tools/isotest.c:592:
+		syslog(LOG_INFO,"Send is behind: %zd us - skip sleep",
 		               ^

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1224: FILE: tools/isotest.c:1107:
+		/* Fallthrough */

/github/workspace/src/12840293.patch total: 5 errors, 1 warnings, 1221 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12840293.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: Make Distcheck - FAIL
Desc: Run distcheck to check the distribution
Output:
make[2]: *** No rule to make target 'tools/isotest.1', needed by 'all-am'.  Stop.
make[1]: *** [Makefile:4342: all] Error 2
make: *** [Makefile:11250: distcheck] Error 1




---
Regards,
Linux Bluetooth


--===============7270095866849796900==--
