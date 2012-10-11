Return-Path: <cyrus@holtmann.org>
Message-ID: <1349968394.27233.184.camel@aeonflux>
Subject: Re: [RFC 5/6] Bluetooth: Add L2CAP create channel request handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Date: Thu, 11 Oct 2012 17:13:14 +0200
In-Reply-To: <1349966905-32336-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1349966905-32336-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> The L2CAP create channel request is very similar to an L2CAP connect
> request, but it has an additional parameter for the controller ID.  If
> the controller id is 0, the channel is set up on the BR/EDR controller
> (just like a connect request).  Using a valid high speed controller ID
> will cause the channel to be initially created on that high speed
> controller.  While the L2CAP data will be initially routed over the
> AMP controller, the L2CAP fixed signaling channel only uses BR/EDR.
> 
> When a create channel request is received for a high speed controller,
> a pending response is always sent first.  After the high speed
> physical and logical links are complete a success response will be
> sent.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   70 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 54 insertions(+), 16 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


