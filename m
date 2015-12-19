Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADLK-zEQH4LiXZwwUUdj4FTqmJhm4-m7vhadR5q2XEQ66OUg7g@mail.gmail.com>
References: <1450426763-17753-1-git-send-email-gowtham.ab@samsung.com>
	<38CECA18-9BB8-4480-BA0F-027B87AB7A85@gmail.com>
	<CADLK-zEQH4LiXZwwUUdj4FTqmJhm4-m7vhadR5q2XEQ66OUg7g@mail.gmail.com>
Date: Sat, 19 Dec 2015 17:03:41 +0000
Message-ID: <CAAu3APbKSoUu7HbVLKtoBd6KjoQrt=82yRm3a70FrW6RR0hEAQ@mail.gmail.com>
Subject: Re: ARM SBC as a BLE Peripheral
From: Barry Byford <31baz66@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Travis,

On 18 December 2015 at 17:22, Gowtham Anandha Babu <gowbabuar@gmail.com> wrote:
> Hi Travis,
>
> On 18 December 2015 at 21:51, Travis Griggs <travisgriggs@gmail.com> wrote:
>> I’m working with a small Linux ARM SBC (similar to a Raspberry Pi), trying to set it up as a BLE peripheral.
>> I’m running Debian Jessie, and build 5.36 of the bluez stack.
I'm trying to do a similar thing with a Raspberry Pi. Although right
now I'm making more progress with the RPi in the central role rather
than a peripheral.

>> I *think* I’ve discerned that there may be 3 different ways I could do this?
>> 1) Just use the hcitool/hciconfig command line tools.
>> 2) There’s a C library. So write a C program that cross compiles for the ARM, including the ARM headers for the bluez stuff.
>> 3) There’s a dbus interface. I appear to have dbus running on my device.
I'm currently exploring your option number 3 using Python as I want to
take advantage to the numerous Python libraries for RPi peripherals.


> I am not that much familiar with embedded. But I tried below things in Ubuntu.
> There are few python scripts in bluez git tree which is using DBus interface.
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-server
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-advertisement
>
> 1) Run bluetoothd with experimental flag enabled (# sudo ./src/bluetoothd -ndE).
> 2) Run the above mentioned script.
> 3) # ./test/example-gatt-server -- it exposes 3 services.
> 4) # ./test/example-advertisement -- it will advertise a sample data.
> 5) Finally you can capture these via your phone app.
>
> You can edit those python scripts to meet your needs.
>
> This is very basic information. Let others comment on this.
I would agree with Gowtham that this is a good approach or at least
the one I'm following.

DBus and GObject are new to me and I found the following stackoverflow
article helpful:
http://stackoverflow.com/questions/33428804/role-of-mainloops-event-loops-in-dbus-service

The goal of my experiments is to get an open source library so school
children can easily code things like:
https://youtu.be/1ZvFdX5bA8k so if you do get something that you can
share I'd be interested.

Another idea you might want to explore is using the CLI client,
bluetoothctl. There are a few bits about it around and I've done a
short video of my experiments:
https://youtu.be/fEx2V5y-Egk

I hope some of that helps.

Regards,
Barry
