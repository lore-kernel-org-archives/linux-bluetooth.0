Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A765C7618F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 19:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4F62067C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 19:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfGOThl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:37:41 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32884 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbfGOThk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 15:37:40 -0400
Received: from [192.168.22.163] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id 31536CEEBA;
        Mon, 15 Jul 2019 21:46:05 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] hidp: Let hidp_send_message return number of queued bytes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f46a923b-caa8-83bb-1b64-44bb0ef25ca6@gmail.com>
Date:   Mon, 15 Jul 2019 21:37:29 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <88E1CAE0-E1ED-417B-8157-2F4A5E9B5C0E@holtmann.org>
References: <f46a923b-caa8-83bb-1b64-44bb0ef25ca6@gmail.com>
To:     Fabian Henneke <fabian.henneke@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fabian,

> Let hidp_send_message return the number of successfully queued bytes
> instead of an unconditional 0.
> 
> With the return value fixed to 0, other drivers relying on hidp, such as
> hidraw, can not return meaningful values from their respective
> implementations of write(). In particular, with the current behavior, a
> hidraw device's write() will have different return values depending on
> whether the device is connected via USB or Bluetooth, which makes it
> harder to abstract away the transport layer.
> 
> Signed-off-by: Fabian Henneke <fabian.henneke@gmail.com>
> ---
> net/bluetooth/hidp/core.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

