Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4118C562.1050300@superbug.demon.co.uk>
Date: Tue, 10 Aug 2004 13:53:54 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de> <1092140041.4564.96.camel@pegasus>
In-Reply-To: <1092140041.4564.96.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

I don't know if this will help, but I will itemise the requirements that 
and alsa driver will need:

1) A ring buffer, that is then broken up into 2 or more chunks called 
periods. The userland application will set the buffer_size and period_size.
2) An interrupt or callback routine is called as each period reaches the 
headset speakers, same for capture from headset mic.
3) A hardware pointer value, that can be read at any time, and returns 
the current sample being played by the speakers, or as close as possible 
to it.
4) Latency between samples leaving the ring buffer and being played to 
the speakers should be as small as possible. This should be less than 
10ms. Optimum low latency is achieved using 2 periods per buffer.
5) The rate at which samples leave the ring buffer should be constant, 
and ideally under hardware control.

My suggestion for the SCO channel, is to use a fixed number, normally 2, 
of SCO packets in a loop.
1) User app fills buffer.
2) SCO takes X samples from ring buffer, creates a SCO packet, and sends 
it to the hardware.
3) SCO takes X more samples from the ring buffer, creates another SCO 
packet, and sends it to the hardware.
4) SCO then waits until SCO has finished (2), and only then takes X 
samples from the ring buffer, creates a SCO packet, and sends it to the 
hardware...then repeats.
5) Add a SCO api call, so that the higher level module can find out how 
much of the SCO packet has been output, and thus return accurate 
hardware pointer values.

In this way there are only ever 2 SCO packets in the pipeline.
It fixes the latency, and we always have an accurate idea of which 
sample is currently being played.

Summary: Limit the size of the SCO packet buffer to 2 packets, or some 
fixed even value.

Cheers
James
