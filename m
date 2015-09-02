Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1441026307-27322-1-git-send-email-luiz.dentz@gmail.com>
References: <1441026307-27322-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 2 Sep 2015 14:41:27 +0300
Message-ID: <CABBYNZKEGnRPxuKwvm7vy=5SwUPEEQqYbOgjEn_S9hiKMsOn3Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] TODO: Add item for agent queueing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 31, 2015 at 4:05 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  TODO | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/TODO b/TODO
> index 2945392..8c710ef 100644
> --- a/TODO
> +++ b/TODO
> @@ -61,6 +61,12 @@ General
>    Priority: Low
>    Complexity: C2
>
> +- Add queueing support for src/agent.c, currently if there is any request
> +  pending the code fail with error EBUSY which is very inconvenient.
> +
> +  Priority: Low
> +  Complexity: C2
> +
>  Low Energy
>  ==========
>
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
