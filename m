Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85808C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 09:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F3161A83
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 09:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353032AbhJAJlE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:41:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37868 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352790AbhJAJlE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 05:41:04 -0400
Received: from smtpclient.apple (62-134-92-74.business.static.de.bt.net [62.134.92.74])
        by mail.holtmann.org (Postfix) with ESMTPSA id F0F3ECED29;
        Fri,  1 Oct 2021 11:39:18 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RESEND] Bluetooth: hci_sock: Replace use of memcpy_from_msg with
 bt_skb_sendmsg
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210930203352.3378502-1-luiz.dentz@gmail.com>
Date:   Fri, 1 Oct 2021 11:39:18 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <65DF610D-4A69-44D3-9DDC-DDFD81F007C7@holtmann.org>
References: <20210930203352.3378502-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This makes use of bt_skb_sendmsg instead of allocating a different
> buffer to be used with memcpy_from_msg which cause one extra copy.
> 
> Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_sock.c | 100 +++++++++++++++------------------------
> 1 file changed, 37 insertions(+), 63 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

