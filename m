Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7778C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 17:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD19C61A0D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 17:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhKORJK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 12:09:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56780 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhKORIu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 12:08:50 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 49BCCCED36;
        Mon, 15 Nov 2021 18:05:34 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: Fix adv set removal processing.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211115135114.2763223-1-alainm@chromium.org>
Date:   Mon, 15 Nov 2021 18:05:33 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        mcchou@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C44D0F6E-CF4F-44BC-BE13-43F62D083774@holtmann.org>
References: <20211115135114.2763223-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> When multiple advertisement sets are active and a single instance is
> removed, the processing of hci_cc_le_set_ext_adv_enable will result in
> considering all advertisements as disabled since the instance has
> already been removed from the list.
> 
> The fix is to use the command parameters to validate the intent rather
> than making an assumption based on the validity of the adv set.
> 
> remove_advertising() hci0
> 
> hci_req_add_ev() hci0 opcode 0x2039 plen 6
> hci_req_add_ev() hci0 opcode 0x203c plen 1
> 
> hci_remove_adv_instance() hci0 removing 2MR
> <-- This removes instance 2 from the adv_instances list
> 
> hci_cc_le_set_ext_adv_enable() hci0 status 0x00
> hci_sent_cmd_data() hci0 opcode 0x2039
> hci_cc_le_set_ext_adv_enable() adv instance 0, enabled 0
> <-- This incorrectly assumes that all instances are
>    being disabled while only handle 2 is being disabled.
> 
> hci_cc_le_set_ext_adv_enable() adv instance list status - before
> hci_cc_le_set_ext_adv_enable() adv instance 3 is 1
> hci_cc_le_set_ext_adv_enable() adv instance 1 is 1
> hci_cc_le_set_ext_adv_enable() HCI_LE_ADV state before: 1
> hci_cc_le_set_ext_adv_enable() adv instance list status - after
> hci_cc_le_set_ext_adv_enable() adv instance 3 is 0
> hci_cc_le_set_ext_adv_enable() adv instance 1 is 0
> hci_cc_le_set_ext_adv_enable() HCI_LE_ADV state after: 0
> <-- This is incorrect since handle 1 and 3 are still enabled
>    in the controller
> 
> The fix was validated by running the ChromeOS bluetooth_AdapterAdvHealth
> test suite.
> 
> Reviewed-by: mcchou@chromium.org

we need clear name and email in the tags please. And I also like to have Fixes: tags here as well.

> Signed-off-by: Alain Michaud <alainm@chromium.org>
> 
> ---
> 
> net/bluetooth/hci_event.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d4b75a6cfeee..52161d04136f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1385,14 +1385,16 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
> 				if (adv->enabled)
> 					goto unlock;
> 			}
> -		} else {
> +
> +			hci_dev_clear_flag(hdev, HCI_LE_ADV);
> +		} else if (!cp->num_of_sets || !set->handle) {
> 			/* All instances shall be considered disabled */
> 			list_for_each_entry_safe(adv, n, &hdev->adv_instances,
> 						 list)
> 				adv->enabled = false;
> -		}
> 
> -		hci_dev_clear_flag(hdev, HCI_LE_ADV);
> +			hci_dev_clear_flag(hdev, HCI_LE_ADV);
> +		}
> 	}

Just checking if this wouldn’t be cleaner:

		} else {
			if (foo)
				bar;

			hci_dev_clear_flag(hdev, HCI_LE_ADV);
		}

Regards

Marcel

