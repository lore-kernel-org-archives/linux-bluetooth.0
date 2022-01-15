Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Jan 2022 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiAOACv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiAOACu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jan 2022 19:02:50 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C737C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 16:02:50 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 82so12548142qki.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=d1GAcdMkpm5aMsWmxI86AZdTr2wf2SeCVnKbqYa8H5I=;
        b=cB9gOrP2zaXMsYNJKWSD9RVh6lWqD6HxeO35tBat4TOwNAYJ9+qeGG+upngszCSStH
         3y3ByEA7CPcfnaZ1yDv1VBEqTnPLp7NM+vPkQHL/O9cKTef/iqGaqkOaDos2j5nEXvRB
         v7JJh/7W34Dva77f5jSTY06bGQQvMCwqAQs0V6CvwSySdDC2N2l2D4U20ZODNaUsVwA5
         L5Vry8I6IVd3F8catRb+l5VWAc2MF0kZ2sUTLLkrgA5DM+FiNhyQkG9efiIc5i7fbNlr
         yIgnVaXpxgLdcAbmieAi/rtRDEtsd9wQ5mZ0X2YvICTPO1RwiFKbJMSBWKf1tOwh3PUV
         TvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=d1GAcdMkpm5aMsWmxI86AZdTr2wf2SeCVnKbqYa8H5I=;
        b=Eqp21DG7Z0nHTiRQ/98G5jpzGUODLQTuRqKNf2eQW7IKhtnn4ea2r7nDytuLgLU/YC
         dMCCvFJVcr6HBpEZ6LaF6TMVD90zBQl7f/321C7AbbKHL4QG9UMu1g1/sddaljpdPU3C
         uoIXzgKa35K2PaZxenhcVXhHvaCfqJgokCTXeSlwkNcGq8LXDxEVaxil91A0adLA6Kai
         hivl7fQBPmHWa2kVn8+1tOPjhFPfiQ1wumTW+fHVCGkzgwxkEBybeqlT/83pJSHx8JAq
         vDDkb4YmGv2nqVKbcM+GAhm4djdWkHzs1So4c2zBDQOAS+AKfp+joqn57HkzcRWhl5Rr
         mf7Q==
X-Gm-Message-State: AOAM533IrFyGQiBm4AUFz6hKZ0qTefxacXMv8Y9SuGiOk7igoWdkd80c
        njN2IUz5REqUmSDbZXau6Z7dNO4U840ouA==
X-Google-Smtp-Source: ABdhPJxj+snaG119DPofPFEq2PPD/rQWloAl6I+1Iye28Q/lRzbkoyVDDDBu2ket20eLwHNCyzSmuA==
X-Received: by 2002:a37:8d04:: with SMTP id p4mr1025321qkd.535.1642204969485;
        Fri, 14 Jan 2022 16:02:49 -0800 (PST)
Received: from [172.17.0.2] ([104.209.175.69])
        by smtp.gmail.com with ESMTPSA id f9sm4354547qkp.94.2022.01.14.16.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:02:49 -0800 (PST)
Message-ID: <61e20f29.1c69fb81.9ee78.7d68@mx.google.com>
Date:   Fri, 14 Jan 2022 16:02:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6250268716235981445=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor/avctp: Fix parsing of GetElementAttribute
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220114220959.917157-1-luiz.dentz@gmail.com>
References: <20220114220959.917157-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6250268716235981445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=605632

---Test result---

Test Summary:
CheckPatch                    FAIL      3.24 seconds
GitLint                       PASS      2.01 seconds
Prep - Setup ELL              PASS      42.16 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      8.34 seconds
Build - Make                  PASS      1258.23 seconds
Make Check                    PASS      11.72 seconds
Make Check w/Valgrind         PASS      437.37 seconds
Make Distcheck                PASS      227.87 seconds
Build w/ext ELL - Configure   PASS      8.47 seconds
Build w/ext ELL - Make        PASS      1256.72 seconds
Incremental Build with patchesPASS      2518.42 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/2] avrcp: Fix unaligned access
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#111: FILE: profiles/audio/avrcp.c:940:
+} __attribute__ ((packed));

/github/workspace/src/12714173.patch total: 0 errors, 1 warnings, 747 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12714173.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6250268716235981445==--
