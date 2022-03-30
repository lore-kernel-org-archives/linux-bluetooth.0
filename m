Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFEAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 11:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbiC3L5Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345839AbiC3LzE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 07:55:04 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56B8E263678
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 04:51:47 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fa3c.dip0.t-ipconnect.de [79.249.250.60])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7FDA2CECCC;
        Wed, 30 Mar 2022 13:51:41 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 2/3] Bluetooth: Print broken quirks
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220329201646.2296314-2-luiz.dentz@gmail.com>
Date:   Wed, 30 Mar 2022 13:51:40 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5F248916-7BF7-4FA1-AA37-4596B6BD4F35@holtmann.org>
References: <20220329201646.2296314-1-luiz.dentz@gmail.com>
 <20220329201646.2296314-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This prints warnings for controllers setting broken quirks to increase
> their visibility and warn about broken controllers firmware that
> probably needs updates to behave properly.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_sync.c | 66 +++++++++++++++++++++++++++++++++++++---
> 1 file changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 8f4c5698913d..8994ff1f94e6 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3825,6 +3825,67 @@ static int hci_init_sync(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +#define HCI_QUIRK_BROKEN(_quirk, _desc) \
> +{ \
> +	.quirk = _quirk, \
> +	.desc = _desc, \
> +}
> +

#define HCI_QUIRK_BROKEN(_quirk, _desc) { .quirk = _quirk, .desc = _desc }

Doesn’t this fit into a single line?

> +static const struct hci_quirk_broken {
> +	unsigned long quirk;
> +	const char *desc;

I am not sure if we better use an anonymous table here.

static const struct {
	..
} hci_broken_table[] = {
	..
};

> +} hci_broken_table[] = {
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_LOCAL_COMMANDS,
> +			 "HCI Read Local Supported Commands not supported"),

I am after this:

	HCI_QUIRK_BROKEN(LOCAL_COMMANDS, “HCI Read Local Supported ..”),


> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_STORED_LINK_KEY,
> +			 "HCI Delete Stored Link Key command is advertised, "
> +			 "but not supported."),
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
> +			 "HCI Read Default Erroneous Data Reporting command is "
> +			 "advertised, but not supported."),
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
> +			 "HCI Read Transmit Power Level command is advertised, "
> +			 "but not supported."),
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
> +			 "HCI Set Event Filter command not supported."),
> +	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN,
> +			 "HCI Enhanced Setup Synchronous Connection command is "
> +			 "advertised, but not supported.")
> +};
> +
> +static void hci_dev_print_broken_quirks(struct hci_dev *hdev)
> +{
> +	int i;
> +
> +	bt_dev_dbg(hdev, "");
> +
> +	for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
> +		const struct hci_quirk_broken *broken = &hci_broken_table[i];
> +
> +		if (test_bit(broken->quirk, &hdev->quirks))
> +			bt_dev_warn(hdev, "%s", broken->desc);
> +	}

	for (i = 0; .. ) }
		if (!test_bit(hci_broken_table[i], &hdev->quirks))
			continue;

		bt_dev_warn(hdev, “%s”, hci_broken_table[i].desc);
	}
> +}
> +
> +static int hci_dev_setup_sync(struct hci_dev *hdev)
> +{
> +	bt_dev_dbg(hdev, "");
> +
> +	hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> +
> +	if (hdev->setup) {
> +		int ret;
> +
> +		ret = hdev->setup(hdev);
> +		if (ret)
> +			return ret;
> +
> +		hci_dev_print_broken_quirks(hdev);
> +	}
> +
> +	return 0;
> +}
> +
> int hci_dev_open_sync(struct hci_dev *hdev)
> {
> 	int ret = 0;
> @@ -3887,10 +3948,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
> 	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> 		bool invalid_bdaddr;
> 
> -		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> -
> -		if (hdev->setup)
> -			ret = hdev->setup(hdev);
> +		ret = hci_dev_setup_sync(hdev);

Please don’t create spaghetti code. Just add the print of the quirks here.

In addition you also need to print the quirks even if no hdev->setup is defined. Quirks can also be set on probe() without the need of a vendor specific setup function.

> 
> 		/* The transport driver can set the quirk to mark the
> 		 * BD_ADDR invalid before creating the HCI device or in

Regards

Marcel

