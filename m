Return-Path: <netdev-owner@vger.kernel.org>
Date: Thu, 25 Jan 2018 16:35:01 -0500 (EST)
Message-Id: <20180125.163501.1972801521632703691.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2018-01-25
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180125105540.GA28588@x1c.lan>
References: <20180125105540.GA28588@x1c.lan>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 25 Jan 2018 12:55:40 +0200

> Here's one last bluetooth-next pull request for the 4.16 kernel:
> 
>  - Improved support for Intel controllers
>  - New set_parity method to serdev (agreed with maintainers to be taken
>    through bluetooth-next)
>  - Fix error path in hci_bcm (missing call to serdev close)
>  - New ID for BCM4343A0 UART controller
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
