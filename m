Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410866009-2417-1-git-send-email-luiz.dentz@gmail.com>
References: <1410866009-2417-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 22 Sep 2014 19:16:41 +0300
Message-ID: <CABBYNZLmY1GbqYekRpg-EgUo2fcRA1ka74fLZv=-+_-wmQ86kg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/obex-api: Mark DatabaseIdentifier as optional
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 16, 2014 at 2:13 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> There is no need to declare DatabaseIdentifier in case it is invalid
> since by omitting it should indicate GetVersion is not supported.
> ---
>  doc/obex-api.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index 31afc74..f80ef39 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -491,12 +491,10 @@ Properties        string Folder [readonly]
>
>                         Current folder.
>
> -               string DatabaseIdentifier [readonly]
> +               string DatabaseIdentifier [readonly, optional]
>
>                         128 bits persistent identifier.
>
> -                       Value '0' shall be considered as not supported.
> -
>
>  Synchronization hierarchy
>  =========================
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz
