Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329813983-26707-3-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329813983-26707-3-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 21 Feb 2012 13:07:53 +0200
Message-ID: <CABBYNZLUY4exfmnVN6M7D-V3XqHmFhrq-oQZMckAsg8hy1v3AA@mail.gmail.com>
Subject: Re: [PATCH obexd 2/9] client: fix obc_session_get_buffer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 21, 2012 at 10:46 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Size 0 should be reported if no transfer exists. Some existing code
> relies on this behavior.
> ---
>  client/session.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index 85f466a..e113d1f 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -1128,8 +1128,12 @@ const char *obc_session_get_buffer(struct obc_session *session, size_t *size)
>        const char *buf;
>
>        transfer = obc_session_get_transfer(session);
> -       if (transfer == NULL)
> +       if (transfer == NULL) {
> +               if (size != NULL)
> +                       *size = 0;
> +
>                return NULL;
> +       }
>
>        buf = obc_transfer_get_buffer(transfer, size);
>
> --
> 1.7.6.5

Nice catch, ack.

-- 
Luiz Augusto von Dentz
