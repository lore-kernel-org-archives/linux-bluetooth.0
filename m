Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E66CA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 10:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjILKmS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjILKmR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 06:42:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5952D9F
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 03:42:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf6ea270b2so36858665ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694515332; x=1695120132; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XuKwqk+qwJLyu8Y7xKHY+yWAtSbzuBCmFD+gdKsH6MY=;
        b=ht+ePz1CfSso2v42oqve8sDuIiLxoEYs6jYWoXkAjIUaEnCtOrbN8gkuOgF7qE3z9W
         Ffb7o3vDAHcHnuw2A+jXBG3GUlp7qNU1t4Jttk1HggadAhpxeQvtduk2zITnJ9kOu4mF
         Kq4m8JCnlIAdvUlAa9yR3xJ5mhcURW59uBBOUTwls+qIkTWuVJVDP3fgfCl28HE0+yE6
         WeG5Id5F5u4+iJs/pqvH+M2UDTtwM0KXsW9tc1i5wctjJB68gSJec2r3BuDAp3grgwXt
         Dh+3v8/IvWZSw9pkva6pRzNupjf6P67XWtJ9lWzVG+jve624MGcThkePGnM3xumKPKnL
         PttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694515332; x=1695120132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuKwqk+qwJLyu8Y7xKHY+yWAtSbzuBCmFD+gdKsH6MY=;
        b=SXe8Ah5sSrvzg2ieeVSw/1mMwKufmBrNwlNUuq9KWioDiyii3OQ79RCSf3cFqnEDve
         k0Lu+xZAgS+z5XhrUcaQxMVhsIVxGy1E8CUy1co4+YSZFljvskj5HWon3OTj0EzYFl0e
         I16WNSyJ/4jtdf5eE8ggdkCVTUk7Dc6trq3AkxfNHehi29egxA3nO1KID6ueYybU38cN
         WRZys/vgyazqpClAR3c9nauu7ijIe+dYUwsgkf6tneyRio9MuIoXyVSI7tWFRCeEMtTP
         E58FhG3Q549xotwTRBtRSfi5mQCiWofXRxuM2MHEJGJs/64i0VZvrBVYYKYmbw31FUEW
         aWfw==
X-Gm-Message-State: AOJu0Yw9pbokgsxdoK31WwEHdWNfAQl2CoWlaZXpWZfNJjtmp0O/956t
        0xC7RkclGLnG6ifDHvLK+3aZ2jT915I=
X-Google-Smtp-Source: AGHT+IH5R5jJCH47yV+P3UcVQD0X7HlE6F5ZgVaCfuyq7ZE/xBRfqHE5TMRsogcR6dEtFqkS82jtIw==
X-Received: by 2002:a17:902:eb46:b0:1c0:c640:3f3e with SMTP id i6-20020a170902eb4600b001c0c6403f3emr11499778pli.42.1694515332445;
        Tue, 12 Sep 2023 03:42:12 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.11.210])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902bd8a00b001b9e9f191f2sm8151888pls.15.2023.09.12.03.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:42:12 -0700 (PDT)
Message-ID: <65004084.170a0220.ff7a.51dd@mx.google.com>
Date:   Tue, 12 Sep 2023 03:42:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6137892083160463797=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v2] Bluetooth: qca: add support for QCA2066
In-Reply-To: <20230912093957.3334273-1-quic_tjiang@quicinc.com>
References: <20230912093957.3334273-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6137892083160463797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783369

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      40.24 seconds
CheckAllWarning               PASS      45.38 seconds
CheckSparse                   PASS      51.36 seconds
CheckSmatch                   PASS      135.91 seconds
BuildKernel32                 PASS      38.84 seconds
TestRunnerSetup               PASS      586.45 seconds
TestRunner_l2cap-tester       PASS      33.08 seconds
TestRunner_iso-tester         PASS      75.19 seconds
TestRunner_bnep-tester        PASS      13.66 seconds
TestRunner_mgmt-tester        PASS      255.45 seconds
TestRunner_rfcomm-tester      PASS      20.44 seconds
TestRunner_sco-tester         PASS      23.04 seconds
TestRunner_ioctl-tester       PASS      22.40 seconds
TestRunner_mesh-tester        PASS      16.82 seconds
TestRunner_smp-tester         PASS      17.93 seconds
TestRunner_userchan-tester    PASS      14.11 seconds
IncrementalBuild              PASS      36.93 seconds



---
Regards,
Linux Bluetooth


--===============6137892083160463797==--
