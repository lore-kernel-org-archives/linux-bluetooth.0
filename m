Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3A5EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjF1PgC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjF1Pev (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 11:34:51 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A3C30F8
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 08:34:29 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7836e80b303so2133939f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687966468; x=1690558468;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7lJLjF04uGxvWl7V5jWferf4VG+V/dSAkgtE2/1Jgtc=;
        b=h1qKycXGO6kE9jifzJL4OsW73rsNj+R1TB/wsMkhdDGZU1gOM9aHnQFk2M4ciL0nDZ
         kGawWu1u1gZJOs6MNKJtMXwejWEOEKU68p791iAMKSOQjQQzJRjB9iR5cZ7isUfAXwW7
         yRyezI42MyjRwV1AuJJl9UG2I/gODclCEoL/mCECGFpv3kjt+xfHpvqqADjdE3nG2FGe
         3Hs9r1MHZa0dqssxD+adRKR9U/JimK9tc49LscCZCY9N7k94eDBeOQYXFpDxq0aL4VCq
         GsbiqcGr+1oEzFRHRa2FUeK9QChhjvE0Z8tW1WZlfj3IGW4oeB8UPLiDIpr/2+rcJ+U/
         VuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966468; x=1690558468;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lJLjF04uGxvWl7V5jWferf4VG+V/dSAkgtE2/1Jgtc=;
        b=hxevN/XTshuxPDGVveFyNWFv9LgK4tpEqlj8zYjdAeYesJ6dG1NH6psdU5xerNAqGT
         zqClc7jKAEun9G8Vbh5SUmAgoPu/m89K7tHS/KLge009pEkUR0JAn+z53G++lS34tfKk
         9uG0PYWNcyoMwphns5PWcR3NT7Ko06EdfUiSkntP2OmSMVICmnioAgwlxhJWM5nRVNzj
         jAvZiqJFGwWOS5+52v0pkZQn1bpAg8xg1wVc3LyRiOd/jtj61/+Tf9fBG/RQKht/AKD+
         KngXYsolNyeGxfRG6jbuIDCHZl8nbIJonelr6znbhlD4pq6XqwyRk+jBEJpqRwp4Dvbp
         3DYw==
X-Gm-Message-State: AC+VfDy/tBny4HocHv7LtMcfcWqeMYYkLBIiqOtR2uLtM8B0ofbPn5al
        r744Hp1cYFmqID8qw+iq9AMVUypIPeQ=
X-Google-Smtp-Source: ACHHUZ5L52MfT7XTkJ5YjJ2wqgRJGmLtNAOHZsbYWCXgUEm3ybQuxSsiCg9Vmbx5bN1K+w9A+XPNIA==
X-Received: by 2002:a05:6602:255b:b0:783:7193:b019 with SMTP id cg27-20020a056602255b00b007837193b019mr6198546iob.4.1687966468284;
        Wed, 28 Jun 2023 08:34:28 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.18.83])
        by smtp.gmail.com with ESMTPSA id f8-20020a5edf08000000b00777b7fdbbffsm3699329ioq.8.2023.06.28.08.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:34:28 -0700 (PDT)
Message-ID: <649c5304.5e0a0220.76e10.41c7@mx.google.com>
Date:   Wed, 28 Jun 2023 08:34:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3280761935505991807=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Notify user space about failed bis connections
In-Reply-To: <20230628150232.239778-2-iulia.tanasescu@nxp.com>
References: <20230628150232.239778-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3280761935505991807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760969

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.73 seconds
CheckAllWarning               PASS      35.07 seconds
CheckSparse                   WARNING   40.47 seconds
CheckSmatch                   WARNING   112.29 seconds
BuildKernel32                 PASS      31.48 seconds
TestRunnerSetup               PASS      442.17 seconds
TestRunner_l2cap-tester       PASS      16.56 seconds
TestRunner_iso-tester         PASS      22.42 seconds
TestRunner_bnep-tester        PASS      5.25 seconds
TestRunner_mgmt-tester        PASS      126.41 seconds
TestRunner_rfcomm-tester      PASS      8.51 seconds
TestRunner_sco-tester         PASS      7.83 seconds
TestRunner_ioctl-tester       PASS      9.02 seconds
TestRunner_mesh-tester        PASS      6.71 seconds
TestRunner_smp-tester         PASS      7.78 seconds
TestRunner_userchan-tester    PASS      5.50 seconds
IncrementalBuild              PASS      29.58 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============3280761935505991807==--
