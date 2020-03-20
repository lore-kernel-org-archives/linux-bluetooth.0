Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C39EC4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 00:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6117F20739
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 00:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCTA6O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:58:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46443 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCTA6O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Mar 2020 20:58:14 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AAB67CEC82;
        Fri, 20 Mar 2020 02:07:42 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v3 3/3] Bluetooth: Add BT_MODE socket option
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200318215019.21494-4-luiz.dentz@gmail.com>
Date:   Fri, 20 Mar 2020 01:58:11 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DDA058C0-9DF5-43F4-9A41-001595A95573@holtmann.org>
References: <20200318215019.21494-1-luiz.dentz@gmail.com>
 <20200318215019.21494-4-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds BT_MODE socket option which can be used to set L2CAP modes,
> including modes only supported over LE which were not supported using
> the L2CAP_OPTIONS.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/bluetooth.h | 11 ++++
> net/bluetooth/l2cap_sock.c        | 96 +++++++++++++++++++++++++++++++
> 2 files changed, 107 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 1576353a2773..34191e34bfdc 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -139,6 +139,17 @@ struct bt_voice {
> #define BT_PHY_LE_CODED_TX	0x00002000
> #define BT_PHY_LE_CODED_RX	0x00004000
> 
> +#define BT_MODE			15
> +
> +#define BT_MODE_BASIC		0x00
> +#define BT_MODE_RETRANS		0x01
> +#define BT_MODE_FLOWCTL		0x02
> +#define BT_MODE_ERTM		0x03
> +#define BT_MODE_STREAMING	0x04
> +#define BT_MODE_EXT_FLOWCTL	0x05
> +
> +#define BT_MODE_LE_FLOWCTL	0x80
> +

what I would do is just this:

	BASIC		0x00
	ERTM		0x01
	STREAMING	0x02
	LE_FLOWCTL	0x03
	EXT_FLOWCTL	0x04

Trying to cling onto some old L2CAP definition from the 2.1 days is not helpful. I would really make a clean cut here.

This way we can also cleanly check the available modes per selected socket and have either setsockopt or connect fail appropriately.

> __printf(1, 2)
> void bt_info(const char *fmt, ...);
> __printf(1, 2)
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 117ba20ea194..f2bb376c699f 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -500,6 +500,25 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
> 	return err;
> }
> 
> +static u8 l2cap_get_mode(struct l2cap_chan *chan)
> +{
> +	switch (chan->mode) {
> +	case L2CAP_MODE_BASIC:
> +	case L2CAP_MODE_RETRANS:
> +	case L2CAP_MODE_FLOWCTL:
> +	case L2CAP_MODE_ERTM:
> +	case L2CAP_MODE_STREAMING:
> +		/* Mode above are the same on both old and new sockopt */
> +		return chan->mode;
> +	case L2CAP_MODE_LE_FLOWCTL:
> +		return BT_MODE_FLOWCTL;
> +	case L2CAP_MODE_EXT_FLOWCTL:
> +		return BT_MODE_EXT_FLOWCTL;
> +	}
> +
> +	return chan->mode;
> +}
> +

Don’t bother with this. Keep the old socket and new socket independent code. I also want to add Kconfig option later that will allow us to disable the old socket options once we have SOL_L2CAP requirement eradicated.

Regards

Marcel

