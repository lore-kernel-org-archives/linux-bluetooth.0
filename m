Return-Path: <cyrus@holtmann.org>
Message-ID: <5374DAEF.40605@ahsoftware.de>
Date: Thu, 15 May 2014 17:19:11 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 2/2] bluetooth: raise HCI_CMD_TIMEOUT from 2s to 8s
References: <1400076025-5103-1-git-send-email-holler@ahsoftware.de>	<1400076025-5103-2-git-send-email-holler@ahsoftware.de> <CABBYNZLFutVy=Msz7=AAwXmo4wDHjv59GcLCedEzSrWjkLQ3cw@mail.gmail.com> <5374D452.8020709@ahsoftware.de>
In-Reply-To: <5374D452.8020709@ahsoftware.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 15.05.2014 16:50, schrieb Alexander Holler:
> Am 15.05.2014 14:54, schrieb Luiz Augusto von Dentz:

>> This timeout seems arbitrary so I suppose we can increase it if we
>> feel it is necessary but we used already different timeout for
>> different commands like HCI_POWER_OFF_TIMEOUT, so perhaps if we can
>> identify which command is more likely to timeout.
>>
>> We could perhaps auto reset if a command timeout if there is really no
>> other way to recover.
>
> It is arbitrary but 2s is not enough here. And as I've written in the
> description, there is absolutely no reason to keep this timeout
> unnecessarily short. No one cares if an error message appears after 2s
> or 8s if the communication with the dongle is in both cases broken
> afterwards.
>
> One of the commands I experieced the problem with was e.g.
> HCI_OP_DELETE_STORED_LINK_KEY or HCI_OP_WRITE_SSP_MODE.

The problem is that you can never be sure what the origin of a timeouted 
command was. It might have been e.g. the USB-subsystem through wich the 
command and the response has to travel (in case of USB dongles) and not 
the dongle itself.

Regards,

Alexander Holler
