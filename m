Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Jul 2011 18:44:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] Fix unpair device when disconnected for No
 Bonding
Message-ID: <20110709154400.GA10054@dell.ger.corp.intel.com>
References: <1309786828-11792-1-git-send-email-dmitriy.paliy@nokia.com>
 <1309786828-11792-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309786828-11792-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Jul 04, 2011, Dmitriy Paliy wrote:
> @@ -2069,6 +2076,9 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
>  
>  	device_auth_req_free(device);
>  
> +	if (bonding)
> +		device->bonded = TRUE;

The "bonding" variable will only be set if we are the initiators. What
about us acting as acceptors? Wouldn't you need to check the storage
anyway here to be completely sure if you're bonded or not?

Johan
