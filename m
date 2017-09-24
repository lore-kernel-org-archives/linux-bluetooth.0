Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170924122814.29703-1-tduszyns@gmail.com>
References: <20170924122814.29703-1-tduszyns@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 24 Sep 2017 20:59:28 +0300
Message-ID: <CABBYNZK=QTw=O481k_PyEmHw5n-UbuuT2N4=325VRonpTh6=DA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc: fix typo
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomasz,

On Sun, Sep 24, 2017 at 3:28 PM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
> s/parser/parsed
> ---
>  doc/advertising-api.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index 36fe130d9..e432fb074 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -107,7 +107,7 @@ Methods             RegisterAdvertisement(object advertisement, dict options)
>                         InvalidLength error indicates that the data
>                         provided generates a data packet which is too long.
>
> -                       The properties of this object are parser when it is
> +                       The properties of this object are parsed when it is
>                         registered, and any changes are ignored.
>
>                         If the same object is registered twice it will result in
> --
> 2.14.1

Could you please merge all the typo fixes?

-- 
Luiz Augusto von Dentz
