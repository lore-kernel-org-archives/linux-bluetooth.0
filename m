Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1447707493-9342-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1447707493-9342-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Date: Tue, 17 Nov 2015 16:07:43 +0200
Message-ID: <CABBYNZKAyHOZNR-uHFhRDhY1fyAEXc=R=O3XuFGSiOfr2pGA5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc/adapter-api: Use correct signal name
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Nov 16, 2015 at 10:58 PM, Łukasz Rymanowski
<lukasz.rymanowski@codecoup.pl> wrote:
> ---
>  doc/adapter-api.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index cf7169f..284214e 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -167,7 +167,7 @@ Properties  string Address [readonly]
>                         value will fail.
>
>                         When changing the Powered property the new state of
> -                       this property will be updated via a PropertyChanged
> +                       this property will be updated via a PropertiesChanged
>                         signal.
>
>                         For any new adapter this settings defaults to false.
> --
> 2.5.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
