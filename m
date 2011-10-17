Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv3 2/4] add fixed channel definitions
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 17 Oct 2011 08:29:26 -0700
In-Reply-To: <1318839662-13609-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318839662-13609-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1318839662-13609-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318865368.15441.94.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>  lib/l2cap.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/l2cap.h b/lib/l2cap.h
> index 47b3dc3..3880551 100644
> --- a/lib/l2cap.h
> +++ b/lib/l2cap.h
> @@ -139,6 +139,11 @@ struct l2cap_conninfo {
>  
>  #define L2CAP_SDULEN_SIZE	2
>  
> +/* L2CAP fixed channels */
> +#define L2CAP_FC_L2CAP		0x02
> +#define L2CAP_FC_CONNLESS	0x04
> +#define L2CAP_FC_A2MP		0x08
> +

please get these added to bluez.git first and then send exactly the same
patch to add them here (once accepted).

Also please add also LE, LE signaling, AMP test manager as well. Just
make sure the list is complete according to 4.0 specification and
assigned numbers list.

Regards

Marcel


