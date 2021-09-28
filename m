Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EACEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 08:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F6A60F9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 08:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbhI1IFZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:05:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36552 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhI1IEu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 04:04:50 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id AA7B0CECD6;
        Tue, 28 Sep 2021 10:03:04 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: msft: Fix build when BT_MSFTEXT is not defined
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210927220024.2776585-1-luiz.dentz@gmail.com>
Date:   Tue, 28 Sep 2021 10:03:04 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <499B9510-C689-4D19-A6F5-14DE582B8300@holtmann.org>
References: <20210927220024.2776585-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> ld: net/bluetooth/hci_event.o: in function `msft_suspend':
> /linux/net/bluetooth/msft.h:64: multiple definition of `msft_suspend';
> net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
> ld: net/bluetooth/hci_event.o: in function `msft_resume':
> /linux/net/bluetooth/msft.h:64: multiple definition of `msft_resume';
> net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
> ld: net/bluetooth/mgmt.o: in function `msft_suspend':
> /linux/net/bluetooth/msft.h:64: multiple definition of `msft_suspend';
> net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
> ld: net/bluetooth/mgmt.o: in function `msft_resume':
> /linux/net/bluetooth/msft.h:64: multiple definition of `msft_resume';
> net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
> ld: net/bluetooth/hci_request.o: in function `msft_suspend':
> /linux/net/bluetooth/msft.h:64: multiple definition of `msft_suspend';
> net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
> ld: net/bluetooth/hci_request.o: in function `msft_resume':
> /linux/net/bluetooth/msft.h:64: multiple definition of `msft_resume';
> net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
> make: *** [Makefile:1176: vmlinux] Error 1
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/msft.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

I decided to amend the commit at fault.

Regards

Marcel

