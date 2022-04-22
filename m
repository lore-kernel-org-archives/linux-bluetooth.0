Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7405CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 08:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445013AbiDVIYW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445206AbiDVIYN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 04:24:13 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39BD052E4C
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 01:21:20 -0700 (PDT)
Received: from smtpclient.apple (p4fefc32f.dip0.t-ipconnect.de [79.239.195.47])
        by mail.holtmann.org (Postfix) with ESMTPSA id 614E1CECD3;
        Fri, 22 Apr 2022 10:21:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_event: Fix checking for invalid
 handle on error status
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220421214607.3326277-1-luiz.dentz@gmail.com>
Date:   Fri, 22 Apr 2022 10:21:18 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <02890F1F-1C5A-44AF-8C0E-D7412193C642@holtmann.org>
References: <20220421214607.3326277-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Commit d5ebaa7c5f6f6 introduces checks for handle range
> (e.g HCI_CONN_HANDLE_MAX) but controllers like Intel AX200 don't seem
> to respect the valid range int case of error status:
> 
>> HCI Event: Connect Complete (0x03) plen 11
>        Status: Page Timeout (0x04)
>        Handle: 65535
>        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
> 	Sound Products Inc)
>        Link type: ACL (0x01)
>        Encryption: Disabled (0x00)
> [1644965.827560] Bluetooth: hci0: Ignoring HCI_Connection_Complete for
> invalid handle
> 
> Because of it is impossible to cleanup the connections properly since
> the stack would attempt to cancel the connection which is no longer in
> progress causing the following trace:
> 
> < HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
>        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
> 	Sound Products Inc)
> = bluetoothd: src/profile.c:record_cb() Unable to get Hands-Free Voice
> 	gateway SDP record: Connection timed out
>> HCI Event: Command Complete (0x0e) plen 10
>      Create Connection Cancel (0x01|0x0008) ncmd 1
>        Status: Unknown Connection Identifier (0x02)
>        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
> 	Sound Products Inc)
> < HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
>        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
> 	Sound Products Inc)
> 
> Fixes: d5ebaa7c5f6f6 ("Bluetooth: hci_event: Ignore multiple conn complete events")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Check if handle is valid just before assigning it to hci_conn object and
> in case it is invalid reset the status to HCI_ERROR_INVALID_PARAMETERS(0x12)
> so it can be passed to the likes of hci_connect_cfm and then is translated to
> EINVAL by bt_to_errno.
> v3: Rebase changes.
> 
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_event.c   | 45 ++++++++++++++++++++-----------------
> 2 files changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 8bb81ea4d286..62a9bb022aed 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -587,6 +587,7 @@ enum {
> #define HCI_ERROR_CONNECTION_TIMEOUT	0x08
> #define HCI_ERROR_REJ_LIMITED_RESOURCES	0x0d
> #define HCI_ERROR_REJ_BAD_ADDR		0x0f
> +#define HCI_ERROR_INVALID_PARAMETERS	0x12
> #define HCI_ERROR_REMOTE_USER_TERM	0x13
> #define HCI_ERROR_REMOTE_LOW_RESOURCES	0x14
> #define HCI_ERROR_REMOTE_POWER_OFF	0x15
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index abaabfae19cc..9feef7dbde3d 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3068,11 +3068,6 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
> 	struct hci_ev_conn_complete *ev = data;
> 	struct hci_conn *conn;
> 
> -	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> -		bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for invalid handle");
> -		return;
> -	}
> -
> 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> 
> 	hci_dev_lock(hdev);
> @@ -3124,6 +3119,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
> 
> 	if (!ev->status) {
> 		conn->handle = __le16_to_cpu(ev->handle);
> +		if (conn->handle > HCI_CONN_HANDLE_MAX) {
> +			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
> +				   conn->handle, HCI_CONN_HANDLE_MAX);
> +			ev->status = HCI_ERROR_INVALID_PARAMETERS;

it is not a good idea to overwrite ev. We should have a separate status variable. Remember that we have ev = data and I think it is a mistake that it is not const void *data in the first place.

> +			goto done;
> +		}
> 
> 		if (conn->type == ACL_LINK) {
> 			conn->state = BT_CONFIG;
> @@ -3164,17 +3165,17 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
> 			hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE, sizeof(cp),
> 				     &cp);
> 		}
> -	} else {
> -		conn->state = BT_CLOSED;
> -		if (conn->type == ACL_LINK)
> -			mgmt_connect_failed(hdev, &conn->dst, conn->type,
> -					    conn->dst_type, ev->status);
> 	}
> 
> 	if (conn->type == ACL_LINK)
> 		hci_sco_setup(conn, ev->status);
> 
> +done:
> 	if (ev->status) {
> +		conn->state = BT_CLOSED;
> +		if (conn->type == ACL_LINK)
> +			mgmt_connect_failed(hdev, &conn->dst, conn->type,
> +					    conn->dst_type, ev->status);
> 		hci_connect_cfm(conn, ev->status);
> 		hci_conn_del(conn);
> 	} else if (ev->link_type == SCO_LINK) {
> @@ -4690,11 +4691,6 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
> 		return;
> 	}
> 
> -	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> -		bt_dev_err(hdev, "Ignoring HCI_Sync_Conn_Complete for invalid handle");
> -		return;
> -	}
> -
> 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> 
> 	hci_dev_lock(hdev);
> @@ -4732,6 +4728,14 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
> 	switch (ev->status) {
> 	case 0x00:
> 		conn->handle = __le16_to_cpu(ev->handle);
> +		if (conn->handle > HCI_CONN_HANDLE_MAX) {
> +			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
> +				   conn->handle, HCI_CONN_HANDLE_MAX);
> +			ev->status = HCI_ERROR_INVALID_PARAMETERS;
> +			conn->state = BT_CLOSED;
> +			break;
> +		}
> +
> 		conn->state  = BT_CONNECTED;
> 		conn->type   = ev->link_type;
> 
> @@ -5527,11 +5531,6 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> 	struct smp_irk *irk;
> 	u8 addr_type;
> 
> -	if (handle > HCI_CONN_HANDLE_MAX) {
> -		bt_dev_err(hdev, "Ignoring HCI_LE_Connection_Complete for invalid handle");
> -		return;
> -	}
> -
> 	hci_dev_lock(hdev);
> 
> 	/* All controllers implicitly stop advertising in the event of a
> @@ -5603,6 +5602,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> 
> 	conn->dst_type = ev_bdaddr_type(hdev, conn->dst_type, NULL);
> 
> +	if (handle > HCI_CONN_HANDLE_MAX) {
> +		bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x", handle,
> +			   HCI_CONN_HANDLE_MAX);
> +		status = HCI_ERROR_INVALID_PARAMETERS;
> +	}
> +
> 	if (status) {
> 		hci_le_conn_failed(conn, status);
> 		goto unlock;

Regards

Marcel

