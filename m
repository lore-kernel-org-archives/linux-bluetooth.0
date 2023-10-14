Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3169FCDB465
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 09:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjJNJPQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Oct 2023 05:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJNJPP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Oct 2023 05:15:15 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FA2AD
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 02:15:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c62cb79b02so1865628a34.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697274913; x=1697879713; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LM0l7EI9GNZmLJCWGOKRcu8YimBuITEmxNE2Ql9Tu5U=;
        b=kRbsRYjLF2cc2cqjFkFxNzfyFLKxIC2YJ6+1/pN/pAuloWnk/T4BFTOoQmsI4lbvAQ
         8EnJGGBoglBIhMsbVsqZMcA2qUzOY5rmZx2ax6urm+j7bdz7d3bNwQjDsXE+d7UFaj50
         D0u+ZCeXQWU2y2kC6DS9AiR6OvdLso174hl2MM9LqFDtYfErtSLuJEYHNdkZIObe0e3a
         HfdEATXLmpylqcRZUL27TizxKsrhW+AnYiE5/3XyR5TzxUb0NQBf4JkmVDxqeNxYsB7A
         Cj6qC6Eg15Qzac6RWOm9Yhv7KOMxWI3PUiDg7T3ltf3xYWKcmfq2YZrCiN6t5viH5qMG
         SS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697274913; x=1697879713;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LM0l7EI9GNZmLJCWGOKRcu8YimBuITEmxNE2Ql9Tu5U=;
        b=dgU31oc+Yv8wU3mqlrfoILibWY2zv8mkHTN7cuYxzy+IJGCXpH3r3GaVs3FKq8VlkP
         ckiXagII7irbTdkftoP613Kjsv8r89Zgftc9fSUp66xlqqNJXCuMIIKSTicEtvPODPnL
         0NJDeoSp+DKr4Jgu+aFta3ytEYPoycvlZuGEpy0U/iGJKDuYE9xf3gFNR8ZZMlrE9Xqj
         WXTRPlCkd8avTNNj66C3hwfiSe9959Pi1On6HPlinT66zIpazYysrKislPwP0vY5trU9
         LjGIKVfsEGcv1shLyBqMo7SIfiwE0QX+9MDTpdRzkNmh5+jLEK0UQF4YGxRRDay5YpsZ
         0mLA==
X-Gm-Message-State: AOJu0YxGDjlSbQ4nq9MvxWrQDsSF7O7BZHytlD0karV5htek0ECt8N7q
        n4e1IJc2TGmklSdhIpDjZ+RNzwZu7Q2u9A==
X-Google-Smtp-Source: AGHT+IH3Yz4WmGigdFut1lkSGrY41CiSBfBTficvsYqsLHsCguwGUmrMWVJRPG1lduQhbTUBVYLT6A==
X-Received: by 2002:a05:6830:207:b0:6c6:4a8d:da98 with SMTP id em7-20020a056830020700b006c64a8dda98mr30581447otb.24.1697274913295;
        Sat, 14 Oct 2023 02:15:13 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.172.174])
        by smtp.gmail.com with ESMTPSA id g5-20020a9d6c45000000b006c480563197sm977450otq.26.2023.10.14.02.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 02:15:12 -0700 (PDT)
Message-ID: <652a5c20.9d0a0220.cb84f.9d58@mx.google.com>
Date:   Sat, 14 Oct 2023 02:15:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2300024614753450340=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] btdev: Broadcast EXT_ADV packets every 200 ms
In-Reply-To: <20231014074716.1866266-1-arkadiusz.bokowy@gmail.com>
References: <20231014074716.1866266-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2300024614753450340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793193

---Test result---

Test Summary:
CheckPatch                    FAIL      0.65 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      28.00 seconds
BluezMake                     PASS      811.79 seconds
MakeCheck                     PASS      11.86 seconds
MakeDistcheck                 PASS      175.90 seconds
CheckValgrind                 PASS      270.00 seconds
CheckSmatch                   WARNING   363.05 seconds
bluezmakeextell               PASS      116.87 seconds
IncrementalBuild              PASS      706.09 seconds
ScanBuild                     WARNING   1076.17 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] btdev: Broadcast EXT_ADV packets every 200 ms
WARNING:LINE_SPACING: Missing a blank line after declarations
#192: FILE: emulator/btdev.c:5068:
+				unsigned int duration_ms = eas->duration * 10;
+				ext_adv->timeout_id = timeout_add(duration_ms,

/github/workspace/src/src/13421935.patch total: 0 errors, 1 warnings, 165 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13421935.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:421:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1086:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1337:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1459:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============2300024614753450340==--
