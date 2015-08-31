Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1440772352-7564-1-git-send-email-bharat.panda@samsung.com>
 <1440772352-7564-2-git-send-email-bharat.panda@samsung.com>
 <CABBYNZ+cNYm6JZfj=7Z3FEoLbqZVkF5S0ER7c1UU0TV6aic0ZQ@mail.gmail.com>
In-reply-to: <CABBYNZ+cNYm6JZfj=7Z3FEoLbqZVkF5S0ER7c1UU0TV6aic0ZQ@mail.gmail.com>
Subject: RE: [PATCH v1 2/2] audio/avrcp: Add GetFolderItems support
Date: Mon, 31 Aug 2015 17:02:07 +0530
Message-id: <010501d0e3e0$ba9dd630$2fd98290$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Monday, August 31, 2015 4:30 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH v1 2/2] audio/avrcp: Add GetFolderItems support
> 
> Hi Bharat,
> 
> On Fri, Aug 28, 2015 at 5:32 PM, Bharat Panda
> <bharat.panda@samsung.com> wrote:
> > Support added to handle Get Folder Items browsing PDU for media player
> > scope in TG role.
> >
> > e.g.
> >       AVCTP Browsing: Response: type 0x00 label 0 PID 0x110e
> >         AVRCP: GetFolderItems: len 0x0030
> >           Status: 0x04 (Success)
> >           UIDCounter: 0x0000 (0)
> >           NumOfItems: 0x0001 (1)
> >           Item: 0x01 (Media Player)
> >           Length: 0x0028 (40)
> >           PlayerID: 0x0000 (0)
> >           PlayerType: 0x0001 (Audio)
> >           PlayerSubType: 0x00000001 (Audio Book)
> >           PlayStatus: 0x01 (PLAYING)
> >           Features: 0x0000000000b701e80200000000000000
> >           CharsetID: 0x006a (UTF-8)
> >           NameLength: 0x000c (12)
> >           Name: SimplePlayer
> > ---
> >  profiles/audio/avrcp.c | 146
> +++++++++++++++++++++++++++++++++++++++++++++++++
> >  profiles/audio/avrcp.h |   1 +
> >  profiles/audio/media.c |   8 +++
> >  3 files changed, 155 insertions(+)
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c index
> > 76e89af..77b10f5 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -138,6 +138,11 @@
> >
> >  #define AVRCP_BROWSING_TIMEOUT         1
> >
> > +#define SCOPE_MEDIA_PLAYER_LIST                0x00
> > +#define SCOPE_MEDIA_PLAYER_VFS                 0x01
> > +#define SCOPE_SEARCH                           0x02
> > +#define SCOPE_NOW_PLAYING                      0x03
> 
> All protocol defines should use AVRCP_ as prefix.
> 
> > +
> >  #if __BYTE_ORDER == __LITTLE_ENDIAN
> >
> >  struct avrcp_header {
> > @@ -176,6 +181,30 @@ struct avrcp_browsing_header {  } __attribute__
> > ((packed));  #define AVRCP_BROWSING_HEADER_LENGTH 3
> >
> > +struct get_folder_items_rsp {
> > +       uint8_t status;
> > +       uint16_t uid_counter;
> > +       uint16_t num_items;
> > +       uint8_t data[0];
> > +} __attribute__ ((packed));
> > +
> > +struct folder_item {
> > +       uint8_t type;
> > +       uint16_t len;
> > +       uint8_t data[0];
> > +} __attribute__ ((packed));
> > +
> > +struct player_item {
> > +       uint16_t player_id;
> > +       uint8_t type;
> > +       uint32_t subtype;
> > +       uint8_t status;
> > +       uint8_t features[16];
> > +       uint16_t charset;
> > +       uint16_t namelen;
> > +       char name[0];
> > +} __attribute__ ((packed));
> > +
> >  struct avrcp_server {
> >         struct btd_adapter *adapter;
> >         uint32_t tg_record_id;
> > @@ -261,6 +290,18 @@ struct control_pdu_handler {  static GSList
> > *servers = NULL;  static unsigned int avctp_id = 0;
> >
> > +/* Default feature bit mask for media player
> > + * supporting Play, Stop, Pause, Rewind, fast forward,
> > + * Forward, Backward, Vendor Unique, Basic Group Navigation,
> > + * Advanced Control Player, Browsing, UIDs unique,
> > + * OnlyBrowsableWhenAddressed
> > + */
> > +static const uint8_t features[16] = {
> > +                               0x00, 0x00, 0x00, 0x00, 0x00,
> > +                               0xB7, 0x01, 0xE8, 0x02, 0x00,
> > +                               0x00, 0x00, 0x00, 0x00, 0x00,
> > +                               0x00 };
> 
> That is not what we currently support, we actually support almost all pass-
> through commands (see avctp.c) but we don't have any support for
> browsing, etc.
> 
> >  /* Company IDs supported by this device */  static uint32_t
> > company_ids[] = {
> >         IEEEID_BTSIG,
> > @@ -1821,11 +1862,116 @@ err_metadata:
> >         return AVRCP_HEADER_LENGTH + 1;  }
> >
> > +static uint16_t player_get_uid_counter(struct avrcp_player *player) {
> > +       if (!player)
> > +               return 0x0000;
> > +
> > +       return player->uid_counter;
> > +}
> > +
> > +static void avrcp_handle_get_folder_items(struct avrcp *session,
> > +                               struct avrcp_browsing_header *pdu,
> > +                               uint8_t transaction) {
> > +       struct avrcp_player *player = session->target->player;
> > +       struct get_folder_items_rsp *rsp;
> > +       uint32_t start_item = 0;
> > +       uint32_t end_item = 0;
> > +       uint8_t scope;
> > +       uint8_t status = AVRCP_STATUS_SUCCESS;
> > +       const char *name = NULL;
> > +       GSList *l;
> > +
> > +       if (!pdu || ntohs(pdu->param_len) < 10)
> > +               goto failed;
> > +
> > +       scope = pdu->params[0];
> > +       start_item = bt_get_be32(&pdu->params[1]);
> > +       end_item = bt_get_be32(&pdu->params[5]);
> > +
> > +       DBG("scope 0x%02x start_item 0x%08x end_item 0x%08x", scope,
> > +                               start_item, end_item);
> > +
> > +       if (end_item < start_item) {
> > +               status = AVRCP_STATUS_INVALID_PARAM;
> > +               goto failed;
> > +       }
> > +
> > +       switch (scope) {
> > +       case SCOPE_MEDIA_PLAYER_LIST:
> 
> Lets create another function for each scope, so the following code should be
> move to avrcp_handle_media_player_list.
> 
> > +               rsp = (void *)pdu->params;
> > +               rsp->status = AVRCP_STATUS_SUCCESS;
> > +               rsp->uid_counter = htons(player_get_uid_counter(player));
> > +               rsp->num_items = 0;
> > +               pdu->param_len = sizeof(*rsp);
> > +
> > +               for (l = g_slist_nth(session->server->players, start_item);
> > +                                               l; l = g_slist_next(l)) {
> > +                       struct avrcp_player *player = l->data;
> > +                       struct folder_item *folder;
> > +                       struct player_item *item;
> > +                       uint16_t namelen;
> > +
> > +                       if (rsp->num_items == (end_item - start_item) + 1)
> > +                               break;
> > +
> > +                       folder = (void *)&pdu->params[pdu->param_len];
> > +                       folder->type = 0x01; /* Media Player */
> > +
> > +                       pdu->param_len += sizeof(*folder);
> > +
> > +                       item = (void *)folder->data;
> > +                       item->player_id = htons(player->id);
> > +                       item->type = 0x01; /* Audio */
> > +                       item->subtype = htonl(0x01); /* Audio Book */
> > +                       item->status = player_get_status(player);
> > +                       memset(item->features, 0xff, 7);
> 
> This is invalid, first this would leave the remaining bytes unset which may not
> be 0x00, but you should actually use features, this clearly indicate to me that
> you have not tested this with PTS since it would probably not match the
> value in PIXIT.
I agree this is invalid memset should be used with proper features length, I will fix this this and submit v2 with all review comments fixed.

Yes it was not tested with PTS, due to some PTS frequent crash issue during startup, But I have tested the functionality to get the player list using car-kit and MecApp AVRCP. Once the PTS issues is fixed, I will run the specific TCs and attach the result along with the patch details.

> 
> > +
> > +                       memcpy(&item->features, &features, sizeof(features));
> > +                       item->charset = htons(AVRCP_CHARSET_UTF8);
> > +
> > +                       name = player->cb->get_player_name(player->user_data);
> > +                       namelen = strlen(name);
> > +                       item->namelen = htons(namelen);
> > +                       memcpy(item->name, name, namelen);
> > +
> > +                       folder->len = htons(sizeof(*item) + namelen);
> > +                       pdu->param_len += sizeof(*item) + namelen;
> > +                       rsp->num_items++;
> > +               }
> > +
> > +               /* If no player could be found respond with an error */
> > +               if (!rsp->num_items) {
> > +                       status = AVRCP_STATUS_OUT_OF_BOUNDS;
> > +                       goto failed;
> > +               }
> > +
> > +               rsp->num_items = htons(rsp->num_items);
> > +               pdu->param_len = htons(pdu->param_len);
> > +
> > +               break;
> > +       case SCOPE_MEDIA_PLAYER_VFS:
> > +       case SCOPE_SEARCH:
> > +       case SCOPE_NOW_PLAYING:
> > +       default:
> > +               status = AVRCP_STATUS_INVALID_PARAM;
> > +               goto failed;
> > +       }
> > +
> > +       return;
> > +
> > +failed:
> > +       pdu->params[0] = status;
> > +       pdu->param_len = htons(1);
> > +}
> > +
> >  static struct browsing_pdu_handler {
> >         uint8_t pdu_id;
> >         void (*func) (struct avrcp *session, struct avrcp_browsing_header
> *pdu,
> >                                                         uint8_t
> > transaction);  } browsing_handlers[] = {
> > +               { AVRCP_GET_FOLDER_ITEMS,
> > + avrcp_handle_get_folder_items },
> >                 { },
> >  };
> >
> > diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h index
> > a9aeb1a..fbd84ce 100644
> > --- a/profiles/audio/avrcp.h
> > +++ b/profiles/audio/avrcp.h
> > @@ -93,6 +93,7 @@ struct avrcp_player_cb {
> >         const char *(*get_status) (void *user_data);
> >         uint32_t (*get_position) (void *user_data);
> >         uint32_t (*get_duration) (void *user_data);
> > +       const char *(*get_player_name) (void *user_data);
> 
> Use get_name, the struct is already referring to player no need to use the
> term again.
"get_name" is already being used for getting the endpoint name in the same file media.c, so I used get_player_name. 
> 
> >         void (*set_volume) (uint8_t volume, struct btd_device *dev,
> >                                                         void *user_data);
> >         bool (*play) (void *user_data); diff --git
> > a/profiles/audio/media.c b/profiles/audio/media.c index
> > 106b18a..ba7662e 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -1013,6 +1013,13 @@ static const char *get_setting(const char *key,
> void *user_data)
> >         return g_hash_table_lookup(mp->settings, key);  }
> >
> > +static const char *get_player_name(void *user_data) {
> > +       struct media_player *mp = user_data;
> > +
> > +       return mp->name;
> > +}
> > +
> >  static void set_shuffle_setting(DBusMessageIter *iter, const char
> > *value)  {
> >         const char *key = "Shuffle";
> > @@ -1273,6 +1280,7 @@ static struct avrcp_player_cb player_cb = {
> >         .get_position = get_position,
> >         .get_duration = get_duration,
> >         .get_status = get_status,
> > +       .get_player_name = get_player_name,
> >         .set_volume = set_volume,
> >         .play = play,
> >         .stop = stop,
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

