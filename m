Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170925155352.21203-1-tduszyns@gmail.com>
References: <20170925155352.21203-1-tduszyns@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Sep 2017 15:07:26 +0300
Message-ID: <CABBYNZLE2aJ2ehn+AY=v3_j+y0s5xG8wPTV8Gd_2X-Sx1n6fFQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc: fix typos
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomasz,

On Mon, Sep 25, 2017 at 6:53 PM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
> s/parser/parsed
> s/prevously/previously
> ---
>  doc/advertising-api.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index 36fe130d9..7cc183043 100644
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
> @@ -124,7 +124,7 @@ Methods             RegisterAdvertisement(object advertisement, dict options)
>                 UnregisterAdvertisement(object advertisement)
>
>                         This unregisters an advertisement that has been
> -                       prevously registered.  The object path parameter must
> +                       previously registered.  The object path parameter must
>                         match the same value that has been used on registration.
>
>                         Possible errors: org.bluez.Error.InvalidArguments
> --
> 2.14.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
