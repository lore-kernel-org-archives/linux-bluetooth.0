Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AFFC04A6A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 20:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjHHUVt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjHHUVh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 16:21:37 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCFD5BD5D
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 12:28:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bf7eb259d5so133676fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Aug 2023 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691522926; x=1692127726;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/y3LNkYt8xN4admkh2/Bw8Vr1sfU+XKRwNwgeZCksOw=;
        b=QZ9cZ+svcwU1H/9MpZ/FsUC9FUzylj89xbFdaJoNpsoOCKwgV2E7UwVm7p4LS0V/MA
         k2bHhez2xgk3OxUl5+pGfQKWN1zibiksRF/NP1Xx7Vey0g1FyzVH2DsdoWDvbUFxQ6ZD
         E6hlSiqsw24lyxrfDZQE+bBHz+ItJnIGhywVLXrPkmcD83nEL7m25ymalZT8maXOsH99
         4yCJTvf2i3ZPAjO/WtmfliyQfXu52jevTpJqidcFXgdQzOwfIymHD5s+E2b8ca0nverC
         CE4HQt6dt6jVss5Jl6t0YCLy4RB4CRwC6ATE9QGG4QEP1UdHvSG6UYl9TWJAl39SylLh
         4N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691522926; x=1692127726;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/y3LNkYt8xN4admkh2/Bw8Vr1sfU+XKRwNwgeZCksOw=;
        b=K3XM1oBwq/bIc24C34JtAO0BIQpWX6BGyaLpsVvqX47I+Jw5+29DEp3gyoC+ffWyvX
         04+Qjcblbyl1KN6dFZTPGwTYEH50lEW6eluTjLAxS50XBdMLTPfAllA7n0CrJyKvfUXb
         HmBc3tbLCM5CMjSvFLhW89Njit4csVigiW/tpydNQnDTg8h+VPDrbvdEoDtsjjbVztsA
         Mei44wxXqd+2cFN9vcCWDGCPj31oBmb2qPgyvleRoNGctLOm4hGaPoT6OHV9Mab3EPCH
         IcjhXNrbwqUBVQJaqlaOvPxSbXm8np/6R2YH8tqUCFL5QmKLC+2DSV+yfV/F3cSIEnyS
         UZ8w==
X-Gm-Message-State: AOJu0Yx70hzEacp5TkgWIzSgUtK7+xiPaIc6DYSF18pRR/VGwL7MgJZ5
        8JZ55h2nKYnE49VZTiCcWl/mBAeMK1s=
X-Google-Smtp-Source: AGHT+IF1YRcZ9uNQFWieI2buSCfvTtw4qHM1V48BeuYRhUp2nXsMOnuepahinAqmW6DJ5MPEGyPe3w==
X-Received: by 2002:a05:6871:b28:b0:1b4:4935:961c with SMTP id fq40-20020a0568710b2800b001b44935961cmr508490oab.27.1691522925660;
        Tue, 08 Aug 2023 12:28:45 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.133.24])
        by smtp.gmail.com with ESMTPSA id eb18-20020a056870a89200b001bf3942ea12sm6441857oab.1.2023.08.08.12.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:28:45 -0700 (PDT)
Message-ID: <64d2976d.050a0220.10e55.f62b@mx.google.com>
Date:   Tue, 08 Aug 2023 12:28:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4554771167508707907=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gioele@svario.it
Subject: RE: Makefile.am: Install D-Bus policy in /usr/share, not /etc
In-Reply-To: <20230808065734.1475152-2-gioele@svario.it>
References: <20230808065734.1475152-2-gioele@svario.it>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4554771167508707907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774181

---Test result---

Test Summary:
CheckPatch                    FAIL      0.65 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      33.30 seconds
BluezMake                     PASS      1034.49 seconds
MakeCheck                     PASS      14.02 seconds
MakeDistcheck                 PASS      194.13 seconds
CheckValgrind                 PASS      312.82 seconds
CheckSmatch                   PASS      414.43 seconds
bluezmakeextell               PASS      127.22 seconds
IncrementalBuild              PASS      839.33 seconds
ScanBuild                     PASS      1292.79 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[PREFIX,BlueZ,1/1] Makefile.am: Install D-Bus policy in /usr/share, not /etc
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#61: 
> deprecates installing packages' default policies into `/etc/dbus-1/systemd`,

/github/workspace/src/src/13346586.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13346586.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4554771167508707907==--
