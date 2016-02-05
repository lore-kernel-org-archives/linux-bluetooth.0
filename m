Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [BfA] Setting Reconnection Address
Date: Fri, 05 Feb 2016 10:10:53 +0100
Message-ID: <2189623.YQGdH5ZUzM@ix>
In-Reply-To: <CAKafyqoPC5AqtwGaO+CdvDc3SbQOO4zgYnZbFCthM4paZy4d9A@mail.gmail.com>
References: <CAKafyqoPC5AqtwGaO+CdvDc3SbQOO4zgYnZbFCthM4paZy4d9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Friday 29 January 2016 17:42:18 Prabhu Chawandi wrote:
> Hi All,
> 
>    I have basic doubt, which is as below.
> when I enable the privacy feature random address will be advertised.
> 
> Say, I am using blueooth smart KB from logitek.
> 
> When I connect using " hidhost connect" works fine.  When I reboot,
> How can I reconnect ? I have random address which is no more valid.

After reboot this device should be visible with its Identity Address. The 
reason why you don't see this change right after pairing is that Android HAL 
doesn't provide any means to notify framework about such change.

So until you restart bluetoothd you should use address that was used for 
pairing and bluetoothd will handle this internally. After restart this is read 
from storage and device is visible with its identity address.

Normally this is handled by Android Framework where after start it gets list 
of bonded devices and supported profiles. So for end user this change is 
invisible since name of device stays the same.
 
> Or Do I need not to try to reconnect ? When Directed advertisement go
> will it connect automatically ?

AFAIR for HoG you need to explicitly connect it for the first time after BT is 
enabled. After that auto connect should work.

> Please let me know, how to handle this Privacy feature enabled Server
> devices.

-- 
pozdrawiam
Szymon Janc
