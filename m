Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9849e4169bcd4e919628054345b533e5@labapart.com>
References: <9849e4169bcd4e919628054345b533e5@labapart.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Jul 2017 15:23:32 +0300
Message-ID: <CABBYNZKT_PYo6ahosHXLOizRLcYwZgTzFOF32R6wb5M67Wf8-A@mail.gmail.com>
Subject: Re: AcquireWrite & AcquireNotify
To: Olivier MARTIN <olivier@labapart.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Olivier,

On Tue, Jul 18, 2017 at 12:14 AM, Olivier MARTIN <olivier@labapart.com> wrote:
> Hi all,
> After exchanging a couple of emails about MTU on the mailing-list last week,
> Luiz suggested the new functions AcquireWrite() & AcquireNotify() would do
> the job. I wanted to give a try and I changed my application protocol to
> take advantage of them.
>
> But I have just realized they are both for the client side but I am using
> Bluez on the GATT server side. I am a bit worry to come back to my initial
> issue where I was thinking I will need the MTU... How can I send the longest
> GATT notification from the GATT server (in the context of a DBUS-based
> application)?

Well the server don't really need to restrict access since it is only
accessed by bluetoothd, though the notification is not 1:1, so if you
change the Value bluetoothd will send the data to all connected peers
with notifications enabled.

I guess the right the most efficient thing to do would make fd passing
for the server as well, though AcquireWrite/AcquireRead would not work
as intended there since the one passing down the fd would be the
application itself not bluetoothd. For things like WriteValue we end
up extending the parameters with a dictionary and then have server
only options, like Device an MTU, though the fd has still to be
returned, but this may not be a bad idea after all since the app would
be able to control exactly where it wants bluetoothd to write to.

> Thanks in advance,
> Olivier
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
