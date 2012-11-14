Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Nov 2012 12:45:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] adapter: Convert storage aliases
Message-ID: <20121114104553.GA6519@x220>
References: <1352888166-7391-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1352888166-7391-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Wed, Nov 14, 2012, Frédéric Danis wrote:
>  #define SETTINGS_PATH STORAGEDIR "/%s/settings"
>  #define CACHE_PATH STORAGEDIR "/%s/cache/%s"
> +#define DEVICE_INFO_PATH STORAGEDIR "/%s/%s/info"

Why do you have these separate defines? Do you need them in multiple
places? The define names are longer than the actual values and you're
just obfuscating the actual call that uses them (since you need to look
in two places to figure out of the format parameters are actually
matching the format string). So please don't use these.

Johan
