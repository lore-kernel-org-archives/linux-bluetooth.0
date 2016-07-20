Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 20 Jul 2016 14:44:43 -0700 (PDT)
Message-Id: <20160720.144443.401615378058083843.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	mchehab@osg.samsung.com, sameo@linux.intel.com
Subject: Re: pull request: bluetooth-next 2016-07-19
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160719061452.GA21654@t440s.P-661HNU-F1>
References: <20160719061452.GA21654@t440s.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Tue, 19 Jul 2016 09:14:52 +0300

> Here's likely the last bluetooth-next pull request for the 4.8 kernel:
> 
>  - Fix for L2CAP setsockopt
>  - Fix for is_suspending flag handling in btmrvl driver
>  - Addition of Bluetooth HW & FW info fields to debugfs
>  - Fix to use int instead of char for callback status.
> 
> The last one (from Geert Uytterhoeven) is actually not purely a
> Bluetooth (or 802.15.4) patch, but it was agreed with other maintainers
> that we take it through the bluetooth-next tree.
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks.
