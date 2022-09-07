Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA64C38145
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 22:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIGWQq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIGWQp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 18:16:45 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75960985AB
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 15:16:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h22so11574819qtu.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=H9NDw90l+zdWvx9mhWLfK7JgLDusDlzEO1/jfNT9+EM=;
        b=UTWgP6j3rLHb7ioTJuhEXHR526RuahD6HJrNvqrgcBAy+FkpJly9MMz9uwE5Ov6ZO2
         NdBXfN/NlAAaDx+WG6dnpBgembSnvrTY4hpUH3KLo0SzFdsqutxKeafuNulkDVR2c7VM
         ow1Hdbpa6tPjPXIDG2pFtGOgNNFmRo6Q598JInoPlUCSzBRbxunjdztYy6epylR0qD3S
         xWKSo28W6PNJWQrGt8aaX9pGhAi3s37O5TOXM62nYcXBgzP9ZdeAZErdoNjJGrkkxHsQ
         SaL/I77Ttrq5XmupnxQ1/cWfjQ8TkQ9lKLWNZ0N71ccdWuZrJTRBr40F3UhjDZ1X4p+Y
         q3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=H9NDw90l+zdWvx9mhWLfK7JgLDusDlzEO1/jfNT9+EM=;
        b=MkPT1pZqYFdx92jlR2WEqvz9H8UXuV/XFhiU47Q/pdWXlEEtFpxMSPoEpJ5KxbTsYY
         97mi48Lv1m4FNaeojJcEd55qnytIVjkJQa+XnuJOzPdtP1no828QbXxmHMxs08kW7ztN
         hKV6DXYGeUEkO5jenpgFt8UP/Z+WMzLHf/tIeRi7B7eypFvQYXx0MeCEitcQplcWcMFv
         5vtUohTIwyjSX6FkDdKLGC0vLVfKz51hKqFxyUayLhzI1NNJrB2KVDWkIlyrD2koRirQ
         yG9UWbxce+DodPqud85hX+8wm1WQD1tioilkR2gOLhyJRmeDi0JAPnQdp/k7w36bauk2
         Hykw==
X-Gm-Message-State: ACgBeo0K/jATjsQO9Q6vBGmSxc/uvpwTB9t34iUvsSNTAajmc641SE8o
        CJbba+08OcULpAsXTwua9q6VRhS3W1M=
X-Google-Smtp-Source: AA6agR7Kus0DHgkyFPZrFTHFxg6zEXrZjUNxoLGzVMPvCUHHox/jZLGQRIh/Vz/Q5hJ5nKLULXX83Q==
X-Received: by 2002:a05:622a:510:b0:343:6a9b:d877 with SMTP id l16-20020a05622a051000b003436a9bd877mr5199919qtx.677.1662589002429;
        Wed, 07 Sep 2022 15:16:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.119.131])
        by smtp.gmail.com with ESMTPSA id f8-20020ac81348000000b00343681ee2e2sm12966162qtj.35.2022.09.07.15.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 15:16:41 -0700 (PDT)
Message-ID: <63191849.c80a0220.9f1a5.e24a@mx.google.com>
Date:   Wed, 07 Sep 2022 15:16:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9108301349007694825=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2,1/2] monitor: Add ADV Monitor events to btmon parser
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220907205205.49729-1-brian.gix@intel.com>
References: <20220907205205.49729-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9108301349007694825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=674993

---Test result---

Test Summary:
CheckPatch                    FAIL      3.41 seconds
GitLint                       FAIL      2.03 seconds
Prep - Setup ELL              PASS      34.30 seconds
Build - Prep                  PASS      1.09 seconds
Build - Configure             PASS      10.75 seconds
Build - Make                  PASS      1120.88 seconds
Make Check                    PASS      12.83 seconds
Make Check w/Valgrind         PASS      349.08 seconds
Make Distcheck                PASS      304.88 seconds
Build w/ext ELL - Configure   PASS      10.82 seconds
Build w/ext ELL - Make        PASS      107.26 seconds
Incremental Build w/ patches  PASS      256.04 seconds
Scan Build                    PASS      707.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v2,2/2] monitor: Add mesh MGMT cmds/events to btmon parser
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#68: 
@ MGMT Command: Read Mesh Features (0x0058) plen 0                                      {0x0002} [hci0] 6.849795

/github/workspace/src/12969379.patch total: 0 errors, 1 warnings, 135 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12969379.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,v2,2/2] monitor: Add mesh MGMT cmds/events to btmon parser
4: B1 Line exceeds max length (112>80): "@ MGMT Command: Read Mesh Features (0x0058) plen 0                                      {0x0002} [hci0] 6.849795"
5: B1 Line exceeds max length (112>80): "@ MGMT Event: Command Complete (0x0001) plen 7                                          {0x0002} [hci0] 6.849800"
12: B1 Line exceeds max length (112>80): "@ MGMT Command: Set Mesh Receiver (0x0057) plen 9                                       {0x0002} [hci0] 6.871462"
20: B1 Line exceeds max length (112>80): "@ MGMT Event: Command Complete (0x0001) plen 3                                          {0x0002} [hci0] 6.871505"
24: B1 Line exceeds max length (112>80): "@ MGMT Command: Mesh Send (0x0059) plen 43                                             {0x0002} [hci0] 11.865613"
32: B1 Line exceeds max length (112>80): "@ MGMT Event: Command Complete (0x0001) plen 4                                         {0x0002} [hci0] 11.865626"
37: B1 Line exceeds max length (112>80): "@ MGMT Event: Mesh Packet Complete (0x0032) plen 1                                     {0x0001} [hci0] 11.911088"




---
Regards,
Linux Bluetooth


--===============9108301349007694825==--
