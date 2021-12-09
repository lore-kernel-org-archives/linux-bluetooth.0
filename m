Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B4FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 10:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhLILB3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 06:01:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41889 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhLILB1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 06:01:27 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 583D9CECD4;
        Thu,  9 Dec 2021 11:57:53 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix using wrong mode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211208233548.515899-1-luiz.dentz@gmail.com>
Date:   Thu, 9 Dec 2021 11:57:53 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E82B2A4C-318B-499E-BAC5-751585800292@holtmann.org>
References: <20211208233548.515899-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> If user has a set to use SOCK_STREAM the socket would default to
> L2CAP_MODE_ERTM which later needs to be adjusted if the destination
> address is LE which doesn't support such mode.
> 
> Fixes: 15f02b9105625 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

