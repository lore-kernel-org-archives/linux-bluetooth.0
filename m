Return-Path: <cyrus@holtmann.org>
Message-ID: <54D0881B.2020009@mozilla.com>
Date: Tue, 03 Feb 2015 09:34:35 +0100
From: Thomas Zimmermann <tzimmermann@mozilla.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, Shawn Huang <shuang@mozilla.com>
Subject: Re: Extending BlueZ's HAL protocol
References: <54CB81F5.3000401@mozilla.com> <E422020A-9686-42FB-BB9A-2FEACDF59529@holtmann.org>
In-Reply-To: <E422020A-9686-42FB-BB9A-2FEACDF59529@holtmann.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

Am 30.01.2015 um 18:59 schrieb Marcel Holtmann:
> Hi Thomas,
>
>> On Mozilla's Firefox OS, we use a daemon for running Bluedroid drivers
>> in their own address space, and communicate with the daemon via BlueZ's
>> HAL protocol. [1]
>>
>> We'd like to use the HAL protocol as-is, but several commands are not
>> defined in the spec. We especially ran into this problem with
>> Bluedroid's |bt_interface_t::config_hci_snoop_log|. BlueZ has a
>> completely different mechanism for handling the command and probably
>> won't ever require an opcode for it. Just adding an opcode for
>> |config_hci_snoop_log| to our code base will probably collide with BlueZ
>> official spec in the long run.
>>
>> Our proposal is to reserve two opcodes per service for extensions to
>> commands and notifications. This would allow us to add the missing
>> pieces without opcode collisions.
> when you are using BlueZ for Android, we run the bluetoothd-snoop daemon to collect the traces. The reason why it is not in bluetoothd that provides all the other functionality is pretty simple. We do not have to and that is why we never bothered to define an opcode for it. That is the advantage of not being a huge monolithic block like Bluedroid.

It's not that easy in our case, I guess. We still run Bluedroid, but
wrapped it in it's own daemon and use BlueZ HAL protocol for
communication. We try to be compatible to BlueZ, so that we can replace
Bluedroid for BlueZ easily. However, we cannot drop Bluedroid, because
that's what Android chipset vendors support.

I think we somehow have to make our Bluedroid daemon call
|config_hci_snoop_log|. One idea is the proposed opcode for vendor
extensions (Mozilla would be the vendor in our case). The other idea
would be to write our own |bluetooth-snoop|, which uses a different
channel to instruct the Bluedroid daemon to call |config_hci_snoop_log|.

Best regards
Thomas

> We rely on the Bluetooth subsystem and its monitor (snooping) functionality. The big advantage having this in a separate process is that it will not interfere with any other operation bluetoothd has to do. The kernel can schedule bluetoothd and bluetoothd-snoop individually.
>
> So bluetoothd-snoop is essentially a mini version of btmon where its only feature is to store traces in the old BTSnoop format (Frontline compatible). That said, nothing is stopping you from actually running btmon or hcidump on the target platform or multiple of them. We could even write a USB gadget driver that exports the traces over USB and you could run btmon / Wireshark on a PC to collect them.
>
> Can you just run bluetoothd-snoop as well and get the tracing feature that way? If you build BlueZ for Android and run it that way, that is what happens through the developer menu. It is fully integrated into the Android UI and we have been running it that way for a long time now.
>
> Regards
>
> Marcel
>
