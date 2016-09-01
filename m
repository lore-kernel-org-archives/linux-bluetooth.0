Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Mark CW6622 devices to have broken link key commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1472743357-11144-1-git-send-email-szymon.janc@codecoup.pl>
Date: Thu, 1 Sep 2016 08:54:31 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <591B9692-5393-4EE8-B75C-AD212E9252A9@holtmann.org>
References: <1472743357-11144-1-git-send-email-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Conwise CW6622 seems to have a problem with the stored link key
> commands so just mark it as broken.
> 
> < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
>> HCI Event: Command Complete (0x0e) plen 12
>    Read Local Supported Features (0x04|0x0003) ncmd 1
>    status 0x00
>    Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
> < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
>> HCI Event: Command Complete (0x0e) plen 12
>    Read Local Version Information (0x04|0x0001) ncmd 1
>    status 0x00
>    HCI Version: 2.0 (0x3) HCI Revision: 0x1f4
>    LMP Version: 2.0 (0x3) LMP Subversion: 0x1f4
>    Manufacturer: CONWISE Technology Corporation Ltd (66)
> ...
> < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
>> HCI Event: Command Complete (0x0e) plen 68
>    Read Local Supported Commands (0x04|0x0002) ncmd 1
>    status 0x00
>    Commands: 7fffef03cedfffffffffff1ff20ff8ff3f
> ...
> < HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
>    bdaddr 00:00:00:00:00:00 all 1
>> HCI Event: Command Complete (0x0e) plen 8
>    Read Stored Link Key (0x03|0x000d) ncmd 1
>    status 0x11 max 0 num 0
>    Error: Unsupported Feature or Parameter Value
> 
> Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> ---
> drivers/bluetooth/btusb.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

