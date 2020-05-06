Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3776C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 08:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C687C206D5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 08:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgEFIr5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 04:47:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42918 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgEFIr5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 04:47:57 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 18A44CED01;
        Wed,  6 May 2020 10:57:37 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Avoid calling device_add() on duplicated HCI
 conn event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200506025358.361519-1-olivier.crete@collabora.com>
Date:   Wed, 6 May 2020 10:47:55 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0858E407-99A0-4EF7-B890-B367B206F4AD@holtmann.org>
References: <20200506025358.361519-1-olivier.crete@collabora.com>
To:     =?utf-8?Q?Olivier_Cr=C3=AAte?= <olivier.crete@collabora.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Olivier,

> The BCM20702A1 device in the ThinkPad x230 seems to send the HCI
> Connection Complete event twice for the same connection, for which the
> stack seems to recover, except for the core device_add() function
> which is not meant to be called twice for the same device. So let's
> just avoid calling it in that case.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204633
> Signed-off-by: Olivier Crête <olivier.crete@collabora.com>
> Cc: stable@vger.kernel.org

please include the btmon output showing this issue.

And there is no firmware update available for the Bluetooth controller in the ThinkPad. Most Broadcom devices require an actual firmware load to fix bugs. Does your device load firmware?

> ---
> include/net/bluetooth/hci_core.h | 3 +++
> net/bluetooth/hci_conn.c         | 1 +
> net/bluetooth/hci_event.c        | 8 ++++++--
> 3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index d4e28773d378..b74669397dbb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -500,6 +500,9 @@ struct hci_dev {
> 
> #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
> 
> +/* Valid HCI handles are in the 0x0000-0x0EFF range per spec */
> +#define HCI_INVALID_HANDLE 0xFFFF
> +
> struct hci_conn {
> 	struct list_head list;
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e245bc155cc2..edf12a3f46aa 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -532,6 +532,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 	conn->rssi = HCI_RSSI_INVALID;
> 	conn->tx_power = HCI_TX_POWER_INVALID;
> 	conn->max_tx_power = HCI_TX_POWER_INVALID;
> +	conn->handle = HCI_INVALID_HANDLE;
> 
> 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
> 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0a591be8b0ae..e498f70fcda9 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2553,6 +2553,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	}
> 
> 	if (!ev->status) {
> +		int first_connection = (conn->handle == HCI_INVALID_HANDLE);
> +

We have the type bool available for these kind of things. 

> 		conn->handle = __le16_to_cpu(ev->handle);
> 
> 		if (conn->type == ACL_LINK) {
> @@ -2567,8 +2569,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		} else
> 			conn->state = BT_CONNECTED;
> 
> -		hci_debugfs_create_conn(conn);
> -		hci_conn_add_sysfs(conn);
> +		if (first_connection) {
> +			hci_debugfs_create_conn(conn);
> +			hci_conn_add_sysfs(conn);
> +		}
> 
> 		if (test_bit(HCI_AUTH, &hdev->flags))
> 			set_bit(HCI_CONN_AUTH, &conn->flags);

Regards

Marcel

