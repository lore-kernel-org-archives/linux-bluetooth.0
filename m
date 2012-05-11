Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336707680-25287-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1336707680-25287-1-git-send-email-paulo.alcantara@openbossa.org>
Date: Fri, 11 May 2012 06:31:15 -0700
Message-ID: <CABBYNZLqwJR0NB-id4obX08qsxNPhh=iOuN-bko7NBzAsZEG_Q@mail.gmail.com>
Subject: Re: [PATCH] event: Remove unused variable
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Thu, May 10, 2012 at 8:41 PM, Paulo Alcantara
<paulo.alcantara@openbossa.org> wrote:
> "srcaddr" variable is not used for anything else in
> btd_event_remote_name() function. So, remove it for now.
> ---
>  src/event.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/src/event.c b/src/event.c
> index 514744b..8ecb942 100644
> --- a/src/event.c
> +++ b/src/event.c
> @@ -318,7 +318,6 @@ void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
>  void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
>  {
>        struct btd_adapter *adapter;
> -       char srcaddr[18];
>        struct btd_device *device;
>        struct remote_dev_info *dev_info;
>
> @@ -339,8 +338,6 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
>        if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
>                return;
>
> -       ba2str(local, srcaddr);
> -
>        dev_info = adapter_search_found_devices(adapter, peer);
>        if (dev_info) {
>                g_free(dev_info->name);
> --
> 1.7.7.6

I believe the correct prefix here would be core, IMO event is too
generic. Other than that the patch looks good.


-- 
Luiz Augusto von Dentz
