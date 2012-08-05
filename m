Return-Path: <cyrus@holtmann.org>
Message-ID: <1344141450.2083.30.camel@aeonflux>
Subject: Re: [PATCH v17 01/15] doc: Add telephony interface documents
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 04 Aug 2012 21:37:30 -0700
In-Reply-To: <1343995640-19784-2-git-send-email-frederic.danis@linux.intel.com>
References: <1343995640-19784-1-git-send-email-frederic.danis@linux.intel.com>
	 <1343995640-19784-2-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>  Makefile.am                    |    2 +-
>  doc/audio-api.txt              |   87 +++++++++++++++++++++++++++++++++
>  doc/audio-telephony-design.txt |  106 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 194 insertions(+), 1 deletion(-)
>  create mode 100644 doc/audio-telephony-design.txt

I looked at this, and we should split this into two patches as well. And
it should be leading with the design document.

> diff --git a/doc/audio-telephony-design.txt b/doc/audio-telephony-design.txt
> new file mode 100644
> index 0000000..a5936f6
> --- /dev/null
> +++ b/doc/audio-telephony-design.txt
> @@ -0,0 +1,106 @@

Can we please get a proper design document. Something that introduces
the problem, describes the goal and how we are trying to achieve it.

> +The org.bluez.Telephony interface will simplify BlueZ code by focusing on
> +the Bluetooth communication part and by letting the external application (i.e.
> +oFono) take charge of the Telephony tasks (AT parsing and modem specific code).
> +So, it becomes simpler, easier to maintain and debug.
> +
> +External applications, which should implement AT parsing and telephony
> +part of HeadSet or HandsFree Profiles, will have to register an

Please use Headset and Handsfree in writing. And unless part of the
profile name itself, it is lower case profiles.

> +org.bluez.TelephonyAgent using this new interface. This will setup a SDP record
> +for the profile and a RFCOMM server listening for incoming connection.
> +
> +When a new device is connected, NewConnection method of TelephonyAgent is
> +called. The telephony agent should reply to it after proper communication
> +establishment (directly for HSP or after SLC setup completes for HFP).

We need to describe on how HFP 1.6 with wideband speech is handled as
well.

> +Interaction with the audio component (i.e. PulseAudio) will be done through the
> +MediaTransport object (passed to telephony agent during NewConnection call).

This is the one thing that is really unclear to me. How does this
actually help. The MediaTransport and TelephonyAgent should be
independent.

> +Here is some flowcharts of interactions between BlueZ, telephony agent (oFono)
> +and audio component (PulseAudio):
> +
> +        .....>  Bluetooth communication between headset and phone
> +        ----->  Dbus messages and signals
> +
> +SCO connection - AG initiated
> +
> +	PulseAudio              BlueZ             HF
> +	|                         |               |
> +	|    transport acquire    |               |
> +	|------------------------>|               |
> +	|                         |  connect SCO  |
> +	|                         |<.............>|
> +	|      return SCO fd      |               |
> +	|<------------------------|               |
> +	|                         |               |

For every diagram it needs to have some sort of description.

> +
> +SCO connection - HF initiated
> +
> +	PulseAudio              BlueZ             HF
> +	|                         |               |
> +	|                         |  connect SCO  |
> +	|                         |<.............>|
> +	|  state changed signal   |               |
> +	|<------------------------|               |
> +	|                         |               |
> +	|    transport acquire    |               |
> +	|------------------------>|               |
> +	|                         |               |
> +	|      return SCO fd      |               |
> +	|<------------------------|               |
> +	|                         |               |
> +
> +AT+NREC
> +
> +	HF              oFono           BlueZ           PulseAudio
> +	|     AT+NREC     |               |                  |
> +	|................>|               |                  |
> +	|                 |  SetProperty  |                  |
> +	|                 |-------------->|                  |
> +	|                 |               | property changed |
> +	|                 |               |      signal      |
> +	|                 |               |----------------->|
> +
> +
> ++BSIR
> +
> +	HF          oFono         BlueZ        PulseAudio        app
> +	|             |             |               |             |
> +	|             |             |               |<------------|
> +	|             |             |  SetProperty  |             |
> +	|             |             |<--------------|             |
> +	|             |             |               |             |
> +	|             |   property changed signal   |             |
> +	|             |<------------*-------------->|             |
> +	|   +BSIR:x   |             |               |             |
> +	|<............|             |               |             |
> +	|             |             |               |             |
> +
> +
> +AT+VGS,AT+VGM
> +
> +	HF          oFono         BlueZ        PulseAudio        app
> +	|             |             |               |             |
> +	|  AT+VGS=xx  |             |               |             |
> +	|............>|             |               |             |
> +	|             | SetProperty |               |             |
> +	|             |------------>|               |             |
> +	|             |             |               |             |
> +	|             |   property changed signal   |             |
> +	|             |<------------*-------------->|             |
> +	|             |             |               |------------>|
> +	|             |             |               |             |
> +
> +
> ++VGS,+VGM
> +
> +	HF          oFono         BlueZ        PulseAudio        app
> +	|             |             |               |             |
> +	|             |             |               |<------------|
> +	|             |             |  SetProperty  |             |
> +	|             |             |<--------------|             |
> +	|             |             |               |             |
> +	|             |   property changed signal   |             |
> +	|             |<------------*-------------->|             |
> +	|   +VGS:xx   |             |               |             |
> +	|<............|             |               |------------>|
> +	|             |             |               |             |

Regards

Marcel


