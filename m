Return-Path: <jp-www@dcs.gla.ac.uk>
Date: Tue, 10 Aug 2004 14:39:20 +0100 (BST)
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
cc: Marcel Holtmann <marcel@holtmann.org>,
   Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
In-Reply-To: <4118C562.1050300@superbug.demon.co.uk>
Message-ID: <Pine.LNX.4.59.9999.0408101435250.22497@brava.dcs.gla.ac.uk>
References: <4117AB9A.9010909@dark-reality.de>  <1092071356.4564.12.camel@pegasus>
  <4117B098.5020805@dark-reality.de>  <1092073167.4564.26.camel@pegasus>
 <4117C0AB.2010609@superbug.demon.co.uk>  <1092090364.4564.46.camel@pegasus>
 <41180E64.1010007@dark-reality.de> <1092140041.4564.96.camel@pegasus>
 <4118C562.1050300@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 10 Aug 2004 1:53pm +0100, James Courtier-Dutton wrote:

> 4) SCO then waits until SCO has finished (2), and only then takes X samples 
> from the ring buffer, creates a SCO packet, and sends it to the 
> hardware...then repeats.
> 5) Add a SCO api call, so that the higher level module can find out how much 
> of the SCO packet has been output, and thus return accurate hardware pointer 
> values.

Is this additional api call necessary? Suppose packets are about 24 bytes 
(that's what I remember them to be). So the suggestion is to have two of 
these in flight at a time. Given 8000 Hz sampling rate (equating to 8000 
or 16000 bytes per second if using 8bit or 16bit PCM, respectively), those 
24 bytes correspond to between 1.5 and 3ms.

In summary: isn't it sufficient to just keep track of what packets have 
been sent? This gives 3ms accuracy.

Thanks.
