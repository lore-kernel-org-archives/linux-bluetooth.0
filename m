Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F92C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 14:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiLLOlO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiLLOlN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 09:41:13 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3B6562
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 06:41:11 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id f139so13617322yba.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 06:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3OBOn4lLreVYXSVQJlaaMk0alemsVcyAOiQ/fVdIDMQ=;
        b=Q/W662sVZ67S8W316r1poCzfGpVPGmeiKXYQmazp3ukyuWWFdcYFqjssKg8aypdmRL
         Ux1ifP3TKITpKlbFExsff+Ppl8pBp31qG4KI2wY1ddMqfvr385rxhI4SEmHl0L1wBYkA
         wO8CcbecmEbY1oLJK4Q/EBcZQ8Y++6AigbJ2uVfKJFX5p8Gw2f6tLZ1RWt1QLkH3pdlP
         U6NZOB72+LqLyFLVa0x99Eq3iKxCm/kJw7cpriDJLlLBNg3sgbCOJO0kUU9rfD7tuXLu
         OrBRzBM952R2AXye2v5V1cslwRUmFnGbK3BRaP67sh9uk3UC0qxAPkLJlL4Wn32zpK4I
         SmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OBOn4lLreVYXSVQJlaaMk0alemsVcyAOiQ/fVdIDMQ=;
        b=7EBwuNYS5M8x8ChvevosoPX861WJ6m/cWruyelfvyeIrWAvK0EuinYznjkLhV3ZI2Y
         NwdgouUOTT6MzuGyAXvU0rYAq5yimQ60QmSqJP/w86xOuOwDXhcopr6KJ2bEWtiL9xP/
         +BK3bgYBOnj9vq7937UHAPnERpvusvsDFSF4UCYikMmB2qLfFPrsF89o8F/E9CpZoSiC
         vC6xmo88655xZcF4/W6CLYXjvD1jevEsBRckgluiwkrnSLxCdZqfKW/aB5UwaLx0khW/
         4Id2WMEuhDCBeBeORZn1oBTuvhLCRJlYEJfEM5NCBd7Hi0HpfXN9v65b6eZ6WCoax2PF
         mp/g==
X-Gm-Message-State: ANoB5pmzSVX89f3gubcsc4Nk3BvpKCN4JcmfzEXR22IxZipmPtBDx9dY
        QDezyKb7OV2f8d7in9Jrw8XPP3EU0U6vcw==
X-Google-Smtp-Source: AA0mqf57u8GkgYWbhA8QzxwAV4SPTSE9KEN7M/T20j0yAdDZW2b0E319by5k3wZEA1KEWdP6pimtiA==
X-Received: by 2002:a25:3445:0:b0:6fa:51c:dbf5 with SMTP id b66-20020a253445000000b006fa051cdbf5mr13662824yba.33.1670856070146;
        Mon, 12 Dec 2022 06:41:10 -0800 (PST)
Received: from [172.17.0.2] ([172.177.233.51])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006fbaf9c1b70sm5792831qki.133.2022.12.12.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 06:41:09 -0800 (PST)
Message-ID: <63973d85.050a0220.8dafe.e30d@mx.google.com>
Date:   Mon, 12 Dec 2022 06:41:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0229038567793151009=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arthur@marmottus.net
Subject: RE: Expose the disconnect reason over D-Bus
In-Reply-To: <20221212133235.79657-2-arthur@marmottus.net>
References: <20221212133235.79657-2-arthur@marmottus.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0229038567793151009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=703845

---Test result---

Test Summary:
CheckPatch                    FAIL      0.79 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.63 seconds
BluezMake                     PASS      1018.21 seconds
MakeCheck                     PASS      11.85 seconds
MakeDistcheck                 PASS      149.74 seconds
CheckValgrind                 PASS      247.21 seconds
bluezmakeextell               PASS      97.21 seconds
IncrementalBuild              PASS      855.05 seconds
ScanBuild                     PASS      1064.30 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] device: Expose the disconnect reason over D-Bus
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#98: FILE: src/device.c:2640:
+static void btd_device_disconnected_cb(struct btd_device *device, uint8_t reason)

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#113: FILE: src/device.c:3011:
+	{ "DisconnectReason", "y", dev_property_get_disconnect_reason, NULL, NULL },

/github/workspace/src/src/13071144.patch total: 0 errors, 2 warnings, 67 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13071144.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0229038567793151009==--
