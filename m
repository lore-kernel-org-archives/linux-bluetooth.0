Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BBBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 17:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbiEIRaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 13:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbiEIRaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 13:30:21 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1017DDD1
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 10:26:24 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id f3so6645653qvi.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 May 2022 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VbhrwySksxN5qaoRH87H6DPMNvPi+hNjXjM+RsI5mKs=;
        b=T3vJOLSFhxspIblmZapsQrVzqubSvEvTWqvJlNdc91Qm9BzuXNdVY/Tz2h+PyC8DPR
         6upqueyPWGa36VizwAhe15y/oUlZN1nsOEKVQvYR/SKfTsHf6KCu+zsx4OYZYMTto7y+
         Os8iDSyf/G76h7IEmET5VpACErL+sDwAeo5kazKCHMqoZDGthhaEIimz1uKH3Hkk6K/x
         NrH4+mfIvSSxm3R/253KU8WWt844AFsbvGO/4QBRVWnmnlCANweL47W/Xkinhy9QKEWF
         AK5MTx35tFtjw/f2Zh2VFKyOjx7yAglrPGbF+2S1fC8pNwZuHOGmTFedOvdqhGcmtEqH
         iN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VbhrwySksxN5qaoRH87H6DPMNvPi+hNjXjM+RsI5mKs=;
        b=Na4DY8O81Aom/DBxR4CbZi96/HVkTgSHPiZ+xgn7lw0sBJSMZMQGJNvGF2skAGSimp
         OxCNtKwIQfs9dCDSRLIADiQu1vjft5khwHmz7vUOg0l9raQb17oLQz8AbglfAqKq/Iif
         cgJUXlXcHn60J1RlXEbcvcWd/SefLJ6QOpKKVW07TNZZGLUdD/tsef/AahTiz7yWwV5H
         qZmtJceZ2NsePNgM+6EKONjqQACQ29YADSlcABPtkmJbIbtKYckur4L4n5Pkp7L9U5J4
         3iuejKAO20KOcRGmcbq0cVjfsvhXLNcvEAphBMdurufu2MOZNWQJFAt1XEBluEzbsKRa
         fI5w==
X-Gm-Message-State: AOAM530KuOfItNlwGnvZYoXMMAzEmo95RkM2y4a14+buDa8VwXLRhmiZ
        xoaRXUNh+/plNeZWyya/Jp+rKsyIfbxMQQ==
X-Google-Smtp-Source: ABdhPJx5LbWjEq6rc88wp0E09eyItacphdqw6jJ/lXiTHOjgmEBfaFSM9k7Lek45nBG2fXg3XDnomA==
X-Received: by 2002:a05:6214:27e7:b0:45a:96ed:d45 with SMTP id jt7-20020a05621427e700b0045a96ed0d45mr14197628qvb.60.1652117183202;
        Mon, 09 May 2022 10:26:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.0.93])
        by smtp.gmail.com with ESMTPSA id e26-20020ac8671a000000b002f39b99f6c2sm7770048qtp.92.2022.05.09.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:26:23 -0700 (PDT)
Message-ID: <62794ebf.1c69fb81.9e08e.6873@mx.google.com>
Date:   Mon, 09 May 2022 10:26:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8743172198538396658=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dimitri.ledkov@canonical.com
Subject: RE: Bluetooth: btintel: Correctly declare all module firmware files.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220509163259.1513242-1-dimitri.ledkov@canonical.com>
References: <20220509163259.1513242-1-dimitri.ledkov@canonical.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8743172198538396658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639836

---Test result---

Test Summary:
CheckPatch                    PASS      1.59 seconds
GitLint                       FAIL      0.99 seconds
SubjectPrefix                 PASS      0.93 seconds
BuildKernel                   PASS      31.76 seconds
BuildKernel32                 PASS      28.69 seconds
Incremental Build with patchesPASS      38.90 seconds
TestRunner: Setup             PASS      475.73 seconds
TestRunner: l2cap-tester      PASS      17.45 seconds
TestRunner: bnep-tester       PASS      6.16 seconds
TestRunner: mgmt-tester       PASS      102.48 seconds
TestRunner: rfcomm-tester     PASS      9.62 seconds
TestRunner: sco-tester        PASS      9.46 seconds
TestRunner: smp-tester        PASS      9.42 seconds
TestRunner: userchan-tester   PASS      6.37 seconds

Details
##############################
Test: GitLint - FAIL - 0.99 seconds
Run gitlint with rule in .gitlint
Bluetooth: btintel: Correctly declare all module firmware files.
1: T3 Title has trailing punctuation (.): "Bluetooth: btintel: Correctly declare all module firmware files."




---
Regards,
Linux Bluetooth


--===============8743172198538396658==--
