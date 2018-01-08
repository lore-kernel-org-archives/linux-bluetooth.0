Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFmMasjrc7yh0GTjok8wK6L587a_tG-7kJ8kj_Jnj1taTX75hg@mail.gmail.com>
References: <CAFmMashE1ReOhQFe9OD2BrXooNGz_Gxa9gHLYfB+BgHLQsT5HA@mail.gmail.com>
 <CY4PR02MB2231273076CC0D335C86346782130@CY4PR02MB2231.namprd02.prod.outlook.com>
 <CAFmMasjrc7yh0GTjok8wK6L587a_tG-7kJ8kj_Jnj1taTX75hg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jan 2018 11:05:43 -0200
Message-ID: <CABBYNZLiwnG6W424ps-b6+pX8xA5okufaZc1c9A232W7MQNnMQ@mail.gmail.com>
Subject: Re: Overhead reduction in LE connection establishment
To: Alfonso Acosta <alfonso.acosta@gmail.com>
Cc: Jamie Mccrae <Jamie.Mccrae@lairdtech.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Mon, Jan 8, 2018 at 7:32 AM, Alfonso Acosta <alfonso.acosta@gmail.com> w=
rote:
> Hi Jamie,
>
>>>For the application=E2=80=99s purpose, it=E2=80=99s critical that the no=
tification is recieved with the minimum latency.
>>
>> Is there any reason why you wish to have the button in a disconnected st=
ate when inactive over having it in a connected state but with a high conne=
ction interval and a large slave latency? A high slave latency means it can=
 stay in sleep mode if there is nothing to report back to the central devic=
e for a specified number of packets so is perfect for battery powered devic=
es.
>
> The only reason is: very high expectations of battery life. I recall
> we played with the slave latency in the past, but we will reevaluate
> and see if it's a feasible option. Thanks for the suggestion.
>
> Regardless, I am still curious to know if disconnecting and sending
> the notification right away (as Luiz suggests) isn't racy with respect
> to StartNotify().

The reason we maintain the attributes, if the device is not temporary,
is exactly to avoid this race, but perhaps you a talking about
temporary devices? We consider temporary devices those that have not
been connected/paired or in case the devices use a random address that
has not been resolved.

Note that has been a lot of debate regarding this behavior of BlueZ,
most stacks would remove any cache for devices which have not been
paired but in BlueZ we choose to keep the cache to prevent this sort
of race, which may be caused by intermittent connections. We do
however only reload the device attributes once connecting, to avoid
heavy io at startup, so if you are restarting bluetoothd it won't
restore the objects right away.


--=20
Luiz Augusto von Dentz
