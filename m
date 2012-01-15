Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120115105818.GA12769@x220.P-661HNU-F1>
References: <1326278147.6454.225.camel@aeonflux>
	<1686528.W7zB9hRLAY@uriel>
	<20120115105818.GA12769@x220.P-661HNU-F1>
Date: Sun, 15 Jan 2012 12:21:36 +0100
Message-ID: <CAKLz3G33gyobr1HDqmDKumO_He=0H=rxWsP2cx3_ErYk-Fb+RA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support for BCM20702A0 [0489:e031]
From: David Strobach <lalochcz@gmail.com>
To: David Strobach <lalochcz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jan 15, 2012 at 11:58, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Sat, Jan 14, 2012, David Strobach wrote:
>> > > > virtualbox and then running either usbmon or Wireshark on your Linux
>> > > > system should work just fine.
>> > >
>> > > O.K., here's what I found: running windows in virtualbox first then
>> > > shutting it down again: the adapter works in linux too until the next
>> > > reboot (still have to load the module and echo the ID to new_ID because
>> > > of the adapter not reconigzed by the actual bt module)
>> > > Doing a capture with wireshark on usb port 2 gives me the capture file
>> > > attached.
>> >
>> > so there is clearly some binary download in the capture file. It will
>> > most likely match the files that a referenced in the .inf file. However
>> > I am not reverse engineering this stuff for anybody. Someone else has to
>> > do that job.
>>
>> based on the trace and the .hex files I extracted from the Windows driver
>> package I wrote a simple python rampatch downloader script. I also started
>> writing a downloader kernel module. I have two questions though.
>>
>> Is there a need for a driver module at all?
>> The script seems to work well, so I think it would be sufficient to write a
>> statically linked libusb based binary downloader and distribute it along with
>> the rampatch files and an udev rule file.
>>
>> If the module is needed for whatever reason, is there a way to implement it
>> using btusb HCI interface functions?
>> The rampatch download process is basically a series of HCI commans sent to
>> control or bulk out endpoint. I could of course implement the payload
>> packaging myself, but I feel somehow, that a cleaner solution would be to use
>> some common subsystem mechanism.
>
> How is this all related to the Broadcom firmware uploader that was sent
> to this list back in November, or is that for some separate piece of
> hardware:
> http://www.spinics.net/lists/linux-bluetooth/msg17785.html

That seems to be for old BCM2045 Blutonium adapters.
