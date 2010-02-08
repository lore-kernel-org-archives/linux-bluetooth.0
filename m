Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100207133015.GD28037@xs4all.nl>
References: <20100204220516.GC8556@xs4all.nl>
	 <1265399409.31341.241.camel@localhost.localdomain>
	 <20100207133015.GD28037@xs4all.nl>
Date: Mon, 8 Feb 2010 09:48:15 +0200
Message-ID: <2d5a2c101002072348xe83e0e0w5211a1bf2dd51327@mail.gmail.com>
Subject: Re: Problem with 'inquiry_cache' in sysfs
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Frank Maas <frank.maas@cheiron-it.nl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Feb 7, 2010 at 3:30 PM, Frank Maas <frank.maas@cheiron-it.nl> wrote:
> Hello Marcel,
>
>> > I am currently developing a system that relies heavily on the Linux
>> > bluetooth stack. That system uses the sysfs interface to the kernel
>> > module and more specifically the entry 'inquiry_cache' of the device
>> > "directory".
>>
>> that file should have been moved to debugfs, but we haven't done that
>> yet. It really doesn't belong in sysfs at all. And should not be treated
>> as an API.
>
> If I can be blunt: please remove it asap. It is very simple to make a
> system crash for a simple user while this is part of the distribution.
> And perhaps even worse options exists.
>
> I'd like to point out that the functionality it offers is of use. As far
> as I have seen the 'hcitool' offers an inquiry functionality, but that
> starts an inquiry itself. The 'benefit' of the current inquire_cache
> file is that one can use it without having to wait for an inquiry to
> finish and while knowing that the cache is pretty recent. Perhaps
> hcitool could be extended with an option for 'inq' that suppresses the
> inquiry itself?

Well if you use bluetoothd there is no such problem, it won't block
while inquiring/discovering and provide you dbus signals with the
important part of the inquire results.

Regards,


-- 
Luiz Augusto von Dentz
Computer Engineer
