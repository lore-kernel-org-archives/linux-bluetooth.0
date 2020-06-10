Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8E2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9365E206F4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFJRXF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:23:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48689 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFJRXF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 13:23:05 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 84415CECE9;
        Wed, 10 Jun 2020 19:32:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] doc: Add commands and event for handling device flags
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mU2+Z3f1ZqR8RCsOUu6Crc_xng12gcgn0YCwjzfH9Y-nQ@mail.gmail.com>
Date:   Wed, 10 Jun 2020 19:23:03 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <8FE42946-ED27-4F9F-8F30-2744D0AC2AB0@holtmann.org>
References: <20200406180331.891822-1-marcel@holtmann.org>
 <CANFp7mXe3QtkKL8+TgTp=jwvpydABhDkiXks=3h4+op20rWhGQ@mail.gmail.com>
 <AC887BAA-95ED-456B-84D2-2D1EF6A8339F@holtmann.org>
 <CANFp7mU2+Z3f1ZqR8RCsOUu6Crc_xng12gcgn0YCwjzfH9Y-nQ@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> Coming back to this device flags idea, I think I would prefer the
> original design over adding new management commands for each flag.
> Bluez will just have to maintain the current flags and pending flags
> (i.e. mgmt call) to decide when to emit property changed events for
> the device WakeAllowed property.
> 
> 0x0049 and 0x004A are now taken for experimental features but you have
> my reviewed-by for the next available values for the original patch.

I updated the patch and applied it.

Regards

Marcel

