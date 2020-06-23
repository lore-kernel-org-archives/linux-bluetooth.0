Return-Path: <SRS0=Gzv7=AE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADFFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 06:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3BF20771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 06:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgFWGIz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:08:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49649 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbgFWGIy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jun 2020 02:08:54 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 014B8CED34;
        Tue, 23 Jun 2020 08:18:44 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Fix and detect most of the Chinese
 Bluetooth controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0018a41a-5a46-2db6-5df2-e1b026b81bae@gmail.com>
Date:   Tue, 23 Jun 2020 08:08:51 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <AFE45DF6-8803-4613-9F7C-F9EB9894C4AD@holtmann.org>
References: <0018a41a-5a46-2db6-5df2-e1b026b81bae@gmail.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ismael,

> For some reason they tend to squat on the very first CSR/
> Cambridge Silicon Radio VID/PID instead of paying fees.
> 
> This is an extremely common problem; the issue goes as back as 2013
> and these devices are only getting more popular, even rebranded by
> reputable vendors and sold by retailers everywhere.
> 
> So, at this point in time there are hundreds of modern dongles reusing
> the ID of what originally was an early Bluetooth 1.1 controller.
> 
> Linux is the only place where they don't work due to spotty checks
> in our detection code. It only covered a minimum subset.
> 
> So what's the big idea? Flip the check around, we know that there
> are potentially going to be more. But CSR is done for and the
> real device only worked in an old and narrow subset of the
> protocol that has been amply superseded.
> 
> Known fake bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
> IC markings on 0x7558: FR3191AHAL 749H15143 (???)
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=60824
> 
> Fixes: 81cac64ba258ae (Deal with USB devices that are faking CSR vendor)
> Reported-by: Michał Wiśniewski <brylozketrzyn@gmail.com>
> Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 28 ++++++++++++++++++++--------
> 1 file changed, 20 insertions(+), 8 deletions(-)
> 
> PS: I'm wondering how flexible the new 100-column limit really is,
>    I tried to trim the comment a bit but it looked ugly. :)

it might be in general for Linus, but here lets try to keep it at 80.

> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5f022e9cf..880fe46aa 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1739,9 +1739,22 @@ static int btusb_setup_csr(struct hci_dev *hdev)
> 
> 	rp = (struct hci_rp_read_local_version *)skb->data;
> 
> -	/* Detect controllers which aren't real CSR ones. */
> +	/* Detect a wide host of Chinese controllers that aren't CSR. Some of these clones even
> +	 * respond with the correct HCI manufacturer, and their bcdDevice tags are all over the place,
> +	 * which may be another good angle to look into if we really want to have really long quirk lists.
> +	 *
> +	 * Known fake bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
> +	 * IC markings on 0x7558: FR3191AHAL 749H15143 (???)
> +	 *
> +	 * But the main thing they have in common is that these are really popular low-cost
> +	 * options that support newer Bluetooth versions but rely on heavy VID/PID
> +	 * squatting of this poor old Bluetooth 1.1 device. Even sold as such.
> +	 */
> 	if (le16_to_cpu(rp->manufacturer) != 10 ||
> -	    le16_to_cpu(rp->lmp_subver) == 0x0c5c) {
> +	    le16_to_cpu(rp->lmp_subver) == 0x0c5c ||
> +	    le16_to_cpu(rp->hci_ver) >= BLUETOOTH_VER_1_2) {

This check will also catch actually Bluetooth 2.0 and later made devices from CSR.

> +		bt_dev_info(hdev, "CSR: Unbranded CSR clone detected; adding workaround");
> +
> 		/* Clear the reset quirk since this is not an actual
> 		 * early Bluetooth 1.1 device from CSR.
> 		 */
> @@ -1751,6 +1764,9 @@ static int btusb_setup_csr(struct hci_dev *hdev)
> 		 * stored link key handling and so just disable it.
> 		 */
> 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
> +	} else {
> +		/* Only apply these quirks to the actual, old CSR devices */
> +		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> 	}
> 
> 	kfree_skb(skb);
> @@ -3995,17 +4011,13 @@ static int btusb_probe(struct usb_interface *intf,
> 
> 	if (id->driver_info & BTUSB_CSR) {
> 		struct usb_device *udev = data->udev;
> -		u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
> 
> 		/* Old firmware would otherwise execute USB reset */
> -		if (bcdDevice < 0x117)
> +		if (le16_to_cpu(udev->descriptor.bcdDevice) < 0x117)
> 			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);

Keep this as is.

> 
> 		/* Fake CSR devices with broken commands */
> -		if (bcdDevice <= 0x100 || bcdDevice == 0x134)
> -			hdev->setup = btusb_setup_csr;
> -
> -		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> +		hdev->setup = btusb_setup_csr;

Frankly, I rather add a switch statement and list all the known broken bcdDevice instead of trying to penalize real CSR devices.

Regards

Marcel

