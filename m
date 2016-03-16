Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAASrBQ=Wd1Jdp1GHEzjPrZ=-nZocAo9qx05pvsMsz0T6Btc95Q@mail.gmail.com>
References: <CAASrBQ=Wd1Jdp1GHEzjPrZ=-nZocAo9qx05pvsMsz0T6Btc95Q@mail.gmail.com>
Date: Wed, 16 Mar 2016 14:03:14 +0200
Message-ID: <CABBYNZ+4r+YTJByojL8QBCtWnUFeojqOoKkiOBycJFrfCdWz=g@mail.gmail.com>
Subject: Re: setting indication on GattCharacteristic1 interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mark Rages <markrages@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Wed, Mar 16, 2016 at 12:59 AM, Mark Rages <markrages@gmail.com> wrote:
> Hi,
>
> The GattCharacteristic1 d-bus interface has methods for StartNotify
> and StopNotify.
>
> But I don't see corresponding methods for requesting Indications
>
> Is there a way to do this?  Should I write to the CCCD directly?  How
> do the indications arrive on the d-bus?

Indicate would probably need to be a method since it does require a
reply, but for now you can just treat it as a notification whereas
BlueZ will be responsible for confirming so nothing else need to be
done by the application. The code can actually distinguished between
the 2:

/* Try to enable notifications and/or indications based on
* whatever the characteristic supports.
*/
if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_NOTIFY)
pdu[2] = 0x01;

if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
pdu[2] |= 0x02;


-- 
Luiz Augusto von Dentz
