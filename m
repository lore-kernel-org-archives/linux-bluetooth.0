Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340878959-1343-5-git-send-email-michal.labedzki@tieto.com>
References: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
	<1340878959-1343-5-git-send-email-michal.labedzki@tieto.com>
Date: Thu, 28 Jun 2012 13:42:03 +0300
Message-ID: <CABBYNZKyhFfRHpJqxSw5emS2isKJ5UTm__v6a-2gqy-dbGM8CA@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] AVRCP: Convert spaces to tabs
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi,
	johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Jun 28, 2012 at 1:22 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Fix coding style issue.
> ---
>  audio/avrcp.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index fec4e6c..4c545e3 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -1125,17 +1125,17 @@ err_metadata:
>
>  size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
>  {
> -    struct avrcp_header *pdu = (void *) operands;
> -    uint32_t company_id = get_company_id(pdu->company_id);
> +       struct avrcp_header *pdu = (void *) operands;
> +       uint32_t company_id = get_company_id(pdu->company_id);
>
> -    *code = AVC_CTYPE_REJECTED;
> -    pdu->params_len = htons(1);
> -    pdu->params[0] = STATUS_INTERNAL_ERROR;
> +       *code = AVC_CTYPE_REJECTED;
> +       pdu->params_len = htons(1);
> +       pdu->params[0] = STATUS_INTERNAL_ERROR;
>
> -    DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
> -            pdu->pdu_id, company_id, pdu->params_len);
> +       DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
> +               pdu->pdu_id, company_id, pdu->params_len);
>
> -    return AVRCP_HEADER_LENGTH + 1;
> +       return AVRCP_HEADER_LENGTH + 1;
>  }
>
>  static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
> --
> on behalf of ST-Ericsson

Applied, thanks.

-- 
Luiz Augusto von Dentz
