Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343292324-959-2-git-send-email-frederic.danis@linux.intel.com>
References: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com>
	<1343292324-959-2-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 27 Jul 2012 09:52:00 +0200
Message-ID: <CANT-zCVCXCSha3CTC2BL9TA9564RQyB8x86QGoOrUuo6OBKU3g@mail.gmail.com>
Subject: Re: [PATCH v15 01/14] doc: Add telephony interface documents
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
> ---
>  Makefile.am                    |    2 +-
>  doc/assigned-numbers.txt       |    1 +
>  doc/audio-api.txt              |   90 ++++++++++++++++++++++++++++++++++
>  doc/audio-telephony-design.txt |  106 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 doc/audio-telephony-design.txt
>
> diff --git a/Makefile.am b/Makefile.am
> index 45a811c..1aa302c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -381,7 +381,7 @@ EXTRA_DIST += doc/manager-api.txt \
>                 doc/network-api.txt doc/input-api.txt doc/audio-api.txt \
>                 doc/control-api.txt doc/hfp-api.txt doc/health-api.txt \
>                 doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
> -               doc/supported-features.txt
> +               doc/supported-features.txt doc/audio-telephony-design.txt
>
>  AM_YFLAGS = -d
>
> diff --git a/doc/assigned-numbers.txt b/doc/assigned-numbers.txt
> index cda934c..120d7ea 100644
> --- a/doc/assigned-numbers.txt
> +++ b/doc/assigned-numbers.txt
> @@ -8,6 +8,7 @@ avoid conflicts.
>  Profile                Channel
>  -----------------------
>  DUN            1
> +HSP HS         6
>  HFP HF         7
>  OPP            9
>  FTP            10
> diff --git a/doc/audio-api.txt b/doc/audio-api.txt
> index ca430fc..cc94267 100644
> --- a/doc/audio-api.txt
> +++ b/doc/audio-api.txt
> @@ -423,3 +423,93 @@ properties boolean Connected [readonly]
>                 uint16 MicrophoneGain  [readonly]
>
>                         The speaker gain when available.
> +
> +
> +Telephony hierarchy
> +===================
> +
> +Service                org.bluez
> +Interface      org.bluez.Telephony
> +Object path    [variable prefix]/{hci0,hci1,...}
> +
> +Methods                void RegisterAgent(object path, dict properties)
> +
> +                       Register a TelephonyAgent to sender, the sender can
> +                       register as many agents as it likes.
> +
> +                       Note: If the sender disconnects its agents are
> +                       automatically unregistered.
> +
> +                       possible properties:
> +
> +                               string UUID:
> +
> +                                       UUID of the profile which the agent is
> +                                       for.
> +
> +                               uint16 Version:
> +
> +                                       Version of the profile which the agent
> +                                       implements.
> +
> +                               uint16 Features:
> +
> +                                       Agent supported features as defined in
> +                                       profile spec e.g. HFP.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +
> +               void UnregisterAgent(object path)
> +
> +                       Unregister sender agent.
> +
> +TelephonyAgent hierarchy
> +========================
> +
> +Service                unique name
> +Interface      org.bluez.TelephonyAgent
> +Object path    freely definable
> +
> +Methods                void NewConnection(filedescriptor fd, dict properties)
> +
> +                       This method gets called whenever a new connection
> +                       has been established. This method assumes that D-Bus
> +                       daemon with file descriptor passing capability is
> +                       being used.
> +
> +                       The agent should only return successfully once the
> +                       establishment of the service level connection (SLC)
> +                       has been completed.  In the case of Handsfree this
> +                       means that BRSF exchange has been performed and
> +                       necessary initialization has been done.
> +
> +                       possible properties:
> +
> +                               object Device:
> +
> +                                       BlueZ remote device object.
> +
> +                               string UUID:
> +
> +                                       Profile UUID of the connection.

What would be the purpose of this property?

I believe the agent was already registered for a specific UUID, so
this seems redundant.

Cheers,
Mikel
