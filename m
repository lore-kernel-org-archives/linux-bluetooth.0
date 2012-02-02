Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328182415-14860-1-git-send-email-jaganath.k@samsung.com>
References: <1328182415-14860-1-git-send-email-jaganath.k@samsung.com>
Date: Thu, 2 Feb 2012 09:16:41 -0800
Message-ID: <CABBYNZLT1ynsVJ3U6bujAn_CgKVCGSfF7ffmw=iP4W90UV6kUw@mail.gmail.com>
Subject: Re: [PATCH obexd 2/4] gobex: Fix ABORT request not processing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Feb 2, 2012 at 3:33 AM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> G_OBEX_OP_ABORT is defined as 0x7f but error checking of opcode is
> done for greater than 0x1f. So abort request is simply ignored.
> ---
>  gobex/gobex.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index 0853a9b..c1e7dc4 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -1163,7 +1163,7 @@ static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
>        } else {
>                opcode = obex->rx_last_op;
>                /* Unexpected response -- fail silently */
> -               if (opcode > 0x1f && opcode < 0xff) {
> +               if (opcode > 0x1f && opcode != G_OBEX_OP_ABORT) {
>                        obex->rx_data = 0;
>                        return TRUE;
>                }
> --
> 1.7.1

Ack

-- 
Luiz Augusto von Dentz
