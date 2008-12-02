Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch for 2.6.28? 1/1] bluetooth: Dell Wireless 365 requires
 reset quirk
From: Marcel Holtmann <marcel@holtmann.org>
To: tim.gardner@canonical.com
Cc: akpm@linux-foundation.org, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	mario_limonciello@dell.com, hidave.darkstar@gmail.com,
	stable@kernel.org
In-Reply-To: <49347D69.7070807@tpi.com>
References: <200812012201.mB1M155p001654@imap1.linux-foundation.org>
	 <1228169030.31158.154.camel@violet.holtmann.net> <49347D69.7070807@tpi.com>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 01:22:19 +0100
Message-Id: <1228177339.31158.155.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

> >> This patch causes the BT365 to be reset when the driver is loaded. 
> >> Without it, the machine is unable to connect to other devices or to scan
> >> for devices.
> >>
> >> Signed-off-by: Mario Limonciello <mario_limonciello@dell.com>
> >> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> >> Cc: Marcel Holtmann <marcel@holtmann.org>
> >> Cc: Dave Young <hidave.darkstar@gmail.com>
> >> Cc: <stable@kernel.org>
> >> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > 
> > NAK. I fixed this differently by making the reset quirk default.
>
> Does that mean the devices in blacklist_table that have _only_
> BTUSB_RESET should be removed? It would get rid of roughly half of the
> entries.

that has already been done. See the pull request I sent to Dave.

Regards

Marcel


