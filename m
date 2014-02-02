Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391157222-24504-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391157222-24504-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sun, 2 Feb 2014 08:03:34 -0800
Message-ID: <CABBYNZ+-mc_u+ihj_FB5e89TNmBgZvyWxW4vwMCuFDh1_TjCJg@mail.gmail.com>
Subject: Re: [PATCH] avrcp: Fix wrong pointer check
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 31, 2014 at 12:33 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> There is wrong assumption that handler might be NULL while it is a
> pointer to a struct table so check instead for struct members. This
> fixes accessing wrong memory.
> ---
>  profiles/audio/avrcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index df88138..5030ce1 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1673,7 +1673,7 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
>                         break;
>         }
>
> -       if (!handler || handler->code != *code) {
> +       if (!handler->code || handler->code != *code) {

The code checks if  session->control_handlers is initialized and Im
not sure what is the invalid memory access you are talking about since
handle->code is no a pointer, I do agree that we should probably drop
the second check for the handler in the lines bellow.

-- 
Luiz Augusto von Dentz
