Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: HID Over GATT
Date: Wed, 25 Mar 2015 08:58:12 +0100
Message-ID: <5471283.ZkqiNuijOo@leonov>
In-Reply-To: <CAKafyqpoxYifTLCpazGFHG5g3dsvN-THX0eB9=xqVEpWD1EP+Q@mail.gmail.com>
References: <CAKafyqpoxYifTLCpazGFHG5g3dsvN-THX0eB9=xqVEpWD1EP+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wednesday 25 of March 2015 07:55:17 Prabhu Chawandi wrote:
> Hi All,
> 
>   Can any one help me understand, how can I use the
> sample/uhid/uhid-sample.c . I have built and ran it I dint get what it
> is doing?

You don't need to run this.

> With 5.28 there is no hidd daemon is there any alternative for that.
> I want my BT LE KBD and Mouse to be paired and connected to my
> embedded device not the Desktop linux.
> 
> Your inputs will be very helpful

HoG is handled by bluetoothd. Just pair with device and bluetoothd will take 
care of the rest.

so:
make sure bluetoothd is running

start bluetoothctl:
agent on
default-agent
scan on
scan off
pair <your_device_address>

-- 
BR
Szymon Janc
