Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CEAC04AA7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 16:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjITQeX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 12:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjITQeN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 12:34:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F2E9
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 09:34:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso2028135b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695227647; x=1695832447; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xH3dsN3YdRrJDj/o6JnqG5j30f+MQtXj9CS/jlzUtmM=;
        b=cXYv75TRK49QZXrvPrv0vcTr7YW28lEm0U1Fnt1kgOnpHiun6GcaIhLWerBNce+MTY
         ctI4e+3qyx8O0dFW5OGR4lqunJzm+YVzS3mqlLHS88WkeKWE+TTuIsVnEPJ9uZqexNL1
         ii9n5hwiRf1BoJHWIEdR8P9PiigCQ2gT6sbcwy0MJiKbGq5yxuYO8hULdOfqPTwYlCDO
         TbzegD5cJfZrEM6jf6HP3BxztLZ2lplEjBycc0y1dOKLTHgvyfamnDf1fYd+Lc+kKNAu
         3z2OYq8326mNx8tltImY6IoY0qW/av3b5IF8oNnmRysoZHeCHn8p2tje7XP0FFfqAocp
         gybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695227647; x=1695832447;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xH3dsN3YdRrJDj/o6JnqG5j30f+MQtXj9CS/jlzUtmM=;
        b=xRRKYy/8naeWJtB5KjD0lI9IHhmCAA2NCmxP0PzLnMS00oXbQf7nk05gh6nRDnMGzY
         xppSN6kOIpB6fnyfFPpD9ln089vCWn7GCZV7T7dH1c5gRyrBfywp7JSx02GNpRzY6dc9
         Uty9V8DAXDQx8BR3Ymy33YYMVdamjHAy9m99vmkRf8lu4Ao0L1D0i+47ZTqNr/0lui8d
         lx3v5BXoXPLHVWU3WVqkoWAd9+VLWaByUL/SIExD8XOadWb/edlpPtPmTuoXtx3/4bnq
         dpUfms1VwyxDpF/9tu7uRTqZOeCs1cuu+a8piccy3mUDRS+YGehMLRLVYDFx6Ynpb1PE
         U+MA==
X-Gm-Message-State: AOJu0YzY75DRoKCgHXdERGXIHNv7CJIKnJQiI878+mKNGNOmaPUdaHiz
        YNqq28NZkaIGljVVC7E1gXSYPMwKZ+Q=
X-Google-Smtp-Source: AGHT+IFAoDwXFsqUPoXSDj1XgVQyxvXMqKoZqVEqDK6xXdRPtGL5UZ9WV0IVq3rY5Xo3od0inda+hg==
X-Received: by 2002:a05:6a20:1442:b0:159:dccb:8bb4 with SMTP id a2-20020a056a20144200b00159dccb8bb4mr3255038pzi.23.1695227647301;
        Wed, 20 Sep 2023 09:34:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.22.161])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b002694fee879csm1655242pji.36.2023.09.20.09.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:34:06 -0700 (PDT)
Message-ID: <650b1efe.170a0220.2edf7.4ae8@mx.google.com>
Date:   Wed, 20 Sep 2023 09:34:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6007763341598126579=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] vhci: Check whether vhci open setup succeeded
In-Reply-To: <20230920153008.967330-2-arkadiusz.bokowy@gmail.com>
References: <20230920153008.967330-2-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6007763341598126579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785988

---Test result---

Test Summary:
CheckPatch                    FAIL      0.67 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      27.52 seconds
BluezMake                     PASS      781.14 seconds
MakeCheck                     PASS      12.21 seconds
MakeDistcheck                 PASS      160.15 seconds
CheckValgrind                 PASS      254.18 seconds
CheckSmatch                   PASS      345.37 seconds
bluezmakeextell               PASS      104.92 seconds
IncrementalBuild              PASS      649.07 seconds
ScanBuild                     PASS      1031.05 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] vhci: Check whether vhci open setup succeeded
WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#144: FILE: emulator/vhci.c:133:
+			!(rsp.pkt_type == HCI_VENDOR_PKT && rsp.opcode == req.opcode)) {

/github/workspace/src/src/13393018.patch total: 0 errors, 1 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13393018.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6007763341598126579==--
