Return-Path: <frederic.danis.oss@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Do not change uart speed
To: Marcel Holtmann <marcel@holtmann.org>, jonas.holmberg@axis.com
References: <20170207125342.21962-1-jonashg@axis.com>
 <59DECB69-AB06-4F66-8CE1-AA90A797285B@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Message-ID: <f6d456ea-427a-87ae-a35e-73c08edb6ad3@gmail.com>
Date: Fri, 10 Feb 2017 13:01:05 +0100
MIME-Version: 1.0
In-Reply-To: <59DECB69-AB06-4F66-8CE1-AA90A797285B@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Le 10/02/2017 à 12:41, Marcel Holtmann a écrit :
> Hi Jonas,
>
>> Do not change from init_speed to oper_speed per default since it may
>> cause failures and timeouts if the uart cannot handle the new speed.
>> orig_speed should probably be set using device tree instead.
>> ---
>> drivers/bluetooth/hci_bcm.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index 8f6c23c..7787f82 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -809,7 +809,7 @@ static const struct hci_uart_proto bcm_proto = {
>> 	.name		= "Broadcom",
>> 	.manufacturer	= 15,
>> 	.init_speed	= 115200,
>> -	.oper_speed	= 4000000,
>> +	.oper_speed	= 0,
>> 	.open		= bcm_open,
>> 	.close		= bcm_close,
>> 	.flush		= bcm_flush,
> I am generally fine with this, but the DT support for Broadcom UART devices is not yet upstream. And we need to make sure this also works for ACPI based devices. If we can get the max UART speed from ACPI, then I am fine doing it this way.

Afair, the max UART speed is nor provided from ACPI, only the initial 
speed is provided, at least for the Asus T100TA.

Regards,

Frédéric
