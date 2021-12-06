Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE9BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 19:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348715AbhLFTyD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:54:03 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41240 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346214AbhLFTyC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 14:54:02 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id E695BCECF9;
        Mon,  6 Dec 2021 20:50:32 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH 3/3] Bluetooth: mgmt: Make use of mgmt_send_event_skb in
 MGMT_EV_DEVICE_CONNECTED
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211204001542.2404778-3-luiz.dentz@gmail.com>
Date:   Mon, 6 Dec 2021 20:50:32 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8ACCBA6F-F19A-409E-9B5C-EF61A310FB68@holtmann.org>
References: <20211204001542.2404778-1-luiz.dentz@gmail.com>
 <20211204001542.2404778-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This makes use of mgmt_alloc_skb to build MGMT_EV_DEVICE_CONNECTED so
> the data is copied directly to skb that is then sent using
> mgmt_send_event_skb eliminating the necessity of intermediary buffers.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/mgmt.c | 26 ++++++++++++++++++--------
> 1 file changed, 18 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

