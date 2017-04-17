Return-Path: <netdev-owner@vger.kernel.org>
Date: Mon, 17 Apr 2017 15:02:17 -0400 (EDT)
Message-Id: <20170417.150217.1911065261318715863.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2017-04-14
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170414181212.GA27363@x1c.P-661HNU-F1>
References: <20170414181212.GA27363@x1c.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Fri, 14 Apr 2017 21:12:12 +0300

> Here's the main batch of Bluetooth & 802.15.4 patches for the 4.12
> kernel.
> 
>  - Many fixes to 6LoWPAN, in particular for BLE
>  - New CA8210 IEEE 802.15.4 device driver (accounting for most of the
>    lines of code added in this pull request)
>  - Added Nokia Bluetooth (UART) HCI driver
>  - Some serdev & TTY changes that are dependencies for the Nokia
>    driver (with acks from relevant maintainers and an agreement that
>    these come through the bluetooth tree)
>  - Support for new Intel Bluetooth device
>  - Various other minor cleanups/fixes here and there
> 
> Please let me know if there are any issues pulling. Thanks.

Applied, thanks.
