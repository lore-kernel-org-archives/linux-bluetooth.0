Return-Path: <cyrus@holtmann.org>
Message-ID: <1353023637.1849.1.camel@aeonflux>
Subject: Re: [RFC 3/4] Bluetooth: Remove unneeded local_amp_id initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 16 Nov 2012 08:53:57 +0900
In-Reply-To: <1352996096-27374-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1352996096-27374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1352996096-27374-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> local_amp_id is already set in l2cap_connect() which is called several
> lines above.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    1 -
>  1 file changed, 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


