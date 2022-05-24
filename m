Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE03C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 14:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiEXOsV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 10:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiEXOsU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 10:48:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA79B185
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 07:48:19 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1ntVpY-00016O-Kq; Tue, 24 May 2022 16:48:16 +0200
Message-ID: <148a9f76-0784-1d17-22cd-80343895aa37@pengutronix.de>
Date:   Tue, 24 May 2022 16:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH-stable] Bluetooth: hci_conn: Fix hci_connect_le_sync
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20220520183713.2641513-1-luiz.dentz@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20220520183713.2641513-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 20.05.22 20:37, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The handling of connection failures shall be handled by the request
> completion callback as already done by hci_cs_le_create_conn, also make
> sure to use hci_conn_failed instead of hci_le_conn_failed as the later
> don't actually call hci_conn_del to cleanup.
> 
> Link: https://github.com/bluez/bluez/issues/340
> Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A bit late, as I am not subscribed to linux-bluetooth and didn't notice this
patch, but FWIW: Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

  Bluetooth: hci0: Opcode 0x200d failed: -110
  Bluetooth: hci0: request failed to create LE connection: err -110

now, whereas before it crashed the kernel.

Cheers,
Ahmad

> ---
>  net/bluetooth/hci_conn.c  | 5 +++--
>  net/bluetooth/hci_event.c | 8 +++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 882a7df13005..ac06c9724c7f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -943,10 +943,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
>  
>  	bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
>  
> -	if (!conn)
> +	/* Check if connection is still pending */
> +	if (conn != hci_lookup_le_connect(hdev))
>  		goto done;
>  
> -	hci_le_conn_failed(conn, err);
> +	hci_conn_failed(conn, err);
>  
>  done:
>  	hci_dev_unlock(hdev);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0270e597c285..af17dfb20e01 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5632,10 +5632,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
>  		status = HCI_ERROR_INVALID_PARAMETERS;
>  	}
>  
> -	if (status) {
> -		hci_conn_failed(conn, status);
> +	/* All connection failure handling is taken care of by the
> +	 * hci_conn_failed function which is triggered by the HCI
> +	 * request completion callbacks used for connecting.
> +	 */
> +	if (status)
>  		goto unlock;
> -	}
>  
>  	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
>  		addr_type = BDADDR_LE_PUBLIC;


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
