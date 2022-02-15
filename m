Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E112C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 03:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiBODRM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:17:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiBODRL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 22:17:11 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3C25D9
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 19:17:02 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id c14so16500203qvl.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 19:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CRxlvhjXjZFJOIF+Je9RzF6p7cf3hIBZU1thrI2sTp4=;
        b=ldqqW8MZdIyCb/ahoj/RB4CArHSKaAXvyzJ6oOKb0AbesKgOmlDj95p3hvUfr81CrJ
         pVXHbrUJ9R9rzJ3BxiDZLZaTrT0QbZKTxh+Z6MMykuRqcPPUqx8VsRq4Ixy7Jxw/LL9t
         wLvWcShMBw14TX1+fQ3aBll0L7t3kmQfQWM+apQRVg8rIgw0ZyFtwfsobgk2+7aC4tc5
         m0Dl+iQJUte1QjvHeky6C9C98motQfUsAKEaH2SHDOrKJ3f1qs/W1VCbAkmGd3wWyjYw
         uVTxSsU9G1Onm8Weg9dDMtZBcinUQp3FlDxIigzPtsS1A2pGH8Yt6kqluVLUbTEKoyrB
         4KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CRxlvhjXjZFJOIF+Je9RzF6p7cf3hIBZU1thrI2sTp4=;
        b=EYOY7Pbhjrw0muauRA4kTQKYIAnJskVy6RnoNANXpsCN0znCjuG6NcgAe7U/Bs9oUg
         Hky8uVJq8wx7z5GUhHQOdW+AAeEGDZVXZCHzyjvkF+Svbl/fLljvJaL/N2JY1+Y9RArx
         RYgkHnxB5PxUYDpw+73hxcEXRxlaizxQcDVuHni0P9OFVLSfjCWG1PTWO8k7YuRJ6uA8
         +yChJyOFeSG5s8vXD3yLoEEh84Mvdrvp0dc2iHiZ/U1++KWLIxzvSueuz1fHMqdw6hKF
         SQekSHAjDs4ltgXG+ZaOeYVc4GhrSKnhJK7oCkytyHRNCP8O7fDYyU+7Rg0s6ElMgNQt
         9dtA==
X-Gm-Message-State: AOAM530ymgWt7bgQclGCDMrscl7JPmC7kBu1fTHtNqwSVPVIZqtoYGZi
        nygJHQQpeS2sAmg/kdI95bj1pHnRXPvbAg==
X-Google-Smtp-Source: ABdhPJw9JJMooRgkbgCKp6kU0wrVUJNwg8njJx7w4CqStiVTMUOEjmit86IntB6bYBgrxVU35aGgFA==
X-Received: by 2002:ad4:5bed:: with SMTP id k13mr566631qvc.1.1644895021892;
        Mon, 14 Feb 2022 19:17:01 -0800 (PST)
Received: from [172.17.0.2] ([20.114.151.107])
        by smtp.gmail.com with ESMTPSA id v73sm16293910qkb.51.2022.02.14.19.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 19:17:01 -0800 (PST)
Message-ID: <620b1b2d.1c69fb81.dfb2e.723c@mx.google.com>
Date:   Mon, 14 Feb 2022 19:17:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6358378221402693531=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Fix bt_skb_sendmmsg not allocating partial chunks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220215015938.1950978-1-luiz.dentz@gmail.com>
References: <20220215015938.1950978-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6358378221402693531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614339

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
GitLint                       FAIL      1.02 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      39.86 seconds
BuildKernel32                 PASS      35.43 seconds
Incremental Build with patchesPASS      46.00 seconds
TestRunner: Setup             PASS      583.22 seconds
TestRunner: l2cap-tester      PASS      15.80 seconds
TestRunner: bnep-tester       PASS      8.18 seconds
TestRunner: mgmt-tester       PASS      124.55 seconds
TestRunner: rfcomm-tester     PASS      9.28 seconds
TestRunner: sco-tester        PASS      8.98 seconds
TestRunner: smp-tester        PASS      8.79 seconds
TestRunner: userchan-tester   PASS      7.30 seconds

Details
##############################
Test: GitLint - FAIL - 1.02 seconds
Run gitlint with rule in .gitlint
Bluetooth: Fix bt_skb_sendmmsg not allocating partial chunks
9: B1 Line exceeds max length (141>80): "Link: https://lore.kernel.org/linux-bluetooth/aa3ee7ac-6c52-3861-1798-3cc1a37f6ebf@molgen.mpg.de/T/#m1f9673e4ab0d55a7dccf87905337ab2e67d689f1"




---
Regards,
Linux Bluetooth


--===============6358378221402693531==--
