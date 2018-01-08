Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CY4PR02MB2231273076CC0D335C86346782130@CY4PR02MB2231.namprd02.prod.outlook.com>
References: <CAFmMashE1ReOhQFe9OD2BrXooNGz_Gxa9gHLYfB+BgHLQsT5HA@mail.gmail.com>
 <CY4PR02MB2231273076CC0D335C86346782130@CY4PR02MB2231.namprd02.prod.outlook.com>
From: Alfonso Acosta <alfonso.acosta@gmail.com>
Date: Mon, 8 Jan 2018 10:32:04 +0100
Message-ID: <CAFmMasjrc7yh0GTjok8wK6L587a_tG-7kJ8kj_Jnj1taTX75hg@mail.gmail.com>
Subject: Re: Overhead reduction in LE connection establishment
To: Jamie Mccrae <Jamie.Mccrae@lairdtech.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jamie,

>>For the application=E2=80=99s purpose, it=E2=80=99s critical that the not=
ification is recieved with the minimum latency.
>
> Is there any reason why you wish to have the button in a disconnected sta=
te when inactive over having it in a connected state but with a high connec=
tion interval and a large slave latency? A high slave latency means it can =
stay in sleep mode if there is nothing to report back to the central device=
 for a specified number of packets so is perfect for battery powered device=
s.

The only reason is: very high expectations of battery life. I recall
we played with the slave latency in the past, but we will reevaluate
and see if it's a feasible option. Thanks for the suggestion.

Regardless, I am still curious to know if disconnecting and sending
the notification right away (as Luiz suggests) isn't racy with respect
to StartNotify().
