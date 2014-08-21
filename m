Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408543612-5615-1-git-send-email-vcgomes@gmail.com>
References: <1408543612-5615-1-git-send-email-vcgomes@gmail.com>
Date: Thu, 21 Aug 2014 10:54:41 +0300
Message-ID: <CABBYNZKan=WEK9aOOM6jgdSUJAMRB1tkhznpDsH=FP_mD80RUA@mail.gmail.com>
Subject: Re: [PATCH] audio/avdtp: Fix invalid reference counting
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vcgomes@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Aug 20, 2014 at 5:06 PM, Vinicius Costa Gomes <vcgomes@gmail.com> wrote:
> If the AVDTP session is terminated via any other mean than
> 'connection_lost()' (the only place that btd_device_unref() was called),
> there was a dangling reference to the device.
>
> This can be easily reproduced by suspending the host while using an A2DP
> speaker. It has the very misleading effect of being unable to create the
> device when the system resumes.
> ---
>  profiles/audio/avdtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 8a7d1c0..ba5f0e5 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1135,6 +1135,7 @@ static void avdtp_free(void *data)
>
>         g_free(session->buf);
>
> +       btd_device_unref(session->device);
>         g_free(session);
>  }
>
> @@ -1160,7 +1161,6 @@ static void connection_lost(struct avdtp *session, int err)
>                 return;
>
>         server->sessions = g_slist_remove(server->sessions, session);
> -       btd_device_unref(session->device);
>         avdtp_free(session);
>  }
>
> --
> 2.0.4

Nice catch, Ive been hunting this very problem for some time.

Applied, thanks.


-- 
Luiz Augusto von Dentz
