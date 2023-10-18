Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B26CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 10:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjJRKiI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 06:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRKiH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 06:38:07 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E024B0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 03:38:06 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3574297c79eso27828625ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697625485; x=1698230285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aY0WlkQFmh7S/4iBHBepPUwtCmD2KZUTm4x2jnnnork=;
        b=fLIw1uVbrRQXz5EVgz1efLo7VWMofb0Wc+T/Xph/pYnfq+KFgJK6/upntxBvO+zg1Z
         6iiMg5mfcEjLB4mH9UkCsr0q33ixFgZHVePlVRHuq22KA/hwXQs+xsSY/UVsqAUgWSix
         lTqsxKISo7l0HC72/YYboaOTU3MFnQj2llCET4v6x6imGTS/3lAmdGE9bn2Sfn5ViRjv
         P/4IDNbKdFqxWSNe0MFr6tDx/H/SzFBpo8NDYFUOo+7+nNie4mK4GWmHgmGnpOKFJ9xB
         qA7p6uTwJwoeQDtvTjQONKZHzQ1VuhOpc0hZzyt/8qRvgZtjpw7s6fIKVyGBIL/wDngT
         U/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625485; x=1698230285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aY0WlkQFmh7S/4iBHBepPUwtCmD2KZUTm4x2jnnnork=;
        b=C0b01JpqbjYAZbH7lZX4/CS6DryvxMpD7RR7JCnRFKGFbX3Ovjz6svjAM/7Y1XO8yJ
         W0BJEd1O5nhEQ3wywT/15Sk9pAUbtcjODpDZjfzP8B31aM4SZDiz74uv5pDtTg9rt/Rr
         LyNFO/PD470NxfVpvJfbZwtJMpWgxSjtRVPiXraTW3BBMQ2+eDv8QM/gfXfZ2EfdL3os
         9PiToFTROrqO3nRM0tD/+PcCaDVWAMvZDSiJwBv5GZcZ1e7b9PkhiemAAzO0od7qDtW+
         HrqhK55ll98lVI3p2shwfH2HDQKLyfzwCIkqx48Fx8Y5199Xp3pZ3oXBBXnYZD5RGfX7
         OtjA==
X-Gm-Message-State: AOJu0YwEBqwMNH6U3dgk3Dk/8Hfh8gf/PlpLnFpq04ZYAAHBedR6kI14
        K5YlsDZ+Oqf/eS3ZBuIPYbqs6tJrxbw=
X-Google-Smtp-Source: AGHT+IH+MSn9y2LzHjV8cb9U0QH07T63rxfsGwzndELcMQRtW32QjseFG2uahelOW1CZic6h3O9BkA==
X-Received: by 2002:a92:cb02:0:b0:34b:ae46:8040 with SMTP id s2-20020a92cb02000000b0034bae468040mr4966229ilo.5.1697625485207;
        Wed, 18 Oct 2023 03:38:05 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.3.142])
        by smtp.gmail.com with ESMTPSA id a19-20020a056e020e1300b003526f14513dsm1010001ilk.7.2023.10.18.03.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:38:05 -0700 (PDT)
Message-ID: <652fb58d.050a0220.6d6ff.12b5@mx.google.com>
Date:   Wed, 18 Oct 2023 03:38:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5584664119705620807=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: Bluetooth:btusb: Add return error code
In-Reply-To: <20231018095339.199956-1-youwan@nfschina.com>
References: <20231018095339.199956-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5584664119705620807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794272

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 FAIL      0.38 seconds
BuildKernel                   PASS      33.08 seconds
CheckAllWarning               PASS      36.38 seconds
CheckSparse                   PASS      41.59 seconds
CheckSmatch                   PASS      116.34 seconds
BuildKernel32                 PASS      32.02 seconds
TestRunnerSetup               PASS      504.10 seconds
TestRunner_l2cap-tester       PASS      29.29 seconds
TestRunner_iso-tester         PASS      57.68 seconds
TestRunner_bnep-tester        PASS      9.58 seconds
TestRunner_mgmt-tester        PASS      210.80 seconds
TestRunner_rfcomm-tester      PASS      15.03 seconds
TestRunner_sco-tester         PASS      18.49 seconds
TestRunner_ioctl-tester       PASS      17.02 seconds
TestRunner_mesh-tester        PASS      12.45 seconds
TestRunner_smp-tester         PASS      13.36 seconds
TestRunner_userchan-tester    PASS      10.16 seconds
IncrementalBuild              PASS      31.06 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============5584664119705620807==--
