Return-Path: <netdev-owner@vger.kernel.org>
Date: Tue, 12 Apr 2016 11:58:16 -0400 (EDT)
Message-Id: <20160412.115816.674950615229727734.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2016-04-12
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160412080815.GA17516@t440s>
References: <20160412080815.GA17516@t440s>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Tue, 12 Apr 2016 11:08:15 +0300

> Here's a set of Bluetooth & 802.15.4 patches intended for the 4.7 kernel:
> 
>  - Fix for race condition in vhci driver
>  - Memory leak fix for ieee802154/adf7242 driver
>  - Improvements to deal with single-mode (LE-only) Bluetooth controllers
>  - Fix for allowing the BT_SECURITY_FIPS security level
>  - New BCM2E71 ACPI ID
>  - NULL pointer dereference fix fox hci_ldisc driver
> 
> Let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
