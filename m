Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1466762356-4171-1-git-send-email-szymon.janc@codecoup.pl>
References: <1466762356-4171-1-git-send-email-szymon.janc@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jun 2016 14:44:32 +0300
Message-ID: <CABBYNZJUnGZsjvDAig7_V9=aT_-K3DSAC2QsgwK-GxXkohXVcg@mail.gmail.com>
Subject: Re: [PATCH] doc/mgmt-api: Add Authentication Failure code to
 Disconnected event
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jun 24, 2016 at 12:59 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> This error code will be set if authentication (enabling encryption)
> failed with 'PIN or Key Missing' error. This will allow userspace
> to take actions (eg ask user for consent for rebonding) when remote
> device lost bond.
> ---
>  doc/mgmt-api.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 8393bbf..9384f70 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3061,6 +3061,7 @@ Device Disconnected Event
>                 1       Connection timeout
>                 2       Connection terminated by local host
>                 3       Connection terminated by remote host
> +               4       Connection terminated due to authentication failure
>
>         Note that the local/remote distinction just determines which side
>         terminated the low-level connection, regardless of the
> --
> 2.7.4

Looks good, lets get the kernel patch merged first then I will merge this one.

-- 
Luiz Augusto von Dentz
