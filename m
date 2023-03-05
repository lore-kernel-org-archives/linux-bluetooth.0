Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F2C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Mar 2023 18:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCESH1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Mar 2023 13:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCESH0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Mar 2023 13:07:26 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A74AE05F
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Mar 2023 10:07:24 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17638494edbso9059566fac.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Mar 2023 10:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678039644;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=swUDSaOLnSvGvFkUhSa0vlK+6aXpUeGsayijGiqQF5s=;
        b=GYQWX/z8OwRa2+2coBnrSc6MxunO2dFA9847KxYl9va7HgQ4V/Y126I5yNr8HNytKV
         hiev3OGrH6JBvTeOfYzlF0wllTzior4sAf3ixzkzBEoAvg5hizuNnCzaQAGZDjTWgaE0
         lt/CsJg0AZCY7pF54w7uhD6nZKEOzRit7LS37NrVWC0z4sstUsI/XBFYEPIcDqXjdnZN
         o2HCxv2aC7XT1jCpG3RXUAAirbd/SMQH5RgsgqOMXHYcJnIWAZiR0pBOOHMJ5aUrVu5m
         cjVSk5/s5hRotyM4lRITyY/7IGWz+/sve0y+oW+Anz1jgz8oFLV9Vw9XOZ8dgYQLNujJ
         CcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678039644;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swUDSaOLnSvGvFkUhSa0vlK+6aXpUeGsayijGiqQF5s=;
        b=p6tXdwCNwMH0IhNZd1VJpu5qpBhPbsOwN2vg10yxMeyXW/iPtKA2AP5AqwB/MkjCAa
         DvO11/naBV7FVVgiGVaSd0HF3/i9z2RAoa6fiwV5e6z3KAdOcWKyxy0KvTi0mNyHykKM
         2t8pMRJDo0yG2NvJZX2Z4LpvW4QDIIognWISFbrw8weE0/qoZzSFzzHi5uXpGO7P33/o
         smzjFhJd4Zqla8PL3cLu1Qexki7mYxsbjnP4jojoU0s2TzDHS0IZVJwvERg7SkZbIJ1w
         LsNHBW624ZrCy2vzT7rdpn6PFLSnywk25EyCPEsD5vMiqUmLkTglFW10QXgnWuUsfpDZ
         UnUg==
X-Gm-Message-State: AO0yUKXs137eCCIR7VqgN4QtQqqaDgQht8xlIejGC5b3ba2awh5mw0A/
        FJgQbbshYD2TYIQY87nhl83H1W48pf0=
X-Google-Smtp-Source: AK7set8MH/GporQSYT3ZcbGp02CkDdMDsaazRB1RiE9hqN4+PYA9ycKhw9RSmyawQbY/K20mM5AiLA==
X-Received: by 2002:a05:6870:fb8c:b0:176:39b1:51c6 with SMTP id kv12-20020a056870fb8c00b0017639b151c6mr5250003oab.5.1678039643727;
        Sun, 05 Mar 2023 10:07:23 -0800 (PST)
Received: from [172.17.0.2] ([52.248.87.128])
        by smtp.gmail.com with ESMTPSA id z21-20020a056870739500b0017697dfc20fsm1552050oam.12.2023.03.05.10.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 10:07:23 -0800 (PST)
Message-ID: <6404da5b.050a0220.3dd38.4d37@mx.google.com>
Date:   Sun, 05 Mar 2023 10:07:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4578713277595138085=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, qydwhotmail@gmail.com
Subject: RE: [BlueZ] Fix missing required properties in MPRIS
In-Reply-To: <20230305170551.2572-1-qydwhotmail@gmail.com>
References: <20230305170551.2572-1-qydwhotmail@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4578713277595138085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=726694

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.58 seconds
BluezMake                     PASS      774.54 seconds
MakeCheck                     PASS      10.78 seconds
MakeDistcheck                 PASS      150.29 seconds
CheckValgrind                 PASS      241.45 seconds
CheckSmatch                   PASS      322.65 seconds
bluezmakeextell               PASS      97.04 seconds
IncrementalBuild              PASS      620.01 seconds
ScanBuild                     PASS      981.51 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] Fix missing required properties in MPRIS
WARNING:TYPO_SPELLING: 'requried' may be misspelled - perhaps 'required'?
#79: 
"SupportedUriSchemes" and "SupportedMimeTypes" are requried properties
                                                   ^^^^^^^^

/github/workspace/src/src/13160178.patch total: 0 errors, 1 warnings, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13160178.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4578713277595138085==--
