Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52194C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Dec 2020 04:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F17F230FA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Dec 2020 04:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgLYE2z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Dec 2020 23:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgLYE2y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Dec 2020 23:28:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B6C061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Dec 2020 20:28:14 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d26so3735788wrb.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Dec 2020 20:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orcam.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=wmJs7zKf/+RCK1WPopBohG5gzoxZ3nrWzARx2+S4/MU=;
        b=FI6E6wvF5kcO58TSHVdtqnaFPf4V3CU9T3YAMyO/lP6gOqqaRMT/a7ykO2g/XQBYGk
         OCetGeLK7ivt8Bk/u7lHXQ1OTRugrHsjPIwLb5+76hvBGW0kk3YYKZQwmUNtPNWBQyNj
         nUsBKriMjvjLtx3xZt6As74kMPI6WgsAHayHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wmJs7zKf/+RCK1WPopBohG5gzoxZ3nrWzARx2+S4/MU=;
        b=IEEvjt5TRI05+ib+AErki86PdIM9ZIvBAxInHXdS4h+4h+AvEZEASTUmOnRg2Wsiwi
         K7exJpmGxJU0F45xi22NjozfoYNP5KcU41N1Hxw6Ymw72ksQPliF43cGplCQ8kO/Z44o
         n/akX7Q3e8MZ5w3d5RxEBmlmb35xs8MyOSbDV98uFzz8btR7aMhhVISIM5+ck3dNe+U4
         ibnX93+J0fVc2RUXYa2hud6zG7+VITBELlsiIybQWG1NX2F/qwvr2Vi5o047M8dB+JLB
         QlNreWrr56Ns/fq3YThxXnfHTkJ8cfd7kHbQPB9DPnO6ip+z956xGyijeJLSbo3Ey4lp
         zBgw==
X-Gm-Message-State: AOAM532wTv5rrbupK2AeYEsbAUG51H559eUZl3Ct+54xGiXwxBgDEaGi
        PEUMGXXOWk36EIDdSsb2V0W0ozum9TsNwovBjs/hnzp0ZnKVWQ==
X-Google-Smtp-Source: ABdhPJxbCiWIVA0t7vSjI0EnM0crLqhZphS/lJPSxp3RducWhnRCjueXUXl7fdwcWMwYErw+etcBGUk2eAOHSDMgiBQ=
X-Received: by 2002:adf:9525:: with SMTP id 34mr37900289wrs.389.1608870492797;
 Thu, 24 Dec 2020 20:28:12 -0800 (PST)
MIME-Version: 1.0
From:   Ordit Gross <ordit.gross@orcam.com>
Date:   Fri, 25 Dec 2020 06:28:02 +0200
Message-ID: <CAB+bgRb6vh4Pv9nZjYGoNXimTGoW1jYjxHk8ouvf6cBb8PcOXQ@mail.gmail.com>
Subject: getting address type from scan result
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi,

Up till now the peripheral device we worked against was configured
with public address,
now it might also be random (both BDADDR_LE_RANDOM, BDADDR_LE_PUBLIC).
The type of address is needed to connect correctly to the device
(using l2cap_connect).

How can I get the address type from the scan report?
I'm currently using bluetoothctl, which seems not to expose this
information in Device1 interface.
thanks in advance! and happy holidays

--
