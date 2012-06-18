Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339889570.20079.7.camel@sirocco.config>
References: <1339889570.20079.7.camel@sirocco.config>
Date: Mon, 18 Jun 2012 11:44:16 +0300
Message-ID: <CABBYNZJ0-CDhC6WQJ-k20yCeJRiHR7c__tV6xg9-xphcDdEg_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] fakehid: Disconnect from PS3 remote after 10 mins
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sun, Jun 17, 2012 at 2:32 AM, Bastien Nocera <hadess@hadess.net> wrote:
> After 10 minutes, disconnect the PS3 BD Remote to avoid draining its
> battery. This is consistent with its behaviour on the PS3.
>
> Original patch by Ruslan N. Marchenko <rufferson@gmail.com>
> ---
>  input/device.h  |    1 +
>  input/fakehid.c |   36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/input/device.h b/input/device.h
> index ff52967..d8baa2c 100644
> --- a/input/device.h
> +++ b/input/device.h
> @@ -33,6 +33,7 @@ struct fake_input {
>        int             uinput;         /* uinput socket */
>        int             rfcomm;         /* RFCOMM socket */
>        uint8_t         ch;             /* RFCOMM channel number */
> +       guint           timeout_id;     /* Disconnect timeout ID */
>        gboolean        (*connect) (struct input_conn *iconn, GError **err);
>        int             (*disconnect) (struct input_conn *iconn);
>        void            *priv;
> diff --git a/input/fakehid.c b/input/fakehid.c
> index 3181538..a125356 100644
> --- a/input/fakehid.c
> +++ b/input/fakehid.c
> @@ -44,6 +44,9 @@
>  #include "fakehid.h"
>  #include "uinput.h"
>
> +/* Timeout to get the PS3 remote disconnected, in seconds */
> +#define PS3_REMOTE_TIMEOUT 10 * 60
> +
>  enum ps3remote_special_keys {
>        PS3R_BIT_PS = 0,
>        PS3R_BIT_ENTER = 3,
> @@ -141,6 +144,20 @@ static unsigned int ps3remote_keymap[] = {
>        [0xff] = KEY_MAX,
>  };
>
> +static gboolean ps3_remote_timeout_cb(gpointer user_data);
> +
> +static void ps3remote_set_timeout(struct fake_input *fake, gboolean enable)
> +{
> +       if (enable) {
> +               fake->timeout_id = g_timeout_add_seconds(PS3_REMOTE_TIMEOUT, ps3_remote_timeout_cb, fake);
> +       } else {
> +               if (fake->timeout_id > 0) {
> +                       g_source_remove(fake->timeout_id);
> +                       fake->timeout_id = 0;
> +               }
> +       }
> +}

It doesn't really need to remove/add the timeout separately, upon
event just reset the idle timeout.

-- 
Luiz Augusto von Dentz
