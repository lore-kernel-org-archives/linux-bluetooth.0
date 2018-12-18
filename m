Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1AEC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17B82184C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeLRXbD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:31:03 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48329 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeLRXbD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 18:31:03 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 376F1CEE81;
        Wed, 19 Dec 2018 00:38:41 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Broken "device" privacy for my TI chip
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <AM0PR02MB38415BE5FF10D0A6D1469E8AC5A90@AM0PR02MB3841.eurprd02.prod.outlook.com>
Date:   Wed, 19 Dec 2018 00:31:02 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <32DDD430-DD53-4C30-B288-1AE2F58D2EC9@holtmann.org>
References: <AM0PR02MB38415BE5FF10D0A6D1469E8AC5A90@AM0PR02MB3841.eurprd02.prod.outlook.com>
To:     Kai Ruhnau <kai.ruhnau@target-sg.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kai,

> I’m running BlueZ 5.50 on my embedded platform containing an ODIN-W160 WiFi/Bluetooth-combo-chip with a TI Bluetooth core. After un-resetting the Bluetooth power GPIO, I run `hciattach … texas 115200 flow` and then start bluetoothd. In `main.conf`, I have set `Privacy=device`.
> 
> With this setup, the `set_privacy_complete` (adapter.c) callback in bluetoothd is called with `status == MGMT_STATUS_REJECTED` and according to my 4.9 kernel, this is the case when `hdev_is_powered`: After booting and running `hciattach`, my chip is already "up" and thus I cannot set the IRK.
> 
> I found in `texas_post` (hciattach_ti.c), that there's an explicit ioctl to HCIDEVUP the chip at the end, so this combination cannot work correctly at the moment.
> 
> For the time being, I have extended my hciattach systemd unit with `ExecStartPost=/usr/bin/hciconfig hci0 down` and that fixes the `set_privacy` call chain when starting bluetoothd.

stop using hciattach and start using serdev.

Regards

Marcel

