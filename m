Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140127181307.GB7831@x220.p-661hnu-f1>
References: <20140125005506.7AD85100900@puck.mtv.corp.google.com>
	<20140125221329.GB14531@x220.p-661hnu-f1>
	<CAGXr9JHEe+9gu-giUF=iH4LAv=FAAutYPeFY483DQU2r40wmkg@mail.gmail.com>
	<20140127181307.GB7831@x220.p-661hnu-f1>
Date: Mon, 27 Jan 2014 11:31:52 -0800
Message-ID: <CAGXr9JGm1OUnPHdM=m6nH66xQVjUgL=P3zmwJp-aj2f9whbEpQ@mail.gmail.com>
Subject: Re: [PATCH] Rename adapter_remove_device to btd_adapter_remove_device
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	johan.hedberg@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Once BlueZ host and the remote have been paired successfully the first
time, the remote has a key combination available that allows it to be
unpaired and reset to initial state. But, BlueZ won't know about that.
It still considers the remote paired. Thus, when the BD address
arrives to the IR-assist plugin again, the plugin needs to clear all
old state from BlueZ side and start over as if the device had never
been discovered before.

The old device removal and new device creation are handled in the
plugin, since the device creation part is not possible over D-Bus.
However, once the device is created, the pairing is handled in a
separate Python script.

-- Petri

On Mon, Jan 27, 2014 at 10:13 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Petri,
>
> On Sun, Jan 26, 2014, Petri Gynther wrote:
>> I would need this for the IR-assist device discovery plugin that I'm
>> writing. Basically, I have a HID remote control which is not
>> discoverable (but it is connectable). When this HID remote is in
>> unpaired state, it sends its BD address to the host via IR. The plugin
>> will get the BD address and do the following:
>>
>> device = btd_adapter_find_device(adapter, &device_bdaddr);
>> if (device) {
>>     /* remove old pairing and device info */
>>     btd_device_set_temporary(device, TRUE);
>>     btd_adapter_remove_device(adapter, device);
>> }
>
> If the device is only discoverable through IR why would there be an
> existing device object for it? And if there does exist a device object
> doesn't it mean it's already paired and you don't need to repair?
>
> Johan
