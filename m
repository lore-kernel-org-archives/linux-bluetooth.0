Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Add missing ACPI ID for bcm43241, used in HP Omni10
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1453391122-25226-1-git-send-email-jjmeijer88@gmail.com>
Date: Fri, 22 Jan 2016 14:42:33 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FD3D2636-B096-45F8-A4E2-4E48B2293F42@holtmann.org>
References: <Re: [PATCH] Another ACPI ID for bcm43241> <1453391122-25226-1-git-send-email-jjmeijer88@gmail.com>
To: "J.J. Meijer" <jjmeijer88@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

please provide a commit message. You need subject line and commit message body. Make it more verbose on which machine this is enabling. If you have ACPI debug output or other information, please include it as well.

> On Jan 21, 2016, at 16:45, J.J. Meijer <jjmeijer88@gmail.com> wrote:
> 
> From: meijjaa <jjmeijer88@gmail.com>
> 
> Signed-off-by: meijjaa <jjmeijer88@gmail.com>

You might want to fix your .gitconfig to have proper name and email information in your commits.

> ---
> drivers/bluetooth/hci_bcm.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 4797c5c..48dbf51 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -820,6 +820,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
>  	{ "BCM2E3D", 0 },
> 	{ "BCM2E3F", 0 },
>  	{ "BCM2E40", 0 },
> +	{ "BCM2E54", 0 },
>  	{ "BCM2E64", 0 },
>  	{ "BCM2E65", 0 },
>  	{ "BCM2E67", 0 },

I was not able to apply the patch. Please make sure it is against bluetooth-next tree.

Regards

Marcel

