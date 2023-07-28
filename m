Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02714C001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 08:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjG1Imw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 04:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjG1Imu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 04:42:50 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF5511B
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 01:42:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a5ac8717c6so1498828b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690533768; x=1691138568;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8iztI3BVARUSwGaVHMFNL7pBtUyobm/fjAMIBrjY8i8=;
        b=P6QcowyzWpXqwUwwbWN4TBtjKtUs+jo6n53LXXvAHjYVdvIkkViOwiwy/VyqRiUQDI
         BC58+m/OHNvshns1ecpeMBHj4nfWVow8FrP8sG/oCn07mIbRK273tF7uBdJhJ0lio/nK
         QvW8o6cSFdZleUlZ73e83paX+/W2ySTmgMOvBSeegQU1K8qAjXR08XNaJUMyfAAL5sgV
         6gjYMtlc8RUtytnaV/1YFQhYisLbCof6DdsKqfic32h/Xb5JKsP3BptvDg1P2Wt878P4
         3IKjVWqR38ieYVZM2DHKLeqyE5l7kWQ7YB5BO3dp5+Lw6i2ZN2qj51IEKxds9BzcJZqg
         54DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690533768; x=1691138568;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iztI3BVARUSwGaVHMFNL7pBtUyobm/fjAMIBrjY8i8=;
        b=b9cA1Y/3Ub72OnihLT/Eq8Lft+N4yAyjkfrPgjedoZHaFP5o45dn2xY4pJiIbYJ81J
         r7JKFI+6sYjO49SHjIstSPeyKhIIEWn2wKXOhBVqcqwVKAu5QFqJRZvlcLImAXCzxAva
         BmIJcVqOMDuxY1A4VrbRzrwzUqBznHUNgd/Zew+1iNxLwiaAwG2iNEiYSTKTlF47X7MY
         1wi46bz3oHIjhcTC3ckaw8inqvEvYcBEAl63Z8txMeCZbvrI4u/aN2flFCjwwn4Gja8i
         nmomrOh1cQLwB1OsPfevhY9KiT0HgkxikTXTtzekY/28yePnOrznysBnKLL7fWEGJXOq
         0Hng==
X-Gm-Message-State: ABy/qLa3a2vmTsTLdzcDls2rB9Xc8anVh6+q1UYsy1138GSQ3mz4jme/
        fQPr+sqd/+eMEupHz2FN65m58o2BsJk=
X-Google-Smtp-Source: APBJJlGstU9MZHH5CQdl9ExECtnHr701mDOixxU3rZUzJsoII0ea0UwZfrY1+iEWXMRwNnJgzC3T0Q==
X-Received: by 2002:a05:6808:4044:b0:3a5:cc7d:3d66 with SMTP id cz4-20020a056808404400b003a5cc7d3d66mr1846407oib.49.1690533768270;
        Fri, 28 Jul 2023 01:42:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.112])
        by smtp.gmail.com with ESMTPSA id p14-20020a05680811ce00b003a37fd2be45sm1450464oiv.31.2023.07.28.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:42:48 -0700 (PDT)
Message-ID: <64c37f88.050a0220.b079.8eee@mx.google.com>
Date:   Fri, 28 Jul 2023 01:42:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3155602409425855690=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Device pairing and discovery fixes
In-Reply-To: <20230728053153.584222-2-simon.mikuda@streamunlimited.com>
References: <20230728053153.584222-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3155602409425855690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770402

---Test result---

Test Summary:
CheckPatch                    FAIL      2.88 seconds
GitLint                       PASS      1.55 seconds
BuildEll                      PASS      33.07 seconds
BluezMake                     PASS      1196.56 seconds
MakeCheck                     PASS      12.58 seconds
MakeDistcheck                 PASS      192.41 seconds
CheckValgrind                 PASS      304.17 seconds
CheckSmatch                   PASS      422.49 seconds
bluezmakeextell               PASS      127.59 seconds
IncrementalBuild              PASS      5054.50 seconds
ScanBuild                     PASS      1352.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/5] device: Refactor device_discover_services function
WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#136: FILE: src/device.c:5874:
+						uint8_t bdaddr_type, DBusMessage *msg)

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#177: FILE: src/device.h:180:
+						uint8_t bdaddr_type, DBusMessage *msg);

/github/workspace/src/src/13331214.patch total: 0 errors, 2 warnings, 71 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13331214.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/5] device: Fix returning discovery error for Device.Pair
WARNING:TYPO_SPELLING: 'successfull' may be misspelled - perhaps 'successful'?
#80: 
If discovery was requesed from pair request we will report successfull
                                                           ^^^^^^^^^^^

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#104: FILE: src/device.c:6355:
+		err = device_discover_services(device, bdaddr_type, bonding->msg);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#107: FILE: src/device.c:6358:
+				g_dbus_emit_property_changed(dbus_conn, device->path,

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#112: FILE: src/device.c:6363:
+			g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_TYPE_INVALID);

/github/workspace/src/src/13331216.patch total: 0 errors, 4 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13331216.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,4/5] device: Fix pairing with dual mode devices
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#82: 
even when we have connection to LE bearer only. In these situation we should

/github/workspace/src/src/13331217.patch total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13331217.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,5/5] device: Fix reverse service discovery handling for dual mode devices
WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#185: FILE: src/device.c:2795:
+	 * device->state.browse is set and "InProgress" error is returned instead

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#349: FILE: src/device.c:6406:
+		 * timer */

/github/workspace/src/src/13331218.patch total: 0 errors, 2 warnings, 268 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13331218.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3155602409425855690==--
