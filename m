Return-Path: <cyrus@holtmann.org>
Message-ID: <1349968365.27233.183.camel@aeonflux>
Subject: Re: [RFC 4/6] Bluetooth: Ignore BR/EDR packet size constraints when
 fragmenting for AMP
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Date: Thu, 11 Oct 2012 17:12:45 +0200
In-Reply-To: <1349966905-32336-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1349966905-32336-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When operating over BR/EDR, ERTM accounts for the maximum over-the-air
> packet size when setting the PDU size.  AMP controllers do not use the
> same over-the-air packets, so the PDU size should only be based on the
> HCI MTU of the AMP controller.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


