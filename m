Return-Path: <cyrus@holtmann.org>
Message-ID: <1350085857.19673.11.camel@aeonflux>
Subject: Re: [RFCv1 3/7] Bluetooth: AMP: Drop packets when no l2cap conn
 exist
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 13 Oct 2012 01:50:57 +0200
In-Reply-To: <1350051005-6015-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1350051005-6015-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> HS hci conn should always have l2cap_conn associated with it.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


