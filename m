Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1458737729-4233-1-git-send-email-luiz.dentz@gmail.com>
References: <1458737729-4233-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 24 Mar 2016 15:52:16 +0200
Message-ID: <CABBYNZLhO-jWO2RLownxsnGwaen2=9+h-rr=ejHvKmoCv32F-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] audio/avdtp: Only set disconnect timer if connected
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 23, 2016 at 2:55 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If the session is not connected it makes no sense to enable the
> disconnect timer.
> ---
>  profiles/audio/avdtp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 52ee767..78e7b4d 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1171,7 +1171,12 @@ void avdtp_unref(struct avdtp *session)
>         if (session->ref > 0)
>                 return;
>
> -       set_disconnect_timer(session);
> +       if (session->state == AVDTP_SESSION_STATE_CONNECTED) {
> +               set_disconnect_timer(session);
> +               return;
> +       }
> +
> +       connection_lost(session, ECONNABORTED);
>  }
>
>  struct avdtp *avdtp_ref(struct avdtp *session)
> --
> 2.5.0

Applied.


-- 
Luiz Augusto von Dentz
