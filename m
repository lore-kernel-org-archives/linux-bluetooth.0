Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F43C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 21:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441806AbiDUVJy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbiDUVJx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 17:09:53 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F116049244
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:07:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id f22so4188773qtp.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rZwmWumLrxezSEnGT0SSRLiPXj1vjunaBAhUOhmvtwM=;
        b=Xz2xC7T+PtvU6AwrNBSrnXGtMcs7go11hkuO61UcGMSyRruKFImnrVO3J4fyiyuLxk
         CXjMv/UyetDJRL/FyP4xk3u2MU1M9boB91dxMx4Eh6IWOF+Cfw7qSRbSnpbPuXuJ4jKu
         OQvTrDK+5R02cOCDuSDswvlRJWjIIcEH/JtdPsAD/6e0NN0mDFYkB9xzsvZYMKsx2QSV
         vCUEnXcjOaziTe2Uh/AsK0wChp13pX3T8OodHEJKLUfwhalHRMsKF3A9f40QdWtuqtce
         d+aO9d1DJdDzHjrR2jeKG/dzSsehVoVda/JgqIFvO0CIhOpY11mOwrXErQVV90PKLiwd
         5GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rZwmWumLrxezSEnGT0SSRLiPXj1vjunaBAhUOhmvtwM=;
        b=NB0mXyGN8wwgZeKeI/a0PFR2Ck97W8E+EsyCOrXXOL8qva0v337L7iCU/v9HoqNqNv
         VDoHz40CGu/+IUvnT1bwoiJUyruygePGO2VzLbpQVzJLc36ek9Te4EgGQuF8WWhLG8rZ
         itvu0R4WZpAEUVKZtVgaBQYe4cqRdy/cVDQJT1I8+J7nYld5NBJedgEjLanKpVIoNorV
         LIQGJf3mIA8BgSGqjmmHt3nFH6gbCUpyqA/W8RmM17o63Vs8JXgXDPQdyD3TosWZDmGc
         Hv/6p5mJ6Ri4MDxqePu1gf6ku2DlvUgSOtwiBluEkbyo4MqB05/E1jHqSUA3AeUROmSn
         eXKA==
X-Gm-Message-State: AOAM531cnX7ULiwvnY4hhwiRyNoSQ74sg+wnCjM9WBpgouHl8CX2T9u6
        q2Q1Vs8QFxlJmAHAXzMdne6u9Hac6Qg=
X-Google-Smtp-Source: ABdhPJzGrkFZuB9RT1jPWnQBr3MlPvFgYUZU+zuG3QQ4q3F8qM1BJobl6Hy7R4wxSo5N8PGneLDTCQ==
X-Received: by 2002:ac8:5449:0:b0:2f1:eea6:bbc7 with SMTP id d9-20020ac85449000000b002f1eea6bbc7mr997321qtq.143.1650575221907;
        Thu, 21 Apr 2022 14:07:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.220.182])
        by smtp.gmail.com with ESMTPSA id a63-20020ae9e842000000b0069e6722632bsm38078qkg.39.2022.04.21.14.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:07:01 -0700 (PDT)
Message-ID: <6261c775.1c69fb81.d285d.039f@mx.google.com>
Date:   Thu, 21 Apr 2022 14:07:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8455272688354111140=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_event: Fix checking for invalid handle on error status
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220421204715.3268714-1-luiz.dentz@gmail.com>
References: <20220421204715.3268714-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8455272688354111140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=634373

---Test result---

Test Summary:
CheckPatch                    PASS      1.87 seconds
GitLint                       FAIL      0.98 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      31.73 seconds
BuildKernel32                 PASS      27.95 seconds
Incremental Build with patchesPASS      38.16 seconds
TestRunner: Setup             PASS      474.65 seconds
TestRunner: l2cap-tester      PASS      17.75 seconds
TestRunner: bnep-tester       PASS      6.35 seconds
TestRunner: mgmt-tester       PASS      105.77 seconds
TestRunner: rfcomm-tester     PASS      9.94 seconds
TestRunner: sco-tester        PASS      9.76 seconds
TestRunner: smp-tester        PASS      9.67 seconds
TestRunner: userchan-tester   PASS      6.59 seconds

Details
##############################
Test: GitLint - FAIL - 0.98 seconds
Run gitlint with rule in .gitlint
Bluetooth: hci_event: Fix checking for invalid handle on error status
13: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"
25: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"
27: B3 Line contains hard tab characters (\t): "	gateway SDP record: Connection timed out"
32: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"
35: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"




---
Regards,
Linux Bluetooth


--===============8455272688354111140==--
