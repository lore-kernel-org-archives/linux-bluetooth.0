Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A42C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 13:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E835B20772
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 13:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgGBNSp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:18:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41205 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGBNSo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 09:18:44 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6AF6BCED12;
        Thu,  2 Jul 2020 15:28:38 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: le_supported_roles experimental feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200701220853.421445-1-alainm@chromium.org>
Date:   Thu, 2 Jul 2020 15:18:42 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <427B6E1C-178C-405D-88F8-899EC48AC8A9@holtmann.org>
References: <20200701220853.421445-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This patch adds an le_supported_roles features which allows a
> clients to determine if the controller is able to support peripheral and
> central connections separately and at the same time.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> Changes in v2:
> - Slight change of design based on offline feedback
> 
> net/bluetooth/mgmt.c | 36 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5e9b9728eeac..c13fcc21745f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3753,10 +3753,36 @@ static const u8 debug_uuid[16] = {
> };
> #endif
> 
> +/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
> +static const u8 le_supported_roles[16] = {
> +	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
> +	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
> +};
> +
> +static u32 get_le_roles_flags(struct hci_dev *hdev)
> +{
> +	u32 flags = 0;
> +
> +	/* Central connections supported */
> +	if (hdev->le_states[4] & 0x08)
> +		flags |= BIT(0);
> +
> +	/* Peripheral connections supported */
> +	if (hdev->le_states[4] & 0x40)
> +		flags |= BIT(1);
> +
> +	/* Simult central and peripheral connections supported */
> +	if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
> +	    (hdev->le_states[3] & 0x10))
> +		flags |= BIT(2);
> +
> +	return flags;
> +}

this is not what we can do here. The flags are defined like this.

        The following bits are defined for the Flags parameter:

                0       Feature active
                1       Causes change in supported settings

And I want these flags for generic handling of experimental features. Individual features can not overwrite it.

So if you only want to support a the “read" functionality, then something like this please.

	if ((hdev->le_states[4] & 0x08) &&	/* Central */
	    (hdev->le_states[4] & 0x40) &&	/* Peripheral */
	    (hdev->le_states[3] & 0x10) &&	/* Simultaneous */
	    test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks))
		flags |= BIT(0);

> +
> static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 				  void *data, u16 data_len)
> {
> -	char buf[42];
> +	char buf[44];
> 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
> 	u16 idx = 0;
> 
> @@ -3774,6 +3800,14 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 	}
> #endif
> 
> +	if (hdev) {
> +		memcpy(rp->features[idx].uuid, le_supported_roles,
> +		       sizeof(le_supported_roles));
> +

And I would put it all here instead of a separate function.

> +		rp->features[idx].flags = cpu_to_le32(get_le_roles_flags(hdev));
> +		++idx;
> +	}
> +
> 	rp->feature_count = cpu_to_le16(idx);
> 
> 	/* After reading the experimental features information, enable

Regards

Marcel

