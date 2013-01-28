Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359170626.16748.4.camel@aeonflux>
References: <CAJ+AEyM4aZY80+Eo7g5=z+3t2fZB+n0rW6a02p8G2CJZ9JvAQQ@mail.gmail.com>
	<1359170626.16748.4.camel@aeonflux>
Date: Mon, 28 Jan 2013 09:45:24 +0000
Message-ID: <CAJ+AEyOWFZq+cvk2QNgY7ZCuuR0bBuUZqsrLUcHumYQNX8g78A@mail.gmail.com>
Subject: Re: What is involved in supporting SCO packets in HCI_RAW mode?
From: Eponymous - <the.epon@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for getting back to me so quickly Marcel.

Yes that sounds logical. I think it sounds like we are wanting connect
using USB another way in this case rather than trying to re-engineer
BlueZ to work in a way which it wasn't intended.

Cheers.

On Sat, Jan 26, 2013 at 3:23 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>
>> After the patch was added to btusb.c to allow ACL packets to be
>> sent/received in HCI_RAW mode I was wondering what would be involved
>> in allowing raw SCO packets to be sent/received?
>>
>> This would be a useful feature for someone like me who works with
>> Bluetooth firmware at this level on a daily basis.
>>
>> However, I can understand there may be some limitations.
>>
>> Is this something that can be realistically done?
>
> I do not see a way to do this properly. The main problem here is the USB
> transport. It requires special settings and active URBs.
>
> Once you switch it to HCI_RAW mode, the Bluetooth host stack does no
> command/event tracking and with that no connection tracking anymore.
> This means it can not inform the driver about any changes. And for USB
> it is required to change its alternate setting based on the number of
> connections and start ISOC URBs. Having ISOC URBs submitted all the time
> is not feasible either since that consumes way too much power.
>
> For other transports like UART, the SCO packets in HCI_RAW mode should
> still work.
>
> Regards
>
> Marcel
>
>
