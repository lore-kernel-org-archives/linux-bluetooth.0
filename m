Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 26 Aug 2016 21:10:05 -0700 (PDT)
Message-Id: <20160826.211005.1840302554943486711.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth 2016-08-25
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160825191746.GA16954@t440s.P-661HNU-F1>
References: <20160825191746.GA16954@t440s.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 25 Aug 2016 22:17:46 +0300

> Here are a couple of important Bluetooth fixes for the 4.8 kernel:
> 
>  - Memory leak fix for HCI requests
>  - Fix sk_filter handling with L2CAP
>  - Fix sock_recvmsg behavior when MSG_TRUNC is not set
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
