Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47043C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC156137B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 13:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJTNHW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:07:22 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46620 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTNHV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 09:07:21 -0400
Received: from smtpclient.apple (p54899aa7.dip0.t-ipconnect.de [84.137.154.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 47D49CED1B;
        Wed, 20 Oct 2021 15:05:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: btsdio: Do not bind to non-removable BCM4345
 and BCM43455
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211020130023.196651-1-kmcopper@danwin1210.me>
Date:   Wed, 20 Oct 2021 15:05:05 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dragan Simic <dragan.simic@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9074E09C-F1A0-48CA-BCB4-2526B4CFB89C@holtmann.org>
References: <20211020130023.196651-1-kmcopper@danwin1210.me>
To:     Kyle Copperfield <kmcopper@danwin1210.me>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kyle,

> BCM4345 and BCM43455 devices soldered onto the PCB (non-removable),
> use an UART connection for Bluetooth, such as in the Pinebook Pro,
> and the advertised btsdio support as an SDIO function is ignored.
> 
> Reviewed-by: Dragan Simic <dragan.simic@gmail.com>
> Signed-off-by: Kyle Copperfield <kmcopper@danwin1210.me>
> ---
> drivers/bluetooth/btsdio.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

