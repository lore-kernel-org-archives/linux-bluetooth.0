Return-Path: <cyrus@holtmann.org>
Message-ID: <1353023666.1849.2.camel@aeonflux>
Subject: Re: [RFC 4/4] Bluetooth: Set local_amp_id after getting Phylink
 Completed evt
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 16 Nov 2012 08:54:26 +0900
In-Reply-To: <1352996096-27374-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1352996096-27374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1352996096-27374-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> local_amp_id is used in l2cap_physical_cfm and shall be set up
> before calling it.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/amp.c |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


