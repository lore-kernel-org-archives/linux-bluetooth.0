Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: Bluetooth Qualcomm Atheros QCA9565 / AR9565 [168c:0036] not recognized
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <56970229.4020703@live.com>
Date: Thu, 21 Jan 2016 12:16:55 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <1556EAE0-AC3B-4FA3-88AD-A1DDED950664@holtmann.org>
References: <56970229.4020703@live.com>
To: Leonardo Marques Rodrigues <leo.mrodrigues@live.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Leonardo,

> I have installed Ubuntu 14.04 on my Acer Aspire E5-573G, and the bluetooth was not recognized, but wifi is working perfectly. I make tests from  kernel 3.19 - 4.4-rc8 and this occurred on all tests.
> 
> I did a bug report on  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1532267 and I was instructed to report here.
> 
> Thank you for your attention.
> 
> Below I send some results:
> 
> --------------------------------------------------------------------------------------------------------
> cat /proc/version:
> 
> Linux version 4.4.0-040400-generic (kernel@gomeisa) (gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201601101930 SMP Mon Jan 11 00:32:41 UTC 2016
> 
> --------------------------------------------------------------------------------------------------------
> 
> sh ver_linux:
> 
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>  
> Linux thor 4.4.0-040400-generic #201601101930 SMP Mon Jan 11 00:32:41 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

so where is this module support to sit on in the first place. PCI, USB, SDIO or UART?

Regards

Marcel

