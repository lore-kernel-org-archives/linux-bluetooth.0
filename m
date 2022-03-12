Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583B4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 17:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiCLRpN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Mar 2022 12:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiCLRpL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Mar 2022 12:45:11 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B32E48396
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 09:44:05 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a14so9951740qtx.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 09:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=R1tZCiT3I8mNoKNp8L5qcgTo+duTw3ETHzcIpGzBEjA=;
        b=I0e2g1CgUCKxEy4XGKI00gvAuaGCHoU3N+9pUughNxNmV8ojU4R1FpLQNe/zJL1rJg
         QepcMpb6gy+3c7TX1N9VUleT4sF7j13D/GaFfPkHP6QVGlbX2m48ZvHPOjUvUQi83Xc/
         6g+zpT+VidCaAUzwZk+qqfSDXfiN9j9t2tSjh9aqCeGZqTrxDYVV1cv9pRPx8N7jpSga
         3dd0kuOv6wNftpMzJ/cYb94KGjlimRrtQ+MYNe+EMDH1CZp4WaFLtZcQv/E/KYxyPET6
         oE4Vr2LHd5iE1Wk53e2FPlADZLDPr2RkCH7O5paU5136YueyO5bs32RAiqSfDFwIViJB
         pTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=R1tZCiT3I8mNoKNp8L5qcgTo+duTw3ETHzcIpGzBEjA=;
        b=6E2Z1ICCR1LUjAcsvKxTvnRZewhoRRf01cfyG9zIWeWoXvGvlnUk/yQ28RlLV62w2J
         wjcyg4VErhCaMoLUX78YQPK59Y1KAv+Fu+ubQOpgLWaqrUMg6/kWCUZJcNkMQIBUXFAk
         +MZj2m4uKY3ZJQl6azi8i2w6pmb0+ujSDNoxdVNLX5RnQCF/GWP1rrog31DL3xhqwWgk
         JonHYWXrD0rJCsRD3tchwB045z/FHq6PGzHGER2P3/jo7JmGGzbwjAmpOQQltKjKKwWA
         4b8nlVG9aABcwKduA88j4kyfeMXugvttxScyK0b5wqrrtchyJs/CqqVH9NzhcjgEZjvv
         yMDg==
X-Gm-Message-State: AOAM532zbibCKz7HJsfK1mYyckpXifLoeD65rC+WOZl+BoC4u+hSU9ut
        pu/9E4EMJdkXren1Yo/7xyZzWuvpFdirwg==
X-Google-Smtp-Source: ABdhPJxg2gpDPHyXQ6hHqQzqHOw1g4dja/iH5BdqsE+zqRYxO4jrfuu+X4uag2q1r/C02UiblTlDnA==
X-Received: by 2002:a05:622a:1996:b0:2e0:ffd3:a2d5 with SMTP id u22-20020a05622a199600b002e0ffd3a2d5mr12998962qtc.390.1647107044001;
        Sat, 12 Mar 2022 09:44:04 -0800 (PST)
Received: from [172.17.0.2] ([20.25.25.181])
        by smtp.gmail.com with ESMTPSA id n13-20020ac85b4d000000b002de6fe91d2fsm8272185qtw.68.2022.03.12.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 09:44:03 -0800 (PST)
Message-ID: <622cdbe3.1c69fb81.494da.e338@mx.google.com>
Date:   Sat, 12 Mar 2022 09:44:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7517292261777889076=="
MIME-Version: 1.0
Subject: RE: Bluetooth: hci_event: Remove excessive bluetooth warning
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mike@fireburn.co.uk
In-Reply-To: <20220312164550.1810665-1-mike@fireburn.co.uk>
References: <20220312164550.1810665-1-mike@fireburn.co.uk>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7517292261777889076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_event.c:6818
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7517292261777889076==--
