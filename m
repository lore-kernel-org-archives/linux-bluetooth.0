Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE52C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 18:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjEUS2k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 14:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjEUSVA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 14:21:00 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384C7192
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 11:11:12 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6af6d8687faso677678a34.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684692671; x=1687284671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QxPU/5rE1vPsbl4nzRwo2XKRmEDwdP2t/Mnpc1y85A8=;
        b=DJY2Ju5dWEijtNj1/Z0yCeyQP//XteUTgAE/QLidwN1q3KOan3JHuOou9BB5XjA0gl
         NN+tAaK+RC4fQ1P+cXWVdTzZwH//A8srUk09dsh+mdoqPNpJDG49W/mbnBXlPtl3GJtx
         mt2xN0snQCWYJ/yDmtPeLdGBwk7v9ZiDcEVDd/MaoSIOKGnH47p4lb28ciG/FwzaSXye
         T4N4c0iFfYsTinz8b3otqZhkv+IUxvPF1XHkvu/tZ78WP1FdUvgjegbGbDCaFG7eDl5+
         TDDuXSyHUm8QZbIo33YHD4VnWXvo58cX3EqUJmqoOK9IonIfdsqWU7skCaYZ90dtq35i
         6vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684692671; x=1687284671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxPU/5rE1vPsbl4nzRwo2XKRmEDwdP2t/Mnpc1y85A8=;
        b=DVhIEiPULzQPD5CtnFGRDsZ8vqAmdRhaDStOc1xTB4obPJ5omHEgyq55YcnsXR9mSI
         gOJzV7NL93d+KyFQDiJEjXnBIgmSje3WuGiiPhB/UKPMWnYn73e32S7XvVO4aYsdrcOb
         Z07dvcw2+cu6R0T6hBw7SkL4k0bhxLVPQLu8RKyNIU4YZussxKyHDyu0O62h1mzEoT/Q
         HOiDYXdq2bBi0eAsm+3hAYx57T2DUurQS1WxY0ure0OxRQfgQUNcAJI20GUaUY9mgKtm
         wUmwRzdV5wEWgFlLsgAug9ay714+wNYo4wDHa4lcA3z1Y4k5Ys9kDmxzYjIsnsgBroyb
         NSzg==
X-Gm-Message-State: AC+VfDwVnwxiz0NsApFplE6IVyQ5LB8ZW9+o/+bEB3OpCudrd/YD5KYu
        bYQL7LtMt1+/H+hmY7aosLgVm4XYuiM=
X-Google-Smtp-Source: ACHHUZ77Xx2q27WOiO8/M/lQdLpveb2eDC0iaiTUMYdw+zumxhskgjBTEd84zX1bvl/goCrjNjyE1w==
X-Received: by 2002:a05:6830:1203:b0:6ac:802a:69e6 with SMTP id r3-20020a056830120300b006ac802a69e6mr4264459otp.1.1684692671143;
        Sun, 21 May 2023 11:11:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.141.224])
        by smtp.gmail.com with ESMTPSA id e20-20020a9d63d4000000b006a30260ccfdsm1626714otl.11.2023.05.21.11.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 11:11:10 -0700 (PDT)
Message-ID: <646a5ebe.9d0a0220.8363d.5c84@mx.google.com>
Date:   Sun, 21 May 2023 11:11:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5188650414482168788=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/5] iso-tester: always use DEFER_SETUP for multiple CIS in same CIG
In-Reply-To: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5188650414482168788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749544

---Test result---

Test Summary:
CheckPatch                    FAIL      3.27 seconds
GitLint                       FAIL      2.14 seconds
BuildEll                      PASS      35.87 seconds
BluezMake                     PASS      1238.75 seconds
MakeCheck                     PASS      13.36 seconds
MakeDistcheck                 PASS      202.49 seconds
CheckValgrind                 PASS      329.93 seconds
CheckSmatch                   WARNING   459.17 seconds
bluezmakeextell               PASS      136.68 seconds
IncrementalBuild              PASS      5329.21 seconds
ScanBuild                     WARNING   1454.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,3/5] btdev: support multiple CIG
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#74: FILE: emulator/btdev.c:108:
+} __attribute__ ((packed));

/github/workspace/src/src/13249428.patch total: 0 errors, 1 warnings, 279 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13249428.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,5/5] iso-tester: add tests for multiple simultaneous CIG

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
17: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:416:29: warning: Variable length array is used.emulator/btdev.c:416:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1079:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1391:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============5188650414482168788==--
