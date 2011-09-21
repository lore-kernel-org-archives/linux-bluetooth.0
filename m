Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316543496-18575-3-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1316543496-18575-3-git-send-email-lucas.demarchi@profusion.mobi>
Date: Wed, 21 Sep 2011 13:14:59 +0300
Message-ID: <CABBYNZJayw0pb8brhENg5H=L_TBS6YXWf7XxVa=Xvmb1XnzQqw@mail.gmail.com>
Subject: Re: [PATCH 2/3] avrcp: implement pdu continuation request and abort
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Sep 20, 2011 at 9:31 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> GetElementAttributes is the only one that can possibly overflow the MTU
> of AVC. When this command is received, if the response is larger than
> the MTU split the messages and queue them for later processing.
> ---
>  audio/avrcp.c |  282 ++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 229 insertions(+), 53 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index ba04a12..8fccede 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -64,6 +64,12 @@
>  #define E_PARAM_NOT_FOUND      0x02
>  #define E_INTERNAL             0x03
>
> +/* Packet types */
> +#define AVRCP_PACKET_TYPE_SINGLE       0x00
> +#define AVRCP_PACKET_TYPE_START                0x01
> +#define AVRCP_PACKET_TYPE_CONTINUING   0x02
> +#define AVRCP_PACKET_TYPE_END          0x03
> +
>  /* PDU types for metadata transfer */
>  #define AVRCP_GET_CAPABILITIES         0x10
>  #define AVRCP_LIST_PLAYER_ATTRIBUTES   0X11
> @@ -77,6 +83,8 @@
>  #define AVRCP_GET_ELEMENT_ATTRIBUTES   0x20
>  #define AVRCP_GET_PLAY_STATUS          0x30
>  #define AVRCP_REGISTER_NOTIFICATION    0x31
> +#define AVRCP_REQUEST_CONTINUING       0x40
> +#define AVRCP_ABORT_CONTINUING         0x41
>
>  /* Notification events */
>  #define AVRCP_EVENT_PLAYBACK_STATUS_CHANGED            0x01
> @@ -201,6 +209,7 @@ struct media_player {
>
>        struct media_info mi;
>        GTimer *timer;
> +       GQueue *pending_pdus;
>        unsigned int handler;
>        uint16_t registered_events;
>        uint8_t transaction_events[AVRCP_EVENT_TRACK_CHANGED + 1];
> @@ -645,15 +654,17 @@ static void mp_set_playback_status(struct media_player *mp, uint8_t status,
>  * Copy media_info field to a buffer, intended to be used in a response to
>  * GetElementAttributes message.
>  *
> - * It assumes there's enough space in the buffer and on success it returns the
> - * size written.
> + * If there isn't enough space in the buffer, the available space is filled,
> + * the remainder (both header and value) is allocated in @param remainder and
> + * its size is written to remainder_len.
>  *
> - * If @param id is not valid, -EINVAL is returned. If there's no such media
> - * attribute, -ENOENT is returned.
> + * On success, it returns the size written. Otherwise it returns -EINVAL if
> + * @param id is not valid or -ENOENT if there's no such media attribute.
>  */
>  static int mp_get_media_attribute(struct media_player *mp,
> -                                               uint32_t id, uint8_t *buf,
> -                                               uint16_t maxlen)
> +                                       uint32_t id, uint8_t *buf,
> +                                       uint16_t maxlen, uint8_t **remainder,
> +                                       int *remainder_len)
>  {
>        struct media_info_elem {
>                uint32_t id;
> @@ -662,16 +673,16 @@ static int mp_get_media_attribute(struct media_player *mp,
>                uint8_t val[];
>        };
>        const struct media_info *mi = &mp->mi;
> -       struct media_info_elem *elem = (void *)buf;
> +       struct media_info_elem *elem;
>        uint16_t len;
>        char valstr[20];
>        char *valp;
> +       int ret;
>
> -       if (maxlen < sizeof(struct media_info_elem))
> -               return -ENOBUFS;
> +       assert(remainder != NULL);
> +       assert(remainder_len != NULL);

I guess you probably assert(remainder_len > 0) since remainder_len is
int, well perhaps size_t fits better here.

> -       /* Subtract the size of elem header from the available space */
> -       maxlen -= sizeof(struct media_info_elem);
> +       DBG("id=%u buf=%p maxlen=%u", id, buf, maxlen);
>
>        switch (id) {
>        case MEDIA_INFO_TITLE:
> @@ -720,22 +731,50 @@ static int mp_get_media_attribute(struct media_player *mp,
>                return -EINVAL;
>        }
>
> -       if (valp) {
> +       if (valp)
>                len = strlen(valp);
> +       else
> +               len = 0;
> +
> +       if (maxlen < sizeof(struct media_info_elem)) {
> +               /*
> +                * There isn't space even for the header: put both header and
> +                * value in remainder.
> +                */
> +               *remainder_len = sizeof(struct media_info_elem) + len;
> +               elem = g_malloc(*remainder_len);
> +               *remainder = (uint8_t *) elem;
>
> -               if (len > maxlen)
> -                       return -ENOBUFS;
> +               if (len)
> +                       memcpy(elem->val, valp, len);
>
> -               memcpy(elem->val, valp, len);
> +               ret = 0;
>        } else {
> -               len = 0;
> +               /* Put at least header on current PDU */
> +               elem = (struct media_info_elem *) buf;
> +               maxlen -= sizeof(struct media_info_elem);
> +
> +               if (maxlen < len) {
> +                       /* Split value between current PDU and remainder. */
> +                       memcpy(elem->val, valp, maxlen);
> +                       *remainder_len = len - maxlen;
> +                       *remainder = g_memdup(valp + maxlen, *remainder_len);
> +                       ret = sizeof(struct media_info_elem) + maxlen;
> +               } else {
> +                       /* Header and value fit in current PDU */
> +                       if (len)
> +                               memcpy(elem->val, valp, len);
> +
> +                       *remainder = NULL;
> +                       ret = sizeof(struct media_info_elem) + len;
> +               }
>        }

memcpy, hmm bad sign.

>        elem->id = htonl(id);
>        elem->charset = htons(0x6A); /* Always use UTF-8 */
>        elem->len = htons(len);
>
> -       return sizeof(struct media_info_elem) + len;
> +       return ret;
>  }
>
>  static void mp_set_attribute(struct media_player *mp,
> @@ -890,64 +929,116 @@ err:
>        return AVC_CTYPE_REJECTED;
>  }
>
> +static struct avrcp_header *avrcp_split_pdu(struct media_player *mp,
> +                                               struct avrcp_header *last_pdu,
> +                                               uint8_t *remainder,
> +                                               int remainder_len,
> +                                               uint16_t *pos)
> +{
> +       struct avrcp_header *pdu = last_pdu;
> +       uint16_t len;
> +
> +       assert(remainder != NULL);
> +       assert(pos != NULL);
> +
> +       if (!mp->pending_pdus)
> +               mp->pending_pdus = g_queue_new();
> +
> +       for (len = *pos; remainder_len; remainder_len -= len) {
> +               /* Close last pdu - keep host endiannes */
> +               pdu->params_len = len;
> +
> +               /* Create a new PDU */
> +               pdu = g_malloc(AVRCP_MTU);
> +
> +               memcpy(pdu, last_pdu, sizeof(struct avrcp_header));
> +               g_queue_push_tail(mp->pending_pdus, pdu);
> +
> +               if (remainder_len > AVRCP_PDU_MTU)
> +                       len = AVRCP_PDU_MTU;
> +               else
> +                       len = remainder_len;
> +
> +               memcpy(&pdu->params[0], remainder, len);
> +       }

Second memcpy, this does not look good.

> +
> +       *pos = len;
> +
> +       return pdu;
> +}
> +
>  static uint8_t avrcp_handle_get_element_attributes(struct media_player *mp,
> -                                               struct avrcp_header *pdu,
> -                                               uint8_t transaction)
> +                                       struct avrcp_header *first_pdu,
> +                                       uint8_t transaction)
>  {
> -       uint16_t len = ntohs(pdu->params_len);
> +       struct avrcp_header *pdu = first_pdu;
>        uint64_t *identifier = (void *) &pdu->params[0];
> +       uint32_t attr_ids[MEDIA_INFO_LAST];
> +       uint16_t len = ntohs(pdu->params_len);
>        uint16_t pos;
>        uint8_t nattr;
> -       int size;
>        unsigned int i;
>
>        if (len < 8 || *identifier != 0)
>                goto err;
>
> -       len = 0;
> -       pos = 1; /* Keep track of current position in reponse */
>        nattr = pdu->params[8];
>
> -       if (!nattr) {
> -               /*
> -                * Return all available information, at least
> -                * title must be returned.
> -                */
> -               for (i = 1; i < MEDIA_INFO_LAST; i++) {
> -                       size = mp_get_media_attribute(mp, i, &pdu->params[pos],
> -                                                       AVRCP_PDU_MTU - pos);
> -
> -                       if (size > 0) {
> -                               len++;
> -                               pos += size;
> -                       }
> +       DBG("nattr %u", nattr);
> +
> +       /* Copy the requested attribute ids to our private vector */
> +       if (nattr) {
> +               uint32_t *attr = (uint32_t *) &pdu->params[9];
> +               if (nattr > MEDIA_INFO_LAST) {
> +                       error("Got number of attributes %u > %u",
> +                                       nattr, MEDIA_INFO_LAST);
> +                       nattr = MEDIA_INFO_LAST;
>                }
> +
> +               for (i = 0; attr < (uint32_t *)&pdu->params[9] +
> +                                               nattr * sizeof(uint32_t);
> +                                               attr++, i++)
> +                       attr_ids[i] = ntohl(*attr);
>        } else {
> -               uint32_t *attr_ids;
> +               nattr = MEDIA_INFO_LAST - 1;
>
> -               attr_ids = g_memdup(&pdu->params[9], sizeof(uint32_t) * nattr);
> +               for (i = 1; i < MEDIA_INFO_LAST; i++)
> +                       attr_ids[i - 1] = i;
> +       }
>
> -               for (i = 0; i < nattr; i++) {
> -                       uint32_t attr = ntohl(attr_ids[i]);
> +       for (i = 0, len = 0, pos = 1; i < nattr; i++) {
> +               uint8_t *remainder;
> +               int size, remainder_len;
>
> -                       size = mp_get_media_attribute(mp, attr,
> -                                                       &pdu->params[pos],
> -                                                       AVRCP_PDU_MTU - pos);
> +               size = mp_get_media_attribute(mp, attr_ids[i],
> +                                               &pdu->params[pos],
> +                                               AVRCP_PDU_MTU - pos,
> +                                               &remainder, &remainder_len);
>
> -                       if (size > 0) {
> -                               len++;
> -                               pos += size;
> -                       }
> -               }
> +               if (size < 0)
> +                       continue;
>
> -               g_free(attr_ids);
> +               pos += size;
> +               len++;
>
> -               if (!len)
> -                       goto err;
> +               if (remainder) {
> +                       pdu = avrcp_split_pdu(mp, pdu, remainder,
> +                                               remainder_len, &pos);
> +                       g_free(remainder);
> +               }
>        }
>
> -       pdu->params[0] = len;
> -       pdu->params_len = htons(pos);
> +       if (!len)
> +               goto err;
> +
> +       /* Close last pdu - keep host endiannes */
> +       pdu->params_len = pos;
> +
> +       if (first_pdu != pdu)
> +               first_pdu->packet_type = AVRCP_PACKET_TYPE_START;
> +
> +       first_pdu->params[0] = len;
> +       first_pdu->params_len = htons(first_pdu->params_len);
>
>        return AVC_CTYPE_STABLE;
>  err:
> @@ -1192,6 +1283,82 @@ err:
>        return AVC_CTYPE_REJECTED;
>  }
>
> +static void cancel_pending_pdus(struct media_player *mp)
> +{
> +       struct avrcp_header *pdu;
> +
> +       if (!mp || !mp->pending_pdus)
> +               return;
> +
> +       DBG("%u PDUs cancelled.", g_queue_get_length(mp->pending_pdus));
> +
> +       while ((pdu = g_queue_pop_head(mp->pending_pdus)))
> +               g_free(pdu);
> +
> +       g_queue_free(mp->pending_pdus);
> +       mp->pending_pdus = NULL;
> +}
> +
> +static uint8_t avrcp_handle_request_continuing(struct media_player *mp,
> +                                               struct avrcp_header *pdu,
> +                                               uint8_t transaction)
> +{
> +       struct avrcp_header *saved_pdu;
> +       int len;
> +
> +       if (!mp || !mp->pending_pdus) {
> +               pdu->params_len = htons(1);
> +               pdu->params[0] = E_INVALID_PARAM;
> +               return AVC_CTYPE_REJECTED;
> +       }
> +
> +       DBG("");
> +
> +       saved_pdu = g_queue_pop_head(mp->pending_pdus);
> +
> +       len = saved_pdu->params_len;
> +       memcpy(pdu, saved_pdu, sizeof(struct avrcp_header) + len);
> +       pdu->params_len = htons(len);

Third memcpy, I guess we need to fix this somehow.

> +       g_free(saved_pdu);
> +
> +       if (g_queue_is_empty(mp->pending_pdus)) {
> +               pdu->packet_type = AVRCP_PACKET_TYPE_END;
> +               g_queue_free(mp->pending_pdus);
> +               mp->pending_pdus = NULL;
> +       } else {
> +               pdu->packet_type = AVRCP_PACKET_TYPE_CONTINUING;
> +       }
> +
> +       return AVC_CTYPE_STABLE;
> +}
> +
> +static uint8_t avrcp_handle_abort_continuing(struct media_player *mp,
> +                                               struct avrcp_header *pdu,
> +                                               uint8_t transaction)
> +{
> +       uint16_t len = ntohs(pdu->params_len);
> +       struct avrcp_header *saved_pdu;
> +
> +       if (len < 1 || mp->pending_pdus == NULL)
> +               goto err;
> +
> +       saved_pdu = g_queue_peek_head(mp->pending_pdus);
> +
> +       if (saved_pdu->pdu_id != pdu->params[0])
> +               goto err;

There is something missing here, don't you have to free the queue after abort?

> +       pdu->params_len = 0;
> +
> +       return AVC_CTYPE_STABLE;
> +
> +err:
> +       pdu->params_len = htons(1);
> +       pdu->params[0] = E_INVALID_PARAM;
> +       return AVC_CTYPE_REJECTED;
> +}
> +
> +
>  static struct pdu_handler {
>        uint8_t pdu_id;
>        uint8_t code;
> @@ -1223,6 +1390,10 @@ static struct pdu_handler {
>                                        avrcp_handle_get_play_status },
>                { AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
>                                        avrcp_handle_register_notification },
> +               { AVRCP_REQUEST_CONTINUING, AVC_CTYPE_CONTROL,
> +                                       avrcp_handle_request_continuing },
> +               { AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
> +                                       avrcp_handle_abort_continuing },
>                { },
>  };
>
> @@ -1263,6 +1434,11 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
>                goto err_metadata;
>        }
>
> +       /* We have to cancel pending pdus before processing new messages */
> +       if (pdu->pdu_id != AVRCP_REQUEST_CONTINUING
> +                       && pdu->pdu_id != AVRCP_ABORT_CONTINUING)
> +               cancel_pending_pdus(mp);
> +
>        if (!handler->func) {
>                pdu->params[0] = E_INVALID_PARAM;
>                goto err_metadata;
> --
> 1.7.6.1

I wonder if you have tried a more simplistic approach without parsing
and storing all the pdus in a queue since the beginning, we could
store just store the list of pending attributes to be sent and
generate the pdu only when requested/needed, that would probably
eliminate most of the memcpy.

-- 
Luiz Augusto von Dentz
