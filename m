Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC23CC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 12:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiFXMCQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXMCP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 08:02:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED80A7E01D
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 05:02:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w6so2391754pfw.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 05:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Prf/VJHcLzNPGHd30LHc6CkPP70FQ31JOcQkyJz5r1Y=;
        b=ZMLMeNt6RtlsL14qoMvedhTvWPVBBEEs3g+//IDXjruGnPhGtevC1Cg+HOYV7Io6Ja
         y/2L8upyImiNqQV9/Ggb16rjZDlNyzvcQ34awAslRsNb+52tYswivK2wUlgIurdQSxx6
         qEWGD2v+CntsI4d9t9tYRe4Ymj+s9KxymG7loBQvpOC8I924lbq+ChC4UrvKCdAT/4/n
         9mwcsJZ9CWaDHQO84w+ELwQEIVx7JSd5mSvezjM7zlitJ3mytwg4myqpELeXr2fvqt/C
         MfuFRAB84synI3czy9SL2kbbHX4q1ZtibA1i7Rav5VuYuv3SqhE0IQx2IK0eOHg/g8iK
         cpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Prf/VJHcLzNPGHd30LHc6CkPP70FQ31JOcQkyJz5r1Y=;
        b=45yRkK8/EfprRTCM7qpXJ2SaQH5cw8V66Ge5RL0Ws3a2K3m4nyR+83dcibty5F88Ol
         vPReeCngg/kVJOJ2TCJXaWSeThwWbhXQH1jk/S0K/jOq5lgTdcWrEORtfTKo+2RK7N1l
         XBUT6mTR9pMIMkWbddPnAAKIM/IyBciyQ1sXqhlhgSskU9I9DFeWmMVHn08YRY8qXAtr
         FlK02M1OEqXCsM4DcfEQImXMOhhdQptAuC0aVGKp7IWDaeo/0IxTMKPQh+0q38hu5LdJ
         kGUR6LNU3N5y9uv/AFKDmDc1aSBy52Sz64NfuPQcwS1x3iUg/aSgMG1p5HjtXWb83rp3
         7t9g==
X-Gm-Message-State: AJIora/5uKOWDxAA626w2Bp3fUB55MocKaP2WqTHcJK76StVNxxn5fRb
        5kjxz1KxKEC6IQdQbYYGcSfxX5ZID1s=
X-Google-Smtp-Source: AGRyM1ti0RFTgCEqxkqGVgIGOi3QHP5vzR5L/9VyUoXe+HhjMTCbPxAHHb6UmbxazOnxULgag5sM8A==
X-Received: by 2002:a63:7844:0:b0:40c:9792:5d6d with SMTP id t65-20020a637844000000b0040c97925d6dmr11655355pgc.360.1656072131984;
        Fri, 24 Jun 2022 05:02:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.81.64])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b0015f2b3bc97asm1654262plb.13.2022.06.24.05.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 05:02:11 -0700 (PDT)
Message-ID: <62b5a7c3.1c69fb81.f92ea.293d@mx.google.com>
Date:   Fri, 24 Jun 2022 05:02:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1948628232478483973=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: btmrvl_sdio: Remove hci_{suspend|resume}_dev
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220624192010.1.I9afcc6142cb963cf7014aa09edf61a94f5684799@changeid>
References: <20220624192010.1.I9afcc6142cb963cf7014aa09edf61a94f5684799@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1948628232478483973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653560

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      37.93 seconds
BuildKernel32                 PASS      34.14 seconds
Incremental Build with patchesPASS      45.35 seconds
TestRunner: Setup             PASS      576.13 seconds
TestRunner: l2cap-tester      PASS      19.26 seconds
TestRunner: bnep-tester       PASS      6.85 seconds
TestRunner: mgmt-tester       PASS      119.32 seconds
TestRunner: rfcomm-tester     PASS      10.85 seconds
TestRunner: sco-tester        PASS      10.35 seconds
TestRunner: smp-tester        PASS      10.45 seconds
TestRunner: userchan-tester   PASS      7.09 seconds



---
Regards,
Linux Bluetooth


--===============1948628232478483973==--
