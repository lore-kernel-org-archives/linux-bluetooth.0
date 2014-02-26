Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <13751D39-57A3-4B04-9E1F-7BC4BE2DF4A7@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
 <1393362104-12175-16-git-send-email-andre.guedes@openbossa.org> <13751D39-57A3-4B04-9E1F-7BC4BE2DF4A7@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Wed, 26 Feb 2014 16:35:05 -0300
Message-ID: <CACJA=fWG5CTkoU52wQu5UhGeOY3uVpuo6qj4itv5GVzTzdr2kw@mail.gmail.com>
Subject: Re: [PATCH 15/17] Bluetooth: Add le_auto_conn file on debugfs
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 26, 2014 at 3:41 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patch adds to debugfs the le_auto_conn file. This file will be
>> used to test LE auto connection infrastructure.
>>
>> To add a new auto connection address we write on le_auto_conn file
>> following the format <address> <address type> <auto_connect>.
>>
>> The <address type> values are:
>>  * 0 for public address
>>  * 1 for random address
>>
>> The <auto_connect> values are (for more details see struct hci_
>> conn_params):
>>  * 0 for disabled
>>  * 1 for always
>>  * 2 for link loss
>>
>> So for instance, if you want the kernel autonomously establishes
>> connections with device AA:BB:CC:DD:EE:FF (public address) every
>> time the device enters in connectable mode (starts advertising),
>> you should run the command:
>> $ echo "AA:BB:CC:DD:EE:FF 0 1" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn
>>
>> To get the list of connection parameters configured in kernel, read
>> the le_auto_conn file:
>> $ cat /sys/kernel/debug/bluetooth/hci0/le_auto_conn
>>
>> Finally, to clear the connection parameters list, write an empty
>> string:
>> $ echo "" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn
>>
>> This file is created only if LE is enabled.
>
> I wonder if this should be prefixed with a command. For example like this:
>
>         "add <address> <address_type> [auto_connect]"
>         "del <address> <address_type>"
>         "clr"

Year, no problem. I'll do like that.

BR,

Andre
