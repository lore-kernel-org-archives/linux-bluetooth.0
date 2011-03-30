Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301480292-25370-1-git-send-email-johan.hedberg@gmail.com>
References: <1301480292-25370-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 30 Mar 2011 08:30:38 -0400
Message-ID: <AANLkTinxPChXddNN_8Qzv4xxBBhvhpzgFD=qk4eKhcVS@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add mgmt_device_found event
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Mar 30, 2011 at 6:18 AM,  <johan.hedberg@gmail.com> wrote:
> +int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
> +                                                               u8 *eir)
> +{
> +       struct mgmt_ev_device_found ev;
> +
> +       memset(&ev, 0, sizeof(ev));
> +
> +       bacpy(&ev.bdaddr, bdaddr);
> +       memcpy(ev.dev_class, dev_class, 3);

What about "sizeof(ev.dev_class)" instead of 3 ?

> +       ev.rssi = rssi;
> +
> +       if (eir)
> +               memcpy(ev.eir, eir, HCI_MAX_EIR_LENGTH);

This could be "sizeof(ev.eir)" as well, although it is already clear
by the #define.

> +
> +       return mgmt_event(MGMT_EV_DEVICE_FOUND, index, &ev, sizeof(ev), NULL);
> +}

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
