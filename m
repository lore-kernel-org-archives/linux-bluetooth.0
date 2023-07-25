Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E79C0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 13:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGYNdE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGYNdD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 09:33:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A9AD
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 06:33:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66869feb7d1so3288018b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690291981; x=1690896781;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hxqy33lGOnm5IH/xWforaNfd6QKrVbr3tF/Htpk6c1Q=;
        b=Nw6IID28r+74m9ceClQS0eHvz0AFNqcadH2PRpSMJjiBZ61L8m5Vqf/7++v6eN6cKj
         +FX0xeaIoco41zuh4ytPvqYAI4gCcQBIqWdPbkW79XZepUci/FH6zPfPOjlRPaH1396V
         k6VEzyfZl5ZA32ZXN3Enhd30xMDiAcLI6L4VC3eZ8ov2cWhv376EvCy9mQ2YF5Lcjppm
         gSVV9z/kyvTT3/RlaNp7h7sSD1R2p1VTjUKmOZIc9AmQeR782+HUJn1/7IHkUQtq92aZ
         I0eNR8D8eP6EemcIf7OXH6ACpMh17xesFJLyXFBP//G2m3QOo+tsj+Fmvd5+pheXrMzt
         Mbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291981; x=1690896781;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxqy33lGOnm5IH/xWforaNfd6QKrVbr3tF/Htpk6c1Q=;
        b=gxuv4HbKlzdIQycqBquiU4yQoVVPvSKXXw8Ka6BhvhAzG3AyvK2FM8i+MabYhKRcd5
         Jz6G4GyZ93Dw/6IpqZiRfmwZO1Ds120VTKJOasF1FaIJbIncMvVkOGM9J3mzyj3Ctl4/
         IUTPXA/VA26E4z98PDPxaFRM0N/W5uuZROMtvl4ZsFUZ4GJdVu4ko8bWZ+y5A2umcK9E
         mAUnw3e00DXTltizx7uA/VWLrbolFJZBDN0nbc1PozCRWJEYyPoFRuajhqZZPtHWfXqS
         WTgqILqa1irlLrVfz42AeGriSDHrtUDW6qt4THldARlOfY2dG0NdFAr1jxMipn79r3rL
         ZrPg==
X-Gm-Message-State: ABy/qLad784xe/sDK91a8bbBsWNN0WsE8RvAfpVf/gUpZ4MpmPUGuK3j
        0yqe8DgU/FyltYDremkAu1LPBUm4DpM=
X-Google-Smtp-Source: APBJJlGlzOz1FnU2gPisHeEVaxg5DW4FxTbTwgBebhW35cyk9MK52GdMMJfmXo7I8nRG8q3w1Rv9Fg==
X-Received: by 2002:a17:90b:3a83:b0:268:7d8:597d with SMTP id om3-20020a17090b3a8300b0026807d8597dmr6743242pjb.46.1690291980573;
        Tue, 25 Jul 2023 06:33:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.243.244])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090a420400b002638e5d2986sm9642882pjg.17.2023.07.25.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:33:00 -0700 (PDT)
Message-ID: <64bfcf0c.170a0220.504b.136b@mx.google.com>
Date:   Tue, 25 Jul 2023 06:33:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2388039260558727754=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nitin.jadhav@nxp.com
Subject: RE: Fixed the crash observed with VOCS
In-Reply-To: <20230725112126.49656-2-nitin.jadhav@nxp.com>
References: <20230725112126.49656-2-nitin.jadhav@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2388039260558727754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769262

---Test result---

Test Summary:
CheckPatch                    FAIL      1.47 seconds
GitLint                       FAIL      1.02 seconds
BuildEll                      PASS      34.62 seconds
BluezMake                     PASS      1221.61 seconds
MakeCheck                     PASS      13.02 seconds
MakeDistcheck                 PASS      200.94 seconds
CheckValgrind                 PASS      327.52 seconds
CheckSmatch                   PASS      460.63 seconds
bluezmakeextell               PASS      134.82 seconds
IncrementalBuild              PASS      3132.74 seconds
ScanBuild                     PASS      1394.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,2/3] shared/vcp: Fixed issues related to read audio location and descriptor
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#99: 
- Audio output descriptor & location read functions, requires code correction

/github/workspace/src/src/13326329.patch total: 0 errors, 1 warnings, 76 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13326329.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,2/3] shared/vcp: Fixed issues related to read audio location and descriptor

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v3,2/3] shared/vcp: Fixed issues related to read audio location and descriptor"


---
Regards,
Linux Bluetooth


--===============2388039260558727754==--
