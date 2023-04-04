Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D18C761A6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 15:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjDDPbP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjDDPbM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 11:31:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98288129
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 08:31:11 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id o10so6403477iou.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Apr 2023 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680622271;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ad7d9qr79mFhudr7z7kCOXUiZ6YQgKnR8VvB6ZN6d10=;
        b=RNIAEsgbIvh3lhlPyRqLLFOtzLa0GEif+20yFn+wDXOr1zVhj/hh4F01yFreVfob8R
         JPFPw7Rrlg94Huk+oCyyK4r6mZ2FzQI7T+IdwfL4c/G/n8YKeUsUCXOp5MJ5RG2PlJ2c
         E4lBl49uQLvLz3wq3lNVq5D5DzO6QePdaPlzHP9z7uy0gGQwQhhaOsIGNmyg8fyNkReB
         Pt0iMkKXyzz7g+vJ0dzlH0GN7HgD1iwz8SpmnR0YSjX1/ScN6y85x4SqtB0k/4/9ByU+
         qrGpskTAr2rPR8N/S0EQ6mPWL0BSE+oDnAIOBvsfazT4bbfHg6+vzvODniDti3DkjJTZ
         YSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622271;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ad7d9qr79mFhudr7z7kCOXUiZ6YQgKnR8VvB6ZN6d10=;
        b=CpXfjISyzCKPcQ/eY84k1sI7738/W63pnrTC6zYrgH/w+de/+q9R+TAF/+q4dq7cr2
         csSHp8iWKsFfPsHgay9Tkoy5nDpGZ8JrfXagml3HvKPtM7C55+DnKX5ZYlLBqC3n8Hr8
         NwnLVFXpwE6C/4KKs8bBoX1cVwdiiJTxSBU3dmeYIHP07B3xHjBuZe3K/hH9n/E5Bea2
         mlNErZB7SMJDKAtI0GRSGFLPR5P1fv3oXR+/4yQPIBo36c/N7ZPjZ9E3GuptPZX4mdg+
         Gdq4oYuzzrxDO5GLsC6Agx5xUQMbVv8VIfuP4X4NFEiCV0154MA75Dt9XoBUvTplJ2wC
         5tVA==
X-Gm-Message-State: AAQBX9fdWkFDuVxa2DChKX/kyEp4nuzGZRkapQWQL7yCSgOtTtbk8xO8
        SLnxYq2Ewzg1fYZ6pGyIrMa+Q1AbwkA=
X-Google-Smtp-Source: AKy350buHnpuTQc8kMdnaaSF0ed45Hjapd/2sEiIv0XEGw2DqeJJ3PpN5tHfHFbzvkX6JvXpmbgVpQ==
X-Received: by 2002:a6b:e007:0:b0:753:476f:9ff4 with SMTP id z7-20020a6be007000000b00753476f9ff4mr2627783iog.3.1680622270657;
        Tue, 04 Apr 2023 08:31:10 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.93.1])
        by smtp.gmail.com with ESMTPSA id q20-20020a5ea614000000b0075c47fb539asm3313050ioi.0.2023.04.04.08.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:31:10 -0700 (PDT)
Message-ID: <642c42be.5e0a0220.58122.32d2@mx.google.com>
Date:   Tue, 04 Apr 2023 08:31:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0880895884333662103=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: monitor/att: Add decoding support for BASS
In-Reply-To: <20230404143053.101464-2-iulia.tanasescu@nxp.com>
References: <20230404143053.101464-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0880895884333662103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736846

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       FAIL      0.70 seconds
BuildEll                      PASS      26.74 seconds
BluezMake                     PASS      758.73 seconds
MakeCheck                     PASS      11.53 seconds
MakeDistcheck                 PASS      149.92 seconds
CheckValgrind                 PASS      242.62 seconds
CheckSmatch                   WARNING   329.06 seconds
bluezmakeextell               PASS      98.21 seconds
IncrementalBuild              PASS      617.07 seconds
ScanBuild                     PASS      988.58 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/1] monitor/att: Add decoding support for BASS

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B3 Line contains hard tab characters (\t): "        	68020101000000000403020400"
33: B2 Line has trailing whitespace: "        Value: "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============0880895884333662103==--
