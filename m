Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339CCDB482
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 08:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjJPICE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 04:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjJPICC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 04:02:02 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47911A2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 01:02:00 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-457cba20cb7so1107991137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697443319; x=1698048119; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aFofDJJbdpZT17xVVXG0MZxcqfb1W9B9G5dlZ6ji40c=;
        b=a48xMXWLbsx7lna0Dh+B7xmK1OMXEZcT3f/WHCk6TgLNB5Vfd+zlWKl0rBzS4H0ccn
         CeKTJotDrvKY7Re0r0e+EGuF791wAjYPwWbjc4zmPAnhAQi7FP07u6OAwVd7B0bWcZA/
         +keCX34KAp+DtIyJB/KskEbZrjMsHpT1XdDXqoApo7GorILCnY+2GL07KNxdsGnD7ey5
         j2Ey4Fa0hpE6v59r2rzDCFYWnWyhhINTIup7SMylrEXFlEeI95E50rm1QzzD9w84+V4u
         xJUOX8eaWvHzVxqKbP0IrseH5Ornu1qFusAT2U+6hwvEJDTOfkYxIyDfQGu5S1D7gi5G
         ffHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697443319; x=1698048119;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFofDJJbdpZT17xVVXG0MZxcqfb1W9B9G5dlZ6ji40c=;
        b=c0LRwszuOIIEOYf2rh1EYP6EAemDB85QAJ8WHjTNPPKqWG0xT1XCRU4EJVaKDh5fMd
         d1MvF5DdQeVc+fZaoRQWXLs86XNXCGYOEw418aLCZOaYxyNwPeiGGUGGpMOsb8BpohEC
         mz05dc6KjZf6EY6QHDHZm2fCcNikRaOM41S1dLgeDLNtmDajTr4BMv4OoufjYSPkif/2
         3h44hn8UFbT0aZbmzjoBabS4eVyrynJIGA5kDNqTvHAmEkSxg5w/alXNImPH9g6sLiyl
         Z40qBhsNiDW3gpPnJt3vtqUaxTcII0IZvwn4xf/vcIYsylZME6Vd6Dx8SgrlsA/NRDEb
         zQ5w==
X-Gm-Message-State: AOJu0Yx+durjHwpP7phuJHxWr5mpMwCvm4Z650ElHy+7WSbOcTCVWk9Q
        OpO2dG26d1+BYZg6KVwTTHyIboz5gGU=
X-Google-Smtp-Source: AGHT+IFxn7ScE0TX9ZYXOIIhX0f4poiPOuRHB4bMRErThbJ4mTsQ+LMNwsonicJ0lhXZEu+bawMMTQ==
X-Received: by 2002:a05:6102:50d:b0:452:679f:a2c7 with SMTP id l13-20020a056102050d00b00452679fa2c7mr31323176vsa.24.1697443319208;
        Mon, 16 Oct 2023 01:01:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.124.88])
        by smtp.gmail.com with ESMTPSA id r6-20020ac84246000000b00419cb97418bsm2828530qtm.15.2023.10.16.01.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:01:58 -0700 (PDT)
Message-ID: <652cedf6.c80a0220.ea061.a845@mx.google.com>
Date:   Mon, 16 Oct 2023 01:01:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0927662562701039604=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, devnull+j.jannau.net@kernel.org
Subject: RE: Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED
In-Reply-To: <20231016-bt-bcm4377-quirk-broken-le-coded-v1-1-52ea69d3c979@jannau.net>
References: <20231016-bt-bcm4377-quirk-broken-le-coded-v1-1-52ea69d3c979@jannau.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0927662562701039604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793415

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      35.57 seconds
CheckAllWarning               PASS      39.05 seconds
CheckSparse                   PASS      46.12 seconds
CheckSmatch                   PASS      122.79 seconds
BuildKernel32                 PASS      32.30 seconds
TestRunnerSetup               PASS      511.24 seconds
TestRunner_l2cap-tester       PASS      29.67 seconds
TestRunner_iso-tester         PASS      54.02 seconds
TestRunner_bnep-tester        PASS      9.81 seconds
TestRunner_mgmt-tester        PASS      210.52 seconds
TestRunner_rfcomm-tester      PASS      15.10 seconds
TestRunner_sco-tester         PASS      18.68 seconds
TestRunner_ioctl-tester       PASS      17.14 seconds
TestRunner_mesh-tester        PASS      12.68 seconds
TestRunner_smp-tester         PASS      13.53 seconds
TestRunner_userchan-tester    PASS      10.35 seconds
IncrementalBuild              PASS      31.09 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (96>80): "Link: https://discussion.fedoraproject.org/t/mx-master-3-bluetooth-mouse-doesnt-connect/87072/33"


---
Regards,
Linux Bluetooth


--===============0927662562701039604==--
