Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797EFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B75601FF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbhJLPmL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:42:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33307 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbhJLPmC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 11:42:02 -0400
Received: from smtpclient.apple (p4fefcb73.dip0.t-ipconnect.de [79.239.203.115])
        by mail.holtmann.org (Postfix) with ESMTPSA id 568C2CECE2;
        Tue, 12 Oct 2021 17:40:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix not initializing sk_peer_pid
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211007202625.1462550-1-luiz.dentz@gmail.com>
Date:   Tue, 12 Oct 2021 17:39:59 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <91C3976B-B11E-45BB-8917-744049270A40@holtmann.org>
References: <20211007202625.1462550-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> In order to group sockets being connected using L2CAP_MODE_EXT_FLOWCTL
> the pid is used but sk_peer_pid was not being initialized as it is
> currently only done for af_unix.
> 
> Fixes: b48596d1dc25 "Bluetooth: L2CAP: Add get_peer_pid callback"
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

