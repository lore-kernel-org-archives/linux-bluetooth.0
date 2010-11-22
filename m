Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 15:33:45 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix managing dbus filters depending on BT state
Message-ID: <20101122143345.GA2303@jh-x301>
References: <1290423382-5493-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290423382-5493-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Mon, Nov 22, 2010, Bartosz Szatkowski wrote:
> Previously even if BT was disabled, bluetoothd would handle some dbus
> singals (mostly connected with HFP). Now filters are added when
> BT is enabled and removed when BT is disabled.
> ---
>  audio/manager.c          |    4 ++--
>  audio/telephony-dummy.c  |   10 ++++++++++
>  audio/telephony-maemo5.c |   10 ++++++++++
>  audio/telephony-maemo6.c |   10 ++++++++++
>  audio/telephony-ofono.c  |   10 ++++++++++
>  audio/telephony.h        |    1 +
>  src/adapter.c            |    5 +++++
>  7 files changed, 48 insertions(+), 2 deletions(-)

Nack on this one. I understand the issue you're trying to fix but it
needs to be done differently.

> diff --git a/audio/manager.c b/audio/manager.c
> index 816c807..2fc7bf1 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -1178,7 +1178,7 @@ proceed:
>  		btd_register_adapter_driver(&media_server_driver);
>  
>  	if (enabled.headset) {
> -		telephony_init();
> +		telephony_set_state(1);
>  		btd_register_adapter_driver(&headset_server_driver);
>  	}

If you're gonna call this "state" you should have proper defines or
enums for the values, however in this case it's essentially a boolean so
that's not necessary. In fact since it's a boolean you don't even need
to have any new function or variable at all for it: just use
telephony_init and telephony_exit.

> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -57,6 +57,7 @@
>  #include "glib-helper.h"
>  #include "agent.h"
>  #include "storage.h"
> +#include "../audio/telephony.h"
>  
>  #define IO_CAPABILITY_DISPLAYONLY	0x00
>  #define IO_CAPABILITY_DISPLAYYESNO	0x01
> @@ -2404,6 +2405,8 @@ int adapter_start(struct btd_adapter *adapter)
>  
>  	err = adapter_up(adapter, mode);
>  
> +	telephony_init();
> +

This is just wrong. The core daemon should never have direct access to
the telephony driver. Instead, you should have the audio plugin
(probably audio/manager.c or audio/headset.c) register a adapter powered
callback and then call telehony_init/exit from that callback.

Johan
