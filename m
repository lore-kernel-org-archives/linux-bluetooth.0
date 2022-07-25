Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A1AC43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jul 2022 23:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiGYXFT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGYXFR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jul 2022 19:05:17 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EC56273
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 16:05:13 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e16so9844105qka.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 16:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2/HkIFTb1mu6v02yyQPCVfUA6en4U92SpUWNARUYdgo=;
        b=WNHic1CgaE3ExSxtzD22+j6gus6MHwgSlgn4tXBkPbBl2cuagbnquE7eyPEfIa91Xh
         Mo5BVpu/vz15f3HI6kpcRZTEubLZxQurtPCYdvOQrJkWs0c6sPhUpjv16khAcbtwPv5d
         5v1On87v+pHWo4PjtRxWsZG6QU2cUU7FYS0m/+lvnNBn/5EyP77j3oJG1ACc9rk7A66F
         H54CIGhWw3+m6AfRX5zlsNK28yMjM2kx/Xt+SBmS8O1fBHRCa8Jzd1uqcefy+Fxj3DHK
         KIuzc2otTcAMDbZNgQNXdj8LO3ns4AeNOO0IxjHwyuwv3ubKk4oTFR43JQsHr9A0pAHg
         Z6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2/HkIFTb1mu6v02yyQPCVfUA6en4U92SpUWNARUYdgo=;
        b=E/IKBXMxqEAgYC7225rPjwZvPR7uNzY4NblSxvU76794DFucc+DRCQb5hUko1spsbW
         lfN0qdsuRT1Jg67XgQpVgln0r8TEQ/j0syqG2AUm37l07EY8Dny7YTn9u4Aui9AzANm+
         LFe/R7SWTWiUVAQq8EPpCg3EDFZs1Qv4/HFVpUYy1zIP6HPztTN5APXwYYF+cQGhCrdY
         BYbzBBV+oCipDPTWzhHmKnLfVgisYWjN+z3l72oAyAUqXjALrYizuH2b69c03ix1fN/y
         rK7pkZdnhZ9ZRGz6zKbHh4/NG5s2EThEElCHt7jQLkGg7yZxowgNe6HksurVubFxqDmY
         hoPA==
X-Gm-Message-State: AJIora8CERLhJKwPA3R/g9pwD5sEPM5Yr9PQ4aPLCdDV9gWZfz/rbn5Z
        OlpJxdaD53dTiMjekDQr/xDWRPNzcqo=
X-Google-Smtp-Source: AGRyM1t1pNOTdcZ+c9picsXB8pR3uT3LZ90Y1YQS+yr+5OUg7d6G94VADj7Tfhiewoq2jWfGn1PB7w==
X-Received: by 2002:ae9:ddc6:0:b0:6b6:3f6:5a95 with SMTP id r189-20020ae9ddc6000000b006b603f65a95mr10359787qkf.667.1658790312221;
        Mon, 25 Jul 2022 16:05:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.126.193])
        by smtp.gmail.com with ESMTPSA id t13-20020a05622a148d00b0031ea4c4afa7sm8598355qtx.2.2022.07.25.16.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:05:11 -0700 (PDT)
Message-ID: <62df21a7.1c69fb81.393ed.72fe@mx.google.com>
Date:   Mon, 25 Jul 2022 16:05:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4815348819793098498=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@google.com
Subject: RE: [v2] Bluetooth: Always set event mask on suspend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220725153415.v2.1.Ia18502557c4ba9ba7cd2d1da2bae3aeb71b37e4e@changeid>
References: <20220725153415.v2.1.Ia18502557c4ba9ba7cd2d1da2bae3aeb71b37e4e@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4815348819793098498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662882

---Test result---

Test Summary:
CheckPatch                    PASS      2.00 seconds
GitLint                       PASS      1.15 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      35.92 seconds
BuildKernel32                 PASS      31.56 seconds
Incremental Build with patchesPASS      48.37 seconds
TestRunner: Setup             PASS      530.76 seconds
TestRunner: l2cap-tester      PASS      16.93 seconds
TestRunner: bnep-tester       PASS      6.37 seconds
TestRunner: mgmt-tester       PASS      98.27 seconds
TestRunner: rfcomm-tester     PASS      9.52 seconds
TestRunner: sco-tester        PASS      9.30 seconds
TestRunner: smp-tester        PASS      9.36 seconds
TestRunner: userchan-tester   PASS      6.39 seconds



---
Regards,
Linux Bluetooth


--===============4815348819793098498==--
