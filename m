Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316543496-18575-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1316543496-18575-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Wed, 21 Sep 2011 12:23:30 +0300
Message-ID: <CABBYNZL1=BqkqD1oH5dYrPrzuYVgjXhATcxZDuaJn=i1TqDFKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] avrcp: limit avrcp packet size to the MTU of AV/C
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Sep 20, 2011 at 9:31 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> AVRCP is an extension of AV/C spec which has a limit of 512 bytes. The
> only place where it can exceed this value is in the response to
> GetElementAttributes command.
>
> Now we simply don't add the attributes that would overflow the available
> buffer space.
> ---
>  audio/avctp.c |    2 -
>  audio/avctp.h |    3 ++
>  audio/avrcp.c |   58 +++++++++++++++++++++++++++++++++-----------------------
>  3 files changed, 37 insertions(+), 26 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 2800a16..e9b8e40 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -84,7 +84,6 @@ struct avc_header {
>        uint8_t subunit_type:5;
>        uint8_t opcode;
>  } __attribute__ ((packed));
> -#define AVC_HEADER_LENGTH 3
>
>  #elif __BYTE_ORDER == __BIG_ENDIAN
>
> @@ -104,7 +103,6 @@ struct avc_header {
>        uint8_t subunit_id:3;
>        uint8_t opcode;
>  } __attribute__ ((packed));
> -#define AVC_HEADER_LENGTH 3
>
>  #else
>  #error "Unknown byte order"
> diff --git a/audio/avctp.h b/audio/avctp.h
> index 2dab8fa..9727485 100644
> --- a/audio/avctp.h
> +++ b/audio/avctp.h
> @@ -24,6 +24,9 @@
>
>  #define AVCTP_PSM 23
>
> +#define AVC_MTU 512
> +#define AVC_HEADER_LENGTH 3
> +
>  /* ctype entries */
>  #define AVC_CTYPE_CONTROL              0x0
>  #define AVC_CTYPE_STATUS               0x1
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index f962946..ba04a12 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -173,6 +173,9 @@ struct avrcp_header {
>  #error "Unknown byte order"
>  #endif
>
> +#define AVRCP_MTU      (AVC_MTU - AVC_HEADER_LENGTH)
> +#define AVRCP_PDU_MTU  (AVRCP_MTU - AVRCP_HEADER_LENGTH)
> +
>  struct avrcp_server {
>        bdaddr_t src;
>        uint32_t tg_record_id;
> @@ -649,7 +652,8 @@ static void mp_set_playback_status(struct media_player *mp, uint8_t status,
>  * attribute, -ENOENT is returned.
>  */
>  static int mp_get_media_attribute(struct media_player *mp,
> -                                               uint32_t id, uint8_t *buf)
> +                                               uint32_t id, uint8_t *buf,
> +                                               uint16_t maxlen)
>  {
>        struct media_info_elem {
>                uint32_t id;
> @@ -661,67 +665,72 @@ static int mp_get_media_attribute(struct media_player *mp,
>        struct media_info_elem *elem = (void *)buf;
>        uint16_t len;
>        char valstr[20];
> +       char *valp;
> +
> +       if (maxlen < sizeof(struct media_info_elem))
> +               return -ENOBUFS;
> +
> +       /* Subtract the size of elem header from the available space */
> +       maxlen -= sizeof(struct media_info_elem);
>
>        switch (id) {
>        case MEDIA_INFO_TITLE:
> -               if (mi->title) {
> -                       len = strlen(mi->title);
> -                       memcpy(elem->val, mi->title, len);
> -               } else {
> -                       len = 0;
> -               }
> -
> +               valp = mi->title;
>                break;
>        case MEDIA_INFO_ARTIST:
>                if (mi->artist == NULL)
>                        return -ENOENT;
>
> -               len = strlen(mi->artist);
> -               memcpy(elem->val, mi->artist, len);
> +               valp = mi->artist;
>                break;
>        case MEDIA_INFO_ALBUM:
>                if (mi->album == NULL)
>                        return -ENOENT;
>
> -               len = strlen(mi->album);
> -               memcpy(elem->val, mi->album, len);
> +               valp = mi->album;
>                break;
>        case MEDIA_INFO_GENRE:
>                if (mi->genre == NULL)
>                        return -ENOENT;
>
> -               len = strlen(mi->genre);
> -               memcpy(elem->val, mi->genre, len);
> +               valp = mi->genre;
>                break;
> -
>        case MEDIA_INFO_TRACK:
>                if (!mi->track)
>                        return -ENOENT;
>
>                snprintf(valstr, 20, "%u", mi->track);
> -               len = strlen(valstr);
> -               memcpy(elem->val, valstr, len);
> +               valp = valstr;
>                break;
>        case MEDIA_INFO_N_TRACKS:
>                if (!mi->ntracks)
>                        return -ENOENT;
>
>                snprintf(valstr, 20, "%u", mi->ntracks);
> -               len = strlen(valstr);
> -               memcpy(elem->val, valstr, len);
> +               valp = valstr;
>                break;
>        case MEDIA_INFO_PLAYING_TIME:
>                if (mi->track_len == 0xFFFFFFFF)
>                        return -ENOENT;
>
>                snprintf(valstr, 20, "%u", mi->track_len);
> -               len = strlen(valstr);
> -               memcpy(elem->val, valstr, len);
> +               valp = valstr;
>                break;
>        default:
>                return -EINVAL;
>        }
>
> +       if (valp) {
> +               len = strlen(valp);
> +
> +               if (len > maxlen)
> +                       return -ENOBUFS;
> +
> +               memcpy(elem->val, valp, len);
> +       } else {
> +               len = 0;
> +       }
> +
>        elem->id = htonl(id);
>        elem->charset = htons(0x6A); /* Always use UTF-8 */
>        elem->len = htons(len);
> @@ -905,8 +914,8 @@ static uint8_t avrcp_handle_get_element_attributes(struct media_player *mp,
>                 * title must be returned.
>                 */
>                for (i = 1; i < MEDIA_INFO_LAST; i++) {
> -                       size = mp_get_media_attribute(mp, i,
> -                                                       &pdu->params[pos]);
> +                       size = mp_get_media_attribute(mp, i, &pdu->params[pos],
> +                                                       AVRCP_PDU_MTU - pos);
>
>                        if (size > 0) {
>                                len++;
> @@ -922,7 +931,8 @@ static uint8_t avrcp_handle_get_element_attributes(struct media_player *mp,
>                        uint32_t attr = ntohl(attr_ids[i]);
>
>                        size = mp_get_media_attribute(mp, attr,
> -                                                       &pdu->params[pos]);
> +                                                       &pdu->params[pos],
> +                                                       AVRCP_PDU_MTU - pos);
>
>                        if (size > 0) {
>                                len++;
> --
> 1.7.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Ack

-- 
Luiz Augusto von Dentz
