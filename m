Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 May 2015 23:27:15 -0700 (PDT)
Message-Id: <20150530.232715.2163410957549351469.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2015-05-28
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150528093143.GA22996@t440s.ger.corp.intel.com>
References: <20150528093143.GA22996@t440s.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 28 May 2015 12:31:43 +0300

> Here's a set of patches intended for 4.2. The majority of the changes
> are on the 802.15.4 side of things rather than Bluetooth related:
> 
>  - All sorts of cleanups & fixes to ieee802154 and related drivers
>  - Rework of tx power support in ieee802154 and its drivers
>  - Support for setting ieee802154 tx power through nl802154
>  - New IDs for the btusb driver
>  - Various cleanups & smaller fixes to btusb
>  - New btrtl driver for Realtec devices
>  - Fix suspend/resume for Realtek devices
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
