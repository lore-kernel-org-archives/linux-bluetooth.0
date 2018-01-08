Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLiwnG6W424ps-b6+pX8xA5okufaZc1c9A232W7MQNnMQ@mail.gmail.com>
References: <CAFmMashE1ReOhQFe9OD2BrXooNGz_Gxa9gHLYfB+BgHLQsT5HA@mail.gmail.com>
 <CY4PR02MB2231273076CC0D335C86346782130@CY4PR02MB2231.namprd02.prod.outlook.com>
 <CAFmMasjrc7yh0GTjok8wK6L587a_tG-7kJ8kj_Jnj1taTX75hg@mail.gmail.com> <CABBYNZLiwnG6W424ps-b6+pX8xA5okufaZc1c9A232W7MQNnMQ@mail.gmail.com>
From: Alfonso Acosta <alfonso.acosta@gmail.com>
Date: Mon, 8 Jan 2018 16:03:19 +0100
Message-ID: <CAFmMasjteTShTqXbNtkFY2GjAMA-PnS_kXBfOYMbMAPz1iVQmQ@mail.gmail.com>
Subject: Re: Overhead reduction in LE connection establishment
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jamie Mccrae <Jamie.Mccrae@lairdtech.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz and Jamie,

>> The only reason is: very high expectations of battery life. I recall
>> we played with the slave latency in the past, but we will reevaluate
>> and see if it's a feasible option. Thanks for the suggestion.

I found another reason why the slave latency doesn't fully solve the
problem. The peripheral is not advertising all the time (only on a
key-press to save battery). Thus, a large slave latency doesn't help
when (re-)connecting to the central (e.g. in a cold boot or reboot)
point at which we also expect the first notification latency to be
low.

In fact, unless I can get to deliver the notification before BlueZ
does its post-connection operations (MTU exchange, CCCD write etc ...)
, a large slave latency will probably make things worse. Which leads
me to the question below ...

> We do
> however only reload the device attributes once connecting, to avoid
> heavy io at startup, so if you are restarting bluetoothd it won't
> restore the objects right away.

This reflects what I see.

Then isn't  StartNotify() racy when connecting to bonded peripherals
for the first time after bluetoothd starts?

More specifically, won't the D-Bus API miss notifications when:
1. We have a characteristic in a bonded peripheral for which
notifications when enabled in the CCCD in a prior connection to the
central (BlueZ)
2. Notifications are sent form the peripheral after the connection is
established (without waiting for a CCCD write, which should be
acceptable if the peripheral is bonded)
2. It's the first connection to the peripheral since bluetoothd started
