Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLNzU50vr3WtfOL=-JNkMz8ouqMgpyNAAeqFj8bZ4KzTg@mail.gmail.com>
References: <CAASrBQk2_QYYKAFoMvTUAbmHvAFW12O2yHjx-J1D1+JyNCJNFA@mail.gmail.com>
	<CAASrBQkPyee_J+cMHL+t+YCq=8QBiEnuhgB9aEdkgKQ1RM+vYA@mail.gmail.com>
	<CABBYNZLNzU50vr3WtfOL=-JNkMz8ouqMgpyNAAeqFj8bZ4KzTg@mail.gmail.com>
Date: Sun, 2 Aug 2015 17:00:57 -0600
Message-ID: <CAASrBQkrKVrbT4Rcv9eGtf_+yQoMGcSvPUF7uNGsYeEHUDyUOg@mail.gmail.com>
Subject: Re: bluetoothctl list-attributes command
From: Mark Rages <markrages@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Aug 2, 2015 at 2:48 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mark,
>
> On Sun, Aug 2, 2015 at 2:24 AM, Mark Rages <markrages@gmail.com> wrote:
>> On Wed, Jul 29, 2015 at 5:22 PM, Mark Rages <markrages@gmail.com> wrote:
>>> I solved my previous problem with list-attributes, but now I face another one.
>>>
>>> I am trying to interact with the heart rate monitor strap
>>> 'CB:D7:A0:40:C4:01' using bluetoothctl:
>>>
>>> $ bluetoothctl
>>> [NEW] Controller 00:02:72:C8:B1:AD qountdown [default]
>>> [NEW] Device CB:D7:A0:40:C4:01 mar
>>> [NEW] Service /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0023 Vendor
>>> specific (Primary)
>>> [NEW] Characteristic
>>> /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0023/char0026 Vendor
>>> specific
>>> [NEW] Characteristic
>>> /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0023/char0024 Vendor
>>> specific
>>> [NEW] Service /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0012
>>> Battery Service (Primary)
>>> [NEW] Characteristic
>>> /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0012/char0013 Battery
>>> Level
>>> [NEW] Descriptor
>>> /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0012/char0013/desc0015
>>> Client Characteristic Configuration
>>> [bluetooth]# connect CB:D7:A0:40:C4:01
>>> Attempting to connect to CB:D7:A0:40:C4:01
>>> Connection successful
>>> [mar]# list-attributes
>>> Service /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0023 Vendor
>>> specific (Primary)
>>> Characteristic /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0023/char0026
>>> Vendor specific
>>> Characteristic /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0023/char0024
>>> Vendor specific
>>> Service /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0012 Battery
>>> Service (Primary)
>>> Characteristic /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0012/char0013
>>> Battery Level
>>> Descriptor /org/bluez/hci0/dev_CB_D7_A0_40_C4_01/service0012/char0013/desc0015
>>> Client Characteristic Configuration
>>> [mar]#
>>>
>>> So only two services are listed.
>>>
>>> But according to the Nordic Semiconductor "Master Control Panel" app,
>>> this device offers six services:
>>>
>>> Generic Access (0x1800)
>>> Generic Attribute (0x1801)
>>> Heart Rate (0x180d)
>>> Battery (0x180f)
>>> Device Information (0x180a)
>>> Unknown (0x4001-ceed)
>>>
>>> list-attributes only lists the Battery and 0x4001 services.
>>>
>>> Why is list-attributes only showing two services?  How can I connect
>>> to the Heart Rate (0x180d) service?
>>
>> Is it possible to connect to subscribe to notifications on the heart
>> rate service?
>
> Try > notify on on the characteristic you want to receive notification.
>

Neither the heart rate service nor the characteristics within are
listed on the dbus.  So how can I subscribe to notification on them?

Regards,
Mark
markrages@gmail
