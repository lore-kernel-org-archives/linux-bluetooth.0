Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343292324-959-3-git-send-email-frederic.danis@linux.intel.com>
References: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com>
	<1343292324-959-3-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 27 Jul 2012 10:25:43 +0200
Message-ID: <CANT-zCXbpTQUd9RHJdADL7OWNwzgnn84Kyre2VvoO5eZxtrqjw@mail.gmail.com>
Subject: Re: [PATCH v15 02/14] audio: Move telephony drivers to D-Bus interface
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
> Add a D-Bus interface called org.bluez.Telephony to replace current
> telephony drivers for HeadSet/HandsFree Profiles.
>
> This will simplify BlueZ code by focusing on the Bluetooth
> communication part and by letting the external application (i.e. oFono)
> take charge of the Telephony tasks (AT parsing and modem specific code,
> which can be removed from BlueZ code). So, it becomes simpler, easier
> to maintain and debug.
>
> Telephony application will have to register an agent using this new
> interface.
>
> Remove functions related to AT parsing from audio/headset.c.
>
> Remove current telephony drivers (dummy, maemo 5, maemo 6 and oFono)
> from the build as they have been replaced and are no longer needed.
> ---
>  Makefile.am       |   13 +-
>  audio/headset.c   |  689 +++++------------------------------------------------
>  audio/headset.h   |    3 +
>  audio/manager.c   |   13 +-
>  audio/telephony.c |  633 ++++++++++++++++++++++++++++++++++++++++++++++++
>  audio/telephony.h |   35 +--
>  6 files changed, 715 insertions(+), 671 deletions(-)
>  create mode 100644 audio/telephony.c

<snip>

> -static void hfp_slc_complete(struct audio_device *dev)
> +void headset_slc_complete(struct audio_device *dev)

Just to clarify: Is this a trivial rename being squashed in the same
patch? Or is there some reason behind?

>  {
>         struct headset *hs = dev->headset;
>         struct pending_connect *p = hs->pending;
>
> -       DBG("HFP Service Level Connection established");
> +       DBG("Service Level Connection established");

Same here.

<snip>

> diff --git a/audio/telephony.h b/audio/telephony.h
> index 73b390c..cf216ff 100644
> --- a/audio/telephony.h
> +++ b/audio/telephony.h
> @@ -141,29 +141,18 @@ struct indicator {
>         gboolean ignore_redundant;
>  };
>
> -/* Notify telephony-*.c of connected/disconnected devices. Implemented by
> - * telephony-*.c
> - */
> -void telephony_device_connected(void *telephony_device);
> -void telephony_device_disconnected(void *telephony_device);
> +struct telephony_device;
>
> -/* HF requests (sent by the handsfree device). These are implemented by
> - * telephony-*.c
> - */
> -void telephony_event_reporting_req(void *telephony_device, int ind);
> -void telephony_response_and_hold_req(void *telephony_device, int rh);
> -void telephony_last_dialed_number_req(void *telephony_device);
> -void telephony_terminate_call_req(void *telephony_device);
> -void telephony_answer_call_req(void *telephony_device);
> -void telephony_dial_number_req(void *telephony_device, const char *number);
> -void telephony_transmit_dtmf_req(void *telephony_device, char tone);
> -void telephony_subscriber_number_req(void *telephony_device);
> -void telephony_list_current_calls_req(void *telephony_device);
> -void telephony_operator_selection_req(void *telephony_device);
> -void telephony_call_hold_req(void *telephony_device, const char *cmd);
> -void telephony_nr_and_ec_req(void *telephony_device, gboolean enable);
> -void telephony_voice_dial_req(void *telephony_device, gboolean enable);
> -void telephony_key_press_req(void *telephony_device, const char *keys);
> +struct telephony_device *telephony_device_connecting(GIOChannel *io,
> +                                       struct btd_device *btd_dev,
> +                                       struct audio_device *au_dev,
> +                                       const char *uuid);
> +void telephony_device_disconnect(struct telephony_device *device);
> +
> +gboolean telephony_get_ready_state(struct btd_adapter *adapter);
> +uint32_t telephony_get_ag_features(void);

Shouldn't we start using uint16_t everywhere?

If not, the D-Bus agent should also support uint32_t, right?

Cheers,
Mikel
