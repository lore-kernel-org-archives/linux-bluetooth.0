Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343292324-959-11-git-send-email-frederic.danis@linux.intel.com>
References: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com>
	<1343292324-959-11-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 27 Jul 2012 10:50:15 +0200
Message-ID: <CANT-zCUWdfDtKpjZFX+NFnaGt0Thp5C7uzpwvXU6qpMtZzOStw@mail.gmail.com>
Subject: Re: [PATCH v15 10/14] audio: Move HFP HF server to telephony.c
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Thu, Jul 26, 2012 at 10:45 AM, Frédéric Danis
<frederic.danis@linux.intel.com> wrote:
> Move HandsFree HF RFComm server from audio/manager.c to
> audio/telephony.c.
> Update the HandsfreeGateway API to reflect this change (remove agent
> related methods).
> Doing this, RFComm server related to HandsfreeGateway is only started
> when an agent registers for this role of HandsFree Profile.
> ---
>  audio/device.h    |    1 +
>  audio/gateway.c   |  406 ++++++++++++++---------------------------------------
>  audio/gateway.h   |    8 ++
>  audio/manager.c   |  210 +--------------------------
>  audio/media.c     |   17 +++
>  audio/telephony.c |  217 +++++++++++++++++++++++++++-
>  audio/transport.c |    4 +
>  doc/hfp-api.txt   |   46 ------
>  8 files changed, 349 insertions(+), 560 deletions(-)
>
> diff --git a/audio/device.h b/audio/device.h
> index 75f1da9..1e260e3 100644
> --- a/audio/device.h
> +++ b/audio/device.h
> @@ -48,6 +48,7 @@ struct audio_device {
>         struct target *target;
>
>         guint hs_preauth_id;
> +       guint gw_preauth_id;
>
>         struct dev_priv *priv;
>  };
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 6162948..e3d65a2 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -41,21 +41,20 @@
>  #include <bluetooth/bluetooth.h>
>  #include <bluetooth/sdp.h>
>  #include <bluetooth/sdp_lib.h>
> +#include <bluetooth/uuid.h>
> +
> +#include "btio.h"
> +#include "../src/adapter.h"
> +#include "../src/device.h"
>
>  #include "sdp-client.h"
>  #include "device.h"
>  #include "gateway.h"
> +#include "telephony.h"
>  #include "log.h"
>  #include "error.h"
> -#include "btio.h"
>  #include "dbus-common.h"
>
> -struct hf_agent {
> -       char *name;     /* Bus id */
> -       char *path;     /* D-Bus path */
> -       guint watch;    /* Disconnect watch */
> -};
> -
>  struct connect_cb {
>         unsigned int id;
>         gateway_stream_cb_t cb;
> @@ -66,12 +65,12 @@ struct gateway {
>         gateway_state_t state;
>         GIOChannel *rfcomm;
>         GIOChannel *sco;
> -       GIOChannel *incoming;
> +       const char *connecting_uuid;
> +       const char *connecting_path;

I would suggest renaming this to something like
connecting_transport_path or connecting_transport. Otherwise the code
is sometimes confusing IMO.

Furthermore, you're actually using gateway_set_media_transport_path()
in the internal API.

>         GSList *callbacks;
> -       struct hf_agent *agent;
>         DBusMessage *msg;
> -       int version;
>         gateway_lock_t lock;
> +       struct telephony_device *tel_dev;
>  };
>
>  struct gateway_state_callback {
> @@ -105,16 +104,6 @@ static const char *state2str(gateway_state_t state)
>         }
>  }
>
> -static void agent_free(struct hf_agent *agent)
> -{
> -       if (!agent)
> -               return;
> -
> -       g_free(agent->name);
> -       g_free(agent->path);
> -       g_free(agent);
> -}
> -
>  static void change_state(struct audio_device *dev, gateway_state_t new_state)
>  {
>         struct gateway *gw = dev->gateway;
> @@ -141,8 +130,19 @@ static void change_state(struct audio_device *dev, gateway_state_t new_state)
>
>  void gateway_set_state(struct audio_device *dev, gateway_state_t new_state)

Perhaps not directly related to your patch but... why do we have this
function anyway as opposed to change_state?

If you compare to headset_set_state, it seems really inconsistent.

>  {
> +       struct gateway *gw = dev->gateway;
> +
>         switch (new_state) {
>         case GATEWAY_STATE_DISCONNECTED:
> +               if (gw->msg) {
> +                       DBusMessage *reply;
> +
> +                       reply = btd_error_failed(gw->msg, "Connect failed");
> +                       g_dbus_send_message(dev->conn, reply);
> +                       dbus_message_unref(gw->msg);
> +                       gw->msg = NULL;
> +               }
> +
>                 gateway_close(dev);
>                 break;

<snip>

> @@ -573,6 +419,11 @@ int gateway_close(struct audio_device *device)
>                 gw->sco = NULL;
>         }
>
> +       if (gw->tel_dev) {
> +               telephony_device_disconnect(gw->tel_dev);
> +               gw->tel_dev = NULL;
> +       }
> +

Don't we also need to clear connecting_uuid and specially connecting_path?

>         change_state(device, GATEWAY_STATE_DISCONNECTED);
>         g_set_error(&gerr, GATEWAY_ERROR,
>                         GATEWAY_ERROR_DISCONNECTED, "Disconnected");
> @@ -607,17 +458,6 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
>         return reply;
>  }

Cheers,
Mikel
