Return-Path: <SRS0=3vvc=RY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE86C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 09:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DE1218AE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 09:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxUgfOD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfCUJlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:41:45 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39380 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfCUJlp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 05:41:45 -0400
Received: by mail-ot1-f47.google.com with SMTP id f10so4852175otb.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2019 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NOoVr6JKWpdHpvtqFB/xwOYQAC30M0qigFfKLs2leg0=;
        b=FxUgfOD+W5qjeMnj088gVpNrOYII77kka7gDkLw+N3/i/NL0S8J/JYEbsRSYDjtlyl
         Q+c+omNw5LmVzpW2VgeMLPJvVtVUOdYDXtQ25ZORYUe1gg8PeUSYJKddow61Sbm7R32J
         adMuEBuD0KD6ADkuwbBk/AzKTM08fToiDkeXXi0vqlBStz2U6OGdkAE6jmYEhQEVHPay
         h4y5zpQNZ3DFiISUbAXHquS7Ne6JacoqqFN9BvdfUg8+vbdkSPOXZWF0+CtKDPCunPE2
         ptIt0ZPP47nOcXh6t1rEBgk0BbJ/leaVrGG7KTeVtAEc5zojxYpfADN5fNvgFS6I0WS1
         fCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NOoVr6JKWpdHpvtqFB/xwOYQAC30M0qigFfKLs2leg0=;
        b=fCsLR8rq3qTq5RQnnELhLU8Zg905alC1rh3AJr+Bk8dgRdgIUpMqq8u6CrwUzjU4J3
         tH7iNJTzaOCT5WV6p0RDakLhep298dZsyrKOeaToiYX9/TYGpNgAZjPhriXeJ8BC9jst
         fdgrN/7GBszghShB6JqEoY2Vhzv4VG5tXHy2uvkYCbwLoVbilzpxuhRUEE1ouzPTZsuf
         +gqQcb7UafClZGPzhtGYzk7gGuO2TOLm+C8wgSUJJYwclxt8atCoX25pdREpjuv6xorl
         2bB7NIcoW8sZSPnGv1i+HegZSGVQgjZY/GJb/TKs+s6GAuUVQkfH6Sx39F5nGRU716Ly
         b5Sg==
X-Gm-Message-State: APjAAAVP6e9jZhpdw2bl2uzWWQE06OKU4sCG1/GELbDTHPCw8HyXsAMk
        v/pBbadguWvkn72oQNjj74bKQpqqcAKEsNfgpnY6VY5y2+A=
X-Google-Smtp-Source: APXvYqzTS2vBJqiWW1mqMmssof0SIr1zUQRfaBsjBrqbbIPHBBu1v3bONOi/Ho/rx2s5sZ6vLYY1pJasnWqxQPBWx4M=
X-Received: by 2002:a9d:63d4:: with SMTP id e20mr1691173otl.243.1553161304409;
 Thu, 21 Mar 2019 02:41:44 -0700 (PDT)
MIME-Version: 1.0
From:   Miguel Sancho <miguel.a.sancho@gmail.com>
Date:   Thu, 21 Mar 2019 10:41:32 +0100
Message-ID: <CAGuyqoEUrwLa6nVGVKasn=3kTTmJV3oLvUO8-9AsnGn08cQGjQ@mail.gmail.com>
Subject: BlueZ 5:50: First key sent from Ble device lost after initing bluetoothd
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
using BlueZ 5.50, I observe that if bluetoothd is re-initialized, the
first key from a previously BLE paired device is not being processed.
Looking into bluetoothd log, upon first key pressed in the device
after bluetoothd re-init, bluetoothd connects to the device and
creates the uHID device:
bluetoothd[9023]: profiles/input/hog-lib.c:report_map_read_cb() HoG
created uHID device

In the second and further connections, key works fine, this is the
only output related to HoG:
    Line 401: bluetoothd[9023]: src/service.c:change_state() 0xd0b98:
device profile input-hog state changed: disconnected -> connected (0)
    Line 402: bluetoothd[9023]: plugins/policy.c:service_cb() Added
input-hog reconnect 0

Is this expected behavior? Can it be avoided? I wonder whether the
uHID device can be created upon bluetoothd initialization instead of
waiting to first connection.

Thanks in advance

Miguel
