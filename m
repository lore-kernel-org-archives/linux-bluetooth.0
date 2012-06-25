Return-Path: <cyrus@holtmann.org>
Message-ID: <1340607113.29898.3.camel@aeonflux>
Subject: Re: [PATCH] bluetooth: opcode field of sent commands is little
 endian.
From: Marcel Holtmann <marcel@holtmann.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	linux-bluetooth@vger.kernel.org, linuxppc-dev@ozlabs.org
Date: Sun, 24 Jun 2012 23:51:53 -0700
In-Reply-To: <1340606319-32187-1-git-send-email-michel@daenzer.net>
References: <1340606319-32187-1-git-send-email-michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michel,

> Fixes built-in Bluetooth not working on Apple PowerBooks, regression from
> commit 75fb0e324daa48ec458fb5c2960eb07b80cfad9d ('Bluetooth: Fix init sequence
> for some CSR based controllers').
> 
> Cc: stable@vger.kernel.org [v3.4]
> Signed-off-by: Michel Dänzer <michel@daenzer.net>
> ---
>  net/bluetooth/hci_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d6dc44c..e039e3d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -92,7 +92,7 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
>  		 * command.
>  		 */
>  
> -		if (cmd != HCI_OP_RESET || sent->opcode == HCI_OP_RESET)
> +		if (cmd != HCI_OP_RESET || sent->opcode == cpu_to_le16(HCI_OP_RESET))
>  			return;

actually you could use __constant_cpu_to_le16() here.

That said, this got actually fixed differently upstream. So I prefer if
that patch gets merged into stable and not this one.

commit 1036b89042df96e71c0cb941be212f8053ecccc0
Author: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Date:   Mon Mar 12 15:59:33 2012 +0200

    Bluetooth: Fix opcode access in hci_complete

In general patches need to get into Linus' tree first before you can
even request them for stable.

Regards

Marcel


