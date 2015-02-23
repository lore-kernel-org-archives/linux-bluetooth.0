Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Feb 2015 15:06:20 -0500 (EST)
Message-Id: <20150223.150620.1748896587152404088.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth 2015-02-23
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150223074526.GA8287@t440s.lan>
References: <20150223074526.GA8287@t440s.lan>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Mon, 23 Feb 2015 09:45:26 +0200

> Here's one important fix for the 4.0-rc series. Refactoring of Intel
> Bluetooth controller detection ended up disabling some older ones which
> are based on CSR hardware. This patch re-introduces the necessary USB id
> and fixes the breakage.
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
