Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141219115338.GA19036@ubuntu.localnet>
References: <20141216172421.GA12748@ubuntu.localnet>
	<20141217133613.GA18280@ubuntu.localnet>
	<1432274.34ricBdst7@uw000953>
	<20141219115338.GA19036@ubuntu.localnet>
Date: Fri, 2 Jan 2015 15:12:03 +0100
Message-ID: <CAA4A+aBQw1GdNWdM0QdSpkE4VG19=FPNA7Fw6RVydA9Oajn=ng@mail.gmail.com>
Subject: Re: ShanWan Sixaxis PS3 controller
From: Szymon Janc <szymon.janc@gmail.com>
To: Veseli Veseljko <veseljko75@gmail.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Veseli,

On Fri, Dec 19, 2014 at 12:53 PM, Veseli Veseljko <veseljko75@gmail.com> wrote:
> On Thursday, 2014-12-18, at 12:24:59 +0100, Szymon Janc wrote:
>> Typically DS3 should be handled like this:
>>
>> 1. make sure you don't have sixad/qtsixa installed as it was reported
>> that it conflicted with sixpair plugin (udev rules)
>
> I've uninstalled sixad and qtsixa.
>
>> 2. make sure you have sixaxis plugin installed - this plugin depends
>> on udev so it is not builin into bluetoothd but loaded on start from
>> /usr/lib/bluetooth/plugins
>
> Yes, plugin "sixaxis.so" is installed in
> "/usr/lib/i386-linux-gnu/bluetooth/plugins/".
>
>> 3. plug it into USB (don't press PS button yet) you should see
>> something like "sixaxis: compatible device connected: ...." in
>> bluetoothd logs
>
> Yes, I got it in the logs:
>
> ---begin---
> bluetoothd[24934]: sixaxis: compatible device connected: PLAYSTATION(R)3
>   Controller (054C:0268)
> bluetoothd[24934]: sixaxis: setting up new device
> ----end----
>
>> 4. unplug it
>> 5. press PS button
>>
>> Device should now connect and you should be asked (in bluetoothctl or
>> UI) to authorize connection. After that you should be able to
>> reconnect without need of pluging it with USB first.
>
> I did as you said, but I haven't been asked to authorize connection.
>
> I attached logs from bluetoothd run with "-d" and hcidump of what has
> happened when I pressed PS button.

It looks like this clone controller is rejecting SDP connection and as
result no input device is created.

I have to think a bit on how we could provide this info out-of-band in
clean way that is feasible for upstream inclusion...

>
>> This was mostly tested with genuine controllers. There were reports
>> that some of clone devices doesn't behave exactly the same ie. use
>> different pid/vid or don't report correct BT address over USB. Making
>> them work would probably require some extra work, but I don't have any
>> of those clone devices.
>
> I could order one of those clone controllers for you if you provide me
> your delivery address.

I'm a bit reluctant to this since I don't want to make any promises
about adding support for this device.

-- 
pozdrawiam
Szymon K. Janc
szymon.janc@gmail.com
