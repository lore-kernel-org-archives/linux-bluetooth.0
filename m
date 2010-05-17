Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 May 2010 18:06:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Avoid multiple inclusions of adapter.h
Message-ID: <20100517160658.GA3788@jh-x301>
References: <1273747136-8816-1-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1273747136-8816-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 13, 2010, Jose Antonio Santos Cadenas wrote:
> ---
>  src/adapter.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/src/adapter.h b/src/adapter.h
> index 9b4ce10..8812ed8 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -22,6 +22,9 @@
>   *
>   */
>  
> +#ifndef __ADAPTER_H__
> +#define __ADAPTER_H__
> +
>  #include <bluetooth/bluetooth.h>
>  #include <dbus/dbus.h>
>  #include <glib.h>
> @@ -183,3 +186,5 @@ struct btd_adapter_ops {
>  int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
>  void btd_adapter_cleanup_ops(struct btd_adapter_ops *btd_adapter_ops);
>  int adapter_ops_setup(void);
> +
> +#endif /* __ADAPTER_H__ */

Lack of these defines is actually intentional for headsers which aren't
part of any public library. The intention is to keep the header
dependencies simple and get errors as soon as there's a circular
dependency between them.

Johan
