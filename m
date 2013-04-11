Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Apr 2013 16:36:54 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH] Bluetooth: Fix SCO connection reference
Message-ID: <20130411193654.GB28775@joana>
References: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2013-04-11 11:35:42 -0300]:

> This patch fixes decrementing SCO connection reference right after
> stablishing the SCO connection with defer setup enabled. The dump below
> shows a disconnection command with handle 0, the connection is still in
> BT_CONNECT2 state and there isn't a handle associated with it.
> 
> < HCI Command: Accept Synchronous Connection (0x01|0x0029) plen 21
>   bdaddr 78:47:1D:B3:72:6C
> > HCI Event: Command Status (0x0f) plen 4
>   Accept Synchronous Connection (0x01|0x0029) status 0x00 ncmd 1
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>   handle 0 reason 0x13
>   Reason: Remote User Terminated Connection
> > HCI Event: Command Status (0x0f) plen 4
>   Disconnect (0x01|0x0006) status 0x00 ncmd 1
> > HCI Event: Synchronous Connect Complete (0x2c) plen 17
>   status 0x00 handle 46 bdaddr 78:47:1D:B3:72:6C
>   type eSCO
>   Air mode: CVSD
> < SCO data: handle 46 flags 0x00 dlen 48
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 1 -
>  1 file changed, 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
