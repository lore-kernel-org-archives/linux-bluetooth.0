Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63998C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 15:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382983AbiDUQAm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390408AbiDUQAl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 12:00:41 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D9C0473A2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 08:57:49 -0700 (PDT)
Received: from smtpclient.apple (p4fefc32f.dip0.t-ipconnect.de [79.239.195.47])
        by mail.holtmann.org (Postfix) with ESMTPSA id 99AA6CED13;
        Thu, 21 Apr 2022 17:57:48 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] Bluetooth: hci_event: Fix checking for invalid handle on
 error status
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220420221433.2933868-1-luiz.dentz@gmail.com>
Date:   Thu, 21 Apr 2022 17:57:48 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <654FF692-95EB-459A-9144-62EA911C7BBB@holtmann.org>
References: <20220420221433.2933868-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Commit d5ebaa7c5f6f6 introduces checks for handle range
> (e.g HCI_CONN_HANDLE_MAX) but controllers don't seem to respect the
> valid range int case of error status:
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

so the problem is that with BR/EDR the lookup is by BD_ADDR. I think the check for valid handle is wrong at the beginning of connect complete handler.

The problem is really the fact the we trying a big hammer at the beginning. The hci_conn_add in case of auto-connect should validate status and handle. We are not even validating the status right now assuming we always get a status == 0 on auto-connect.

The second handle validation should only occur if we have !status in the bottom half of that function.


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

Can we get details about which controller uses 0xffff instead of 0 for the handle?

> 
> Fixes: d5ebaa7c5f6f6 ("Bluetooth: hci_event: Ignore multiple conn complete events")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_event.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index abaabfae19cc..1cc5a712459e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3068,7 +3068,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
> 	struct hci_ev_conn_complete *ev = data;
> 	struct hci_conn *conn;
> 
> -	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> +	if (!status && __le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> 		bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for invalid handle");
> 		return;
> 	}

See comments above.

> @@ -4690,7 +4690,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
> 		return;
> 	}
> 
> -	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> +	if (!status && __le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> 		bt_dev_err(hdev, "Ignoring HCI_Sync_Conn_Complete for invalid handle");
> 		return;
> 	}

This is also in the wrong position. Fundamentally we need to check the validity of the handle before we assign it and not just globally.

> @@ -5527,7 +5527,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> 	struct smp_irk *irk;
> 	u8 addr_type;
> 
> -	if (handle > HCI_CONN_HANDLE_MAX) {
> +	if (!status && handle > HCI_CONN_HANDLE_MAX) {
> 		bt_dev_err(hdev, "Ignoring HCI_LE_Connection_Complete for invalid handle");
> 		return;
> 	}

Same here. The global check is pointless. Check before using it.

Regards

Marcel

