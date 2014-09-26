Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1411467474-22288-1-git-send-email-luiz.dentz@gmail.com>
References: <1411467474-22288-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 26 Sep 2014 11:19:17 +0300
Message-ID: <CABBYNZKPuyLHCSSzqSZMzQjMRiM81aL6QuByi5G8OznA4OREBQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/obex-api: Split FilterBy into FilterAll and FilterAny
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 23, 2014 at 1:17 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes a simpler API and document the fact that they cannot be used
> together.
> ---
>  doc/obex-api.txt | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index f80ef39..a39abc0 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -473,14 +473,19 @@ Filter:           string Format:
>
>                         Possible values can be query with ListFilterFields.
>
> -               array{string} FilterBy:
> +               array{string} FilterAll:
>
> -                       Filter items by fields. Default do not filter by
> -                       fields.
> +                       Filter items by fields using AND logic, cannot be used
> +                       together with FilterAny.
>
> -                       Possible values can be query with ListFilterFields
> -                       excluding the first item that must be either '&' or
> -                       '|' that apply AND or OR logic respectively.
> +                       Possible values can be query with ListFilterFields.
> +
> +               array{string} FilterAny:
> +
> +                       Filter items by fields using OR logic, cannot be used
> +                       together with FilterAll.
> +
> +                       Possible values can be query with ListFilterFields.
>
>                 bool ResetNewMissedCalls
>
> --
> 1.9.3

Applied.


-- 
Luiz Augusto von Dentz
