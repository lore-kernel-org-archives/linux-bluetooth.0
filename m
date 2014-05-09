Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 May 2014 10:32:44 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv4 04/12] android/handsfree: Add SCO Audio IPC
Message-ID: <20140509073242.GA23010@aemeltch-MOBL1>
References: <1399551937-27109-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1399551937-27109-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZJZAg33U_QpkeD80xBQj-cH3qTY6we6-O+A6D47x76Y6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJZAg33U_QpkeD80xBQj-cH3qTY6we6-O+A6D47x76Y6Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, May 08, 2014 at 04:22:35PM +0300, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Thu, May 8, 2014 at 3:25 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > If SCO Audio IPC gets connected it provides only one command:
> > connect_sco().
> > ---
> >  android/handsfree.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 57 insertions(+), 1 deletion(-)
> >
> > diff --git a/android/handsfree.c b/android/handsfree.c
> > index 8202e53..96f0f6e 100644
> > --- a/android/handsfree.c
> > +++ b/android/handsfree.c
> > @@ -45,6 +45,7 @@
> >  #include "bluetooth.h"
> >  #include "src/log.h"
> >  #include "utils.h"
> > +#include "sco-msg.h"
> >
> >  #define HSP_AG_CHANNEL 12
> >  #define HFP_AG_CHANNEL 13
> > @@ -156,7 +157,9 @@ static struct {
> >  static uint32_t hfp_ag_features = 0;
> >
> >  static bdaddr_t adapter_addr;
> > +
> >  static struct ipc *hal_ipc = NULL;
> > +static struct ipc *audio_ipc = NULL;
> >
> >  static uint32_t hfp_record_id = 0;
> >  static GIOChannel *hfp_server = NULL;
> > @@ -822,6 +825,8 @@ static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
> >         g_io_channel_unref(device.sco);
> >         device.sco = NULL;
> >
> > +       DBG("");
> > +
> >         device.sco_watch = 0;
> >
> >         device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
> > @@ -887,6 +892,27 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
> >                                                         sco_watch_cb, NULL);
> >
> >         device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
> > +
> > +       if (audio_ipc) {
> > +               int fd = g_io_channel_unix_get_fd(chan);
> > +               GError *err = NULL;
> > +               uint16_t mtu = 48;
> > +               struct audio_rsp_connect_sco rsp;
> > +
> > +               if (!bt_io_get(chan, &err, BT_IO_OPT_MTU, &mtu,
> > +                                                       BT_IO_OPT_INVALID)) {
> > +                       error("Unable to get MTU: %s\n", err->message);
> > +                       g_clear_error(&err);
> > +               }
> > +
> > +               DBG("fd %d mtu %u", fd, mtu);
> > +
> > +               rsp.mtu = mtu;
> > +
> > +               ipc_send_rsp_full(audio_ipc, AUDIO_SERVICE_SCO_ID,
> > +                                       AUDIO_OP_CONNECT_SCO, sizeof(rsp), &rsp,
> > +                                       fd);
> > +       }
> 
> This does not look correct place to do it, I would probably move to a
> separate function and call it from device_set_audio_state.
> 
> >  }
> >
> >  static bool connect_sco(void)
> > @@ -904,7 +930,7 @@ static bool connect_sco(void)
> >                                 device.negotiated_codec != CODEC_ID_CVSD)
> >                 voice_settings = BT_VOICE_TRANSPARENT;
> >         else
> > -               voice_settings = BT_VOICE_CVSD_16BIT;
> > +               voice_settings = 0;
> 
> What is the reason for changing this value to 0?
> 
> >
> >         io = bt_io_connect(connect_sco_cb, NULL, NULL, &gerr,
> >                                 BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
> > @@ -2563,6 +2589,33 @@ static void disable_sco_server(void)
> >         }
> >  }
> >
> > +static void bt_audio_connect_sco(const void *buf, uint16_t len)
> > +{
> > +       DBG("");
> > +
> > +       connect_audio();
> 
> There doesn't seems to exist any connect_audio function, does this
> even compile? Btw, you need to check if it is already connected then
> you should respond immediately.

Luiz have you tried to compile it? At least I am able to fine the
function:

./android/handsfree.c:1677:static bool connect_audio(void)
static bool connect_audio(void)
{
	if (device.audio_state !=
HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED)
		return false;

	/* we haven't negotiated codec, start selection */
	if ((device.features & HFP_HF_FEAT_CODEC) &&
!device.negotiated_codec) {
		select_codec(0);
		return true;
	}

	return connect_sco();
}

Best regards 
Andrei Emeltchenko 

> 
> > +}
> > +
> > +static const struct ipc_handler audio_handlers[] = {
> > +       /* AUDIO_OP_CONNECT_SCO */
> > +       { bt_audio_connect_sco, false, 0 }
> > +};
> > +
> > +static bool bt_audio_register(ipc_disconnect_cb disconnect)
> > +{
> > +       DBG("");
> > +
> > +       audio_ipc = ipc_init(BLUEZ_SCO_SK_PATH, sizeof(BLUEZ_SCO_SK_PATH),
> > +                               AUDIO_SERVICE_SCO_ID, false, disconnect, NULL);
> > +       if (!audio_ipc)
> > +               return false;
> > +
> > +       ipc_register(audio_ipc, AUDIO_SERVICE_SCO_ID, audio_handlers,
> > +                                               G_N_ELEMENTS(audio_handlers));
> > +
> > +       return true;
> > +}
> > +
> >  bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
> >  {
> >         DBG("mode 0x%x", mode);
> > @@ -2597,6 +2650,9 @@ done:
> >         hal_ipc = ipc;
> >         ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
> >                                                 G_N_ELEMENTS(cmd_handlers));
> > +
> > +       bt_audio_register(NULL);
> > +
> 
> I would also change it to bt_sco_register and obviously you need to
> cleanup properly.
> 
> >         return true;
> >  }
> >
> > --
> > 1.8.3.2
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
