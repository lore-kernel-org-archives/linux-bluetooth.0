Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <s5hfv1uvmjq.wl-tiwai@suse.de>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
	<560D1893.6040509@ladisch.de>
	<CAGrhNMxmtt-5kZO-6me2sPQYeQ5wcpvonKqzbx7CEB5=RJ724Q@mail.gmail.com>
	<s5hfv1uvmjq.wl-tiwai@suse.de>
Date: Thu, 1 Oct 2015 13:04:07 +0100
Message-ID: <CAGrhNMxUsUXBmYFLo4Bq=Mx1qdUZC1Zv7c4pXb+F8D8adYTvcg@mail.gmail.com>
Subject: Re: [alsa-devel] [RFC] MIDI over Bluetooth Low Energy
From: Felipe Tonello <eu@felipetonello.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>,
	linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Takashi,

On Thu, Oct 1, 2015 at 12:46 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 01 Oct 2015 13:35:48 +0200,
> Felipe Tonello wrote:
>>
>> Hi Clemens,
>>
>> On Thu, Oct 1, 2015 at 12:27 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> > Felipe Tonello wrote:
>> >> I am planning to start the support of MIDI BLE profile[1].
>> >>
>> >> I suggest two main goals:
>> >>  * To be transparent to applications, i.e., use rawmidi and sequencer
>> >> ALSA interfaces to interact.
>> >>  * To support peripheral and central BLE roles.
>> >>
>> >> My question is: what is the best way possible of doing it?
>> >
>> > Just write a (user-space) sequencer client.
>>
>> But this will limit to seq interface only. It will not be available
>> via rawmidi interface, right? Unless I load snd-virtmidi, correct?
>
> Right.
>
>> That was what I was suggesting at first, but I don't really like the
>> idea of loading snd-virtmidi for that.
>
> Well, many audio/music apps may talk directly sequencer API, too, so
> it's not too bad.  Whether loading snd-virmidi is a system setup
> question, and it'd be more or less static configuration like snd-seq
> core module.
>
>> >> [...]
>> >> They all have the problem of context switching between bluez plugin
>> >> and alsa midi driver.
>> >
>> > Why would context switches be a problem?
>>
>> It is just too much travelling around. GATT messages are parsed in
>> userspace by BlueZ, so it sounds unnecessary to copy buffers to the
>> kernel and copy back to user space to the application (ALSA).
>
> Of course it'd be optimal if we can avoid context switching, but
> usually its latency isn't too critical for MIDI, even on a much slower
> machine in 20 years ago.
>
> So, IMO, we should go for a simpler implementation at first.

Fair enough.

So, initially the best way to go would be to write a seq back-end
using D-Bus GATT API from BlueZ.

An important thing to notice is that this implementation doesn't
support BLE peripheral role.

Felipe
