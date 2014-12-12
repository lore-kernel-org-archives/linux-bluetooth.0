Return-Path: <cyrus@holtmann.org>
Message-ID: <1418383818.2470.17.camel@sipsolutions.net>
Subject: Re: [PATCH v4 2/2] Bluetooth: btmrvl add firmware dump support
From: Johannes Berg <johannes@sipsolutions.net>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, Xinming Hu
	 <huxm@marvell.com>, Cathy Luo <cluo@marvell.com>, Avinash Patil
	 <patila@marvell.com>
Date: Fri, 12 Dec 2014 12:30:18 +0100
In-Reply-To: <1416825653-32530-2-git-send-email-akarwar@marvell.com>
References: <1416825653-32530-1-git-send-email-akarwar@marvell.com>
	 <1416825653-32530-2-git-send-email-akarwar@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2014-11-24 at 02:40 -0800, Amitkumar Karwar wrote:
> From: Xinming Hu <huxm@marvell.com>
> 
> This patch adds firmware dump support for marvell
> bluetooth chipset. Currently only SD8897 is supported.
> This is implemented based on dev_coredump, a new mechnism
> introduced in kernel 3.18rc3
> 
> Firmware dump can be trigger by
> echo 1 > /sys/kernel/debug/bluetooth/hci*/config/fw_dump
> and when the dump operation is completed, data can be read by
> cat /sys/class/devcoredump/devcd*/data

If anyone still cares - this looks fine to me from devcoredump usage.

Personally I would've picked a binary format, but the devcoredump
framework is intentionally payload agnostic.

johannes
