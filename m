Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4118D39D.7000800@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Lars Grunewaldt <lgw@dark-reality.de>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>  <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>  <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>  <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>  <1092140041.4564.96.camel@pegasus>  <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk> <1092143505.4564.117.camel@pegasus> <Pine.LNX.4.59.9999.0408101412470.22497@brava.dcs.gla.ac.uk> <4118CBFE.1070404@dark-reality.de>
In-Reply-To: <4118CBFE.1070404@dark-reality.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 Aug 2004 14:54:37 +0100

Lars Grunewaldt wrote:
> Jonathan Paisley wrote:
> 
> | I haven't been keeping track of ALSA development recently. It sounds
> | like you're saying that the API is going to be changing enough that
> | simple modifications to the existing ALSA-interfacing code in snd-bt-sco
> | will not be enough to keep it up to date. Does this mean it would be
> | worth putting a hold on development of a properly-bluez-integrated
> | driver until the ALSA subsystem has stabilised?

The ALSA kernel driver subsystem has not changed at all(or maybe very 
minor bits), so the old snd-bt-sco will probably still work. What has 
changed is the obvious stuff, like what is needed to convert any kernel 
2.4.x module to 2.6.x.

> 
> possibly, I don't know that their status is either. snd-bt-sco compiles
> nice with kernel 2.6.7 (well nice... at least it does (Niko)) and also
> with alsa-driver-1.0.5a (myself)...
> 
> I'll try to take the time to read through the alsa dev information to
> find out what's going on there, but Marcel will be much more in touch
> with the kernel-related stuff.
> 
> At least I managed to get and look into the headset profile, that
> already helped much to clear things up :)
> 
> cu,
> ~  Lars

I have developed other alsa-kernel drivers, so I can help on alsa kernel 
specific questions, although I don't currently have any time to write 
and bluetooth/sco code.



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
