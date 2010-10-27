Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Oct 2010 18:26:02 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Thomas =?iso-8859-1?Q?W=E4lti?= <twaelti@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Krisztian.Litkey@nokia.com,
	Jyri.Sarha@nokia.com
Subject: Re: HFP Pulseaudio Source destroyed "too quickly" at the end of a
 call
Message-ID: <20101027222602.GB24756@jh-x301>
References: <AANLkTikQqPqJdFgLpUrKiqyAC0HNUFnj+8NtbPxazY18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikQqPqJdFgLpUrKiqyAC0HNUFnj+8NtbPxazY18@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Wed, Oct 27, 2010, Thomas Wälti wrote:
> I'm developing an application that records all kinds of audio using GStreamer.
> Target platform is the Nokia N900, the app is called Recaller
> (http://maemo.org/downloads/product/Maemo5/recaller/)

Looks like a pretty cool app!

> All works well except when ending the recording of Bluetooth
> Conversations: Once a party hangs up the call, the PulseAudio source
> and sink disappear before I can stop GStreamer recording (I'm
> listening to D-Bus events). Unfortunately, this causes my GStreamer
> pipeline to crash.
> 
> Is there a way to either delay the destruction of the sink/source by
> Bluez or a D-Bus message I could intercept/attach to? How can I "win
> the race"?

Probably this isn't really BlueZ related, but the audio policy module
(on the PulseAudio side) in the N900 kicks in and requests these changes
to the audio streams. Unfortunately I'm not really an expert with that
code (and afaik the audio policy part is closed) so I can't really offer
more insight on the issue. Just speculating, but you might be able to
accomplish something by hacking in some delays into the pulse bluetooth
modules (but again, I'm not really familiar with them so this might not
be a feasible approach).

Johan
