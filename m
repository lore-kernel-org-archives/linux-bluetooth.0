Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Apr 2022 04:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiDEE6A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Apr 2022 00:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDEE56 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Apr 2022 00:57:58 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CD56543
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 21:56:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b18so9533796qtk.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Apr 2022 21:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Htm+OshKvAVGdr54FVpJ8CYDFWnBQqW98yqMzSCL5Q4=;
        b=nIepTmglcq0V9/LUVQw8zXt7PLuhhKEasIrmAQ+v8T7D+hSFIrTJYcydWJHq5CutQi
         Kmel5rh7koMEMprhTV1ADf8dkSmSYeFtPSSNnTrMyKn93DQnQkZOZ0v231hOfPLQ1bgY
         QHDmOkANh0hvrrPFa0jQ8HAtN/LYqerahJJ/MpyhgJ1r31jWskQBv551+YnEA3HeN/fQ
         JupbJdBP6OvAcYMuUwx93GW2Lzve3FhWarhYmxFUei1ya+IqJ2kxbmlSYeuaZP/Rrv8h
         ukpCW71IjwK3SarIkRtnXTJK0xQf48REM0cjx5PkwAEG18PqshN/CmZKsZZqbCNLEZCz
         uObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Htm+OshKvAVGdr54FVpJ8CYDFWnBQqW98yqMzSCL5Q4=;
        b=BxYmOlOvlQ0gIy/d9VIF3X98Nx2MEXZQt/ZClRAIOrIhvExj52cLT4n2CmI2CJQtjD
         jladcI9rz9nXrE9FnwFJtOvO3I5MAPxMEMapAN96BBQGugtFjs5WSPlmA+EyaLA60n5r
         mmIPv2IGebWsJxy9zHFzXpPI45wwZlO4IABLhGsXeXZX9BHtZ5mZVFQdL+t0LySTVW6v
         ZYYqg3hc2RZlmdk8Upy6XOExGpXRdjTRhwr0Ysh9r82XfCsLIwGuymkRoJ8Qbm4BAoF2
         oSi5DUDZUE401TMiUNxto6bMfmklB47/9Nysp0G0o53sUlj/8TXHp4RrOSG7qIKf3lxH
         tBpQ==
X-Gm-Message-State: AOAM531N4NvaA6N03uVnilvse1uZrn8RV4GypwU5GTjwpvHpZ5aXC3hm
        rdurygMrutXSanIIBZWa2/wqlnzzvtcNMA==
X-Google-Smtp-Source: ABdhPJx7EK7JZUYa6Lp4pTsqK6sifV5/vgUVU97CGwCJ0WM1IbdUD93h3/cgOMvTqEdI6KyxJrNPXA==
X-Received: by 2002:ac8:57d6:0:b0:2e0:68af:7c52 with SMTP id w22-20020ac857d6000000b002e068af7c52mr1478995qta.380.1649134559939;
        Mon, 04 Apr 2022 21:55:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.158.84])
        by smtp.gmail.com with ESMTPSA id c145-20020a379a97000000b0067d943f7586sm7464635qke.123.2022.04.04.21.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 21:55:59 -0700 (PDT)
Message-ID: <624bcbdf.1c69fb81.630a4.2bfb@mx.google.com>
Date:   Mon, 04 Apr 2022 21:55:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3094856426757195661=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor: Add support for LE BIG Info Adverting Report
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220405004213.1164595-1-luiz.dentz@gmail.com>
References: <20220405004213.1164595-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3094856426757195661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=628953

---Test result---

Test Summary:
CheckPatch                    FAIL      3.02 seconds
GitLint                       PASS      2.09 seconds
Prep - Setup ELL              PASS      51.63 seconds
Build - Prep                  PASS      0.77 seconds
Build - Configure             PASS      10.29 seconds
Build - Make                  PASS      1483.78 seconds
Make Check                    PASS      13.09 seconds
Make Check w/Valgrind         PASS      529.48 seconds
Make Distcheck                PASS      275.18 seconds
Build w/ext ELL - Configure   PASS      10.25 seconds
Build w/ext ELL - Make        PASS      1465.21 seconds
Incremental Build with patchesPASS      3019.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/2] monitor: Add support for LE BIG Info Adverting Report
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#110: FILE: monitor/bt.h:3671:
+} __attribute__ ((packed));

/github/workspace/src/12800993.patch total: 0 errors, 1 warnings, 58 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12800993.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3094856426757195661==--
