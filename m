Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E99C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 22:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjC2WnI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC2WnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 18:43:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C004E5
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 15:42:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so17746922pjz.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680129770;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7IMUBzGWbYUODEg79JnZnUwfjmSC9ZhHimtbcVAMsuE=;
        b=HkrxDXYaBkZ0qJfxX9PCsQ1/wsCArIx7W33yiUUwI/0H/jUlDC0Nien86KZb4IzgUx
         ZC/xQobZ8JwJD/Z5E3/QjrWrHmp7jJ+VfLjsSHI3jg6suym+uiDqUfvGbUcQOWrWMdD2
         NCY3vuEhB/WH7iiy1Q1/FMptEy3wgx4KOE1JYeaHVvDhXCmTmwAI6diaQlGtTAz5R+IL
         Fbtyef0Krs6SVK8DRbVtpxbxRTn0Yu17zoPlx+WZNlkwrbbCH+4D3JRzMmkekx3afDyr
         eC75nJ7+RpOmHNvNzUMUuWawgDLfoyBcXTnDJysYPACexasUKyp5Q+QIodrrcSWiPkls
         OP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680129770;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IMUBzGWbYUODEg79JnZnUwfjmSC9ZhHimtbcVAMsuE=;
        b=VpldBC/Q/Y3LkNRyOologA4LoYpQN/Mp+b4W+mO7mR8YYAsepWkEo9Gc4wZbX+HLxp
         0xn/rcHMC9ssFSs4fMjj+2c0V0eRpTgC+/hKj1jMl3dD9kFR3QN/C7bHxjAIj0yhzZ8p
         3ftCqulaMNBzb043gUqGExHNZtVeZOANtRDnxZJqNIcneU6ubDZ4w8Lc4Q+0y6UZ4PzP
         /DcvOkw0gKHSsXR/zIzuN4HMRIGVENm7MzLRk4nDYo5f3EOkGfFoy14nVJ2mHcbnZgVu
         zMSPGBRSgVVnvPyljt8bdThX+Xnvh/gyx6LxnCMxZtqAV0qvOzXmeODupatSYA4RJ+CN
         WtEw==
X-Gm-Message-State: AAQBX9c8LHZkM87/57Idtf0/ZkC3ZCyRMQiHwOMmqjPNR17vBnTa2uku
        pu8EgaeWhHaPDj3i7L0bNO2G8bvRllA=
X-Google-Smtp-Source: AKy350bkD+P2iLG92gVB9yrc7US3LiwO91JjZcg1kzW8UVCa/Com59jK/t5h6sgR7EB06EgCjXKr8w==
X-Received: by 2002:a17:903:d4:b0:19a:b427:230a with SMTP id x20-20020a17090300d400b0019ab427230amr16833749plc.63.1680129769685;
        Wed, 29 Mar 2023 15:42:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.7.23])
        by smtp.gmail.com with ESMTPSA id 135-20020a63078d000000b0050c08fcff4asm22342105pgh.8.2023.03.29.15.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 15:42:49 -0700 (PDT)
Message-ID: <6424bee9.630a0220.d7780.9c50@mx.google.com>
Date:   Wed, 29 Mar 2023 15:42:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1794276236991852165=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] bap: Mark devices to auto-connect
In-Reply-To: <20230329210932.537019-1-luiz.dentz@gmail.com>
References: <20230329210932.537019-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1794276236991852165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735159

---Test result---

Test Summary:
CheckPatch                    FAIL      1.04 seconds
GitLint                       PASS      0.51 seconds
BuildEll                      PASS      27.02 seconds
BluezMake                     PASS      797.04 seconds
MakeCheck                     PASS      10.89 seconds
MakeDistcheck                 PASS      152.52 seconds
CheckValgrind                 PASS      245.03 seconds
CheckSmatch                   PASS      324.41 seconds
bluezmakeextell               PASS      98.30 seconds
IncrementalBuild              PASS      1258.25 seconds
ScanBuild                     PASS      989.37 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] device: Fix not setting initiator flag when auto-connecting
ERROR:TRAILING_STATEMENTS: trailing statements should be on next line (or did you mean 'else if'?)
#111: FILE: src/device.c:324:
+	} if (dev->bredr_state.connected)

/github/workspace/src/src/13193225.patch total: 1 errors, 0 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13193225.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1794276236991852165==--
