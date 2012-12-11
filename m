Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Dec 2012 20:24:09 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix sending HCI commands after reset
Message-ID: <20121211222409.GC7912@joana>
References: <1355212279-2069-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355212279-2069-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2012-12-11 08:51:19 +0100]:

> After sending reset command wait for its command complete event before
> sending next command. Some chips sends CC event for command received
> before reset if reset was send before chip replied with CC.
> 
> This is also required by specification that host shall not send
> additional HCI commands before receiving CC for reset.
> 
> < HCI Command: Reset (0x03|0x0003) plen 0                              [hci0] 18.404612
> > HCI Event: Command Complete (0x0e) plen 4                            [hci0] 18.405850
>       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0      [hci0] 18.406079
> > HCI Event: Command Complete (0x0e) plen 4                            [hci0] 18.407864
>       Reset (0x03|0x0003) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0      [hci0] 18.408062
> > HCI Event: Command Complete (0x0e) plen 12                           [hci0] 18.408835
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> Cc: stable@vger.kernel.org
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
