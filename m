Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101027222602.GB24756@jh-x301>
References: <AANLkTikQqPqJdFgLpUrKiqyAC0HNUFnj+8NtbPxazY18@mail.gmail.com>
	<20101027222602.GB24756@jh-x301>
Date: Thu, 28 Oct 2010 10:57:33 +0200
Message-ID: <AANLkTimS8qU_kb94BBvnkQFDK32ssmEmHvbBefcfSkDx@mail.gmail.com>
Subject: Re: HFP Pulseaudio Source destroyed "too quickly" at the end of a call
From: =?ISO-8859-1?Q?Thomas_W=E4lti?= <twaelti@gmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	Krisztian.Litkey@nokia.com, Jyri.Sarha@nokia.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/10/28 Johan Hedberg <johan.hedberg@gmail.com>:
> Probably this isn't really BlueZ related, but the audio policy module
> (on the PulseAudio side) in the N900 kicks in and requests these changes
> to the audio streams. Unfortunately I'm not really an expert with that
> code (and afaik the audio policy part is closed) so I can't really offer
> more insight on the issue. Just speculating, but you might be able to
> accomplish something by hacking in some delays into the pulse bluetooth
> modules (but again, I'm not really familiar with them so this might not
> be a feasible approach).

Thanks for the prompt feedback, Johan.
I had looked at the PulseAudio Bluetooth Modules source
(http://git.0pointer.de/?p=pulseaudio.git;a=tree;f=src/modules/bluetooth;hb=HEAD)
before, but didn't see anything (but then, it's a bit over my head :-)
It seems like Joao Paulo Rechi Vita is the author of the relevant
source, and as he also did the Bluez HFP implementation (IIRC), I hope
he might shed a light on this. I'm asking on this list because once
HFP "hangs up", it probably issues some teardown event to its
consumers.

(It would be nice if I could get this solved this before heading to
the MeeGo conf in Dublin - see you there :-)

Best regards
-Tom
