Return-Path: <cyrus@holtmann.org>
Date: Mon, 02 Mar 2015 14:48:13 -0500 (EST)
Message-Id: <20150302.144813.2240523360918229942.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2015-03-02
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150302065354.GA3613@t440s.P-661HNU-F1>
References: <20150302065354.GA3613@t440s.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Mon, 2 Mar 2015 08:53:54 +0200

> Here's the first bluetooth-next pull request targeting the 4.1 kernel:
> 
>  - ieee802154/6lowpan cleanups
>  - SCO routing to host interface support for the btmrvl driver
>  - AMP code cleanups
>  - Fixes to AMP HCI init sequence
>  - Refactoring of the HCI callback mechanism
>  - Added shutdown routine for Intel controllers in the btusb driver
>  - New config option to enable/disable Bluetooth debugfs information
>  - Fix for early data reception on L2CAP fixed channels
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks.
