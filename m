Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDF9C433E4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 14:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77575205CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 14:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgETOXa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 10:23:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51617 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgETOX3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 10:23:29 -0400
Received: from marcel-macbook.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id E07AFCED09;
        Wed, 20 May 2020 16:33:10 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/4] Bluetooth: Disconnect if E0 is used for Level 4
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200519202519.219335-1-luiz.dentz@gmail.com>
Date:   Wed, 20 May 2020 16:23:26 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <180CD116-CEC8-42B3-B3F0-C8EAF76FB1A7@holtmann.org>
References: <20200519202519.219335-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> E0 is not allowed with Level 4:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1319:
> 
>  '128-bit equivalent strength for link and encryption keys
>   required using FIPS approved algorithms (E0 not allowed,
>   SAFER+ not allowed, and P-192 not allowed; encryption key
>   not shortened'
> 
> SC enabled:
> 
>> HCI Event: Read Remote Extended Features (0x23) plen 13
>        Status: Success (0x00)
>        Handle: 256
>        Page: 1/2
>        Features: 0x0b 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>          Secure Simple Pairing (Host Support)
>          LE Supported (Host)
>          Secure Connections (Host Support)
>> HCI Event: Encryption Change (0x08) plen 4
>        Status: Success (0x00)
>        Handle: 256
>        Encryption: Enabled with AES-CCM (0x02)
> 
> SC disabled:
> 
>> HCI Event: Read Remote Extended Features (0x23) plen 13
>        Status: Success (0x00)
>        Handle: 256
>        Page: 1/2
>        Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>          Secure Simple Pairing (Host Support)
>          LE Supported (Host)
>> HCI Event: Encryption Change (0x08) plen 4
>        Status: Success (0x00)
>        Handle: 256
>        Encryption: Enabled with E0 (0x01)
> [May 8 20:23] Bluetooth: hci0: Invalid security: expect AES but E0 was used
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>        Handle: 256
>        Reason: Authentication Failure (0x05)
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_conn.c  | 17 +++++++++++++++++
> net/bluetooth/hci_event.c |  6 ++----
> 2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 07c34c55fc50..0c1cae83c8dc 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1325,6 +1325,23 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
> 			return 0;
> 	}
> 
> +	 /* AES encryption is required for Level 4:
> +	  *
> +	  * BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C
> +	  * page 1319:
> +	  *
> +	  * 128-bit equivalent strength for link and encryption keys
> +	  * required using FIPS approved algorithms (E0 not allowed,
> +	  * SAFER+ not allowed, and P-192 not allowed; encryption key
> +	  * not shortened)
> +	  */
> +	if (conn->sec_level == BT_SECURITY_FIPS &&
> +	    !test_bit(HCI_CONN_AES_CCM, &conn->flags)) {
> +		bt_dev_err(conn->hdev, "Invalid security: expect AES but E0 "
> +			   "was used");

make this bt_dev_warn since it is something that can happen. We fail appropriately now. Also try to fit the error in a single line. “Invalid security: Missing AES-CCM usage”.

> +		return 0;
> +	}
> +
> 	if (hci_conn_ssp_enabled(conn) &&
> 	    !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
> 		return 0;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 006c24e04b44..dc1cc3c4348c 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3078,10 +3078,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	 * that are not encrypted with AES-CCM using a P-256 authenticated
> 	 * combination key.
> 	 */
> -	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
> -	    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
> -	     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
> -		hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
> +	if (!hci_conn_check_link_mode(conn)) {
> +		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);

Why is this a disconnect now? If this is better, then this needs to be explained above, but I have the feeling we really want to respond to the connect request in a clean fashion.

> 		hci_conn_drop(conn);
> 		goto unlock;

Regards

Marcel

