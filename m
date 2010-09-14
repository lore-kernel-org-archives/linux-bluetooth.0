Return-Path: <cyrus@holtmann.org>
Message-ID: <4C8F160B.4010401@Atheros.com>
Date: Tue, 14 Sep 2010 11:58:27 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
References: <1284374584-12282-1-git-send-email-suraj@atheros.com> <1284442946.2405.50.camel@localhost.localdomain>
In-Reply-To: <1284442946.2405.50.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 9/14/2010 11:12 AM, Marcel Holtmann wrote:
> Hi Suraj,
>
>> Below is the Sim Access Profile server role API discription.
>> Please let me know your comments.
>
> my obvious question is why do we wanna do this over D-Bus and not
> connect it directly to the hardware via a plugin?

You meant creating something like a tty device and let the hardware 
connect directly to this?

The initial plan was to use a D-Bus file descriptor and transfer the SAP 
packets to the agent over it.

The problem was the SAP packet format is specified by the Bluetooth SAP 
spec. I could not relate it to any generic packet format ( Like HF, HS, 
DUN can be mapped to an AT parser).

I am not sure if any existing card reader implementation could parse it 
to extract SIM card related data (APDU) without additional support for it.

Another reason I thought about D-Bus was because, most of the SAP 
operations are Request/Response type like Reset, SimOn etc.

It mapped better with a Method/Signal communication than packet transfer.

Some of the card reader implementation I checked had proprietary packet 
format. So not sure how we could interface with them.
>
> Remember that SIM transaction are timing critical and just relaying them
> over D-Bus doesn't sound the right approach right now. While of course
> even bluetoothd can't guarantee and response time, it is clearly better
> than over D-Bus.
>

I would really appreciate if you can give me any idea about working 
around the above mentioned issues.

> Regards
>
> Marcel
>
>

Regards
Suraj
