Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4118FBFD.6000606@superbug.demon.co.uk>
Date: Tue, 10 Aug 2004 17:46:53 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>	 <1092140041.4564.96.camel@pegasus>	 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>	 <1092143505.4564.117.camel@pegasus> <4118D049.9060000@superbug.demon.co.uk>	 <1092145771.4564.148.camel@pegasus> <4118D6B9.3090708@superbug.demon.co.uk>	 <1092148473.4564.156.camel@pegasus> <4118E6A1.4030709@superbug.demon.co.uk> <1092151554.4564.188.camel@pegasus>
In-Reply-To: <1092151554.4564.188.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> 
> the point is in writing an ALSA driver and not changing the ALSA
> subsystem. The SCO driver is part of the Bluetooth subsystem and so it
> will go in by me. The ALSA subsystem provides an in-kernel API and that
> can be used without any acknowledge of the ALSA maintainer.

ALSA is very modularised. This separates the hardware specific driver 
stuff from the more general alsa kernel code. So, if you write your own 
ALSA driver hardware module, it will have to depend on other ALSA 
modules. The only ALSA API that is going to be stable is the user land 
alsa-lib, which talks to applications. Although the ALSA kernel API and 
ALSA low level hardware driver API has not changed in some time, the 
ALSA maintainer reserves the right to change it at any time without 
having to warn people, as alsa-lib hides all the changes from users.
It is therefore a good idea to place any ALSA specific code in the ALSA 
tree, so that the ALSA maintainers keep it's kernel API up to date.
This would then leave the BlueZ team to only have to worry about the 
ALSA to BlueZ API.

> 
> 
>>I was just offering to help with the submission.
> 
> 
> Thanks, but going through the ALSA CVS won't give me any advantage. I
> hope that I can talk with Jaroslav about the Bluetooth issue at the
> Linux-Kongress next month.

He does actually answer emails as well. ;-)

> 
> Regards
> 
> Marcel
> 

James
