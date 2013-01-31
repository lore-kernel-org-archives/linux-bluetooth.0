Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359640112-10920-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
References: <1359640112-10920-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Date: Thu, 31 Jan 2013 08:36:52 -0600
Message-ID: <CABBYNZJffX-i45dnSiqnjwnTPmi4NC-y41WzcWcFHfa=Ajvnbg@mail.gmail.com>
Subject: Re: [PATCH] avctp: Move state change callbacks
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, Jan 31, 2013 at 7:48 AM, Alexandros Antonopoulos
<alexandros.antonopoulos@oss.bmw-carit.de> wrote:
> In avctp_set_change the callbacks are happening before the switch.
> The callbacks can change the state so they should happen at the end
> of the function and not before the switch.
> For example when the state is AVCTP_STATE_CONNECTED the
> avrcp.c:state_changed callback creates a browsing channel which in
> turn is destroyed immediately a few lines below in the
> AVCTP_STATE_CONNECTED case.
>
> ---
>  profiles/audio/avctp.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 41e2f46..2515505 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -473,13 +473,6 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
>                 return;
>         }
>
> -       session->state = new_state;
> -
> -       for (l = callbacks; l != NULL; l = l->next) {
> -               struct avctp_state_callback *cb = l->data;
> -               cb->cb(dev, old_state, new_state, cb->user_data);
> -       }
> -
>         switch (new_state) {
>         case AVCTP_STATE_DISCONNECTED:
>                 DBG("AVCTP Disconnected");
> @@ -505,6 +498,14 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
>                 error("Invalid AVCTP state %d", new_state);
>                 return;
>         }
> +
> +       session->state = new_state;
> +
> +       for (l = callbacks; l != NULL; l = l->next) {
> +               struct avctp_state_callback *cb = l->data;
> +               cb->cb(dev, old_state, new_state, cb->user_data);
> +       }
> +
>  }
>
>  static int avctp_send(struct avctp_channel *control, uint8_t transaction,
> --
> 1.8.1.2

I would like to avoid calling the callback after the session is
destroyed, in fact I will revert
53d3fc3fad5152167458625ad2acf19070cdf26a and move the check to
session_browsing_cb that should fix the problem for good.


--
Luiz Augusto von Dentz
