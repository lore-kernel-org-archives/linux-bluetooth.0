Return-Path: <SRS0=cftP=V3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A6C0650F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jul 2019 09:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797E720679
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jul 2019 09:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfG3JkB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:40:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48534 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfG3JkA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jul 2019 05:40:00 -0400
Received: from marcel-macbook.fritz.box (p5B3D2BA7.dip0.t-ipconnect.de [91.61.43.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id C2375CECFE;
        Tue, 30 Jul 2019 11:48:37 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Yet another counterfeit CSR device?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEQQxWySUJZBa9CF7-W_4zXcuitgaNuu2f_pYswLKDUtVwWd1g@mail.gmail.com>
Date:   Tue, 30 Jul 2019 11:39:59 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A8776B75-52DF-47E9-9FE8-4C59F10109F5@holtmann.org>
References: <CAEQQxWySUJZBa9CF7-W_4zXcuitgaNuu2f_pYswLKDUtVwWd1g@mail.gmail.com>
To:     Andrey Batyiev <batyiev@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

> I have nontdescript usb bluetooth dongle with "V5.0" marking on it.
> It claims to be CSR (0a12:0001) bluetooth dongle, but it has
> nonfunctional "delete stored link key" command, so I think it is
> counterfeit.
> 
> Futhermore, Linux kernel doesn't detect it as counterfeit
> (in`btusb_setup_csr`), because the dongle reports following:
> 
> - From USB enumeration:
> bcdDevice = 0x8891
> 
> - From Read Local Version HCI command:
> Manufacturer = 0x000a (CSR)
> HCI ver. = 4.0
> HCI rev. = 2064
> LMP ver. = 4.0
> LMP subver. = 4114
> 
> So, Linux kernel fails to power up this dongle. Ok, so I've hacked
> `btusb_setup_csr` routine to include this device too (it powers up
> now), however GATT communication doesn't work (btmon should nothing =
> no ATT exchanges except MTU setup).
> 
> Any ideas on what should I check to make this device work?

please post a btmon -w trace.log from the init procedure. You might need to blacklist btusb.ko module and then manually load it to capture the whole sequence with btmon.

Regards

Marcel

