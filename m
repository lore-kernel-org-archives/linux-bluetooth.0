Return-Path: <cyrus@holtmann.org>
Message-ID: <1350085919.19673.12.camel@aeonflux>
Subject: Re: [RFCv1 4/7] Bluetooth: Send EFS Conf Rsp only for BR/EDR chan
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 13 Oct 2012 01:51:59 +0200
In-Reply-To: <1350051005-6015-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1350051005-6015-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Do not send EFS Configuration Response for High Speed channel yet.
> It will be sent after receiving Logical Link Complete event.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


