Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17883C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 09:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiCDJvb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCDJva (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 04:51:30 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76EAE5C378
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 01:50:41 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id D0D3BCED38;
        Fri,  4 Mar 2022 10:50:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH 2/3] Bluetooth: HCI: Add
 HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO quirk
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220303221709.387865-2-luiz.dentz@gmail.com>
Date:   Fri, 4 Mar 2022 10:50:39 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4F704E17-DADA-496D-91A9-12AC77FC439A@holtmann.org>
References: <20220303221709.387865-1-luiz.dentz@gmail.com>
 <20220303221709.387865-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO quirk which can be used
> to mark HCI_Enhanced_Setup_Synchronous_Connection as broken even if its
> support command bit are set since some controller report it as supported
> but the command don't work properly with some configurations
> (e.g. BT_VOICE_TRANSPARENT/mSBC).
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h      | 9 +++++++++
> include/net/bluetooth/hci_core.h | 8 ++++++--
> 2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 35c073d44ec5..a4da339aab07 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -255,6 +255,15 @@ enum {
> 	 * during the hdev->setup vendor callback.
> 	 */
> 	HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
> +
> +	/*
> +	 * When this quirk is set, disables the use of
> +	 * HCI_OP_ENHANCED_SETUP_SYNC_CONN command to setup SCO connections.

it is SCO and eSCO connections.

> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO,
> };

s/_SCO/_SYNC/

> 
> /* HCI device flags */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index d5377740e99c..7a9795783850 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1492,8 +1492,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> #define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
> 				   (hdev->commands[39] & 0x04))
> 
> -/* Use enhanced synchronous connection if command is supported */
> -#define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
> +/* Use enhanced synchronous connection if command is supported and its quirk
> + * has not been set.
> + */
> +#define enhanced_sco_capable(dev) (((dev)->commands[29] & 0x08) && \
> +				   !test_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO, \
> +					     &(dev)->quirks))

Hmmm. So we got that naming wrong already. It should have really read enhanced_setup_sync_capable().

And frankly now I would actually rename it in the context that we limit it other than commands/feature bits. So use use_enhanced_setup_sync() in the code now.

Regards

Marcel

