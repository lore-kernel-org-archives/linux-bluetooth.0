Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0186EC388F3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 20:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6F7224D5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 20:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYPTbg0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbfI3UlE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:41:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41516 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfI3UlE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 16:41:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id n1so18784807qtp.8;
        Mon, 30 Sep 2019 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lHN/tDnufQZObPeH7yuPF8yjfolHqJGmsLh3bQf8sJI=;
        b=dYPTbg0DlUybLnnpGviIbEjsKj/G1+CfDUrB91glQtk/q0CXG94Id/SAfG1ZxoRXdP
         xiibhKBYUWuxsffCd/ksicV0+KWwT/5VmrgkvmJ6hM3v7sSwQQRCQ4w2Swyp00jFatZD
         g7hoVZ3q1oSt3Sm1ljliN+wY9tN/Jfnih1n68zd68TYpvcwk0UzoGNzxq8aVIOnDZfdi
         oGk+0wwgbDkUu6UZUKbf2+fPhliFVuldzjXkIeJKPnohMLjqUGzIRUXmKE7iASa4pU7U
         8D0zA7k+TL2Vn9kFs6fXnqX6DAJxkoXwO6DqQkCQB/V2mxA6BzqkFouDd2Ji15ARZZvG
         eJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lHN/tDnufQZObPeH7yuPF8yjfolHqJGmsLh3bQf8sJI=;
        b=TUdCwqRINxPBXpmvopKtV5tznaYgLjca8CIfd22zDkk9Sgi1wmVSemJQHSX81fmafZ
         RY1tApvlMiGAO07vlV6DKpNYdTpOdITljTUTr05lg90UnkwMSZ0k5YIZALuIwOFJcRqv
         fCBVoSWnTdwQEiAeAkOYPgF4QzoOIULqWr88CLtRFce6oGbiGsoWwahVV5WYyBvU1maF
         S+BzogB9qSi33A1+362Zm53tV+sBaUAfH0ZWAqmSArhQjeqCLh2i+tZypZ45QypSVgo4
         AreqQrKBLI6guorVKNPPmyHZNCLpSt/A31Cth8d2eHwIp5ynCBO0fZePcCRnObclFpRk
         JMuQ==
X-Gm-Message-State: APjAAAVYoWOd4EdDxAk3ShODe2mbHu1zy048imGtq4N9m1LQKRmqZ7oT
        Uue0HHC3OIx40oWZAO8K+XEl8vgvQq275qpk7e/0s500
X-Google-Smtp-Source: APXvYqzcRolQWJkvNIFKrMPKkFHxtANjKncJWEV6fkoP4U+5RdLcKAkWwkiTpQPbiRnOrJgqVkX2ECn9UWoY2h7pYQ4=
X-Received: by 2002:a05:6638:3a5:: with SMTP id z5mr20882591jap.95.1569874230438;
 Mon, 30 Sep 2019 13:10:30 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 30 Sep 2019 15:10:18 -0500
Message-ID: <CAHCN7xLOCC00UC4PB3vHa6Q7yyhXVEaWgx2X9D9L2dDubd_5fA@mail.gmail.com>
Subject: [PATCH] Bluetooth: hci_ll: set operational frequency earlier
To:     Linux-OMAP <linux-omap@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Is anyone else having issues with the hci_ll after  a2e02f38eff8
("Bluetooth: hci_ll: set operational frequency earlier") was applied?

I have an i.MX6Q with a WL1837MOD attached to UART2.  After this patch
I git a bunch of timeouts when initializing the device using the 5.3
and 5.3.1 kernel.   I know a bunch of omap and imx users have done
some various tests over the years, so I thought I'd ask.

[  195.911836] Bluetooth: hci0: command 0xff36 tx timeout
[  206.071837] Bluetooth: hci0: command 0x1001 tx timeout
[  214.231862] Bluetooth: hci0: Reading TI version information failed (-110)
[  214.238712] Bluetooth: hci0: download firmware failed, retrying...
[  216.391834] Bluetooth: hci0: command 0xff36 tx timeout
[  226.551843] Bluetooth: hci0: command 0x1001 tx timeout
[  234.711856] Bluetooth: hci0: Reading TI version information failed (-110)
[  234.718705] Bluetooth: hci0: download firmware failed, retrying...
[  236.871832] Bluetooth: hci0: command 0xff36 tx timeout
[  247.031837] Bluetooth: hci0: command 0x1001 tx timeout
[  255.191852] Bluetooth: hci0: Reading TI version information failed (-110)
[  255.198706] Bluetooth: hci0: download firmware failed, retrying...
Can't init device hci0: Connection timed out (110)

Revering this patch fixes the issue, and subsequent patch proposals
form Philipp haven't seemed to fix the issues for me on 5.3

adam
