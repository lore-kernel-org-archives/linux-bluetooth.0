Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jun 2014 10:55:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 9/9] Fix using address of array instead of size
Message-ID: <20140623075529.GA29804@t440s>
References: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403186136-30041-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403186136-30041-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jun 19, 2014, Andrei Emeltchenko wrote:
> ---
>  src/device.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

I've pushed patches 1-8 (with fixes to 7 and 8 due to messed up
indentation). This one doesn't make much sense though:

> diff --git a/src/device.c b/src/device.c
> index a9b644b..2003c7f 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -595,7 +595,11 @@ static gboolean dev_property_get_name(const GDBusPropertyTable *property,
>  	struct btd_device *device = data;
>  	const char *empty = "", *ptr;
>  
> -	ptr = device->name ?: empty;
> +	if (strlen(device->name) > 0)
> +		ptr = device->name;
> +	else
> +		ptr = empty;

Why do you need the whole "empty" variable here? If strlen(device->name)
is 0 then you've got the exact same thing: a pointer to an empty string.
So to me it seems that this snippet should be changed to simply:

	ptr = device->name;

Johan
