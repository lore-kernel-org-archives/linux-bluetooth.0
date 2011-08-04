Return-Path: <cyrus@holtmann.org>
Message-ID: <4E3A5BFB.1050201@nokia.com>
Date: Thu, 04 Aug 2011 11:44:43 +0300
From: Antti Julku <antti.julku@nokia.com>
MIME-Version: 1.0
To: ext Claudio Takahasi <claudio.takahasi@openbossa.org>
CC: Dmitriy Paliy <dmitriy.paliy@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
References: <1308737516-3303-1-git-send-email-antti.julku@nokia.com>	<1309309092.2208.25.camel@aeonflux>	<CAHMBquWSLjzKKyM2xuMUakHeBb-FMLUWXLj2_Tz4Ye1MWj37qw@mail.gmail.com> <CAKT1EBfQaTSjQe6sZnC5Wx52iPmyo6SSfYD0Ci+_qb1Dbq32+g@mail.gmail.com>
In-Reply-To: <CAKT1EBfQaTSjQe6sZnC5Wx52iPmyo6SSfYD0Ci+_qb1Dbq32+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Claudio and Marcel,

On 07/25/2011 03:46 PM, ext Claudio Takahasi wrote:

> BTW, I think we need to align BR and LE. Proximity and Thermometer
> Profiles also have recommended parameters for fast connection(first
> 30sec) and 2 reduced power options. Both profiles use the same
> configuration. If we add a new command to control page/connection
> parameters it needs to be aligned with BR and LE and if possible
> avoiding transport specific parameters.
>
> BR,
> Claudio

This issue was discussed in the IRC. It seem that for LE, fast 
connection is needed only on the initiator side for outgoing connections 
(LE scan/connection establishment parameters), since 4.0 spec forbids LE 
connections between dual mode devices. So fast connectable mode on the 
LE acceptor side would be only used for testing purposes, or if spec is 
changed, or if single mode hw is supported in the future.

For BR/EDR, as Dmitriy explained, the fast connectable use case is to 
make headset to be able to connect faster when there is an incoming call 
(user switches headset on when call is alerting). It's an enhancement 
for headset connection time and usability.

It is currently implemented in hciops by changing page scan settings 
while incoming call is alerting. HCI commands Write Page Scan Activity 
and Write Page Scan Type are used to change page scan type from standard 
to interlaced and interval 1.28 s => 22.5 ms. This makes the incoming 
connection about 1 s faster. Settings are changed only for a short time 
to minimize impact on power consumption.

In my opinion BR and LE cases are quite different, so I think it would 
make sense to keep these separate and not to put them in one mgmt 
command. Could we just add a generic mgmt command for setting BR page 
scan parameters, for example "Set Page Scan Parameters Command" which 
would take parameters type (standard or interlaced), interval, and window?

Br,
Antti
