Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Mar 2014 11:50:59 +0100
From: Alexander Aring <alex.aring@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bluetooth: make sure 6LOWPAN_IPHC is built-in if needed
Message-ID: <20140313105057.GA3596@omega>
References: <23264195.jQigvx9V9i@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <23264195.jQigvx9V9i@wuerfel>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,

On Thu, Mar 13, 2014 at 11:31:41AM +0100, Arnd Bergmann wrote:
> From 5c094e2f8e556b27a73607fc39d33944c1ec3384 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 13 Mar 2014 11:27:21 +0100
> Subject: [PATCH] Bluetooth: make sure 6LOWPAN_IPHC is built-in if needed
> 
> Commit 975508879 "Bluetooth: make bluetooth 6lowpan as an option"
> ensures that 6LOWPAN_IPHC is turned on when we have BT_6LOWPAN
> enabled in Kconfig, but it allows building the IPHC code as
> a loadable module even if the entire Bluetooth stack is built-in,
> and that causes a link error.

how do you get this link error? I don't see any linking error.

But I know what you mean, because we have a bool and not a tristate
here and then 6LOWPAN_IPHC is always built-in.

Thanks for fixing this.

- Alex
