Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Extending BlueZ's HAL protocol
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54D0881B.2020009@mozilla.com>
Date: Tue, 3 Feb 2015 05:47:25 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Shawn Huang <shuang@mozilla.com>
Message-Id: <17F6E0D4-FB7F-4DB5-ABC2-A3A8268D7748@holtmann.org>
References: <54CB81F5.3000401@mozilla.com> <E422020A-9686-42FB-BB9A-2FEACDF59529@holtmann.org> <54D0881B.2020009@mozilla.com>
To: Thomas Zimmermann <tzimmermann@mozilla.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

>>> On Mozilla's Firefox OS, we use a daemon for running Bluedroid drivers
>>> in their own address space, and communicate with the daemon via BlueZ's
>>> HAL protocol. [1]
>>> 
>>> We'd like to use the HAL protocol as-is, but several commands are not
>>> defined in the spec. We especially ran into this problem with
>>> Bluedroid's |bt_interface_t::config_hci_snoop_log|. BlueZ has a
>>> completely different mechanism for handling the command and probably
>>> won't ever require an opcode for it. Just adding an opcode for
>>> |config_hci_snoop_log| to our code base will probably collide with BlueZ
>>> official spec in the long run.
>>> 
>>> Our proposal is to reserve two opcodes per service for extensions to
>>> commands and notifications. This would allow us to add the missing
>>> pieces without opcode collisions.
>> when you are using BlueZ for Android, we run the bluetoothd-snoop daemon to collect the traces. The reason why it is not in bluetoothd that provides all the other functionality is pretty simple. We do not have to and that is why we never bothered to define an opcode for it. That is the advantage of not being a huge monolithic block like Bluedroid.
> 
> It's not that easy in our case, I guess. We still run Bluedroid, but
> wrapped it in it's own daemon and use BlueZ HAL protocol for
> communication. We try to be compatible to BlueZ, so that we can replace
> Bluedroid for BlueZ easily. However, we cannot drop Bluedroid, because
> that's what Android chipset vendors support.

can you tell me what's your chipset manufacturer? I mean there is almost no chance that you are running on a Bluetooth chip that can not be easily supported with BlueZ. All of them talk HCI and the only difference is some minimal firmware loading, UART baudrate setting or other tiny details. Supporting a Bluetooth chip with BlueZ is most likely a lot easier than with Bluedroid.

You also realize that you can run Bluedroid on top of Bluetooth HCI User Channel feature in the kernel. That way you use the kernel side HCI infrastructure and existing drivers. At that point tools like hcidump, btmon and even hcitool will just work as usual. It is a pretty nifty trick actually. There is a libbt-vendor from Intel that will allow you to run Bluedroid on top of Bluetooth kernel subsystem using HCI User Channel. It is only a few hundred lines of code.

Or have you actually tried to use the vendor provided libbt-vendor and hook it into BlueZ via /dev/vhci. That should actually work easily. So like a tiny libhybris for Bluetooth. I say tiny since all Bluetooth chips talk HCI and it will be pretty much super simple.

> I think we somehow have to make our Bluedroid daemon call
> |config_hci_snoop_log|. One idea is the proposed opcode for vendor
> extensions (Mozilla would be the vendor in our case). The other idea
> would be to write our own |bluetooth-snoop|, which uses a different
> channel to instruct the Bluedroid daemon to call |config_hci_snoop_log|.

We could potentially add such an opcode that does emulate this piece of HAL detail. We did not add it since for us running HCI tracing / snooping in the same core process was never a viable option.

If you would try to use HCI User Channel or wrap libbt-vendor into a /dev/vhci as mentioned above, then you would actually not have to and could just run bluetoothd-snoop like we do.

Regards

Marcel

