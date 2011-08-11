Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313001887-29644-1-git-send-email-syamsidhardh@gmail.com>
References: <1313001887-29644-1-git-send-email-syamsidhardh@gmail.com>
Date: Thu, 11 Aug 2011 11:26:06 +0300
Message-ID: <CABBYNZLbg14wLrG2zge_OvgtvcQULdBq-kqt+MOi7ufh6SHrEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix crash when disconnecting the a2dp
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Syam Sidhardhan <syamsidhardh@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 10, 2011 at 9:44 PM, Syam Sidhardhan <syamsidhardh@gmail.com> wrote:
> When we disconnect the a2dp Headset by immediate power off and soon if we
> initiate a disconnection from our side, a crash is occurring. This is
> happening because of the disconnect_timeout coming after freeing the session.
> ---
>  audio/avdtp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index 76526b6..d8d9d7e 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -690,7 +690,7 @@ static void set_disconnect_timer(struct avdtp *session)
>                remove_disconnect_timer(session);
>
>        if (session->device_disconnect) {
> -               g_idle_add(disconnect_timeout, session);
> +               session->dc_timer = g_idle_add(disconnect_timeout, session);
>                return;
>        }
>

Nice catch, ack.

-- 
Luiz Augusto von Dentz
