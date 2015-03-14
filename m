Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Mar 2015 14:30:09 -0400 (EDT)
Message-Id: <20150314.143009.2216331232217010224.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2015-03-14
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150314180144.GA22474@t440s.P-661HNU-F1>
References: <20150314180144.GA22474@t440s.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Sat, 14 Mar 2015 20:01:44 +0200

> Here's another set of Bluetooth & ieee802154 patches intended for 4.1:
> 
>  - Added support for QCA ROME chipset family in the btusb driver
>  - at86rf230 driver fixes & cleanups
>  - ieee802154 cleanups
>  - Refactoring of Bluetooth mgmt API to allow new users
>  - New setting for static Bluetooth address exposed to user space
>  - Refactoring of hci_dev flags to remove limit of 32
>  - Remove unnecessary fast-connectable setting usage restrictions
>  - Fix behavior to be consistent when trying to pair already paired device
>  - Service discovery corner-case fixes
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
