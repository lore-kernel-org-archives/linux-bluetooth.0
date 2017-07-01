Return-Path: <netdev-owner@vger.kernel.org>
Date: Sat, 01 Jul 2017 15:58:18 -0700 (PDT)
Message-Id: <20170701.155818.1192612802590994151.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2017-07-01
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170701181950.GA27217@x1c.home>
References: <20170701181950.GA27217@x1c.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Sat, 1 Jul 2017 21:19:50 +0300

> Here are some more Bluetooth patches for the 4.13 kernel:
> 
>  - Added support for Broadcom BCM43430 controllers
>  - Added sockaddr length checks before accessing sa_family
>  - Fixed possible "might sleep" errors in bnep, cmtp and hidp modules
>  - A few other minor fixes
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
