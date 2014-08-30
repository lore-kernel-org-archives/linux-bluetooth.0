Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKbPeq9Xxr57EVOqLcY-TTLr6gM2a4yOxP_vBpukM+hqQ@mail.gmail.com>
References: <CAO+8wm_qbHMA8RZmiGQUw-55TDWCXvm+f2zrLCCYXXv7CcL08g@mail.gmail.com>
	<CABBYNZKbPeq9Xxr57EVOqLcY-TTLr6gM2a4yOxP_vBpukM+hqQ@mail.gmail.com>
Date: Fri, 29 Aug 2014 18:23:01 -0700
Message-ID: <CAO+8wm84JUdm4r5zY_eA5jZ1VjQKT94MdjEU0gQiHMekEiP3QA@mail.gmail.com>
Subject: Re: connecting to a Motion 2in1 wiimote clone
From: Kameron Larsen <kroylar@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 29, 2014 at 3:51 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Kameron,
>
> On Fri, Aug 29, 2014 at 1:47 AM, Kameron Larsen <kroylar@gmail.com> wrote:
>> Hello all,
>>
>> I'm having some difficulty in scanning and connecting to a device
>> using bluetoothctl. The device in question is a Motion 2in1 Wiimote.
>> Its basically a cheap chinese wiimote clone.
>>
>> When I try to scan using bluetoothctl the device never shows up. When
>> I try to scan using "hcitool scan --iac=liac", the device shows up as:
>>
>> 2A:04:84:80:13:41 Nintendo RVL-CNT-01
>
> That is strange bluetoothctl should see the device as well.
>
>> The device cannot be connected to in bluetoothctl but I can connect
>> using "hcitool cc 2A:04:84:80:13:41". If I connect using hctitool and
>> then immediately use "pair 2A:04:84:80:13:41" in bluetoothctl. It
>> looks like the device pairs but the wiimote disconnects before
>> finishing the process. If I then run "trust 2A:04:84:80:13:41",
>> bluetoothctl will show that the device connects anytime I press any
>> button, and then shortly disconnects.
>>
>> hcidump reveals that the something is wating for additional data but
>> it is not receiving what it expects.  Because this data was never
>> received the pairing process is left incomplete. However I can
>> reconnect by pressing any button on the remote. Whenever I do, it will
>> automatically disconnect after several seconds.
>
> Have to register an agent to do the pairing? You should be able to do
> that with bluetoothctl:
>
> agent on
> default-agent
>
>> Scouring the code, I've come to realize that this remote is not
>> responding to sdp queries and therefore bluez does not know what
>> services it supports. My logs show this error:
>>
>> 2A:04:84:80:13:41: error updating services: Input/output error (5)
>>
>> Without knowing the services (ie, HID) it fails in connect_event_cb
>> with the following error:
>>
>> Refusing input device connect: No such file or directory (2)
>
> It seems some, or perhaps most, gaming controllers do not have SDP
> working properly but first check if you are really able to pair
> properly because if you don't we wont be able to discover what service
> the remote device support.

I believe it has paired properly. At least bluetoothctl lists it as paired.

[bluetooth]# power on
Changing power on succeeded
[bluetooth]# agent
Missing on/off/capability argument
[bluetooth]# default-agent
No agent is registered
[bluetooth]# devices
Device 00:02:5B:02:65:2A Avantree Hive
Device 2A:04:84:80:13:41 Nintendo RVL-CNT-01
[bluetooth]# remove 2A:04:84:80:13:41
[DEL] Device 2A:04:84:80:13:41 Nintendo RVL-CNT-01
Device has been removed
[bluetooth]# untrust 2A:04:84:80:13:41
Device 2A:04:84:80:13:41 not available
[NEW] Device 2A:04:84:80:13:41 Nintendo RVL-CNT-01

(At this point, I run "hcitool cc 2A:04:84:80:13:41" in a separate
window, and immediately run the following command in bluetoothctl.)

[bluetooth]# pair 2A:04:84:80:13:41
Attempting to pair with 2A:04:84:80:13:41

(It pauses here until it times out according to hcidump, but then I
get these messages)

[CHG] Device 2A:04:84:80:13:41 Connected: no
[CHG] Device 2A:04:84:80:13:41 Paired: yes
Pairing successful
[bluetooth]#

At this pint the wiimote is already off. And the error I get from
bluetoothd in the logs is:
2A:04:84:80:13:41: error updating services: Input/output error (5)

I can then attempt to reconnect by pressing any button on the wiimote:
[CHG] Device 2A:04:84:80:13:41 Class: 0x002504
[CHG] Device 2A:04:84:80:13:41 Icon: input-gaming
[CHG] Device 2A:04:84:80:13:41 Connected: yes

But then after ~8 seconds:
[CHG] Device 2A:04:84:80:13:41 Connected: no

And the logs show:
Refusing input device connect: No such file or directory (2)
Refusing connection from 2A:04:84:80:13:41: unknown device

This I believe is correct behavior. As a comment in plugins/wiimote.c
says that if we don't connect to the input service right away, the
wiimote will turn off after about 5 seconds.

> In case the pairing actually works but we still fail to resolve the
> services you can create a custom plugin that upon detecting it is this
> specific device generates a proper SDP record and add HID UUID via
> btd_device_add_uuid.

Awesome thanks! I think this is necessary. It looks like the wiimote
is connecting (although some unusual process is needed for it to
actually show up in bluetoothctl) and pairing (but also terminating
due to a timeout). But when I reconnect, the device doesn't have any
services associated with it due to sdp browse failing, and so we can't
connect to its input device.
