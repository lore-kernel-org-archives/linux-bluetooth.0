Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7801AC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 02:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiGAC2h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiGAC2g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 22:28:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D42599EE
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 19:28:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jh14so1074309plb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 19:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fnut58ZmQ207qXLvXfpC5o5EI/qzf92FttfqieUVlZk=;
        b=Utyn9Qub17K7t1Y+LSSv9l230vtbEgS3Qq09TSDI9yGKQmgNnJ+YwRFRsmti6Z4Hgi
         ocM5YipYniRcaedJnWuSKMwM+d1bISMhN9HCCI2mJOOiEk3wq9hsppJm0kVufhyuOeLh
         HANAkJTpRV1eG/J3+RsgjCUMJ9kRIDpW7hTTL0ry5sBsFhvPCS8lL0GFsJY50uVbPN77
         YkksEPWWCiToWppyJAs90gLS1XVOPYIFJDif2iz2mkbodNcyr6947SI5hMZmJijM8a2f
         4fh+V4/nx+Z1asgxsamsBPsebpXP6YF8lgIU+xtO4W/RjE186PEi/R+FF6aUQImSyaWj
         HYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fnut58ZmQ207qXLvXfpC5o5EI/qzf92FttfqieUVlZk=;
        b=Thh+EefQ9FgfxCWCzfb62W0wo3CsNLK20YHlZbzK/8rm/nF6wieobekSFIehaiBkK/
         5nflUuBmWL2yC7TXi2ZZ6Y72r1Pt1kDNu7cPMzxe2bYJjmL7Dn/pNFVlNRbK9RMly1Pu
         MxgvwFA5lbgLXW6F3gE1sx2gJcl+M208Pa9nS3PBLE6/ALfOYiHrXHdnXMCacWrLESc9
         oYOjMFwdsW94cqzunPNGGTGNCb5fAaIzYo1J3I2uBZhz8xsYX3n1D0j9wQbPPu9onyaB
         j8L4Z25L8OhYduZYJoWT0WkR4swIMF5e4tG57rN/QpXNTJlroot8fmu/MWfBANQvgrEL
         U8UQ==
X-Gm-Message-State: AJIora+95zbFquy4CfrI3W2B0fDu8NS38gM1O4Q0w8m9Va6oe93cXvup
        Jktk7a1+K2gEiqTyij+BJEdq6qOPWSo=
X-Google-Smtp-Source: AGRyM1toa3jVlmRve7GgAyRYAiuXNFSgFd812iibZ/n9VQ3Uv9VPRgThtXtg+sVm/GITWrVFixiV+g==
X-Received: by 2002:a17:902:f813:b0:169:8f5d:c343 with SMTP id ix19-20020a170902f81300b001698f5dc343mr18708807plb.98.1656642514282;
        Thu, 30 Jun 2022 19:28:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.134.96])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b0016797c33b6csm14105442plb.116.2022.06.30.19.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 19:28:33 -0700 (PDT)
Message-ID: <62be5bd1.1c69fb81.d3322.4a1b@mx.google.com>
Date:   Thu, 30 Jun 2022 19:28:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3273229432014457905=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v8,1/8] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220630221452.638591-1-luiz.dentz@gmail.com>
References: <20220630221452.638591-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3273229432014457905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655564

---Test result---

Test Summary:
CheckPatch                    FAIL      9.01 seconds
GitLint                       PASS      4.39 seconds
Prep - Setup ELL              PASS      42.53 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      8.20 seconds
Build - Make                  PASS      1358.39 seconds
Make Check                    PASS      10.99 seconds
Make Check w/Valgrind         PASS      421.57 seconds
Make Distcheck                PASS      224.30 seconds
Build w/ext ELL - Configure   PASS      7.92 seconds
Build w/ext ELL - Make        PASS      1321.74 seconds
Incremental Build with patchesPASS      11076.32 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v8,7/8] tools: Add isotest tool
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1235: FILE: tools/isotest.c:1118:
+		/* fall through */

/github/workspace/src/12902316.patch total: 0 errors, 1 warnings, 1233 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12902316.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3273229432014457905==--
