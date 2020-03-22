Return-Path: <SRS0=Z+ax=5H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07404C43332
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Mar 2020 08:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A62720722
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Mar 2020 08:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgCVII4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Mar 2020 04:08:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34413 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgCVII4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Mar 2020 04:08:56 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id ACBE4CECE4;
        Sun, 22 Mar 2020 09:18:24 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] bluetooth: Enforce classic key size verification.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200320133748.154926-1-alainm@chromium.org>
Date:   Sun, 22 Mar 2020 09:08:53 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6953D3BD-54D7-4453-992D-20B881B92AE4@holtmann.org>
References: <20200320133748.154926-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change introduces a new configuration to strictly enforce key size
> checks.  This ensures that systems are in a secured configuration by
> default while allowing for a compatible posture via a Kconfig option to
> support controllers who may not support the read encryption key size
> command.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> net/bluetooth/Kconfig     | 20 ++++++++++++++++++++
> net/bluetooth/hci_core.c  | 10 ++++++++++
> net/bluetooth/hci_event.c |  4 ++++
> 3 files changed, 34 insertions(+)
> 
> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index 165148c7c4ce..8e177d4f3f02 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -128,4 +128,24 @@ config BT_DEBUGFS
> 	  Provide extensive information about internal Bluetooth states
> 	  in debugfs.
> 
> +config BT_EXPERT
> +	bool "Expert Bluetooth options"
> +	depends on BT
> +	default n
> +	help
> +	  Provides a set of expert options and configurations that should
> +	  only be used deliberately by BT experts.  This is considered a
> +	  global switch to ensure these advanced features or options that
> +	  depends on BT_EXPERT are only used in expert mode.
> +
> +config BT_ENFORCE_CLASSIC_KEY_SIZES
> +	bool "Enforces security requirements for Bluetooth classic"
> +	depends on BT && BT_EXPERT
> +	default y
> +	help
> +	  Enforces Bluetooth classic security requirements by disallowing
> +	  use of insecure Bluetooth controllers, i.e. that doesn't support
> +	  Read Encryption Key Size command to prevent BT classic connection
> +	  with very short encryption key.
> +

actually using submenu might have been as good.

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 165148c7c4ce..fc6b1cedbfc8 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -128,4 +128,35 @@ config BT_DEBUGFS
          Provide extensive information about internal Bluetooth states
          in debugfs.
 
+menu "Bluetooth security configuration"
+       depends on BT
+
+config BT_REQUIRE_ENC_KEY_SIZE
+       bool "Disable controllers without encryption key size support"
+       default n
+       help
+         For backwards compability reasons, the Read Encryption Key Size
+         command is not required if not available.  This options allows
+         to force the command to be support by a controller.  If it is
+         not supported, then the controller will stay in an unconfigured
+         state.
+
+         Changing this value increases the security, but might render
+         some Bluetooth controllers inactive.
+
+endmenu
+

> source "drivers/bluetooth/Kconfig"
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 4e6d61a95b20..142130d4b66b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1540,6 +1540,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> 
> 	clear_bit(HCI_INIT, &hdev->flags);
> 
> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES

When used in an ifdef it is CONFIG_BT_..

> +	/* Don't allow usage of Bluetooth if the chip doesn't support */
> +	/* Read Encryption Key Size command */

This comment style is wrong.

> +	if (!ret && !(hdev->commands[20] & 0x10)) {
> +		bt_dev_err(hdev,
> +			   "Disabling BT, Read Encryption Key Size !supported");
> +		ret = -EIO;
> +	}
> +#endif
> +
> 	if (!ret) {
> 		hci_dev_hold(hdev);
> 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a40ed31f6eb8..54f90799a088 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2902,7 +2902,11 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
> 	if (rp->status) {
> 		bt_dev_err(hdev, "failed to read key size for handle %u",
> 			   handle);
> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
> +		conn->enc_key_size = 0;
> +#else
> 		conn->enc_key_size = HCI_LINK_KEY_SIZE;
> +#endif
> 	} else {
> 		conn->enc_key_size = rp->key_size;
> 	}

So actually instead of putting an ifdef here, I would actually try to monitor if this can actually happen. I think this is a theoretical case. I wouldn’t know how this can actually fail since the key size is known by the controller and handing it out to the host is easy. Failure can only happen if the connection terminated in the meantime or if the handle is invalid. If all is valid, then this command will succeed.

Regards

Marcel

