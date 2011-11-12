Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/8] Bluetooth: Rename smp_key_size to enc_size
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 13 Nov 2011 08:35:44 +0900
In-Reply-To: <1320973436-13399-4-git-send-email-vinicius.gomes@openbossa.org>
References: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1320973436-13399-4-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321140947.15441.446.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> This makes clear that this is the size of the key used to
> encrypt the link.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/smp.h |    2 +-
>  net/bluetooth/smp.c         |   18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
> index 15b97d5..cf3aab0 100644
> --- a/include/net/bluetooth/smp.h
> +++ b/include/net/bluetooth/smp.h
> @@ -123,7 +123,7 @@ struct smp_chan {
>  	u8              rrnd[16]; /* SMP Pairing Random (remote) */
>  	u8		pcnf[16]; /* SMP Pairing Confirm */
>  	u8		tk[16]; /* SMP Temporary Key */
> -	u8		smp_key_size;
> +	u8		enc_size;

if we wanna be really clear, then enc_key_size would be the better name.

Regards

Marcel


