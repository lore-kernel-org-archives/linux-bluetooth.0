Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8E6C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137ED206E9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390904AbgDCNtT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:49:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54400 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390830AbgDCNtT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 09:49:19 -0400
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 30CF3CECFF;
        Fri,  3 Apr 2020 15:58:51 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1] bluetooth:Adding driver and quirk defs for multi-role
 LE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200403133806.246918-1-alainm@chromium.org>
Date:   Fri, 3 Apr 2020 15:49:17 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D3C05492-13B9-447C-982B-26B681C9EF8C@holtmann.org>
References: <20200403133806.246918-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds the relevant driver and quirk to allow drivers to
> report that concurrent roles are well supported by the controller.
> 
> This has historically been disabled as controllers did not reliably
> support this. In particular, this will be used to relax this condition
> for controllers that have been well tested and reliable.
> 
> 	/* Most controller will fail if we try to create new connections
> 	 * while we have an existing one in slave role.
> 	 */
> 	if (hdev->conn_hash.le_num_slave > 0)
> 		return NULL;
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> drivers/bluetooth/btusb.c   | 2 ++
> include/net/bluetooth/hci.h | 8 ++++++++
> 2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3bdec42c9612..22e61a502d40 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -58,6 +58,8 @@ static struct usb_driver btusb_driver;
> #define BTUSB_CW6622		0x100000
> #define BTUSB_MEDIATEK		0x200000
> #define BTUSB_WIDEBAND_SPEECH	0x400000
> +#define BTUSB_LE_CONCURRENT_ROLES_SUPPORTED \
> +				0x800000
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5f60e135aeb6..b2c76cde7cd4 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -214,6 +214,14 @@ enum {
> 	 * This quirk must be set before hci_register_dev is called.
> 	 */
> 	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> +
> +	/* When this quirk is set, the controller has validated that
> +	 * concurrent LE roles are supported.  This mechanism is necessary
> +	 * as many controllers have been seen has having trouble initiating
> +	 * a connectable advertisement after at least one connection in
> +	 * central had already been established.
> +	 */
> +	HCI_QUIRK_LE_CONCURRENT_ROLES_SUPPORTED,
> };

lets do this the other way around. Lets remove the limitation we have in our HCI core code. And then we see which controllers report errors. Trying to enable each controller individually is cumbersome. I rather later on blacklist the one or two historic controllers that don’t support it.

Regards

Marcel

