Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2715EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Jan 2022 14:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbiAWOaw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jan 2022 09:30:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60493 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiAWOav (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jan 2022 09:30:51 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2ED49CED41;
        Sun, 23 Jan 2022 15:30:49 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2] Bluetooth: msft: fix null pointer deref on
 msft_monitor_device_evt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220123055709.7925-1-soenke.huster@eknoes.de>
Date:   Sun, 23 Jan 2022 15:30:48 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6455AE62-B472-41E2-8B32-FFF350EF3250@holtmann.org>
References: <20220123055709.7925-1-soenke.huster@eknoes.de>
To:     Soenke Huster <soenke.huster@eknoes.de>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Soenke,

> msft_find_handle_data returns NULL if it can't find the handle.
> Therefore, handle_data must be checked, otherwise a null pointer
> is dereferenced.
> 
> Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> ---
> v2: Remove empty line
> 
> net/bluetooth/msft.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

