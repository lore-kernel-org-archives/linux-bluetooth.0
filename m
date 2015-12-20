Return-Path: <linux-wpan-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH bluetooth-next] 6lowpan: fix debugfs interface entry name
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1450178735-1572-1-git-send-email-alex.aring@gmail.com>
Date: Sun, 20 Dec 2015 08:22:04 +0100
Cc: linux-wpan@vger.kernel.org,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	netdev@vger.kernel.org, kernel@pengutronix.de,
	lukasz.duda@nordicsemi.no
Message-Id: <60F184F1-1E10-4D0E-92F8-C778E6FF8386@holtmann.org>
References: <1450178735-1572-1-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> This patches moves the debugfs interface related register after
> netdevice register. The function lowpan_dev_debugfs_init will use
> "dev->name" which can be before register_netdevice a format string.
> The function register_netdevice will evaluate the format string if
> necessary and replace "dev->name" to the real interface name.
> 
> Reported-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/6lowpan/core.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

