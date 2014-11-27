Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417026903-29469-1-git-send-email-rakesh.mk@samsung.com>
References: <1417026903-29469-1-git-send-email-rakesh.mk@samsung.com>
Date: Thu, 27 Nov 2014 09:44:29 +0100
Message-ID: <CABBYNZK-SRe9bO+3Xmb2vdiJQd8qThAiZf9T6hD1nDgFLjoYgg@mail.gmail.com>
Subject: Re: [PATCH] audio/avdtp: Session reset after linkloss
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Rakesh M K <rakesh.mk@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 26, 2014 at 7:35 PM, Rakesh M K <rakesh.mk@samsung.com> wrote:
> During link loss, previous AVDTP session is not freed due to wrong
> session "ref" count. When ever the START_CMD received from the
> remote headset, avdtp session ref count will be increased.
> Because of this, new A2DP connection will fail.
> This issue is handled with AVDTP session free in case of linkloss (EIO 5)
> irrespective of ref count.
> //If bluez receives START_CMD twice and ref count increased accordingly
> Sep 19 13:54:46 localhost daemon.debug bluetoothd[661]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received START_CMD
> Sep 19 13:54:52 localhost daemon.debug bluetoothd[661]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received START_CMD
> //During session disconnection due to link loss, session is not freed.
> Sep 19 13:54:59 localhost daemon.debug bluetoothd[661]: profiles/audio/avdtp.c:session_cb()
> Sep 19 13:54:59 localhost daemon.debug bluetoothd[661]: profiles/audio/avdtp.c:connection_lost() Disconnected from 38:C0:96:29:74:23 with erro
> //Since proevious session is not freed, new AVDTP connection request is refused.
> Sep 19 13:55:18 localhost daemon.debug bluetoothd[661]: profiles/audio/avdtp.c:avdtp_confirm_cb() AVDTP: incoming connect from 38:C0:96:29:74:23
> Sep 19 13:55:18 localhost daemon.err bluetoothd[661]: Refusing unexpected connect from 38:C0:96:29:74:23
> ---
>  profiles/audio/avdtp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index ba5f0e5..b14e647 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1157,7 +1157,7 @@ static void connection_lost(struct avdtp *session, int err)
>
>         avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
>
> -       if (session->ref > 0)
> +       if (err != EIO && session->ref > 0) /* link loss*/
>                 return;
>
>         server->sessions = g_slist_remove(server->sessions, session);
> --
> 1.7.9.5

We need to find and fix the extra reference then, otherwise we may
free the session while someone is holding the pointer which may lead
to a crash.


-- 
Luiz Augusto von Dentz
