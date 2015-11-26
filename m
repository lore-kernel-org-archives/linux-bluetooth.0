Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: btmrvl: add sysfs commands gpiogap and hscfgcmd
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448534238-5508-1-git-send-email-akarwar@marvell.com>
Date: Thu, 26 Nov 2015 05:06:39 -0800
Cc: linux-bluetooth@vger.kernel.org, Cathy Luo <cluo@marvell.com>,
	Xinming Hu <huxm@marvell.com>
Message-Id: <B75B5139-479F-4A9E-9C5B-136B883B64D2@holtmann.org>
References: <1448534238-5508-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This patch adds support for driver's internal host sleep
> configuration via sysfs. gpiogap and hscfgcmd sysfs commands
> are added for this purpose.
> 
> Examples.
> 1. Get current gpiogap
>   cat /sys/class/bluetooth/hci0/gpiogap
> 2. Set gpio as 13 and gap as 100msecs
>   echo "0x0d64" > /sys/class/bluetooth/hci0/gpiogap
> 3. Download host sleep configuration to firmware.
>   echo "1" > /sys/class/bluetooth/hci0/hscfgcmd

explain to me how this is a good API. Keep in mind this is an userspace API and needs to be stable.

If you want to expose a GPIO, why not expose it through the standard Linux kernel GPIO API. Then it becomes easily discoverable via standard sysfs tools. Also you can use standard tools to modify it.

I also do not understand why you need something to set host sleep configuration. Just do this all the time and be done with it.

Regards

Marcel

