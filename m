Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D6EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 19:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348713AbhLFTyA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:54:00 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51585 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346214AbhLFTyA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 14:54:00 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 46030CECF9;
        Mon,  6 Dec 2021 20:50:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH 1/3] Bluetooth: mgmt: Introduce mgmt_alloc_skb and
 mgmt_send_event_skb
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211204001542.2404778-1-luiz.dentz@gmail.com>
Date:   Mon, 6 Dec 2021 20:50:30 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C5741FDF-6602-4EFA-84F2-2B5B2DF12AA4@holtmann.org>
References: <20211204001542.2404778-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This introduces mgmt_alloc_skb and mgmt_send_event_skb which are
> convenient when building MGMT events that have variable length as the
> likes of skb_put_data can be used to insert portion directly on the skb
> instead of having to first build an intermediate buffer just to be
> copied over the skb.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |  6 +++
> net/bluetooth/mgmt_util.c         | 66 +++++++++++++++++++++++--------
> net/bluetooth/mgmt_util.h         |  4 ++
> 3 files changed, 59 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

