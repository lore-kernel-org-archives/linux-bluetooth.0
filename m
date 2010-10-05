Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: clean up rfcomm code
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1285923911-12902-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1285923911-12902-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 09:53:56 +0200
Message-ID: <1286265236.17473.26.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove dead code and unused rfcomm thread events
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  include/net/bluetooth/rfcomm.h |    5 -----
>  net/bluetooth/rfcomm/core.c    |   29 ++++++++++++++---------------
>  2 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
> index a140847..71047bc 100644
> --- a/include/net/bluetooth/rfcomm.h
> +++ b/include/net/bluetooth/rfcomm.h
> @@ -213,11 +213,6 @@ struct rfcomm_dlc {
>  #define RFCOMM_DEFER_SETUP  8
>  
>  /* Scheduling flags and events */
> -#define RFCOMM_SCHED_STATE  0
> -#define RFCOMM_SCHED_RX     1
> -#define RFCOMM_SCHED_TX     2
> -#define RFCOMM_SCHED_TIMEO  3
> -#define RFCOMM_SCHED_AUTH   4
>  #define RFCOMM_SCHED_WAKEUP 31

we had some big ambition to use these, but never did in the end or
realized that they are not needed. So I am fine with removing these.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


