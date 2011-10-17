Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLGsA3JmdMRz0qGK9fdxZdehr5aJmu94xN_ipOcX8tjaA@mail.gmail.com>
References: <1318627712-9725-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1318627712-9725-6-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZLGsA3JmdMRz0qGK9fdxZdehr5aJmu94xN_ipOcX8tjaA@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 17 Oct 2011 10:27:30 -0200
Message-ID: <CAMOw1v7yr=gKK8fdT=VaS6WnwooUtBW9XOFhxmPS1j4NxNgbkg@mail.gmail.com>
Subject: Re: [PATCH 5/5] AVRCP: Implement RequestContinuingResponse PDU
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 17, 2011 at 7:41 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Sat, Oct 15, 2011 at 12:28 AM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> ---
>>  audio/avrcp.c |  215 ++++++++++++++++++++++++++++++++++++++++++---------------
>>  1 files changed, 158 insertions(+), 57 deletions(-)
>>
>> diff --git a/audio/avrcp.c b/audio/avrcp.c
>> index 1babb94..3c1b752 100644
>> --- a/audio/avrcp.c
>> +++ b/audio/avrcp.c
>> @@ -64,6 +64,12 @@
>>  #define E_PARAM_NOT_FOUND      0x02
>>  #define E_INTERNAL             0x03
>>
>> +/* Packet types */
>> +#define AVRCP_PACKET_TYPE_SINGLE       0x00
>> +#define AVRCP_PACKET_TYPE_START                0x01
>> +#define AVRCP_PACKET_TYPE_CONTINUING   0x02
>> +#define AVRCP_PACKET_TYPE_END          0x03
>> +
>>  /* PDU types for metadata transfer */
>>  #define AVRCP_GET_CAPABILITIES         0x10
>>  #define AVRCP_LIST_PLAYER_ATTRIBUTES   0X11
>> @@ -77,6 +83,7 @@
>>  #define AVRCP_GET_ELEMENT_ATTRIBUTES   0x20
>>  #define AVRCP_GET_PLAY_STATUS          0x30
>>  #define AVRCP_REGISTER_NOTIFICATION    0x31
>> +#define AVRCP_REQUEST_CONTINUING       0x40
>>  #define AVRCP_ABORT_CONTINUING         0x41
>>
>>  /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
>> @@ -399,75 +406,119 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
>>  }
>>
>>  /*
>> - * Copy media_info field to a buffer, intended to be used in a response to
>> - * GetElementAttributes message.
>> - *
>> - * It assumes there's enough space in the buffer and on success it returns the
>> - * size written.
>> + * Write media attribute to buffer, taking care of writing the header when
>> + * necessary, not writing more than @param maxlen and starting string from
>> + * @param last_idx.
>>  *
>> - * If @param id is not valid, -EINVAL is returned. If there's no space left on
>> - * the buffer -ENOBUFS is returned.
>> + * If there isn't enough space in the buffer even for the header, it returns
>> + * -ENOBUFS. Otherwise it returns the size written to buffer and the position
>> + *  within the media attribute in @param last_idx.
>>  */
>> -static int player_get_media_attribute(struct avrcp_player *player,
>> +static int player_write_media_attribute(struct avrcp_player *player,
>>                                                uint32_t id, uint8_t *buf,
>> -                                               uint16_t maxlen)
>> +                                               uint16_t maxlen,
>> +                                               unsigned int *last_idx)
>>  {
>> -       struct media_info_elem {
>> +       struct media_attribute_header {
>>                uint32_t id;
>>                uint16_t charset;
>>                uint16_t len;
>> -               uint8_t val[];
>>        };
>> -       struct media_info_elem *elem = (void *)buf;
>> +       uint8_t *val;
>> +       struct media_attribute_header *hdr;
>>        uint16_t len;
>>        char valstr[20];
>>        void *value;
>>
>> -       if (maxlen < sizeof(struct media_info_elem))
>> -               return -ENOBUFS;
>> +       if (*last_idx == 0) {
>> +               /*
>> +                * Write header first, but bail out if even that
>> +                * doesn't fit in PDU.
>> +                */
>> +               if (maxlen < sizeof(*hdr))
>> +                       return -ENOBUFS;
>>
>> -       /* Subtract the size of elem header from the available space */
>> -       maxlen -= sizeof(struct media_info_elem);
>> +               maxlen -= sizeof(*hdr);
>> +               hdr = (void *) buf;
>> +               hdr->id = htonl(id);
>> +               hdr->charset = htons(0x6A); /* Always use UTF-8 */
>> +               val = ((uint8_t *) hdr) + sizeof(*hdr);
>> +       } else {
>> +               hdr = NULL;
>> +               val = buf;
>> +       }
>>
>>        DBG("Get media attribute: %u", id);
>>
>> -       if (id == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
>> -                       id > AVRCP_MEDIA_ATTRIBUTE_LAST)
>> -               return -ENOENT;
>> -
>>        value = player->cb->get_metadata(id, player->user_data);
>>        if (value == NULL) {
>> -               len = 0;
>> -               goto done;
>> +               hdr->len = 0;
>> +               return sizeof(*hdr);
>>        }
>>
>>        switch (id) {
>> -       case AVRCP_MEDIA_ATTRIBUTE_TITLE:
>> -       case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
>> -       case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
>> -       case AVRCP_MEDIA_ATTRIBUTE_GENRE:
>> -               len = strlen((char *) value);
>> -               if (len > maxlen)
>> -                       return -ENOBUFS;
>> -               memcpy(elem->val, value, len);
>> -               break;
>>        case AVRCP_MEDIA_ATTRIBUTE_TRACK:
>>        case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
>>        case AVRCP_MEDIA_ATTRIBUTE_DURATION:
>>                snprintf(valstr, 20, "%u", GPOINTER_TO_UINT(value));
>> -               len = strlen(valstr);
>> -               if (len > maxlen)
>> -                       return -ENOBUFS;
>> -               memcpy(elem->val, valstr, len);
>> +               value = valstr;
>>                break;
>>        }
>>
>> -done:
>> -       elem->id = htonl(id);
>> -       elem->charset = htons(0x6A); /* Always use UTF-8 */
>> -       elem->len = htons(len);
>> +       len = strlen(value);
>> +       if (hdr != NULL)
>> +               hdr->len = htons(len);
>> +
>> +       value = ((char *) value) + *last_idx;
>> +       len -= *last_idx;
>> +
>> +       if (len > maxlen) {
>> +               *last_idx += maxlen;
>> +               len = maxlen;
>> +       } else {
>> +               *last_idx = 0;
>> +       }
>> +
>> +       memcpy(val, value, len);
>> +
>> +       return val - buf + len;
>
> So the reason you have val - buf is to track if header was written or
> not, right?

Correct.

> In that case I would suggest using something like hdr ?
> sizeof(*hdr) + len : len or perhaps moving the header filling to
> player_fill_media_attribute might simplify this, so you only have to
> keep track of the written value in player_write_media_attribute.

Yeah, I think moving the header filling to player_fill_media_attribute
is a better idea.


>> +}
>>
>> -       return sizeof(struct media_info_elem) + len;
>> +static GList *player_fill_media_attribute(struct avrcp_player *player,
>> +                                       GList *attr_ids, uint8_t *buf,
>> +                                       uint16_t *pos, unsigned int *last_idx)
>> +{
>> +       GList *l;
>> +
>> +       for (l = attr_ids; l != NULL; l = g_list_delete_link(l, l)) {
>> +               uint32_t attr = GPOINTER_TO_UINT(l->data);
>> +               int size;
>> +
>> +               size = player_write_media_attribute(player, attr, &buf[*pos],
>> +                                                       AVRCP_PDU_MTU - *pos,
>> +                                                       last_idx);
>> +               if (size < 0)
>> +                       break;
>> +
>> +               *pos += size;
>> +
>> +               if (*last_idx)
>> +                       break;
>> +       }
>> +
>> +       return l;
>> +}
>> +
>> -               for (i = 0, attr_ids = NULL; i < nattr; i++, attr++) {
>> +               for (i = 0, len = 0, attr_ids = NULL; i < nattr; i++, attr++) {
>>                        uint32_t id = ntohl(bt_get_unaligned(attr));
>> +
>> +                       /* Don't add invalid attributes */
>> +                       if (id == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
>> +                                       id > AVRCP_MEDIA_ATTRIBUTE_LAST)
>> +                               continue;
>> +
>> +                       len++;
>>                        attr_ids = g_list_prepend(attr_ids,
>>                                                        GUINT_TO_POINTER(id));
>>                }
>
> This sounds like a different bug, I mean not checking for invalid
> attributes, if it was introduced in the previous patch can you please
> fix it in place?

It's not a bug. In order to to save the list of pending attributes, I
have to make sure only valid attributes are in the list because I have
to answer in the first PDU the number of attributes I'll be
responding. Without pdu-continuing, this check could be where it was
before.



>
>> @@ -641,24 +700,21 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
>>                attr_ids = g_list_reverse(attr_ids);
>>        }
>>
>> -       for (l = attr_ids, len = 0, pos = 1; l != NULL; l = l->next) {
>> -               uint32_t attr = GPOINTER_TO_UINT(l->data);
>> +       if (!len)
>> +               goto err;
>>
>> -               size = player_get_media_attribute(player, attr,
>> -                                                       &pdu->params[pos],
>> -                                                       AVRCP_PDU_MTU - pos);
>> +       player_abort_pending_pdu(player);
>> +       pos = 1;
>> +       last_idx = 0;
>> +       attr_ids = player_fill_media_attribute(player, attr_ids, pdu->params,
>> +                                                       &pos, &last_idx);
>>
>> -               if (size >= 0) {
>> -                       len++;
>> -                       pos += size;
>> -               }
>> +       if (attr_ids != NULL) {
>> +               player->pending_pdu = pending_pdu_new(pdu->pdu_id, attr_ids,
>> +                                                               last_idx);
>> +               pdu->packet_type = AVRCP_PACKET_TYPE_START;
>>        }
>>
>> -       g_list_free(attr_ids);
>> -
>> -       if (!len)
>> -               goto err;
>> -
>>        pdu->params[0] = len;
>>        pdu->params_len = htons(pos);
>>
>> @@ -889,6 +945,46 @@ err:
>>        return AVC_CTYPE_REJECTED;
>>  }
>>
>> +static uint8_t avrcp_handle_request_continuing(struct avrcp_player *player,
>> +                                               struct avrcp_header *pdu,
>> +                                               uint8_t transaction)
>> +{
>> +       uint16_t len = ntohs(pdu->params_len);
>> +       struct pending_pdu *pending;
>> +
>> +       if (len != 1 || player->pending_pdu == NULL)
>> +               goto err;
>> +
>> +       pending = player->pending_pdu;
>> +
>> +       if (pending->pdu_id != pdu->params[0])
>> +               goto err;
>> +
>> +
>> +       len = 0;
>> +       pending->attr_ids = player_fill_media_attribute(player,
>> +                                                       pending->attr_ids,
>> +                                                       pdu->params, &len,
>> +                                                       &pending->last_idx);
>> +       pdu->pdu_id = pending->pdu_id;
>> +
>> +       if (pending->attr_ids == NULL) {
>> +               g_free(player->pending_pdu);
>> +               player->pending_pdu = NULL;
>> +               pdu->packet_type = AVRCP_PACKET_TYPE_END;
>> +       } else {
>> +               pdu->packet_type = AVRCP_PACKET_TYPE_CONTINUING;
>> +       }
>> +
>> +       pdu->params_len = htons(len);
>> +
>> +       return AVC_CTYPE_STABLE;
>> +err:
>> +       pdu->params_len = htons(1);
>> +       pdu->params[0] = E_INVALID_PARAM;
>> +       return AVC_CTYPE_REJECTED;
>> +}
>> +
>>  static uint8_t avrcp_handle_abort_continuing(struct avrcp_player *player,
>>                                                struct avrcp_header *pdu,
>>                                                uint8_t transaction)
>> @@ -947,8 +1043,11 @@ static struct pdu_handler {
>>                                        avrcp_handle_get_play_status },
>>                { AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
>>                                        avrcp_handle_register_notification },
>> +               { AVRCP_REQUEST_CONTINUING, AVC_CTYPE_CONTROL,
>> +                                       avrcp_handle_request_continuing },
>>                { AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
>>                                        avrcp_handle_abort_continuing },
>> +
>
> Empty line above is not really needed.

ok


Lucas De Marchi
