Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 3 Dec 2010 14:42:17 -0400
Message-ID: <AANLkTik=WyfpbULNywPPXGi-KB=6tK3on2p6TYL94E0O@mail.gmail.com>
Subject: Re: [PATCH 1/5] Add device type to identify LE, BR/EDR or dual mode devices
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Dec 3, 2010 at 10:28 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> +static uint8_t flags2type(uint8_t flags)
> +{
> +       /* Inferring the remote type based on the EIR Flags field */
> +
> +       if (flags & EIR_SIM_CONTROLLER && flags & EIR_SIM_HOST)
> +               return DUALMODE_TYPE;

Can the above be simplified to the following?

 if (flags & (EIR_SIM_CONTROLLER | EIR_SIM_HOST))

I know the semantics will change slightly, but I suppose that either
host or controller supports simultaneous LE and BR/EDR, it can be
considered dual mode. It would no be necessary to have *both* bits set
(my impression).

> @@ -3082,6 +3098,7 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
>        if (new_dev) {
>                dev->le = TRUE;
>                dev->evt_type = info->evt_type;
> +               dev->type = LE_TYPE;
>        } else if (dev->rssi == rssi)
>                return;
>

Can you remind me why both dev->le and dev->type are necessary in
struct remote_dev_info ?

> @@ -3124,6 +3142,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>                        dev->alias = g_strdup(alias);
>
>                dev->le = FALSE;
> +               dev->type = BREDR_TYPE;
>                dev->class = class;
>                dev->legacy = legacy;
>                dev->name_status = name_status;

Same question as above here too.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
