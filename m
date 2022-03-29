Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92406C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 11:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiC2Lfr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiC2Lfq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 07:35:46 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD54F27CC1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 04:34:00 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fa3c.dip0.t-ipconnect.de [79.249.250.60])
        by mail.holtmann.org (Postfix) with ESMTPSA id 811D8CECC8;
        Tue, 29 Mar 2022 13:33:59 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 2/2] Bluetooth: Print broken quirks
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220325211314.425364-2-luiz.dentz@gmail.com>
Date:   Tue, 29 Mar 2022 13:33:58 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BA52316B-CC2F-4030-8764-DC8979075ACB@holtmann.org>
References: <20220325211314.425364-1-luiz.dentz@gmail.com>
 <20220325211314.425364-2-luiz.dentz@gmail.com>
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
> net/bluetooth/hci_sync.c | 44 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 44 insertions(+)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 8f4c5698913d..089500136096 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3825,6 +3825,48 @@ static int hci_init_sync(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +#define HCI_BROKEN(_quirk, _desc) \
> +{ \
> +	.quirk = _quirk, \
> +	.desc = _desc, \
> +}
> +
> +struct hci_broken {
> +	unsigned long quirk;
> +	const char *desc;
> +} hci_broken_table[] = {
> +	HCI_BROKEN(HCI_QUIRK_BROKEN_LOCAL_COMMANDS,
> +		   "HCI Read Local Supported Commands not supported"),
> +	HCI_BROKEN(HCI_QUIRK_BROKEN_STORED_LINK_KEY,
> +		   "HCI Delete Stored Link Key command is advertised, "
> +		   "but not supported."),
> +	HCI_BROKEN(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
> +		   "HCI Read Default Erroneous Data Reporting command is "
> +		   "advertised, but not supported."),
> +	HCI_BROKEN(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
> +		   "HCI Read Transmit Power Level command is advertised, "
> +		   "but not supported."),
> +	HCI_BROKEN(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
> +		   "HCI Set Event Filter command not supported."),
> +	HCI_BROKEN(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN,
> +		   "HCI Enhanced Setup Synchronous Connection command is "
> +		   "advertised, but not supported.")
> +};

static const hci_quirk_broken

And then HCI_QUIRK_BROKEN(LOCAL_COMMANDS, “text”),

> +
> +static void hci_dev_print_broken(struct hci_dev *hdev)
> +{
> +	int i;
> +
> +	bt_dev_dbg(hdev, "");
> +
> +	for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
> +		struct hci_broken *broken = &hci_broken_table[i];
> +
> +		if (test_bit(broken->quirk, &hdev->quirks))
> +			bt_dev_warn(hdev, "%s", broken->desc);
> +	}
> +}
> +
> int hci_dev_open_sync(struct hci_dev *hdev)
> {
> 	int ret = 0;
> @@ -4031,6 +4073,8 @@ int hci_dev_open_sync(struct hci_dev *hdev)
> 	}
> 
> done:
> +	hci_dev_print_broken(hdev);
> +

This is wrong. It gets printed all the time and no matter if success or failure. This needs to go after hdev->setup.

Regards

Marcel

