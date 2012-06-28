Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jun 2012 14:33:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/3] Add SetRemoteProperties method for OOB COD
 setting
Message-ID: <20120628113321.GA18209@x220>
References: <1314014944-21554-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314014944-21554-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz (and whoever is interested in OOB pairing),

On Mon, Aug 22, 2011, Bartosz Szatkowski wrote:
> Add method for suppling class of device through OOB mechanism, to be
> available at pairing phase. At this point it may be presented to the
> user, by agent, in confirmation request (or whatever).
> ---
>  doc/oob-api.txt   |   13 ++++
>  plugins/dbusoob.c |  164 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 177 insertions(+), 0 deletions(-)

These patches never went upstream but I'd like to revive the discussion
around them.

> diff --git a/doc/oob-api.txt b/doc/oob-api.txt
> index d838712..0324758 100644
> --- a/doc/oob-api.txt
> +++ b/doc/oob-api.txt
> @@ -36,3 +36,16 @@ Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
>  
>  			Possible errors: org.bluez.Error.Failed
>  					 org.bluez.Error.InvalidArguments
> +
> +		void SetRemoteProperties(string address, dict data)
> +
> +			This method set new properties for device with specified
> +			address, to be used when device is created.
> +			On success DeviceFound signal will be emitted.
> +
> +			Currently supported keys:
> +
> +				Class		uint32
> +
> +			Possible errors: org.bluez.Error.Failed
> +					 org.bluez.Error.InvalidArguments

Now that we're starting to prepare BlueZ 5 we can make more radical
changes to the D-Bus APIs. E.g. I don't think we need a separate
SetRemoteProperties method but the existing AddRemoteData one could
simply be changed to take a dictionary which would usually just include
the keys "Randomizer" and "Hash" but could also include other info like
"Class".

Thoughts? Is anyone actually actively using the current OutOfBand D-Bus
interface?

Johan
