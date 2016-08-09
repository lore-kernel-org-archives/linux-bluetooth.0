Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1470652860-11461-1-git-send-email-luiz.dentz@gmail.com>
References: <1470652860-11461-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Aug 2016 11:31:32 +0300
Message-ID: <CABBYNZKKoTx7eL4_jAMpk097Wv+YuKx2kp0aC3iuY+m=M6=OyA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/service: Fix setting connecting state
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 8, 2016 at 1:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If the profile don't implement .accept callback it means it cannot
> connect in this mode, which is normally used for GATT profiles, so the
> code shall not assume the profile will be connecting and instead just
> return an error.
> ---
>  src/service.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/service.c b/src/service.c
> index 0da14ab..f387fc4 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -197,7 +197,7 @@ int service_accept(struct btd_service *service)
>         }
>
>         if (!service->profile->accept)
> -               goto done;
> +               return -ENOSYS;
>
>         err = service->profile->accept(service);
>         if (!err)
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz
