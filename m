Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336734130-31397-1-git-send-email-vani.patel@stericsson.com>
References: <1336734130-31397-1-git-send-email-vani.patel@stericsson.com>
Date: Fri, 11 May 2012 06:48:48 -0700
Message-ID: <CABBYNZKUQhQzuGYVsZQPWAnNZKitgH5bURcn7VzyWwXEKS0Z0Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] AVRCP: Register for VolumeChanged Notification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Fri, May 11, 2012 at 4:02 AM, Vani <vani.patel@stericsson.com> wrote:
> From: Vani Patel <vani.patel@stericsson.com>
>
> On connection of control channel, VolumeChanged
> notification is registered with the CT.
> ---
>  audio/avctp.c |    1 +
>  audio/avrcp.c |   25 ++++++++++++++++++++++++-
>  audio/avrcp.h |    4 +++-
>  3 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index c5fbc1b..0cbd114 100755
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
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 2b25253..f4f1b6a 100755
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -91,6 +91,7 @@
>  #define CAP_EVENTS_SUPPORTED   0x03
>  #define COMMAND                0
>  #define RESPONSE               1
> +#define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
>
>  enum battery_status {
>        BATTERY_STATUS_NORMAL =         0,
> @@ -591,11 +592,12 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
>
>                return AVC_CTYPE_STABLE;
>        case CAP_EVENTS_SUPPORTED:
> -               pdu->params[1] = 4;
> +               pdu->params[1] = 5;
>                pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
>                pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
>                pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
>                pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
> +               pdu->params[6] = AVRCP_EVENT_VOLUME_CHANGED;

I believe this is no really necessary, at least not for the role you
are implementing since the headset is the one that should have this,
not us.

> +
> +void register_volume_notification(struct avctp *session)
> +{
> +       uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
> +       struct avrcp_header *pdu = (void *) buf;
> +       static uint8_t transaction = 0;

I don't think the transaction is per command, so IMO we should have a
common one inside avctp which gets incremented on each request.

> +
> +       memset(buf, 0, sizeof(buf));
> +
> +       set_company_id(pdu->company_id, IEEEID_BTSIG);
> +       pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
> +       pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
> +       pdu->params[0] = AVRCP_EVENT_VOLUME_CHANGED;
> +       pdu->params_len = htons (AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
> +
> +       uint8_t length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
> +
> +       uint8_t error = avctp_send_vendordep(session, transaction++,
> +                               AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
> +                               buf, length, COMMAND);

Variable definition should be in the very beginning of the function,
actually I don't think this even compile, so I wonder how you are
testing this code? Please fix them.


-- 
Luiz Augusto von Dentz
