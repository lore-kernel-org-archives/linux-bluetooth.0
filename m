Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE2DC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 09:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjC2JAD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 05:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjC2I7p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 04:59:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B705B3C10
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 01:59:11 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1phRdg-0002Kq-7X; Wed, 29 Mar 2023 10:58:40 +0200
Message-ID: <04377d2a-4d97-0345-18a1-1f18533436fe@pengutronix.de>
Date:   Wed, 29 Mar 2023 10:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix printing errors if LE Connection
 times out
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20230327205347.51568-1-luiz.dentz@gmail.com>
 <20230327205347.51568-2-luiz.dentz@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20230327205347.51568-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

On 27.03.23 22:53, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes errors like bellow when LE Connection times out since that
> is actually not a controller error:
> 
>  Bluetooth: hci0: Opcode 0x200d failed: -110
>  Bluetooth: hci0: request failed to create LE connection: err -110
> 
> Instead the code shall properly detect if -ETIMEDOUT is returned and
> send HCI_OP_LE_CREATE_CONN_CANCEL to give up on the connection.
> 
> Link: https://github.com/bluez/bluez/issues/340

I assume the issue described in the Github PR to be the same issue
I had reported here:

https://lore.kernel.org/linux-bluetooth/a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de/

I gave these patches a test and all pairing attempts after the first pair/unpair
are still unsuccessful. Only visible change to me is that there's no -110 error
message printed anymore with default log level.

Cheers,
Ahmad

#regzbot monitor: https://lore.kernel.org/linux-bluetooth/a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de/

> Fixes: Fixes: 8e8b92ee60de ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_conn.c         |  7 +++++--
>  net/bluetooth/hci_event.c        | 16 ++++++----------
>  net/bluetooth/hci_sync.c         | 13 ++++++++++---
>  4 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 53d3328c2b8b..e22e45fbe8db 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -954,6 +954,7 @@ enum {
>  	HCI_CONN_STK_ENCRYPT,
>  	HCI_CONN_AUTH_INITIATOR,
>  	HCI_CONN_DROP,
> +	HCI_CONN_CANCEL,
>  	HCI_CONN_PARAM_REMOVAL_PEND,
>  	HCI_CONN_NEW_LINK_KEY,
>  	HCI_CONN_SCANNING,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 5af3f6b011c9..e4aee5950c36 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1233,6 +1233,8 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
>  {
>  	struct hci_conn *conn = data;
>  
> +	bt_dev_dbg(hdev, "err %d", err);
> +
>  	hci_dev_lock(hdev);
>  
>  	if (!err) {
> @@ -1240,8 +1242,6 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
>  		goto done;
>  	}
>  
> -	bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
> -
>  	/* Check if connection is still pending */
>  	if (conn != hci_lookup_le_connect(hdev))
>  		goto done;
> @@ -2771,6 +2771,9 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
>  {
>  	int r = 0;
>  
> +	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
> +		return 0;
> +
>  	switch (conn->state) {
>  	case BT_CONNECTED:
>  	case BT_CONFIG:
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 8d8547fa9032..ff99e8c2750f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2886,16 +2886,6 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
>  
>  	conn->resp_addr_type = peer_addr_type;
>  	bacpy(&conn->resp_addr, peer_addr);
> -
> -	/* We don't want the connection attempt to stick around
> -	 * indefinitely since LE doesn't have a page timeout concept
> -	 * like BR/EDR. Set a timer for any connection that doesn't use
> -	 * the accept list for connecting.
> -	 */
> -	if (filter_policy == HCI_LE_USE_PEER_ADDR)
> -		queue_delayed_work(conn->hdev->workqueue,
> -				   &conn->le_conn_timeout,
> -				   conn->conn_timeout);
>  }
>  
>  static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
> @@ -5907,6 +5897,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
>  	if (status)
>  		goto unlock;
>  
> +	/* Drop the connection if it has been aborted */
> +	if (test_bit(HCI_CONN_CANCEL, &conn->flags)) {
> +		hci_conn_drop(conn);
> +		goto unlock;
> +	}
> +
>  	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
>  		addr_type = BDADDR_LE_PUBLIC;
>  	else
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 4376b6f06702..31231f0e4a28 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -246,8 +246,9 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
>  
>  	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
>  	if (IS_ERR(skb)) {
> -		bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
> -				PTR_ERR(skb));
> +		if (!event)
> +			bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
> +				   PTR_ERR(skb));
>  		return PTR_ERR(skb);
>  	}
>  
> @@ -5128,8 +5129,11 @@ static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
>  	if (test_bit(HCI_CONN_SCANNING, &conn->flags))
>  		return 0;
>  
> +	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
> +		return 0;
> +
>  	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN_CANCEL,
> -				     6, &conn->dst, HCI_CMD_TIMEOUT);
> +				     0, NULL, HCI_CMD_TIMEOUT);
>  }
>  
>  static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn)
> @@ -6103,6 +6107,9 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
>  				       conn->conn_timeout, NULL);
>  
>  done:
> +	if (err == -ETIMEDOUT)
> +		hci_le_connect_cancel_sync(hdev, conn);
> +
>  	/* Re-enable advertising after the connection attempt is finished. */
>  	hci_resume_advertising_sync(hdev);
>  	return err;

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

