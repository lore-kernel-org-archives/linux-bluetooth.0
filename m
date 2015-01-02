Return-Path: <cyrus@holtmann.org>
Date: Fri, 02 Jan 2015 16:04:49 -0500 (EST)
Message-Id: <20150102.160449.1604112925381488247.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2014-12-31
From: David Miller <davem@davemloft.net>
In-Reply-To: <20141231072549.GA11458@t440s.P-661HNU-F1>
References: <20141231072549.GA11458@t440s.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Wed, 31 Dec 2014 09:25:49 +0200

> Here's the first batch of bluetooth patches for 3.20.
> 
>  - Cleanups & fixes to ieee802154  drivers
>  - Fix synchronization of mgmt commands with respective HCI commands
>  - Add self-tests for LE pairing crypto functionality
>  - Remove 'BlueFritz!' specific handling from core using a new quirk flag
>  - Public address configuration support for ath3012
>  - Refactor debugfs support into a dedicated file
>  - Initial support for LE Data Length Extension feature from Bluetooth 4.2
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
