Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E3EC001B0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 20:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjHHU0G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjHHUZy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 16:25:54 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D279ED2
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 12:37:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68706d67ed9so4346844b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Aug 2023 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691523463; x=1692128263;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RX6OqOSYpCtpRFz3krgO/ijoBpUYYK2O0ui1BaX1gN4=;
        b=nMa5IcJt6Nle8jP5DYJ8tI1FCEp362/e5slQxIAEIWUdTYPx9Yh/B4q+RZzPjTFE7z
         XsEfWFEqGjxCX5459qOToJ64mdHprL1TOxOPowwqWn16cLcbyxWsLfFEULLjG4ddbOjt
         z+jhRFE/pmo5Zbv+DpLLIFTIDwuEgHYU6LnPL5z/QzimBpGAFjBaCbAoPZtrEsJjMlzG
         kFgQDEEEwQS7yaNPAs9GK4kmiFjt/MeerYBkmIqjVKTUT1X2II1bpUNrax1I3S7MKXO4
         uTPXAa3QW5vpbXe5qlc7FdvElSCwzRkoQbFdeI5PUpIzUlh2lKVDF83raWuMm/jZvP4n
         vaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691523463; x=1692128263;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RX6OqOSYpCtpRFz3krgO/ijoBpUYYK2O0ui1BaX1gN4=;
        b=B4plYJDAJi91zKZEiwiDS4Lrc7GlY2TrMJ3J19p4ZUsCqbe77/M7GryL43jFXEuGCf
         te7wTBMtLorSbSCUbdU6+Wgtp56ZqJRE0PrtUwLZTRp4HX8YVjJ3rbQANAbVGdIvhpHy
         jWetVGyqEnhz8aozg7IrHztgTcCb4phSC1LnZfdwWSneIA85sdROzrl6qYadv54r5UH4
         NffcNEKnml9VG7ciYC2AfOVEmyxXA6tkFGMCuzBNSYpH0xHoC7tNPD/8DNC1VnMYhK4F
         QyqFxnwv60ePvuhm46652grTOuJUGLFDCGMXI1Jvq60aiMsmBnqLhqkUWQGkJP78/ny8
         ZeQA==
X-Gm-Message-State: AOJu0YwqK8pDdOIdrtTft5TpI7Cg/oZZBjSxS+jFUahhyGvmoTuzo9ph
        5ouPqPevqhnmi7tgh6z0YGQreuytWKM=
X-Google-Smtp-Source: AGHT+IFoS7rN7+0ZUnTP2CDISEuw/b89SE7sMFvC63LbbPPwxE2GcS+QXUnTWALgrjP4RbB3kLohbA==
X-Received: by 2002:a05:6a00:398c:b0:687:52ae:34ee with SMTP id fi12-20020a056a00398c00b0068752ae34eemr471365pfb.5.1691523463239;
        Tue, 08 Aug 2023 12:37:43 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.177.239])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78151000000b0064398fe3451sm8394183pfn.217.2023.08.08.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:37:42 -0700 (PDT)
Message-ID: <64d29986.a70a0220.f41e7.f2a0@mx.google.com>
Date:   Tue, 08 Aug 2023 12:37:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0093262115511833212=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gioele@svario.it
Subject: RE: Makefile.am: Install D-Bus policy in /usr/share, not /etc
In-Reply-To: <20230808085540.1475435-2-gioele@svario.it>
References: <20230808085540.1475435-2-gioele@svario.it>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0093262115511833212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774197

---Test result---

Test Summary:
CheckPatch                    FAIL      0.68 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      34.92 seconds
BluezMake                     PASS      1226.11 seconds
MakeCheck                     PASS      13.05 seconds
MakeDistcheck                 PASS      196.01 seconds
CheckValgrind                 PASS      321.40 seconds
CheckSmatch                   PASS      448.00 seconds
bluezmakeextell               PASS      133.20 seconds
IncrementalBuild              PASS      1034.85 seconds
ScanBuild                     PASS      1387.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] Makefile.am: Install D-Bus policy in /usr/share, not /etc
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#58: 
> deprecates installing packages' default policies into `/etc/dbus-1/systemd`,

/github/workspace/src/src/13346617.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13346617.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0093262115511833212==--
