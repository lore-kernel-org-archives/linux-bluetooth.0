Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927ABC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbiKRERj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiKRERh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:17:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7287A5C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:17:36 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so7236121pjc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ViBWe53jTyxz9Y/+bzf5ROMGw1cnnk+URCv9niPd7RY=;
        b=gikyqyhY1oS4AciX/wIe8U/biHlEN+DT1t+QSsafcNAOmEw/GF6gGlFuqxi1Hr+3ci
         4NY7BuJZabWVsFzfeBcmdCnvI0rI9RA2FK7kb5+nvbgC3+sxyhY+naIxYR3QBExWFBfb
         XR656rB+hgLJL5gV114u2wpIits2lpQBUkKNws0wi6L7EC1tZE8DfE5irqUv3fS9fSST
         TfQ8kvJmBV+7bQsLNbJ/fr+n+j7L4LIwtn3q3SbTr014klZeQkrIzIvE/BBQX+cTt+C2
         ygAr49zx07ltcES1OHt0fdFyH35x1jg6Q9P53pMMJu0TtsNwXz6CpykJPaQ1M6lIoFIl
         N8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViBWe53jTyxz9Y/+bzf5ROMGw1cnnk+URCv9niPd7RY=;
        b=6TThlBGxmw+QG6Njk96ZkTtXX7ECroGJC5ug+h9EdxWbqmwjrhkvC0PvWZme1uTMhD
         9cKKnJ9OCKNdcLHVcfP3xzD8cbUMj1ImVNWvd8roSUciVqoQ+aXAjI/ta29X1KbwI7G/
         kvI/WaK/k+U+HfHhhcdbtmT5j9QdGoYraj+lqiDx8sTHybldKwJIeo4Lmx1MU4YdfKLe
         +73oW/XYA6+5GTZBbW6NkjTfbkXFXnQqkC5BeSgzRhOYx5edoi9Br1ho8xMBaT1gl0gd
         iTXuG7acwA4HS72tUeTQQjJwNTN8hcwsl2LYAFNO9MIKv92UupRVFY/smN40FUuZBgJc
         swPg==
X-Gm-Message-State: ANoB5pklGq7+lnCAVt7fdiHLDlDrWB4alIGaT6Wnht6MQsj0n7sFrfCe
        zmFRXoUEAs8kZ2G+e4zxjH0xD7AlstQ=
X-Google-Smtp-Source: AA0mqf4GUVoLtUnou+ET6Jw2IB8Zo98wHLVHDzFaBh2OVUHIs6XeNfluA1rf7uo7ctN4KEKw7ewDQg==
X-Received: by 2002:a17:90a:4605:b0:218:7dd7:ad4c with SMTP id w5-20020a17090a460500b002187dd7ad4cmr2941922pjg.224.1668745055365;
        Thu, 17 Nov 2022 20:17:35 -0800 (PST)
Received: from [172.17.0.2] ([20.66.22.75])
        by smtp.gmail.com with ESMTPSA id 135-20020a62178d000000b0056e8eb09d58sm2028478pfx.170.2022.11.17.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:17:35 -0800 (PST)
Message-ID: <6377075f.620a0220.c0318.35f0@mx.google.com>
Date:   Thu, 17 Nov 2022 20:17:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6586958517208055665=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
In-Reply-To: <20221116211836.2671441-1-luiz.dentz@gmail.com>
References: <20221116211836.2671441-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6586958517208055665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696161

---Test result---

Test Summary:
CheckPatch                    FAIL      0.69 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      35.69 seconds
BluezMake                     PASS      1222.64 seconds
MakeCheck                     PASS      12.81 seconds
MakeDistcheck                 PASS      194.76 seconds
CheckValgrind                 PASS      318.55 seconds
bluezmakeextell               PASS      126.32 seconds
IncrementalBuild              PASS      1007.90 seconds
ScanBuild                     PASS      1399.04 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#101: FILE: monitor/bt.h:1794:
+} __attribute__ ((packed));

/github/workspace/src/src/13045866.patch total: 0 errors, 1 warnings, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13045866.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6586958517208055665==--
