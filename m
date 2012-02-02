Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukzKLNC_bMtYeeParbgr8i1zgTR4XrZgytWjx0LCMhbkGjw@mail.gmail.com>
References: <1328025545-14320-1-git-send-email-sancane@gmail.com>
	<CAJdJm_NADwgGb-ZitDQNipgWoDQuRa1M+aQOMdzWmU81JpuNew@mail.gmail.com>
	<CACLukzKLNC_bMtYeeParbgr8i1zgTR4XrZgytWjx0LCMhbkGjw@mail.gmail.com>
Date: Thu, 2 Feb 2012 16:26:47 -0300
Message-ID: <CAKT1EBeLEmTi9GOSyNBAHt+ZZ_wfUoFGgoKy1k=Bk6sCvZyL8w@mail.gmail.com>
Subject: Re: [PATCH] device: Fix segmentation fault removing devices
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Jan 31, 2012 at 1:33 PM, Santiago Carot <sancane@gmail.com> wrote:
> Hi Anderson,
>
> 2012/1/31 Anderson Lizardo <anderson.lizardo@openbossa.org>:
>> Hi Santiago,
>>
>> On Tue, Jan 31, 2012 at 11:59 AM, Santiago Carot-Nemesio
>> <sancane@gmail.com> wrote:
>>> There is an unbalanced control regarding to the GATT channel and its
>>> attachid, we have to to update the attach id value by setting it to
>>> zero whenever we detach a GATT channel.
>>
>> Can you detail how to reproduce the segfault? I want to test on my own setup.
>>
>
> I simply remove a device with a GATT profile, I used thermometer and I
> saw that whenever the plugin called to
> btd_device_remove_attio_callback, inside this function it was using a
> NULL pointer in device->attrib to detach the channel, so I checked it
> and I saw that it only is paying attention to the device->attachid
> wich was unupdated because it isn't being set to 0 whenever the
> channel is detached.
>
>> Thanks
>>

Ack.

This bug is also easily reproducible after a local initiated disconnection.
For BLE keep the link up an call test-device disconnect "address"
followed by test-device remove "address"

Claudio.
