Return-Path: <jonas.holmberg@axis.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Do not change uart speed
To: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <20170207125342.21962-1-jonashg@axis.com>
 <59DECB69-AB06-4F66-8CE1-AA90A797285B@holtmann.org>
 <f6d456ea-427a-87ae-a35e-73c08edb6ad3@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
From: Jonas Holmberg <jonas.holmberg@axis.com>
Message-ID: <b549dc2e-d386-0654-f2db-18515a2929d9@axis.com>
Date: Mon, 13 Feb 2017 09:05:35 +0100
MIME-Version: 1.0
In-Reply-To: <f6d456ea-427a-87ae-a35e-73c08edb6ad3@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 02/10/2017 01:01 PM, Frédéric Danis wrote:
> Hello,
> 
> Le 10/02/2017 à 12:41, Marcel Holtmann a écrit :
>> Hi Jonas,
>>
>>> Do not change from init_speed to oper_speed per default since it may
>>> cause failures and timeouts if the uart cannot handle the new speed.
>>> orig_speed should probably be set using device tree instead.
>>> ---
>>> drivers/bluetooth/hci_bcm.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>> index 8f6c23c..7787f82 100644
>>> --- a/drivers/bluetooth/hci_bcm.c
>>> +++ b/drivers/bluetooth/hci_bcm.c
>>> @@ -809,7 +809,7 @@ static const struct hci_uart_proto bcm_proto = {
>>>     .name        = "Broadcom",
>>>     .manufacturer    = 15,
>>>     .init_speed    = 115200,
>>> -    .oper_speed    = 4000000,
>>> +    .oper_speed    = 0,
>>>     .open        = bcm_open,
>>>     .close        = bcm_close,
>>>     .flush        = bcm_flush,
>> I am generally fine with this, but the DT support for Broadcom UART
>> devices is not yet upstream. And we need to make sure this also works
>> for ACPI based devices. If we can get the max UART speed from ACPI,
>> then I am fine doing it this way.
> 
> Afair, the max UART speed is nor provided from ACPI, only the initial
> speed is provided, at least for the Asus T100TA.

Does that mean that I will need to patch the kernel for uarts that does
not support 4000000 baud until the DT patches have been merged, or is
there anything else that I can do?

It would be nice if this was a bit more obvious for the user somehow. I
had to use git bisect to figure out why I got random errors and timeouts
after upgrading to kernel version >= 4.2.

Regards
Jonas
