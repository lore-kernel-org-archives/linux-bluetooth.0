Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393418420-8461-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZK9sq8arr71uvUxSg654ke0uZNHQfXxNvyLRz-iRFy8wA@mail.gmail.com>
	<1393418420-8461-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 26 Feb 2014 18:27:23 +0100
Message-ID: <CABBYNZJ+JDt3Wqv-NedOEzaJgL2jLe2816RDKF+rucTJmxjXtw@mail.gmail.com>
Subject: Re: [PATCHv2] android/avrcp: Fix passing wrong len
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 26, 2014 at 1:40 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> When handling vendor dependent PDUs len was passed in wrong order to
> callback function. It is really wrong to pass such a parameter and
> expect that callbacks would handle it.
> ---
>  android/avrcp-lib.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index c78881f..2e5a565 100644
> --- a/android/avrcp-lib.c
> +++ b/android/avrcp-lib.c
> @@ -128,14 +128,14 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
>         const struct avrcp_control_handler *handler;
>         struct avrcp_header *pdu = (void *) operands;
>         uint32_t company_id = ntoh24(pdu->company_id);
> +       uint16_t params_len = ntohs(pdu->params_len);
>
>         if (company_id != IEEEID_BTSIG) {
>                 *code = AVC_CTYPE_NOT_IMPLEMENTED;
>                 return 0;
>         }
>
> -       DBG("AVRCP PDU 0x%02X, len 0x%04X", pdu->pdu_id,
> -                                               ntohs(pdu->params_len));
> +       DBG("AVRCP PDU 0x%02X, len 0x%04X", pdu->pdu_id, params_len);
>
>         pdu->packet_type = 0;
>         pdu->rsvd = 0;
> @@ -163,10 +163,12 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
>                 goto reject;
>         }
>
> -       *code = handler->func(session, transaction, &pdu->params_len,
> +       *code = handler->func(session, transaction, &params_len,
>                                         pdu->params, session->control_data);
>
> -       return AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
> +       pdu->params_len = htons(params_len);
> +
> +       return AVRCP_HEADER_LENGTH + params_len;
>
>  reject:
>         pdu->params_len = htons(1);
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
