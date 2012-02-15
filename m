Return-Path: <cyrus@holtmann.org>
Message-ID: <1329308526.28848.82.camel@aeonflux>
Subject: Re: Add Atheros maryann PIDVID support.
From: Marcel Holtmann <marcel@holtmann.org>
To: "Cho, Yu-Chen" <acho@suse.com>
Cc: padovan@profusion.mobi, linux-bluetooth@vger.kernel.org,
	oneukum@suse.com, jlee@suse.com
Date: Wed, 15 Feb 2012 13:22:06 +0100
In-Reply-To: <ef5cb1fa66b3deee2c51b0a85b681c0ecfafebe2.1329298278.git.acho@suse.com>
References: <ef5cb1fa66b3deee2c51b0a85b681c0ecfafebe2.1329298278.git.acho@suse.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yu-Chen,

> From: "Cho, Yu-Chen" <acho@suse.com>

can you fix your Outlook mail client to have this first name last name.
Unless you really want it this way.

> 
> Add Atheros maryann 0cf3:311D PIDVID support.
> This module is AR3012 Series.

Please include /sys/kernel/debug/usb/devices output here for reference.
Preferable one before the firmware load and one after.

> Signed-off-by: Cho, Yu-Chen <acho@suse.com>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)

Regards

Marcel


