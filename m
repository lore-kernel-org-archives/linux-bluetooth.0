Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4118D049.9060000@superbug.demon.co.uk>
Date: Tue, 10 Aug 2004 14:40:25 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Jonathan Paisley <jp-www@dcs.gla.ac.uk>,
   Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>	 <1092140041.4564.96.camel@pegasus>	 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk> <1092143505.4564.117.camel@pegasus>
In-Reply-To: <1092143505.4564.117.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> 
> 
> I prefer the ALSA integration would be written from scratch, because the
> original driver was written for a 2.4 kernel and we must concentrate on
> the 2.6 series. The ALSA subsytem will be cleaned up in the next kernel
> releases and the magic casting stuff they do is still wrong.
> 
> Regards
> 
> Marcel
> 
> 

The latest alsa cvs fixes the magic casting stuff.
