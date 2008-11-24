Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <70600880-A890-450D-9A97-B06C6A7EF04E@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Schwehn <f.schwehn@wizai.com>
In-Reply-To: <6E2954C9-3AF9-4111-A87F-11C168B77753@wizai.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Question about power tables or other transmit power limit
Date: Mon, 24 Nov 2008 04:03:38 +0100
References: <6E2954C9-3AF9-4111-A87F-11C168B77753@wizai.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> we are looking into limiting transmit power for our bluetooth file  
> server project. The idea is to limit sending radius so that people  
> don't feel harassed if they do not want to receive files.
>
> First we tried to read the RSSI during device discovery and base our  
> decision on that. But the readings varied too much because of power  
> saving methods like power tables.
>
> Since we cannot update the firmware of the mobile phones, we decided  
> to try to limit the transmit power for our device discovery HCI  
> device. After reading about things a bit and browsing through the  
> docs that CSR provides, we tried to cap the maximum power or to  
> change the power tables with the bccmd. Unfortunately, the dongle  
> doesn't seem to accept the change. After setting the value and re- 
> reading it, the change is gone:
>
> [root@horst Desktop]# bccmd psget 0x0017
> Maximum transmit power: 0x0004 (4)
> [root@horst Desktop]# bccmd psset 0x0017 0
> [root@horst Desktop]# bccmd psget 0x0017
> Maximum transmit power: 0x0004 (4)
>
> I also tried dump all PS keys and restoring the modified dump - same  
> issue.
>
> Does anybody have experience with this? Do we need special BT  
> dongles? We are also inquiring with CSR at the moment, but using a  
> windows software is not an option, as our project is using embedded  
> Linux (of course :).

this is a hardware detail that you better discuss with CSR people  
since while I know a lot about their hardware, I am not that deep into  
all the details. And messing with PS keys can result in unexpected  
things.

Regards

Marcel

