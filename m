Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9D4C001E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 09:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjG0Jfo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjG0JfY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 05:35:24 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198993AB2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 02:28:14 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E30A8240027
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:28:10 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RBQRZ4KX6z6txG
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 11:28:10 +0200 (CEST)
Message-ID: <359925f6573cd19244c86266569a0a3b46b70363.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/5] btdev: check error conditions for
 HCI_Create_Connection_Cancel
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Date:   Thu, 27 Jul 2023 09:28:10 +0000
In-Reply-To: <15f85f2e419757a2c689e8572ccf7793a931f555.1690405564.git.pav@iki.fi>
References: <cover.1690405564.git.pav@iki.fi>
         <15f85f2e419757a2c689e8572ccf7793a931f555.1690405564.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

to, 2023-07-27 kello 00:25 +0300, Pauli Virtanen kirjoitti:
> Create Connection Cancel shall return Command Complete with error status
> when there is no Create Connection that can be canceled.  In these
> cases, we should not send a (spurious) Connection Complete event.
> 
> Fix by keeping a list of pending Create Connection commands, and
> returning command errors if there is none pending at the moment.
> ---
>  emulator/btdev.c | 76 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 637f0bb98..0c75e71c0 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -62,6 +62,7 @@ struct hook {
>  
>  #define MAX_HOOK_ENTRIES 16
>  #define MAX_EXT_ADV_SETS 3
> +#define MAX_PENDING_CONN 16
>  
>  struct btdev_conn {
>  	uint16_t handle;
> @@ -223,6 +224,8 @@ struct btdev {
>  	uint8_t  le_rl_enable;
>  	uint16_t le_rl_timeout;
>  
> +	struct btdev *pending_conn[MAX_PENDING_CONN];
> +
>  	uint8_t le_local_sk256[32];
>  
>  	uint16_t sync_train_interval;
> @@ -1211,10 +1214,36 @@ static struct btdev_conn *conn_link_bis(struct btdev *dev, struct btdev *remote,
>  	return conn;
>  }
>  
> +static void pending_conn_add(struct btdev *btdev, struct btdev *remote)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
> +		if (!btdev->pending_conn[i]) {
> +			btdev->pending_conn[i] = remote;
> +			return;
> +		}
> +	}
> +}
> +
> +static bool pending_conn_del(struct btdev *btdev, struct btdev *remote)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
> +		if (btdev->pending_conn[i] == remote) {
> +			btdev->pending_conn[i] = NULL;
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
>  static void conn_complete(struct btdev *btdev,
>  					const uint8_t *bdaddr, uint8_t status)
>  {
>  	struct bt_hci_evt_conn_complete cc;
> +	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
>  
>  	if (!status) {
>  		struct btdev_conn *conn;
> @@ -1223,6 +1252,8 @@ static void conn_complete(struct btdev *btdev,
>  		if (!conn)
>  			return;
>  
> +		pending_conn_del(conn->link->dev, btdev);
> +
>  		cc.status = status;
>  		memcpy(cc.bdaddr, btdev->bdaddr, 6);
>  		cc.encr_mode = 0x00;
> @@ -1240,6 +1271,8 @@ static void conn_complete(struct btdev *btdev,
>  		cc.link_type = 0x01;
>  	}
>  
> +	pending_conn_del(btdev, remote);
> +
>  	cc.status = status;
>  	memcpy(cc.bdaddr, bdaddr, 6);
>  	cc.encr_mode = 0x00;
> @@ -1260,6 +1293,8 @@ static int cmd_create_conn_complete(struct btdev *dev, const void *data,
>  		memcpy(cr.dev_class, dev->dev_class, 3);
>  		cr.link_type = 0x01;
>  
> +		pending_conn_add(dev, remote);
> +
>  		send_event(remote, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(cr));
>  	} else {
>  		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
> @@ -1296,14 +1331,47 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
>  	cc.encr_mode = 0x00;
>  
>  done:
> +	pending_conn_del(dev, conn->link->dev);
> +
>  	send_event(dev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
>  
>  	return 0;
>  }
>  
> +static bool match_bdaddr(const void *data, const void *match_data)
> +{
> +	const struct btdev_conn *conn = data;
> +	const uint8_t *bdaddr = match_data;
> +
> +	return !memcmp(conn->link->dev->bdaddr, bdaddr, 6);
> +}
> +
>  static int cmd_create_conn_cancel(struct btdev *dev, const void *data,
>  							uint8_t len)
>  {
> +	const struct bt_hci_cmd_create_conn_cancel *cmd = data;
> +	struct btdev *remote = find_btdev_by_bdaddr(cmd->bdaddr);
> +	struct btdev_conn *conn;
> +
> +	/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E page 1848
> +	 *
> +	 * If the connection is already established, and the
> +	 * HCI_Connection_Complete event has been sent, then the Controller
> +	 * shall return an HCI_Command_Complete event with the error code
> +	 * Connection Already Exists (0x0B). If the HCI_Create_Connection_Cancel
> +	 * command is sent to the Controller without a preceding
> +	 * HCI_Create_Connection command to the same device, the BR/EDR
> +	 * Controller shall return an HCI_Command_Complete event with the error
> +	 * code Unknown Connection Identifier (0x02).
> +	 */
> +	if (!pending_conn_del(dev, remote)) {
> +		conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
> +		if (conn)
> +			return -EEXIST;
> +
> +		return -ENOENT;
> +	}
> +
>  	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_CREATE_CONN_CANCEL);

This should have been Command_Complete not Command_Status.

For v2

>  
>  	return 0;
> @@ -1372,14 +1440,6 @@ static int cmd_link_key_reply(struct btdev *dev, const void *data, uint8_t len)
>  	return 0;
>  }
>  
> -static bool match_bdaddr(const void *data, const void *match_data)
> -{
> -	const struct btdev_conn *conn = data;
> -	const uint8_t *bdaddr = match_data;
> -
> -	return !memcmp(conn->link->dev->bdaddr, bdaddr, 6);
> -}
> -
>  static void auth_complete(struct btdev_conn *conn, uint8_t status)
>  {
>  	struct bt_hci_evt_auth_complete ev;

