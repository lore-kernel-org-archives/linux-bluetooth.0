Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391171777-27512-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391171777-27512-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sun, 2 Feb 2014 07:50:29 -0800
Message-ID: <CABBYNZ+YB2AL0iqk=FTwMR4ksdaQEBfYSUuhRJBrT8qBuzy8DA@mail.gmail.com>
Subject: Re: [PATCH 1/2] avrcp: Fix printing incorrect order for avrcp control header
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 31, 2014 at 4:36 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  profiles/audio/avrcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 5030ce1..bc5cab3 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1658,7 +1658,7 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
>         }
>
>         DBG("AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
> -                       pdu->pdu_id, company_id, pdu->params_len);
> +                       pdu->pdu_id, company_id, ntohs(pdu->params_len));
>
>         pdu->packet_type = 0;
>         pdu->rsvd = 0;
> @@ -1755,7 +1755,7 @@ size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
>         pdu->params[0] = AVRCP_STATUS_INTERNAL_ERROR;
>
>         DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
> -                               pdu->pdu_id, company_id, pdu->params_len);
> +                       pdu->pdu_id, company_id, ntohs(pdu->params_len));
>
>         return AVRCP_HEADER_LENGTH + 1;
>  }
> --
> 1.8.3.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
