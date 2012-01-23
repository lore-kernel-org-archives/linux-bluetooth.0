Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 13:13:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 4/4] Remove the SMP Long Term Key when the
 device is removed
Message-ID: <20120123111310.GF13100@x220>
References: <1326928412-25910-1-git-send-email-vinicius.gomes@openbossa.org>
 <1326928412-25910-4-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326928412-25910-4-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Jan 18, 2012, Vinicius Costa Gomes wrote:
> ---
>  src/device.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index 16855b1..8d02c2c 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1088,6 +1088,7 @@ static void device_remove_stored(struct btd_device *device)
>  	if (device_is_bonded(device)) {
>  		delete_entry(&src, "linkkeys", addr);
>  		delete_entry(&src, "aliases", addr);
> +		delete_entry(&src, "longtermkeys", addr);
>  		device_set_bonded(device, FALSE);
>  		device->paired = FALSE;
>  		btd_adapter_remove_bonding(device->adapter, &device->bdaddr);

This patch has also been applied, so you just need to fix and resend the
third one. Thanks.

Johan
