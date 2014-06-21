Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1403267016-28422-8-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403267016-28422-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1403267016-28422-8-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Sat, 21 Jun 2014 10:40:30 +0200
Message-ID: <CAJCsO8fQw0YR3tV95AA=1H2DMOm8CKUkTZS2cmZh8VLAUhEn+g@mail.gmail.com>
Subject: Re: [PATCH_v2 7/7] anrdroid/client/health: Cache fd and close on
 channel disconnection
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

I was checking your patches against latest PTS and it seems I was able
to PASS some additional HDP tests.

Since patched are not upstreamed we should still run tests once git
tree is updated.

BR,
Sebastian

On 20 June 2014 14:23, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> Cache fd and close them on channel disconnect or destroy notification.
> When running PTS tests it is expecting to close all data channels before
> exiting test case.
> ---
>  android/client/if-hl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/android/client/if-hl.c b/android/client/if-hl.c
> index 557a205..5940526 100644
> --- a/android/client/if-hl.c
> +++ b/android/client/if-hl.c
> @@ -17,6 +17,7 @@
>
>  #include<stdio.h>
>  #include<ctype.h>
> +#include<unistd.h>
>
>  #include<hardware/bluetooth.h>
>  #include<hardware/bt_hl.h>
> @@ -52,6 +53,7 @@ SINTMAP(bthl_channel_state_t, -1, "(unknown)")
>  ENDMAP
>
>  const bthl_interface_t *if_hl = NULL;
> +static int fd_list[256] = {-1};
>
>  static void app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
>  {
> @@ -69,6 +71,13 @@ static void channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
>                         "channel_id=%d channel_state=%s fd=%d\n", __func__,
>                         app_id, bt_bdaddr_t2str(bd_addr, addr), mdep_cfg_index,
>                         channel_id, bthl_channel_state_t2str(state), fd);
> +
> +       if (state == BTHL_CONN_STATE_CONNECTED)
> +               fd_list[channel_id] = fd;
> +
> +       if (state == BTHL_CONN_STATE_DISCONNECTED ||
> +                       state == BTHL_CONN_STATE_DESTROYED)
> +               close(fd_list[channel_id]);
>  }
>
>  static bthl_callbacks_t hl_cbacks = {
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Seb/
