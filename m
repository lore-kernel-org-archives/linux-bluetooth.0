Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4118CB27.6000402@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>	 <1092140041.4564.96.camel@pegasus>	 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk> <1092143505.4564.117.camel@pegasus>
In-Reply-To: <1092143505.4564.117.camel@pegasus>
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
Date: Tue, 10 Aug 2004 15:18:31 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:

|>As far as the existing snd-bt-sco source goes, I think there's a
|>significant amount of code that can be saved. Most of the code is dealing
|>with the ALSA integration, management of the mixer and pcm interfaces
etc.
|>The kernel thread that does the socket programming can be ripped out
|>(along with the ioctl handlers that set it up) and replaced with
|>timer-driven code which talks directly to the SCO module.
|
|
| I prefer the ALSA integration would be written from scratch, because the
| original driver was written for a 2.4 kernel and we must concentrate on
| the 2.6 series. The ALSA subsytem will be cleaned up in the next kernel
| releases and the magic casting stuff they do is still wrong.

Hm, OK if someone has the time to do this. I might have, if I do some
work on this as my final work for my study. Maybe I'll have to talk
about this with some professors. But I think it's not crazy enough to
make me happy with it ;)

Anyway, we'll get this. It's not like an alsa module is that hard to
write, even from scratch.

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGMsmQWC6DTWkDAoRArdpAKDG9djRipQay4i1/PRWBBiqFVZnZwCfeFGi
CoKHPJLgWaZRP62jgqFlu3g=
=wXN3
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
