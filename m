Return-Path: <cyrus@holtmann.org>
Message-ID: <1337308314.5970.281.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Free allocated ERTM SREJ list if init
 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Date: Thu, 17 May 2012 19:31:54 -0700
In-Reply-To: <1337296814-3763-3-git-send-email-mathewm@codeaurora.org>
References: <1337296814-3763-1-git-send-email-mathewm@codeaurora.org>
	 <1337296814-3763-3-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> If the ERTM SREJ list is properly allocated but the retransmit list
> allocation fails, the SREJ list must be freed before returning from
> l2cap_ertm_init.  l2cap_chan_del will not clean up the SREJ list
> if l2cap_ertm_init returns a failure code.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


