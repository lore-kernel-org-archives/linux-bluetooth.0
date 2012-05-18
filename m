Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336990615-24344-1-git-send-email-vani.patel@stericsson.com>
References: <1336990615-24344-1-git-send-email-vani.patel@stericsson.com>
Date: Fri, 18 May 2012 19:07:15 +0300
Message-ID: <CABBYNZ+_AozCS3GD1Q19gZux-YrF-_Bh1udRW0D+MkNfYC4+SA@mail.gmail.com>
Subject: Re: [PATCH Bluez v2 1/4] AVRCP: Register for VolumeChanged Notification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Mon, May 14, 2012 at 1:16 PM, Vani <vani.patel@stericsson.com> wrote:
> From: Vani Patel <vani.patel@stericsson.com>
>
> On connection of control channel, VolumeChanged
> notification is registered with the CT.
> ---
>  audio/avctp.c |    5 +++--
>  audio/avctp.h |    2 +-
>  audio/avrcp.c |   29 ++++++++++++++++++++++++++++-
>  audio/avrcp.h |    4 +++-
>  4 files changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 5161703..0cbd114 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -607,6 +607,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
>        init_uinput(session);
>
>        avctp_set_state(session, AVCTP_STATE_CONNECTED);
> +       register_volume_notification(session);
>        session->mtu = imtu;
>        session->io_id = g_io_add_watch(chan,
>                                G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
> @@ -892,7 +893,7 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op)
>
>  int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
>                                uint8_t code, uint8_t subunit,
> -                               uint8_t *operands, size_t operand_count)
> +                               uint8_t *operands, size_t operand_count, uint8_t cr)
>  {
>        uint8_t *buf;
>        struct avctp_header *avctp;
> @@ -914,7 +915,7 @@ int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
>
>        avctp->transaction = transaction;
>        avctp->packet_type = AVCTP_PACKET_SINGLE;
> -       avctp->cr = AVCTP_RESPONSE;
> +       avctp->cr = cr;
>        avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
>
>        avc->code = code;
> diff --git a/audio/avctp.h b/audio/avctp.h
> index 9727485..0b9ff37 100644
> --- a/audio/avctp.h
> +++ b/audio/avctp.h
> @@ -96,4 +96,4 @@ gboolean avctp_unregister_pdu_handler(unsigned int id);
>  int avctp_send_passthrough(struct avctp *session, uint8_t op);
>  int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
>                                uint8_t code, uint8_t subunit,
> -                               uint8_t *operands, size_t operand_count);
> +                               uint8_t *operands, size_t operand_count, uint8_t cr);
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index df39d04..cde2885 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -88,6 +88,10 @@
>  /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
>  #define CAP_COMPANY_ID         0x02
>  #define CAP_EVENTS_SUPPORTED   0x03
> +#define COMMAND                0
> +#define RESPONSE               1
> +
> +#define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
>
>  enum battery_status {
>        BATTERY_STATUS_NORMAL =         0,
> @@ -159,6 +163,7 @@ struct avrcp_player {
>
>  static GSList *servers = NULL;
>  static unsigned int avctp_id = 0;
> +static uint8_t transaction = 0;
>
>  /* Company IDs supported by this device */
>  static uint32_t company_ids[] = {
> @@ -395,7 +400,7 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
>
>        err = avctp_send_vendordep(player->session, player->transaction_events[id],
>                                        AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
> -                                       buf, size + AVRCP_HEADER_LENGTH);
> +                                       buf, size + AVRCP_HEADER_LENGTH, RESPONSE);
>        if (err < 0)
>                return err;
>
> @@ -1327,3 +1332,25 @@ void avrcp_unregister_player(struct avrcp_player *player)
>
>        player_destroy(player);
>  }
> +
> +void register_volume_notification(struct avctp *session)
> +{
> +       uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
> +       struct avrcp_header *pdu = (void *) buf;
> +       uint8_t length, error;
> +
> +       memset(buf, 0, sizeof(buf));
> +
> +       set_company_id(pdu->company_id, IEEEID_BTSIG);
> +       pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
> +       pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
> +       pdu->params[0] = AVRCP_EVENT_VOLUME_CHANGED;
> +       pdu->params_len = htons(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
> +
> +       length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
> +
> +       error = avctp_send_vendordep(session, transaction++,
> +                                               AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
> +                                               buf, length, COMMAND);
> +
> +}
> diff --git a/audio/avrcp.h b/audio/avrcp.h
> index 8a09546..d299b67 100644
> --- a/audio/avrcp.h
> +++ b/audio/avrcp.h
> @@ -73,7 +73,8 @@
>  #define AVRCP_EVENT_TRACK_CHANGED      0x02
>  #define AVRCP_EVENT_TRACK_REACHED_END  0x03
>  #define AVRCP_EVENT_TRACK_REACHED_START        0x04
> -#define AVRCP_EVENT_LAST               AVRCP_EVENT_TRACK_REACHED_START
> +#define AVRCP_EVENT_VOLUME_CHANGED     0x0d
> +#define AVRCP_EVENT_LAST               AVRCP_EVENT_VOLUME_CHANGED
>
>  struct avrcp_player_cb {
>        int (*get_setting) (uint8_t attr, void *user_data);
> @@ -100,3 +101,4 @@ void avrcp_unregister_player(struct avrcp_player *player);
>  int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
>
>  size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
> +void register_volume_notification ( struct avctp *session);
> --
> 1.7.5.4

I had to change it completely to make it work, Im afraid you never
really tested this as it did not compile for me, were you using
bootstrap-configure?

Anyway, I send a new series that should take care of subscribing to
VolumeChanged event which should be working with Sony MW600.

Now the only part missing is to send SetAbsoluteVolume when the volume
has changed on our side.

-- 
Luiz Augusto von Dentz
