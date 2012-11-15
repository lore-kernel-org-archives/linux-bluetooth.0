Return-Path: <cyrus@holtmann.org>
Message-ID: <1353023818.1849.3.camel@aeonflux>
Subject: Re: [RFC 2/4] Bluetooth: Fix sending L2CAP Create Chan Req
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 16 Nov 2012 08:56:58 +0900
In-Reply-To: <1352996096-27374-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1352996096-27374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1352996096-27374-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When receiving Physical Link Completed event we need to create L2CAP
> channel with L2CAP Create Chan Request. Current code was sending
> this command only if connection was pending (which is probably
> needed in channel move case). If channel is not moved but created
> Create Chan should be sent for outgoing channel which is checked
> with BT_CONNECT flag.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


