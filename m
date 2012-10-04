Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349356447-8369-2-git-send-email-chanyeol.park@samsung.com>
References: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
	<1349356447-8369-2-git-send-email-chanyeol.park@samsung.com>
Date: Thu, 4 Oct 2012 17:11:59 +0300
Message-ID: <CABBYNZ+X0WOCEotv-hiJDCcPiknUFXh_PSxQvNvW0ajKoB1Srg@mail.gmail.com>
Subject: Re: [PATCH 3/4] audio: Remove redundant procedure when a2dp connect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

On Thu, Oct 4, 2012 at 4:14 PM,  <chanyeol.park@samsung.com> wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
>
> This patch fixes the bug that a2dp connection failure is handled like XCASE
> when remote host is down.
> ---
>  audio/avdtp.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index 54b3d08..e450ec7 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -2481,7 +2481,8 @@ failed:
>                         avdtp_sep_set_state(session, stream->lsep,
>                                                 AVDTP_STATE_IDLE);
>         } else
> -               connection_lost(session, EIO);
> +               connection_lost(session, err->code == EHOSTDOWN ?
> +                                               EHOSTDOWN : EIO);
>  }

This rely on err being set which may not always be the case since
there are other places calling goto failed.


-- 
Luiz Augusto von Dentz
