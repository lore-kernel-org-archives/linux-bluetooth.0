Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3E0C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8231822581
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 10:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404669AbhAZK7I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 05:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404571AbhAZK5n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 05:57:43 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D301C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 02:57:02 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id o10so1200501wmc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 02:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=FLTsPjnA8WgoT/5ooeSvDEfgWw7jUfKsbc3DOWgNQP8=;
        b=GRObe/6EbHhdKiIzMnSRUUWTne56mG7H6ZqTUrxASYY5Aga3lw74nXkaDYSG6szgwJ
         oU7Ni6FtKwTvLttK3KwFN9M8RuISLm4QyneSjfxEuPMEGxS+x/JGzBiztdbWew6IdSkx
         L3Qw29lJxdiXRBlSEXLeKCd6tm1HeUfHugRDxF1VIFsgWiVBbVwKKxTG0RTZMmSvMEKK
         7YiMwHwolGhsNBkvo0RMxZpUMLF7uvDB0X8LWQbExdkMVM6rLQKDpMq7BXz2NC61isX4
         rxWOs9onZT0i3U2PkwWeCpxcECM9eM+eITYB09HjP8hIWWXnizLBk0+sGDQU9uCQ5let
         OoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=FLTsPjnA8WgoT/5ooeSvDEfgWw7jUfKsbc3DOWgNQP8=;
        b=fiM9Jn9ZOohFVBfHvnS+7iIsUD/xfEShqapXCRR9jEzVQykmNS+GhfZ/MPtdRYns2X
         HU9lpYDijAfUzxR+Dd8hu78pbHxOPr71XzFlSqvzFSpTfDum+Wkp2uGok/4UCw3oxoM+
         X+jf1lajFvQVZy0bKEffUkkkusu9xa3PO4Fn3Yt6AQkrU23ZjZucjlksKkz4H+NZSVXC
         M9trK2pYptb9ZE3EfesZmdpHcU3xrPg5d0HQg7u4vpcLF1Ua/ftfTAdsS0b8eV85BcR2
         x0ObkutHnc4YDMmHmt10YNgyw3GYktvqmXQIBcDhheENJt5SxoW5NCxvsLfgYf7todU0
         ZEWw==
X-Gm-Message-State: AOAM533g2DUgqQneU0YSYvTGECeQX7SzU5qN9uOdNT2YEpM5ZgkCxzel
        ox6ISpZi4a2JZxy7odQRRKJ+Z+vGtJ4=
X-Google-Smtp-Source: ABdhPJza3KrSEHJ2NrihHkYwh7d5jm+buDQUoomRBfrYROICT2JD5GJfQxk/oaxoJQg0MIC0TXaHmA==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr4132141wme.53.1611658620971;
        Tue, 26 Jan 2021 02:57:00 -0800 (PST)
Received: from DESKTOP7TC9KE2 ([2a01:388:5c7:110:b1a0:6008:73ad:7f61])
        by smtp.gmail.com with ESMTPSA id n125sm2934610wmf.30.2021.01.26.02.57.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:57:00 -0800 (PST)
From:   <chinotameni@gmail.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: D-BUS Example Request
Date:   Tue, 26 Jan 2021 10:56:59 -0000
Message-ID: <078e01d6f3d1$f8abee60$ea03cb20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adbz0fgGe9SYlZQoT7GIiHLp2QJDRw==
Content-Language: en-gb
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

My aim is to automate pairing, connecting process between Arduino and
Raspberry Pi. The temperature data will be sent from Arduino to Pi without
any human intervention. I am able to automate pairing process, however I
fail at creating connection by using D-BUS. The connection is fine if I use
deprecated tools such as rfcomm, it works also fine if I use python socket
library, however D-BUS device methods Connect and ConnectProfile always
fail. I am completely aware of examples in GitHub however I couldn't create
a working example based on them. If anyone can provide working example or
any related information where the Bluetooth connection between Arduino and
Raspberry Pi is done by python script based on D-BUS I will appreciate it.
 
Best Regards,

