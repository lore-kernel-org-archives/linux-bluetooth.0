Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5022C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jul 2022 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGITaL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jul 2022 15:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGITaK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jul 2022 15:30:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0AAEE32
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 12:30:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b9so1681200pfp.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jul 2022 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=c1xZXROHvfD3b1AAcDLV7ulORsCqYCLvJ7U++NizIC4=;
        b=CJC7R/OmVEIif+5fEo8qML2gid6nKYESo746qseEeKugRY/li6eGeqyGyWDksBdoYy
         z3rmtJVPi7x0Y56Y8dpvk0plZL3e2kdXK6jDc0MufL653PBILwjfTTpNLAIyhVWrJX5Z
         Hr2+KPZgHRhI6mGuzBYkKIk3rj8/ZjrENc+scRnvev937CrUnm/Mg73YVOtV/3nBiWO6
         0JkQrNU8QzYs140cdJc6I8K7H36ni9mVIvXvFaWD0sQCdoz6YGQ4DliIVeeWcWJD0Nsu
         v9zm1wowI8UU3ZgjorA+u+2lHuY19LTVktc9wKRaITKign8fr82xwWa2M5I6Z9uopKez
         RTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=c1xZXROHvfD3b1AAcDLV7ulORsCqYCLvJ7U++NizIC4=;
        b=tgCFTyR/AD8tHdjL02IJwwJpINtPhosPyIdxd2brx4t12R1sxA/UML2MzThY8JQSjy
         aZNY/yrV0cCUO1AiM3tZn6RSkXfmA1n4ZQ3/GJMpnPyEscufvTCx5GK8XKiSJ95Ruo9f
         yEaMGAQNdnX04eQ3SvMuDXduVcJVykhU7gQ8sMISxr7iBoQQ36GsnfgMiTnN1LKGIazN
         u6upaH2aN8vid3ZDng9f/L8uDaQJM4p3he9aonR/z/Y9dTprTURc9Pgd+L7PCwCOD57Z
         7RSn0SQPthjxFNN3rRTqH+Do0PXbQCawwo+GSrtIDbS3YSadiNT+s/iaMfXWYkef7m71
         bhMQ==
X-Gm-Message-State: AJIora+Kd+pGKm1/iwZ0JmffkG/Byt+QPCe2iBJc6eSlQfwCPpUB8H3E
        Te+qIl/IheT7f1YvInBIl1WIZxeigyY=
X-Google-Smtp-Source: AGRyM1vhI+8WKaoffOt2SOl+PSeGmqlF7iwM6mtB/7vh3AzfL5AvMlP7WgUMdxQ72MNvmr1uAoX2pQ==
X-Received: by 2002:a63:5818:0:b0:412:3c6a:8d0 with SMTP id m24-20020a635818000000b004123c6a08d0mr8893709pgb.155.1657395007723;
        Sat, 09 Jul 2022 12:30:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.158.144])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a02d600b001ef95232570sm3776891pjd.52.2022.07.09.12.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 12:30:07 -0700 (PDT)
Message-ID: <62c9d73f.1c69fb81.c40a2.5c0e@mx.google.com>
Date:   Sat, 09 Jul 2022 12:30:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2126856281251700236=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, shwoseph@gmail.com
Subject: RE: ExcludeAdapter configuration setting for input plugin
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220709183524.13900-2-shwoseph@gmail.com>
References: <20220709183524.13900-2-shwoseph@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2126856281251700236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=658204

---Test result---

Test Summary:
CheckPatch                    FAIL      0.78 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      31.19 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      9.53 seconds
Build - Make                  PASS      1033.85 seconds
Make Check                    PASS      11.76 seconds
Make Check w/Valgrind         PASS      325.07 seconds
Make Distcheck                PASS      270.26 seconds
Build w/ext ELL - Configure   PASS      9.60 seconds
Build w/ext ELL - Make        PASS      95.31 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      601.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/1,v2] ExcludeAdapter configuration setting for input profile
ERROR:TRAILING_WHITESPACE: trailing whitespace
#167: FILE: profiles/input/manager.c:39:
+^I$

WARNING:BRACES: braces {} are not necessary for single statement blocks
#174: FILE: profiles/input/manager.c:46:
+		if (strcmp(addr, exclude_adapters[i])) {
+			return 0;
+		}

ERROR:TRAILING_WHITESPACE: trailing whitespace
#178: FILE: profiles/input/manager.c:50:
+^I$

ERROR:TRAILING_WHITESPACE: trailing whitespace
#198: FILE: profiles/input/manager.c:144:
+^I^I$

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#205: FILE: profiles/input/manager.c:151:
+			DBG("input.conf: ExcludeAdapters=%s", exclude_adapters_str);

/github/workspace/src/12912299.patch total: 3 errors, 2 warnings, 103 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12912299.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2126856281251700236==--
