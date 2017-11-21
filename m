Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511261624.16347.29.camel@hadess.net>
References: <1511261624.16347.29.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Nov 2017 13:41:27 +0200
Message-ID: <CABBYNZLn=BGXKPRjyEYYP2X9+5LZ=mb1nBSA+ir6-1hccy23WQ@mail.gmail.com>
Subject: Re: Bluetooth LE mouse staying "connected"
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Nov 21, 2017 at 12:53 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Hey,
>
> I re-tested the battery support for Bluetooth LE, and I still have my
> mouse staying "connected" because the PropertiesChanged signal is never
> sent for it.
>
> I believe the reason is that a btd_device reference is staying around.
>
> Reproducer:
> 1. Launch bluetoothd
> 2. Turn mouse on
> 3. "disconnect" the device from the computer side
> 4. Notice that the "Connected" property didn't change but the device
> will now appear disconnected in a properties dump
>
> When connecting, the flow is:
> - batt_probe() is called, I ref() the device
> - batt_accept() is called
>
> When disconnecting, the flow is:
> - batt_disconnect() is called
>
> Shouldn't batt_remove also be called in this case, so the refing is
> symmetrical? If not, should I move the btd_device ref to batt_accept()
> and add a removal for batt_disconnect()? Or is the problem in the core?

batt_probe and batt_remove are symmetrical, probe callback should be
called just once per device when the UUID is discovered and then when
it is removed. So if you are not seeing this happen then perhaps we
have a bug somewhere.

> Cheers
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
