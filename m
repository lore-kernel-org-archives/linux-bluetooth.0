Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201206251429.44637.oneukum@suse.de>
References: <1340312488.2203.16.camel@iseult>
	<201206220826.36147.oneukum@suse.de>
	<1340441172.2390.9.camel@iseult>
	<201206251429.44637.oneukum@suse.de>
Date: Mon, 2 Jul 2012 18:22:30 +0800
Message-ID: <CAKzePaoOQoXjx5QeRJPCcfOdfULF+EZ9BXf8ihM84YL9rb3D6Q@mail.gmail.com>
Subject: Re: Bluetooth dongle (13d3:3304) not responding after reboot until suspend/resume
From: Al Cho <acho@suse.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: James <theholyettlz@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 25, 2012 at 8:29 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Samstag, 23. Juni 2012, 10:46:12 schrieb James:
>> On Fri, 2012-06-22 at 08:26 +0200, Oliver Neukum wrote:
>>
>> > Basically the device is semi-reset and ath3k cannot deal with a device
>> > in that state. But that doesn't tell us what can be done. Please post "lsusb -v"
>> > of your device _before_ ath3k is loaded (you should disable ath3k and btusb
>> > for that test) in both states, after cold boot and warm reboot from Windows.
>>
>> I blacklisted ath3k and btusb and captured the following lsusb -v
>> outputs for the device, which are attached with names as follows:
>>
>> 1. lsusb-cold_linux.log
>>    Taken from a cold boot straight into Linux. [Manually loaded ath3k
>>    and btusb afterwards, and everything worked properly.]
>>
>> 2. lsusb-after_win7.log
>>    Taken after warm reboot into Linux from Windows 7. Here, lsusb -v
>>    worked without the strange delay.
>
> Hm. This is a bit problematic as we already do a reset in the enumeration
> process. And we cannot tell the states apart based on the descriptors.
> Al, any idea?
>

Yes,
James,would you please help us to get these log from test with unplug
and plug-in,
after warm reboot into Linux from Windows 7 ?

Sincerely,
                  AL
