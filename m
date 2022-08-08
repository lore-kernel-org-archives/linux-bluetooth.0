Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E37C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 09:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242195AbiHHJMZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiHHJMY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 05:12:24 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F315DED8
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 02:12:23 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id y11so5941647qvn.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=9vZzFoMOUAdxVhqkkMRvdZSnz6EZ2M4h2Tst455ALSM=;
        b=kM8nEzLarS8MQ3xwsA2/wcV853BDTkRXYRIaUUSIxrMpBRGMyeeDQb93IRg7PxK7wA
         trAfVYzI972W33gFtuHpWiD3fbpzmrGPdEEvbMoZTYgSG6fICksj3K1AV7ixjtWSMQj+
         Jd+IKLsZveB1nY1y3E+z4LMqaPNlO6bQCp/bIXns2liagx1PDixk42xX1cORhai4nkFz
         j+YZcTCAkj7RLBJWR7OmBeGNDb9WM7bynemKUEo57X6Q1nLUe3Xbg3H4FiEc5/dERQIz
         Vhum6QGIJC0UidpyynQRNL4Yjldw+MpZItJGeYPBj9mUeZaQ6e9dDBbeH/3dwlBNWnxs
         2niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=9vZzFoMOUAdxVhqkkMRvdZSnz6EZ2M4h2Tst455ALSM=;
        b=byml0q9HUpqAZ2KvQhNCsMxfUlhEsbIBSqqSS50aPRlfMeAzbD6gmn2/RtgVp6l1Tx
         jS+PWnDuQx/Shky1XbaJ46K8qaOeBeEDenQtO+I+YdUV2CkrlSs/fJbMipvyhwShHqRl
         kH+SiMfqIpBA7zwCML7DTdOfV10i1GgXoEhe6dSqNlD5fjAO39aTzgBaHK2L07xcZgFa
         9KhpWj/afgHafqbOlpdYgun+39D1/bITYptK3wgVFOvLGJTY5paPrNmM1zO2rtWl7xK7
         9QuH1oP8Zp6tR2cprUfd0JYbzTYE6lHWZEZ2mm9LCs5Yc3OOdlSmmfdoK/rb0ufIlh96
         AG4w==
X-Gm-Message-State: ACgBeo33QRzZlqW/x2IBILP6xQw5M3UUyWZdK1CiJg0n1XexY2H9HJv2
        ybuV4tur+EpsAjQxXis4GZYDTYYIF9Y=
X-Google-Smtp-Source: AA6agR4hii21SITsemTlY2zYzv0H1PLioLlQlIkX8pMgCCZBXXX80VFPRNQ4oF7a1+bVQddRSj2ITg==
X-Received: by 2002:a05:6214:2a4f:b0:474:8044:d120 with SMTP id jf15-20020a0562142a4f00b004748044d120mr14605841qvb.80.1659949942105;
        Mon, 08 Aug 2022 02:12:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.122.207])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006a6ab259261sm9647232qkn.29.2022.08.08.02.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 02:12:21 -0700 (PDT)
Message-ID: <62f0d375.050a0220.49f77.7129@mx.google.com>
Date:   Mon, 08 Aug 2022 02:12:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6978261578165862351=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ntrrgc@gmail.com
Subject: RE: client: Fix uninitialized read in attribute handle
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220808082624.146995-2-ntrrgc@gmail.com>
References: <20220808082624.146995-2-ntrrgc@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6978261578165862351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665993

---Test result---

Test Summary:
CheckPatch                    FAIL      1.93 seconds
GitLint                       PASS      0.96 seconds
Prep - Setup ELL              PASS      28.30 seconds
Build - Prep                  PASS      0.87 seconds
Build - Configure             PASS      8.67 seconds
Build - Make                  PASS      962.04 seconds
Make Check                    PASS      12.23 seconds
Make Check w/Valgrind         PASS      287.33 seconds
Make Distcheck                PASS      237.89 seconds
Build w/ext ELL - Configure   PASS      8.80 seconds
Build w/ext ELL - Make        PASS      83.00 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      496.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/1] client: Fix uninitialized read in attribute handle
WARNING:LINE_SPACING: Missing a blank line after declarations
#104: FILE: client/gatt.c:164:
+	const char *number = path + strlen(path) - 4;
+	if (number < path)

/github/workspace/src/12938577.patch total: 0 errors, 1 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12938577.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6978261578165862351==--
