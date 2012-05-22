Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 11:00:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH BlueZ v2 2/2] core: Fix creating device from "primary"
 file
Message-ID: <20120522080002.GA9688@x220>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337633316-4992-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337633316-4992-3-git-send-email-paulo.alcantara@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337633316-4992-3-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, May 21, 2012, Paulo Alcantara wrote:
> From: Claudio Takahasi <claudio.takahasi@openbossa.org>
> 
> This patch removes the hard-coded address type for the BLE device
> created from the storage.
> ---
>  src/adapter.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index dafe595..1ca21e6 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1940,13 +1940,17 @@ static void create_stored_device_from_primary(char *key, char *value,
>  	struct btd_adapter *adapter = user_data;
>  	struct btd_device *device;
>  	GSList *services, *uuids, *l;
> +	char address[18];
> +	uint8_t bdaddr_type;
> +
> +	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
> +		bdaddr_type = BDADDR_LE_PUBLIC;

That's not safe. What if sscanf returns 0 or a negative value? In that
case the address variable will remain uninitialized (which is why you
should have just followed my suggestion of testing for < 1 and returning
in such a case).

Thinking more about this situation I'm not sure if it's any better to
allow creation of old entries since you won't be able to remove them
anyway: the remove code looks for a bdaddr#type key which won't exist
and adding code to look for both types of keys is just bloating the code
base for a minor benefit.

So maybe your initial patch of failing in the case of sscanf returning < 2
is good enough after all.

Johan
