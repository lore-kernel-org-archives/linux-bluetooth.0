Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 14:39:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 01/10] Battery: Add Battery Service Gatt Client
Message-ID: <20120816113941.GA20887@x220>
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
 <1345109702-5698-2-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345109702-5698-2-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Aug 16, 2012, chen.ganir@ti.com wrote:
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -179,3 +179,8 @@ Properties	string Address [readonly]
>  			Note that this property can exhibit false-positives
>  			in the case of Bluetooth 2.1 (or newer) devices that
>  			have disabled Extended Inquiry Response support.
> +
> +		array{string} Batteries [readonly]
> +
> +			List of device battery object paths that represents the available
> +			batteries on the remote device.

I don't think it's ok to pollute the Device interface or src/device.c
with profile-specific details. That should happen in profile-specific
plugins and interfaces. Since we're switching over to object manager
maybe an interface/property like this isn't needed at all? (even if it
would be needed the type should be array{object} and not array{string}

Johan
