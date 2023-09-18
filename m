Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46801CD13DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Sep 2023 22:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjIRWiM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIRWiK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Sep 2023 18:38:10 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BBA8F
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 15:38:05 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65806ba1221so7174206d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 15:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695076684; x=1695681484; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PEuKqEQ6jkM1A6JtcJRXTLeHY+TjwdelmPX/pI7M/q0=;
        b=LPB0tmjpvmqTCMe6G0KUlhjC99W6HbF+NC+/1gndKpkxvM2u/tWv9J16ZclMZbXHl4
         NGYz602OFGOMjy8lG0YfyGo347bhBiEMLKXItJ6Vf20suRKqr+hEFhcnPq1SPZEh/saf
         EtM1pu3OjvhpI0XrdvHqY9t8rHZMkk9DoWZQTxxuxhyO4UYIWOxKIn21M39n73snVU5L
         AacAn8ngVltZvnai7ipZ8KEBhfb5qGGbfCVmuUCMmQ9GY1iyC6XG/lT83REwEV14sqOH
         YMRjIPDqB6DLl+/DDm8K2PDEIZ87Hhpa8saxFYpBKQbQnkcSxmyUB6hFm9hEzZFw0ZYb
         61hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695076684; x=1695681484;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEuKqEQ6jkM1A6JtcJRXTLeHY+TjwdelmPX/pI7M/q0=;
        b=bsiIKWPn7w5Q0JaglBWfX49xwolcrTpbGDDwXwBPIaSUqS6xVZoHB8U21UK76MNziW
         w3/w8LobAG3V0SGF+Z9NNHc3p2XZRSJstUbPYZ2E+szQq4ec5oWVu0um4Qtyga6Jhd4o
         x2sv5zxdq2FBfFJL8fMNVl5CklsxHzR19BTRnBuN2tLTA1aDTQSSfbPUzdd5MIPzikB5
         E44zcEWGtDAt0k6MI/qtqjP8azc3Kk+XEH+yDBfh09qzm2S87Gi78ZbhN4vv/oQ+MPAx
         zAbIQ2lFWmqqMNup7VOp/0nyvJbJjOVABitOKtKS/OBTdTHKTI+eGbr0oQkYW+e4QhpI
         4hng==
X-Gm-Message-State: AOJu0YwZogtPRjZPdwvgzDeUhCEoVnPBQOn+TwWaLojzPUqRiKPNDVNn
        Lil03N+O7eQQ8Mj/wLWBVUTsriahdPM=
X-Google-Smtp-Source: AGHT+IGqJSbbrvSbftxjRMeZvISjZP2Qx4BYgUcaLjN/Za/lDjH+o1Q+hiNMmxmcYfLTr5xotz00tQ==
X-Received: by 2002:ad4:4e8b:0:b0:63d:7214:638e with SMTP id dy11-20020ad44e8b000000b0063d7214638emr10642386qvb.56.1695076684405;
        Mon, 18 Sep 2023 15:38:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.61.109])
        by smtp.gmail.com with ESMTPSA id w25-20020a0cb559000000b0064f741d2a97sm3834335qvd.40.2023.09.18.15.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 15:38:04 -0700 (PDT)
Message-ID: <6508d14c.0c0a0220.1cb25.de76@mx.google.com>
Date:   Mon, 18 Sep 2023 15:38:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6116580241794670869=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/log: Fix not checking vasprintf return
In-Reply-To: <20230918212219.190667-1-luiz.dentz@gmail.com>
References: <20230918212219.190667-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6116580241794670869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785362

---Test result---

Test Summary:
CheckPatch                    FAIL      0.74 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      28.85 seconds
BluezMake                     PASS      893.48 seconds
MakeCheck                     PASS      12.88 seconds
MakeDistcheck                 PASS      161.29 seconds
CheckValgrind                 PASS      262.51 seconds
CheckSmatch                   PASS      355.74 seconds
bluezmakeextell               PASS      108.95 seconds
IncrementalBuild              PASS      729.31 seconds
ScanBuild                     PASS      1087.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/log: Fix not checking vasprintf return
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#88: 
      #0 0x55e784f75872 in __interceptor_free.part.0 asan_malloc_linux.cpp.o

/github/workspace/src/src/13390493.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13390493.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6116580241794670869==--
