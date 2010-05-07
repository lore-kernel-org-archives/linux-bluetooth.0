Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE39B28.2070504@atheros.com>
Date: Fri, 7 May 2010 10:16:32 +0530
From: Suraj Sumangala <suraj@atheros.com>
MIME-Version: 1.0
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
CC: Max Krasnyansky <maxk@qualcomm.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: multiple HCI_UART protocols over hci_ldisc
References: <549642.78851.qm@web94902.mail.in2.yahoo.com>
In-Reply-To: <549642.78851.qm@web94902.mail.in2.yahoo.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi pavan,

Pavan Savoy wrote:
> Max,
> 
> --- On Fri, 7/5/10, Max Krasnyansky <maxk@qualcomm.com> wrote:
> 
>> From: Max Krasnyansky <maxk@qualcomm.com>
>> Subject: Re: multiple HCI_UART protocols over hci_ldisc
>> To: "Pavan Savoy" <pavan_savoy@yahoo.co.in>
>> Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "Marcel Holtmann" <marcel@holtmann.org>
>> Date: Friday, 7 May, 2010, 4:00 AM
>> On 05/06/2010 03:04 PM, Pavan Savoy
>> wrote:
>>> Hi Marcel,
>>>
>>> I am working on a line discipline which in many
>> respects is similar to the hci_ldisc, but only extended to
>> do plenty of other functionality.
>>> One road block which i have hit is to support multiple
>> devices/or as Alan Cox puts it "avoid single device limits"
>>> So, in somewhat relation to this, I wanted to ask, If
>> in a system I have 2 UARTs both connected to BT chips but
>> only from different vendors say TI/HCI-Ll and broadcomm with
>> BCSP ..
>>> Can I have those 2 protocols on top of HCI-ldisc on
>> different UARTs at the same time?
>>> Is something like that feasible?
>> Sure. You'll get two separate HCI devices in that case.
> 
> But there seems to be only 1,
> static struct hci_uart_proto *hup[HCI_UART_MAX_PROTO];
> int hci_uart_register_proto(struct hci_uart_proto *p)
> {
>         if (p->id >= HCI_UART_MAX_PROTO)
>                 return -EINVAL;
> 
>         if (hup[p->id])
>                 return -EEXIST;
> 
>         hup[p->id] = p;
> 
>         return 0;
> }
> 
> So, If suppose I have 2 UARTs both on which HCI-Ldisc exists, and I try say HCI-LL on both, Now won't I get a -EEXIST for the 2nd HCI-LL ?
> 
> I am a bit confused, can you explain in brief ?
> Is there a possibility of copies of *hup[HCI_UART_MAX_PROTO] for each UART?
> 
>> Max
>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

The call "hci_uart_register_proto()" is used to register each protocol, 
not each device.

Each protocol calls this API to register themselves during module load, 
and will be called only once for each protocol during the module's lifetime.

Checkout the functions under #ifdef inside "hci_uart_init()". each of 
them will be calling "hci_uart_register_proto()" to register themselves.

Whenever you attach a UART BT device, "hci_uart_set_proto()" will be 
called and this will be responsible for creating an hci device, Not 
"hci_uart_register_proto()"

Regards
Suraj
