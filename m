Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E27CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 18:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbiESSI2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbiESSI0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 14:08:26 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69C1D9E9D0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 11:08:24 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fb9d.dip0.t-ipconnect.de [79.249.251.157])
        by mail.holtmann.org (Postfix) with ESMTPSA id B3644CECFA;
        Thu, 19 May 2022 20:08:23 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_conn: Fix hci_connect_le_sync
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220513235125.1364692-3-luiz.dentz@gmail.com>
Date:   Thu, 19 May 2022 20:08:23 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6A7CED55-0DC1-48F1-95FF-A1B2ED3B280C@holtmann.org>
References: <20220513235125.1364692-1-luiz.dentz@gmail.com>
 <20220513235125.1364692-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> The handling of connection failures shall be handled by the request
> completion callback as already done by hci_cs_le_create_conn, also make
> sure to use hci_conn_failed instead of hci_le_conn_failed as the later
> don't actually call hci_conn_del to cleanup.
> 
> Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_conn.c  | 5 +++--
> net/bluetooth/hci_event.c | 8 +++++---
> 2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 4a5193499b77..a36297368c58 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -943,10 +943,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
> 
> 	bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
> 
> -	if (!conn)
> +	/* Check if connection is still pending */
> +	if (conn != hci_lookup_le_connect(hdev))
> 		goto done;
> 
> -	hci_le_conn_failed(conn, bt_status(err));
> +	hci_conn_failed(conn, bt_status(err));
> 
> done:
> 	hci_dev_unlock(hdev);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0270e597c285..af17dfb20e01 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5632,10 +5632,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> 		status = HCI_ERROR_INVALID_PARAMETERS;
> 	}
> 
> -	if (status) {
> -		hci_conn_failed(conn, status);
> +	/* All connection failure handling is taken care of by the
> +	 * hci_conn_failed function which is triggered by the HCI
> +	 * request completion callbacks used for connecting.
> +	 */
> +	if (status)
> 		goto unlock;
> -	}
> 
> 	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
> 		addr_type = BDADDR_LE_PUBLIC;

can apply this patch alone and push it to -stable?

Regards

Marcel

