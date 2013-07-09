Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Jul 2013 15:05:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: martin.xu@linux.intel.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Profile: fix set default external profile authorize
Message-ID: <20130709120505.GD22976@x220.p-661hnu-f1>
References: <1373271440-8673-1-git-send-email-martin.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373271440-8673-1-git-send-email-martin.xu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Mon, Jul 08, 2013, martin.xu@linux.intel.com wrote:
> From: Martin <martin.xu@linux.intel.com>

Please fix your git settings to include your full name here (i.e.
"Martin Xu").

> @@ -1998,7 +2008,7 @@ static void ext_set_defaults(struct ext_profile *ext)
>  
>  	ext->mode = BT_IO_MODE_BASIC;
>  	ext->sec_level = BT_IO_SEC_MEDIUM;
> -	ext->authorize = true;
> +	ext->authorize = false;
>  	ext->enable_client = true;
>  	ext->enable_server = true;
>  	ext->remote_uuid = NULL;

The patch is ok except for the above change. The above change will cause
a break in the external D-Bus API behavior where previously you didn't
need to explicitly say RequireAuthorization=true to get authorization.
With your patch such applications would loose their authorization
requirement. Instead, ext->authorize should still default to true.

> @@ -2029,6 +2039,9 @@ static void ext_set_defaults(struct ext_profile *ext)
>  		if (settings->mode)
>  			ext->mode = settings->mode;
>  
> +		if (settings->authorize)
> +			ext->authorize = true;
> +

Once you make the previous fix you'll need to drop the if-statement and
unconditionally do "ext->authorize = settings->authorize".

Johan
