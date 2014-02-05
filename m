Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391420434-17873-1-git-send-email-luiz.dentz@gmail.com>
References: <1391420434-17873-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 5 Feb 2014 11:37:01 +0200
Message-ID: <CABBYNZ+Rcp7HH_2SeJeFSVLY032aNzMZLM5Mbd-Lo31FzkhNTQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/AVRCP: Fix checking for handler pointer
 instead of pdu_id
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 3, 2014 at 11:40 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The code may not find a valid handler for the pdu_id, in that case the
> handler would not be NULL because the handlers table is not NULL
> terminated, instead the code should check if pdu_id really matches.
> ---
>  profiles/audio/avrcp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 12f7faa..4532d85 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1673,7 +1673,7 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
>                         break;
>         }
>
> -       if (!handler || handler->code != *code) {
> +       if (handler->pdu_id != pdu->pdu_id || handler->code != *code) {
>                 pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
>                 goto err_metadata;
>         }
> @@ -1734,12 +1734,12 @@ static size_t handle_browsing_pdu(struct avctp *conn,
>
>         for (handler = browsing_handlers; handler->pdu_id; handler++) {
>                 if (handler->pdu_id == pdu->pdu_id)
> -                       break;
> +                       goto done;
>         }
>
> -       if (handler == NULL || handler->func == NULL)
> -               return avrcp_browsing_general_reject(operands);
> +       return avrcp_browsing_general_reject(operands);
>
> +done:
>         session->transaction = transaction;
>         handler->func(session, pdu, transaction);
>         return AVRCP_BROWSING_HEADER_LENGTH + ntohs(pdu->param_len);
> --
> 1.8.4.2

Pushed.


-- 
Luiz Augusto von Dentz
