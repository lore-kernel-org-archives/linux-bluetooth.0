Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22B6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356316AbiASRGi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:06:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43269 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356333AbiASRG0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 12:06:26 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2CB51CECDE;
        Wed, 19 Jan 2022 18:06:24 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: ensure valid channel mode when creating l2cap
 conn on LE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220112101731.77010-1-gav@thegavinli.com>
Date:   Wed, 19 Jan 2022 18:06:23 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, Gavin Li <git@thegavinli.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <43EE8877-ACDA-4873-9723-FC8AE004F0A4@holtmann.org>
References: <20220112101731.77010-1-gav@thegavinli.com>
To:     gav@thegavinli.com
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gavin,

> After creating a socket(AF_INET, SOCK_STREAM, BTPROTO_L2CAP) socket and
> connect()'ing to a LE device with default settings (no setsockopt), upon
> the first sendmsg, the following BUG occurs because chan->mode==L2CAP_MODE_ERTM,
> causing l2cap_ertm_send() -> __set_retrans_timer() -> schedule_delayed_work()
> on l2cap_chan.retrans_timer, which was never initialized because
> l2cap_ertm_init() was never called to initialize it.
> 
>  Call Trace:
>   queue_delayed_work_on+0x36/0x40
>   l2cap_ertm_send.isra.0+0x14d/0x2d0 [bluetooth]
>   l2cap_tx+0x361/0x510 [bluetooth]
>   l2cap_chan_send+0xb26/0xb50 [bluetooth]
>   l2cap_sock_sendmsg+0xc9/0x100 [bluetooth]
>   sock_sendmsg+0x5e/0x60
>   sock_write_iter+0x97/0x100
>   new_sync_write+0x1d3/0x1f0
>   vfs_write+0x1b4/0x270
>   ksys_write+0xaf/0xe0
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> This patch ensures that when connecting to a LE device, chan->mode will
> always be corrected to L2CAP_MODE_LE_FLOWCTL if it is invalid for LE.
> 
> Signed-off-by: Gavin Li <git@thegavinli.com>
> ---
> net/bluetooth/l2cap_sock.c | 15 +++++++++++++--
> 1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 160c016a5dfb9..58c06ef32656c 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -78,6 +78,17 @@ static int l2cap_validate_le_psm(u16 psm)
> 	return 0;
> }
> 
> +static bool l2cap_mode_supports_le(u8 mode)
> +{
> +	switch (mode) {
> +		case L2CAP_MODE_LE_FLOWCTL:
> +		case L2CAP_MODE_EXT_FLOWCTL:
> +			return true;
> +		default:
> +			return false;
> +	}
> +}
> +

please use correct coding style.


> static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> {
> 	struct sock *sk = sock->sk;
> @@ -161,7 +172,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> 		break;
> 	}
> 
> -	if (chan->psm && bdaddr_type_is_le(chan->src_type))
> +	if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
> 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
> 
> 	chan->state = BT_BOUND;
> @@ -240,7 +251,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
> 			return -EINVAL;
> 	}
> 
> -	if (chan->psm && bdaddr_type_is_le(chan->src_type) && !chan->mode)
> +	if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
> 		chan->mode = L2CAP_MODE_LE_FLOWCTL;

And you need to add a proper multi-line if clause here.

Regards

Marcel

