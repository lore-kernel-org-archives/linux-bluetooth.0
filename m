Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2301FC47089
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 23:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLEXaf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLEXae (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 18:30:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25D13F3F
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 15:30:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 21so12933209pfw.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 15:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=36kUUdlZRiVUXNgQHuJYI5qLCAbBrTtAcNOuMjO6CW8=;
        b=aIvKNmTR+1J/VpVjJFHBKSz0390ostikGmeYWa0m+yEn/zSmwBMFfesBd7IlnaJ5os
         YPwEUdWJAbehAF5A7bM0GVdvJPd13VFxM7KVW77bp2ky9ZWn4XmAgTxPVheuxi/jnw3E
         JhXWS3yA37cU+zdX4NA5MFIeSXs8zTHrszI4LdD5Sc8UGAW96uC+hZyop1AIKxe/MWv7
         R3pdbIXASBngfOp1woucU++sgzhdJaqw6cFPiUy4LaWLG3Log/fJoiWLKxP9oA09uMeR
         Yw3M6kazY5Fk4YpHP7v7iOKP63GT1hbmZtqZASUkBiIYKzXmVTNZEOqXZfK0hsXVIgBi
         NUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36kUUdlZRiVUXNgQHuJYI5qLCAbBrTtAcNOuMjO6CW8=;
        b=bAQ+YtqcR3OHnx4cqCWYBcOjHPVAdJKxpHviT7iT+OvMSQFkyABaRNzFMaunwJTt5X
         Cq7LbHupwIdptW1gQPyGqXnuyj7Rczs7ewdMXt95rXeGJeZQ132hIBzraqAcQrjTuMb6
         Cfsl707Afm7gcx80VzlrrNMS8cccoH6qIZVuzPlV9PI2Me1yme05oSE72MXgH1UWf2GI
         pm6uvdIpcalM4VhRA4Tqbd+urjmnfJb7yjSr4QccswytURVsCIBqlw1X0BqvyzLHqxvZ
         C9eRDQf00myYpUVqn1vFZyPZyEf/aXr/iT0uUS8IdhGAB4L3vUDSn72RtjapMkOujATr
         nSYA==
X-Gm-Message-State: ANoB5pmuFfj2xL5VpQeRZPp+VjkNGsZNNWS6y/CjlnRjg6SiCVVKLEId
        ako+EkbhK7ZYZtVJq2IO0cfzY92myiA=
X-Google-Smtp-Source: AA0mqf6A0/eDw7P9Nbs3BCAlHegK+aPU8PzGeylukiqdyIKRS53L/L38Lbyx90yksVtjDoLWNlDxIg==
X-Received: by 2002:a63:1803:0:b0:477:6e5d:4e25 with SMTP id y3-20020a631803000000b004776e5d4e25mr64357437pgl.70.1670283032214;
        Mon, 05 Dec 2022 15:30:32 -0800 (PST)
Received: from [172.17.0.2] ([104.42.57.134])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b0017e64da44c5sm11152536plk.203.2022.12.05.15.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:30:31 -0800 (PST)
Message-ID: <638e7f17.170a0220.8c301.49f5@mx.google.com>
Date:   Mon, 05 Dec 2022 15:30:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3649151649396392011=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client: Allow gatt.select-attribute to work with local attributes
In-Reply-To: <20221205222617.3580784-1-luiz.dentz@gmail.com>
References: <20221205222617.3580784-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3649151649396392011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=701982

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      26.97 seconds
BluezMake                     PASS      862.69 seconds
MakeCheck                     PASS      11.89 seconds
MakeDistcheck                 PASS      146.57 seconds
CheckValgrind                 PASS      243.69 seconds
bluezmakeextell               PASS      94.53 seconds
IncrementalBuild              PASS      718.24 seconds
ScanBuild                     PASS      1008.07 seconds



---
Regards,
Linux Bluetooth


--===============3649151649396392011==--
