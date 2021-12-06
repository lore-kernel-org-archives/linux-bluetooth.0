Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93B5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 19:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348710AbhLFTx7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:53:59 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45462 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346214AbhLFTx6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 14:53:58 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1AFB8CECF9;
        Mon,  6 Dec 2021 20:50:28 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH 2/3] Bluetooth: mgmt: Make use of mgmt_send_event_skb in
 MGMT_EV_DEVICE_FOUND
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211204001542.2404778-2-luiz.dentz@gmail.com>
Date:   Mon, 6 Dec 2021 20:50:27 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F6DE6ED3-6640-478F-9F56-7A4B1B85AAFA@holtmann.org>
References: <20211204001542.2404778-1-luiz.dentz@gmail.com>
 <20211204001542.2404778-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This makes use of mgmt_alloc_skb to build MGMT_EV_DEVICE_FOUND so the
> data is copied directly to skb that is then sent using
> mgmt_send_event_skb eliminating the necessity of intermediary buffers.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/mgmt.c | 52 ++++++++++++++++++++++++++------------------
> 1 file changed, 31 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

