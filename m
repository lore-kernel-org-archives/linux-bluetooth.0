Return-Path: <cyrus@holtmann.org>
Message-ID: <1327310352.1955.93.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove old unused lock
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 23 Jan 2012 10:19:12 +0100
In-Reply-To: <1327309863-12696-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327309863-12696-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index f6d5134..c21e37a 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -544,7 +544,6 @@ struct l2cap_conn {
>  	struct smp_chan *smp_chan;
>  
>  	struct list_head chan_l;
> -	struct mutex	chan_lock;
>  };
>  
>  #define L2CAP_INFO_CL_MTU_REQ_SENT	0x01

so if this one is not used, how do we protect any changes at all. I am
kinda nervous now that our L2CAP is broken. Please start looking into
fixing this and send a patch series that I can review as a whole and see
how it progresses.

Regards

Marcel


