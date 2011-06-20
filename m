Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308563100-18917-3-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
	<1308563100-18917-3-git-send-email-nami.li@atheros.com>
Date: Mon, 20 Jun 2011 12:58:40 +0300
Message-ID: <BANLkTim-a8RHeThJ10s8dsN+3OXwFD5aMQ@mail.gmail.com>
Subject: Re: [PATCH obexd 03/14] Add psm member in obex_service_driver struct.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Nami <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, haijun@qca.qualcomm.com,
	yongli@qca.qualcomm.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jun 20, 2011 at 12:44 PM, Nami <nami.li@atheros.com> wrote:
> ---
>  src/service.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/src/service.h b/src/service.h
> index a844885..313b1f2 100644
> --- a/src/service.h
> +++ b/src/service.h
> @@ -25,6 +25,7 @@ struct obex_service_driver {
>        const char *name;
>        uint16_t service;
>        uint8_t channel;
> +       uint16_t psm;
>        const uint8_t *target;
>        unsigned int target_size;
>        const uint8_t *who;
> --
> 1.7.1
>
> --

This one alone would generate a warning which is not nice if cherry
picked, so perhaps you should merge with other code that really uses
it.



-- 
Luiz Augusto von Dentz
