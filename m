Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PNH-1EZqVZp8ZXkU94p6cHJ-3yDcQ4srCX-JwTOSctXg@mail.gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
	<CAJdJm_PNH-1EZqVZp8ZXkU94p6cHJ-3yDcQ4srCX-JwTOSctXg@mail.gmail.com>
Date: Wed, 9 Nov 2011 15:03:17 +0100
Message-ID: <CACLukzKUXMPqDjghjXx1cm1T_b95CsH=s5Sg8HcxCBFm4BxWCw@mail.gmail.com>
Subject: Re: Health Thermometer Profile (HTP)
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson

2011/11/9 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi Santiago,
>
> On Wed, Nov 9, 2011 at 6:51 AM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> This is a new set of patches to enhance thermometer plugin fuctionality.
>> These patches enable watchers to receiave final/intermediate measurements
>> from thermometers devices.
>
> Out of curiosity, with this latest series, will we be able to use LE
> Health Thermometers? Or do you still have pending items?
>

Yes, of course, with these set of patches you should able to use a Thermometer.

> It would be nice if you share your TODO list regarding this profile,
> or current limitations (if any), on each series you send.

Ok,

At present, I'm working on this repository:
https://github.com/sancane/BlueZ

There you will able to see the current status of the plugin
implementation, there you can also find some pending patches wich I've
not yet submited to the list and so on.

On the other hand, there is nothing left more in my TODO list than
finishing the HTP implementation :-P

Regards.

>
>> [PATCH 1/6] Manage GATT attribute indications in handle callback.
>> [PATCH 2/6] Parse final measurement indication
>> [PATCH 3/6] Add org.bluez.ThermometerWatcher interface to default
>> [PATCH 4/6] Implement EnableIntermediateMeasurement D-Bus method
>> [PATCH 5/6] Implement DisableIntermediateMeasurement D-Bus method
>> [PATCH 6/6] Notify intermediate measurements
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
>
