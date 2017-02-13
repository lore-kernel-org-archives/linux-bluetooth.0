Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Do not change uart speed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <b549dc2e-d386-0654-f2db-18515a2929d9@axis.com>
Date: Mon, 13 Feb 2017 10:30:02 +0100
Cc: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <D9B3A7D8-06CC-4E39-B82E-1E21F36EF1BF@holtmann.org>
References: <20170207125342.21962-1-jonashg@axis.com>
 <59DECB69-AB06-4F66-8CE1-AA90A797285B@holtmann.org>
 <f6d456ea-427a-87ae-a35e-73c08edb6ad3@gmail.com>
 <b549dc2e-d386-0654-f2db-18515a2929d9@axis.com>
To: Jonas Holmberg <jonas.holmberg@axis.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonas,

>>>> Do not change from init_speed to oper_speed per default since it may
>>>> cause failures and timeouts if the uart cannot handle the new speed.
>>>> orig_speed should probably be set using device tree instead.
>>>> ---
>>>> drivers/bluetooth/hci_bcm.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>>> index 8f6c23c..7787f82 100644
>>>> --- a/drivers/bluetooth/hci_bcm.c
>>>> +++ b/drivers/bluetooth/hci_bcm.c
>>>> @@ -809,7 +809,7 @@ static const struct hci_uart_proto bcm_proto = {
>>>>    .name        = "Broadcom",
>>>>    .manufacturer    = 15,
>>>>    .init_speed    = 115200,
>>>> -    .oper_speed    = 4000000,
>>>> +    .oper_speed    = 0,
>>>>    .open        = bcm_open,
>>>>    .close        = bcm_close,
>>>>    .flush        = bcm_flush,
>>> I am generally fine with this, but the DT support for Broadcom UART
>>> devices is not yet upstream. And we need to make sure this also works
>>> for ACPI based devices. If we can get the max UART speed from ACPI,
>>> then I am fine doing it this way.
>> 
>> Afair, the max UART speed is nor provided from ACPI, only the initial
>> speed is provided, at least for the Asus T100TA.
> 
> Does that mean that I will need to patch the kernel for uarts that does
> not support 4000000 baud until the DT patches have been merged, or is
> there anything else that I can do?
> 
> It would be nice if this was a bit more obvious for the user somehow. I
> had to use git bisect to figure out why I got random errors and timeouts
> after upgrading to kernel version >= 4.2.

that is a good question and I do not know a clear answer to that. We have to set it to some value. Running these with the default speed of 115200 works, but is also not really acceptable if anybody wants to do A2DP streaming. So what value to pick?

Maybe we can do some ACPI overlay or DT overlay over ACPI to allow setting this externally. But I would have to refer to the ACPI and DT experts on this.

Regards

Marcel

