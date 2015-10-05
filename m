Return-Path: <cyrus@holtmann.org>
Message-ID: <56129822.3020105@steev.me.uk>
Date: Mon, 05 Oct 2015 16:32:50 +0100
From: Steven Davies <linux-bluetooth-list@steev.me.uk>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Gone away BLE device still available in dbus
References: <56126614.5050303@steev.me.uk> <CABBYNZLniquNpn15AzarWYoe4npyrAW8OJMZwAVFGXsbTvO1Og@mail.gmail.com>
In-Reply-To: <CABBYNZLniquNpn15AzarWYoe4npyrAW8OJMZwAVFGXsbTvO1Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 05/10/15 15:11, Luiz Augusto von Dentz wrote:
> Hi Steven,
>
> On Mon, Oct 5, 2015 at 2:59 PM, Steven Davies
> <linux-bluetooth-list@steev.me.uk> wrote:
>> I have two BLE devices which are visible to the bluetooth stack on my
>> host machine. One of them is at the edge of the reception range and
>> sometimes the host can't connect to it. I would expect bluez to remove
>> the record of this device after a timeout (3 minutes?) but it doesn't
>> seem to. Instead, when trying to connect to the device I see this debug
>> output:
>
> Only if the device is temporary, but as soon as you attempt to connect
> to it will be considered persistent since you want to connect to it
> later. Note that BlueZ does use passive scanning in case a driver has
> auto_connect flag so it would reconnect automatically if the device
> start advertising, in that case it is even more important to keep the
> device registered in the bus so that you can disable auto connect by
> calling Device1.Disconnect or Device1.Block.
Does this mean that after a Disconnect, the device will then time out
(if it isn't seen again my active/passive scanning)?
>> Oct  5 12:35:57 bang bluetoothd[3801]: src/device.c:device_connect_le()
>> Connection attempt to: B0:B4:48:B9:77:03
>> Oct  5 12:36:17 bang bluetoothd[3801]:
>> src/adapter.c:connect_failed_callback() hci0 B0:B4:48:B9:77:03 status 2
>> Oct  5 12:36:17 bang bluetoothd[3801]: plugins/policy.c:conn_fail_cb()
>> status 2
>> Oct  5 12:36:17 bang bluetoothd[3801]:
>> src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:B9:77:03
>> type 1 status 0x2
>> Oct  5 12:36:17 bang bluetoothd[3801]:
>> src/device.c:device_bonding_complete() bonding (nil) status 0x02
>> Oct  5 12:36:17 bang bluetoothd[3801]:
>> src/device.c:device_bonding_failed() status 2
>> Oct  5 12:36:17 bang bluetoothd[3801]: src/adapter.c:resume_discovery()
>> Oct  5 12:36:17 bang bluetoothd[3801]: src/device.c:att_connect_cb()
>> connect error: Transport endpoint is not connected (107)
>> Oct  5 12:36:17 bang bluetoothd[3801]: src/device.c:att_error_cb()
>> Enabling automatic connections
>>
>> This returns the message "GDBus.Error:org.bluez.Error.Failed: Software
>> caused connection abort (36)" through dbus.
> We might need the HCI logs to know what could be causing this error,
> usually the error in case a page timeout occurs or passive scanning
> cannot find the device is host is down.
I can send an hcidump of when this next happens if that would help?

Thanks,
Steven Davies
