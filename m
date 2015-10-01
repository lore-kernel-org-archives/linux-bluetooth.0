Return-Path: <cyrus@holtmann.org>
Subject: Re: [alsa-devel] [RFC] MIDI over Bluetooth Low Energy
To: Felipe Tonello <eu@felipetonello.com>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
	<560D1893.6040509@ladisch.de>
	<CAGrhNMxmtt-5kZO-6me2sPQYeQ5wcpvonKqzbx7CEB5=RJ724Q@mail.gmail.com>
Cc: alsa-devel@alsa-project.org, linux-bluetooth@vger.kernel.org
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <560D1EC2.8010603@ladisch.de>
Date: Thu, 1 Oct 2015 13:53:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAGrhNMxmtt-5kZO-6me2sPQYeQ5wcpvonKqzbx7CEB5=RJ724Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Felipe Tonello wrote:
> On Thu, Oct 1, 2015 at 12:27 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Felipe Tonello wrote:
>>> I am planning to start the support of MIDI BLE profile[1].
>>>
>>> I suggest two main goals:
>>>  * To be transparent to applications, i.e., use rawmidi and sequencer
>>> ALSA interfaces to interact.
>>>  * To support peripheral and central BLE roles.
>>>
>>> My question is: what is the best way possible of doing it?
>>
>> Just write a (user-space) sequencer client.
>
> But this will limit to seq interface only. It will not be available
> via rawmidi interface, right?

Yes.  And why would this be a problem?

>>> They all have the problem of context switching between bluez plugin
>>> and alsa midi driver.
>>
>> Why would context switches be a problem?
>
> It is just too much travelling around.

It hasn't been a problem with any other MIDI application.


Regards,
Clemens
