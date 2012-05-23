Return-Path: <cyrus@holtmann.org>
Message-ID: <1337777195.15105.78.camel@aeonflux>
Subject: Re: [PATCHv3] Bluetooth: Define L2CAP conf continuation flag
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 23 May 2012 14:46:35 +0200
In-Reply-To: <1337777047-13515-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337771107.15105.74.camel@aeonflux>
	 <1337777047-13515-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Define Continuation flag which the only flag used from Flags field
> in L2CAP Configuration Request and Response.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 +++
>  net/bluetooth/l2cap_core.c    |   10 +++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 7bc4019..5de6912 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -271,6 +271,9 @@ struct l2cap_conf_rsp {
>  #define L2CAP_CONF_PENDING	0x0004
>  #define L2CAP_CONF_EFS_REJECT	0x0005
>  
> +/* configuration req/rsp continuation flag */
> +#define L2CAP_CONF_FLAG_CONTINUATION	1
> +

I changed the 1 into 0x0001 and then applied your patch to
bluetooth-next tree.

Regards

Marcel


