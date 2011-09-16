Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316060497-4068-6-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1316060497-4068-6-git-send-email-lucas.demarchi@profusion.mobi>
Date: Fri, 16 Sep 2011 10:51:37 +0300
Message-ID: <CABBYNZJAmVEW=M8wS+UJWdB6Jy7XqfN2kCFMhi4rfCyKxt3X0w@mail.gmail.com>
Subject: Re: [PATCH 5/5] avrcp: get/set three-byte company-id
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	David Stockwell <dstockwell@frequency-one.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas and David,

On Thu, Sep 15, 2011 at 7:21 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> From: David Stockwell <dstockwell@frequency-one.com>
>
> ---
>  audio/avrcp.c |   35 ++++++++++++++++++++++++++---------
>  1 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 835249b..f962946 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -517,6 +517,28 @@ static const char *battery_status_to_str(enum battery_status status)
>        return NULL;
>  }
>
> +/*
> + * get_company_id:
> + *
> + * Get three-byte Company_ID from incoming AVRCP message
> + */
> +static uint32_t get_company_id(const uint8_t cid[3])
> +{
> +       return cid[0] << 16 | cid[1] << 8 | cid[2];
> +}
> +
> +/*
> + * set_company_id:
> + *
> + * Set three-byte Company_ID into outgoing AVRCP message
> + */
> +static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
> +{
> +       cid[0] = cid_in >> 16;
> +       cid[1] = cid_in >> 8;
> +       cid[2] = cid_in;
> +}
> +
>  static int avrcp_send_event(struct media_player *mp, uint8_t id, void *data)
>  {
>        uint8_t buf[AVRCP_HEADER_LENGTH + 9];
> @@ -532,9 +554,7 @@ static int avrcp_send_event(struct media_player *mp, uint8_t id, void *data)
>
>        memset(buf, 0, sizeof(buf));
>
> -       pdu->company_id[0] = IEEEID_BTSIG >> 16;
> -       pdu->company_id[1] = (IEEEID_BTSIG >> 8) & 0xFF;
> -       pdu->company_id[2] = IEEEID_BTSIG & 0xFF;
> +       set_company_id(pdu->company_id, IEEEID_BTSIG);
>
>        pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
>        pdu->params[0] = id;
> @@ -774,9 +794,8 @@ static uint8_t avrcp_handle_get_capabilities(struct media_player *mp,
>        switch (pdu->params[0]) {
>        case CAP_COMPANY_ID:
>                for (i = 0; i < G_N_ELEMENTS(company_ids); i++) {
> -                       pdu->params[2 + i * 3] = company_ids[i] >> 16;
> -                       pdu->params[3 + i * 3] = (company_ids[i] >> 8) & 0xFF;
> -                       pdu->params[4 + i * 3] = company_ids[i] & 0xFF;
> +                       set_company_id(&pdu->params[2 + i * 3],
> +                                                       company_ids[i]);
>                }
>
>                pdu->params_len = htons(2 + (3 * G_N_ELEMENTS(company_ids)));
> @@ -1206,9 +1225,7 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
>        struct media_player *mp = user_data;
>        struct pdu_handler *handler;
>        struct avrcp_header *pdu = (void *) operands;
> -       uint32_t company_id = (pdu->company_id[0] << 16) |
> -                               (pdu->company_id[1] << 8) |
> -                               (pdu->company_id[2]);
> +       uint32_t company_id = get_company_id(pdu->company_id);
>
>        if (company_id != IEEEID_BTSIG) {
>                *code = AVC_CTYPE_NOT_IMPLEMENTED;
> --
> 1.7.6.1

Ack.

-- 
Luiz Augusto von Dentz
