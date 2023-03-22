Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64087C76195
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 08:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCVIA6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCVIA5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 04:00:57 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DBB2448A
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 01:00:54 -0700 (PDT)
Received: from [192.168.0.2] (unknown [95.90.235.137])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F234D61CC457B;
        Wed, 22 Mar 2023 09:00:52 +0100 (CET)
Message-ID: <b48ef5be-a64e-48a1-2b43-6e72cc3a0f9f@molgen.mpg.de>
Date:   Wed, 22 Mar 2023 09:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] Bluetooth: Partial support for Actions Semi ATS2851
 based devices
To:     Raul Cheleguini <raul.cheleguini@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
References: <20230322012428.2662664-1-raul.cheleguini@gmail.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230322012428.2662664-1-raul.cheleguini@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Raul,


Thank you for your patch. You could make the summary a statement by 
adding a verb (in imperative mood):

Add partial support for Actions Semi ATS2851 based devices

Am 22.03.23 um 02:24 schrieb Raul Cheleguini:
> The ATS2851 advertises support for commands "Set Random Private Address
> Timeout" and "Extended Create Connection" but does not actually implement
> them and reply with unknown HCI command.
> 
> The failed first command blocks the device initialization, and the failed
> second command blocks the start of the pairing process.
> 
> Add these two quirks to unblock the device initialization and to skip
> the extended create connection command when start pairing.

… when start*ing* pairing.

> v2: Move the extended create connection quirk to use_ext_conn, edit commit
> description and add btmon logs.
> 
> < HCI Command: LE Set Resolvable Private... (0x08|0x002e) plen 2
>          Timeout: 900 seconds
>> HCI Event: Command Status (0x0f) plen 4
>        LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 1
>          Status: Unknown HCI Command (0x01)
> 
> < HCI Command: LE Extended Create Conn.. (0x08|0x0043) plen 26
>          Filter policy: Accept list is not used (0x00)
>          Own address type: Public (0x00)
>          Peer address type: Random (0x01)
>          Peer address: DD:5E:B9:FE:49:3D (Static)
>          Initiating PHYs: 0x01
>          Entry 0: LE 1M
>            Scan interval: 60.000 msec (0x0060)
>            Scan window: 60.000 msec (0x0060)
>            Min connection interval: 30.00 msec (0x0018)
>            Max connection interval: 50.00 msec (0x0028)
>            Connection latency: 0 (0x0000)
>            Supervision timeout: 420 msec (0x002a)
>            Min connection length: 0.000 msec (0x0000)
>            Max connection length: 0.000 msec (0x0000)
>> HCI Event: Command Status (0x0f) plen 4
>        LE Extended Create Connection (0x08|0x0043) ncmd 1
>          Status: Unknown HCI Command (0x01)

The commit message summary/title says “partial support”. What is not 
working?

I’d also split this commit into two. One for each quirk.

> Signed-off-by: Raul Cheleguini <raul.cheleguini@gmail.com>
> ---
>   drivers/bluetooth/btusb.c        |  2 ++
>   include/net/bluetooth/hci.h      | 14 ++++++++++++++
>   include/net/bluetooth/hci_core.h |  3 ++-
>   net/bluetooth/hci_sync.c         | 10 +++++++++-
>   4 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7382b021f3df..8656ac491f13 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4105,7 +4105,9 @@ static int btusb_probe(struct usb_interface *intf,
>   		/* Support is advertised, but not implemented */
>   		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
>   		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
> +		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
>   		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
> +		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
>   	}
>   
>   	if (!reset)
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 997107bfc0b1..3ff1681fd2b8 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -301,6 +301,20 @@ enum {
>   	 * don't actually support features declared there.
>   	 */
>   	HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
> +
> +	/*
> +	 * When this quirk is set, the HCI_OP_LE_SET_RPA_TIMEOUT command is
> +	 * disabled. This is required for the Actions Semiconductor ATS2851
> +	 * controller, which erroneously claim to support it.

controller*s* or claim*s*

> +	 */
> +	HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
> +
> +	/*
> +	 * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command is
> +	 * disabled. This is required for the Actions Semiconductor ATS2851
> +	 * controller, which erroneously claim to support it.
> +	 */
> +	HCI_QUIRK_BROKEN_EXT_CREATE_CONN,

Ditto.

>   };
>   
>   /* HCI device flags */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 53d3328c2b8b..952b0021dc25 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1695,7 +1695,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>   			   !test_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &(dev)->quirks))
>   
>   /* Use ext create connection if command is supported */
> -#define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
> +#define use_ext_conn(dev) (((dev)->commands[37] & 0x80) && \
> +			   !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &(dev)->quirks))
>   
>   /* Extended advertising support */
>   #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 8e5fe73873a8..d49cfd1ea418 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4090,7 +4090,8 @@ static int hci_le_set_rpa_timeout_sync(struct hci_dev *hdev)
>   {
>   	__le16 timeout = cpu_to_le16(hdev->rpa_timeout);
>   
> -	if (!(hdev->commands[35] & 0x04))
> +	if (!(hdev->commands[35] & 0x04) ||
> +	    test_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks))
>   		return 0;
>   
>   	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_RPA_TIMEOUT,
> @@ -4530,6 +4531,12 @@ static const struct {
>   			 "HCI Set Event Filter command not supported."),
>   	HCI_QUIRK_BROKEN(ENHANCED_SETUP_SYNC_CONN,
>   			 "HCI Enhanced Setup Synchronous Connection command is "
> +			 "advertised, but not supported."),
> +	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
> +			 "HCI LE Set Random Private Address Timeout command is "
> +			 "advertised, but not supported."),
> +	HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
> +			 "HCI LE Extended Create Connection command is "
>   			 "advertised, but not supported.")
>   };
>   
> @@ -6067,6 +6074,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
>   	if (err)
>   		goto done;
>   
> +	/* Send command LE Extended Create Connection if supported */
>   	if (use_ext_conn(hdev)) {
>   		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
>   		goto done;


Kind regards,

Paul
