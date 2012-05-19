Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 May 2012 09:43:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH BlueZ 2/2] core: Fix creating device from "primary" file
Message-ID: <20120519064341.GB27057@x220.P-661HNU-F1>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337374667-17802-3-git-send-email-paulo.alcantara@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337374667-17802-3-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 18, 2012, Paulo Alcantara wrote:
> This patch removes the hard-coded address type for the BLE device
> created from the storage.
> ---
>  src/adapter.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index dafe595..8d86ca8 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1940,13 +1940,17 @@ static void create_stored_device_from_primary(char *key, char *value,
>  	struct btd_adapter *adapter = user_data;
>  	struct btd_device *device;
>  	GSList *services, *uuids, *l;
> +	char address[18];
> +	uint8_t bdaddr_type;
> +
> +	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) != 2)
> +		return;

What about entries created by older bluetoothd versions? Will they be
stuck in the storage forever without a way to remove them through the
usual API? Instead of checking for != 2 maybe the check should instead
be < 1 and bdaddr_type be pre-initialized to BDADDR_LE_PUBLIC.

Johan
