Return-Path: <cyrus@holtmann.org>
Message-ID: <4C4DD292.60001@Atheros.com>
Date: Mon, 26 Jul 2010 23:53:14 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC v2] Bluetooth: Provide access to reassembled Rx packets
References: <1280126094-18004-1-git-send-email-suraj@atheros.com> <1280157203.2621.48.camel@localhost.localdomain>
In-Reply-To: <1280157203.2621.48.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 7/26/2010 8:43 PM, Marcel Holtmann wrote:
> Hi Suraj,
>
>> Provide the HCI transport driver access to reassembled Rx packets before
>> sending to Host.
>
> you still haven't answered my question on why you want this. It makes no
> sense to me to relay all packets back to the driver. That is just a
> waste of CPU cycles.
>
> Regards
>
> Marcel
>
>

The requirement is simple. The driver need to know the status of certain 
vendor specific commands by checking the parameters of Command complete 
events.

We also have a requirements to verify the status of HCI RESET command to 
update power management feature.

If you are concerned about CPU cycle, we can limit this only for HCI 
events and not for ACL/SCO packets.

Please do let me know if you think there is an alternate way so that the 
HCI transport driver can access to HCI events.

Regards
Suraj
