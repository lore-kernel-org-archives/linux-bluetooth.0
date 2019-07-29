Return-Path: <SRS0=/vUS=V2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09B8C76186
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 03:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9860F2075B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 03:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7iy0Kcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfG2DUb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 Jul 2019 23:20:31 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:43156 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfG2DUa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 Jul 2019 23:20:30 -0400
Received: by mail-pg1-f169.google.com with SMTP id f25so27457315pgv.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jul 2019 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Qtlvn5JE6Kj1KVZQxpnADX5oZGSAvHEeulkTS7wVoFE=;
        b=E7iy0KcnurL4LIOiw3ynujNnR4aqUe6oO4GlIjdDZtiKy58K6Q2/kfNbeYL6c1xrfe
         9Uuu6aSrzPiT/IIOjSIfsPitK+vypZTOCyVTJkwJP2yKp3UGurO+19yIlnoK0ktF3SGc
         G0IhOHLOjI+15SRKmlR6OH0nezrpbV+pX6UVdMeFh3qY7oZX5XX/2OihfuZGf0aDhJoN
         HuBeS0mioUP1+p0FRUfJvSXnI9LrULqPUZUwQg9VjsNc+LdzkzvFhcEuH7ztsPIFoKa2
         lub3ZM5VMsbASQJqTtcD7BkrBjq3W/cp2x6mtLNXAygJhcqqVN+LpxKIs5+/4gGppiNN
         XU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Qtlvn5JE6Kj1KVZQxpnADX5oZGSAvHEeulkTS7wVoFE=;
        b=TuWcccWOfbRAY+ng65hkT5d68OgHrH2kQcbZ/L3i4phP2wddjD9YheSjBfJZQTR49U
         zCss8yfqY12D7vyfdixw/gfOsP3wcUEDWvDexrTDg2OCbVsWg70EConqhi+qczzGudM0
         Qplmy3c+4q/R0vVNY6qC1C7fZDInZ8D7KgicQJ1iZu3AYI6ztMJFMQatN6o1fZj1M1i1
         CKsQweb0yser+LrzjkcK5AZ2g7SyfovSRHXSrEBRdrJEdx54NpD+1Ky2qeSGYo/xJlKI
         w2CZ7jaK23iaYUOh0IL4w8piKkmMIWUV+EkW87xt9qDg9fjECZPXFTt85j51unMdJP+F
         8N0w==
X-Gm-Message-State: APjAAAVr9HTrDTvqLjZZZUUOpH557W35tyUxAjZEMiYMQ8PZii8yDjLa
        +QxKWd7/qjOiy/yZE61qhuGG3yXVXIUmn31CxhecJ3nj
X-Google-Smtp-Source: APXvYqzLyNnFw2RYxhB1m8yA+iWWY88zKHS7zTZZj9GG30BnDx9O/fi3W5PTWcymt84qtl+Dg2o4BmHRfcjIAmxPsos=
X-Received: by 2002:a62:cdc3:: with SMTP id o186mr34649147pfg.168.1564370429696;
 Sun, 28 Jul 2019 20:20:29 -0700 (PDT)
MIME-Version: 1.0
From:   Andrey Batyiev <batyiev@gmail.com>
Date:   Mon, 29 Jul 2019 06:20:18 +0300
Message-ID: <CAEQQxWySUJZBa9CF7-W_4zXcuitgaNuu2f_pYswLKDUtVwWd1g@mail.gmail.com>
Subject: Yet another counterfeit CSR device?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello everyone,

I have nontdescript usb bluetooth dongle with "V5.0" marking on it.
It claims to be CSR (0a12:0001) bluetooth dongle, but it has
nonfunctional "delete stored link key" command, so I think it is
counterfeit.

Futhermore, Linux kernel doesn't detect it as counterfeit
(in`btusb_setup_csr`), because the dongle reports following:

- From USB enumeration:
bcdDevice = 0x8891

- From Read Local Version HCI command:
Manufacturer = 0x000a (CSR)
HCI ver. = 4.0
HCI rev. = 2064
LMP ver. = 4.0
LMP subver. = 4114

So, Linux kernel fails to power up this dongle. Ok, so I've hacked
`btusb_setup_csr` routine to include this device too (it powers up
now), however GATT communication doesn't work (btmon should nothing =
no ATT exchanges except MTU setup).

Any ideas on what should I check to make this device work?

Thanks,
    Andrey
