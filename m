Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67ACC00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 11:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F40B20756
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 11:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUp6m3w0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgKELPU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 06:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKELPT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 06:15:19 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11240C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2020 03:15:18 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r12so1393654iot.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 03:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tRcYyPU605mT0bQzD455/MnMQryrpZfValh2qnMYYu4=;
        b=ZUp6m3w0wAsdH/Ke85AfBp5Xeqnz86LwA6ws7IEosFdSJ+poK6ji6v+qSPtbQ9zDB5
         GCBHpnvtyQEzy6ZOHqCWSimy3J/lRgsroNYrVItqN9IMfCJO57ivmi93xxbrFW/7IqpW
         ZweXDUf6STF4u42T3nzYR6KlwAuOYHWPog8fVcvy33WFP+aGzHFN7wn0TdEjWX2MtWvT
         T6GzXlMUr+jpEYFJ2JWdYyruKYydszM++GIv6uZawOKqsDv/SHR6r1LzjZ8MemjNDmRa
         I97A1e0FoaDvy6VwZ8ELG2uGW+rIRfLIOMZ/xC1RZyUOFZCJw1OKi+g4QqAH2nwc6+bp
         2VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tRcYyPU605mT0bQzD455/MnMQryrpZfValh2qnMYYu4=;
        b=j+AAL1QsK847tQ44ZCXN/289Igl9FPooqQxcxjKT4jiK6lSTUNQ8Rx71Hm6NOiciLI
         GttCBg9NVX/MTaMxbB2ZkSFJ+V7F/7+tjke1YNEXED06jkTiB5wiScUZ28dSYqDVH1xT
         Wbks5lU6Gv4NRUnjlKh6cawDNr76KniSqt2nN1Io2ip3IMT8jyyUaFMw8EzIHq6r6OeP
         WC5+0R4jCcnJ5SSeiXw2Kh9YnmAbNlIjHKhSczlXdfdhCkXgNdlJNQDyKv9bE6j4xWrf
         WCa+Bmpw1B5P5IwPdbhSTFc94GwVW/3EnlOlTuOC9ERpkplpaTn0uB+ZTtnoDThvFG57
         FX6A==
X-Gm-Message-State: AOAM531d9Bh46gNAReQYwL6huTlQe/YUa4kNu6fL+p7BVNOdFuvJ7Dju
        JZzUWNDhrj/2Y+bDWQRiag3PuSmAPFmVEg==
X-Google-Smtp-Source: ABdhPJz2gQfCnK4prdGeH1fIwCcgCmgMDBReLUuG07UlEAbbuibW4dPN3AdK42aTXGgc61EwXdrJhA==
X-Received: by 2002:a02:48:: with SMTP id 69mr1459096jaa.108.1604574917150;
        Thu, 05 Nov 2020 03:15:17 -0800 (PST)
Received: from [172.17.0.2] ([104.209.181.9])
        by smtp.gmail.com with ESMTPSA id e8sm989209ios.10.2020.11.05.03.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:15:16 -0800 (PST)
Message-ID: <5fa3dec4.1c69fb81.d2617.3553@mx.google.com>
Date:   Thu, 05 Nov 2020 03:15:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6037367981717546991=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v3] Bluetooth: btusb: Add the more support IDs for Realtek RTL8822CE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201105105448.16025-1-max.chou@realtek.com>
References: <20201105105448.16025-1-max.chou@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6037367981717546991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=378069

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============6037367981717546991==--
