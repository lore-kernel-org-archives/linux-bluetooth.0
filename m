Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alexander Holler <holler@ahsoftware.de>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the first adapter found
Date: Fri, 10 Apr 2015 19:15:17 +0200
Message-ID: <1562342.kQUkd9vvG3@leonov>
In-Reply-To: <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org>
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Friday 10 of April 2015 10:10:18 Marcel Holtmann wrote:
> Hi Alexander,
> 
> > You want this option if you're using e.g. a bt-keyboard as the only
> > input device. Other solutions to power on an adapter at startup are
> > either unreliable or too complicated.
> > 
> > E.g. I had a
> > 
> > 	sleep 4
> > 	echo 'power on' | bluetoothctl
> > 
> > in some startup-script. And with an update of bluez from 5.23 to
> > 5.29 Murphy visited me and I had a box without a usable keyboard
> > because those 4 second haven't been enough anymore.
> 
> I think you better have a special script with something like
> wait-for-adapter or something similar instead of trying to force policy
> into the daemon.

I've send RFC patch that adds 'wait for adapter to show up' as an option to 
bluetoothctl before it process stdin. This should allow to script things like
echo 'power on' | bluetoothctl -w
without need for extra dbus scripting.

> We took the power on policy out of BlueZ 5 on purpose.
> 
> > ---
> > src/adapter.c | 10 ++++++++--
> > src/adapter.h |  2 +-
> > src/main.c    |  7 ++++++-
> > 3 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 7ffd302..10de028 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -117,6 +117,8 @@ static GSList *adapter_drivers = NULL;
> > static GSList *disconnect_list = NULL;
> > static GSList *conn_fail_list = NULL;
> > 
> > +static bool power_on_first_adapter;
> > +
> > struct link_key_info {
> > 
> > 	bdaddr_t bdaddr;
> > 	unsigned char key[16];
> > 
> > @@ -7315,8 +7317,11 @@ static int adapter_register(struct btd_adapter
> > *adapter)> 
> > 		return -EINVAL;
> > 	
> > 	}
> > 
> > -	if (adapters == NULL)
> > +	if (adapters == NULL) {
> > 
> > 		adapter->is_default = true;
> > 
> > +		if (power_on_first_adapter)
> > +			set_mode(adapter, MGMT_OP_SET_POWERED, 0x01);
> > +	}
> 
> And this is pretty much the wrong location. You would power on the
> controller with old keys and device list programmed into it. That is not a
> good idea.
> > 	adapters = g_slist_append(adapters, adapter);
> > 
> > @@ -8132,8 +8137,9 @@ static void mgmt_debug(const char *str, void
> > *user_data)> 
> > 	info("%s%s", prefix, str);
> > 
> > }
> 
> Regards
> 
> Marcel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
BR
Szymon Janc
