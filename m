Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: make sure 6LOWPAN_IPHC is built-in if needed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <23264195.jQigvx9V9i@wuerfel>
Date: Thu, 13 Mar 2014 07:07:43 -0700
Cc: Alexander Aring <alex.aring@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <9828457A-6D37-426E-AEA6-E669EAF2553F@holtmann.org>
References: <23264195.jQigvx9V9i@wuerfel>
To: Arnd Bergmann <arnd@arndb.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,

> From 5c094e2f8e556b27a73607fc39d33944c1ec3384 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 13 Mar 2014 11:27:21 +0100
> Subject: [PATCH] Bluetooth: make sure 6LOWPAN_IPHC is built-in if needed

no idea what your email client did here, but I had to manually fix this up.

> Commit 975508879 "Bluetooth: make bluetooth 6lowpan as an option"
> ensures that 6LOWPAN_IPHC is turned on when we have BT_6LOWPAN
> enabled in Kconfig, but it allows building the IPHC code as
> a loadable module even if the entire Bluetooth stack is built-in,
> and that causes a link error.
> 
> We can solve that by moving the 'select' statement into CONFIG_BT,
> which is a "tristate" option to enforce that 6LOWPAN_IPHC can
> only be a module if BT also is a module.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

patch has been applied to bluetooth-next tree.

Regards

Marcel

