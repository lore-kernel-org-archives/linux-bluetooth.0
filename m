Return-Path: <bluez-devel-admin@lists.sourceforge.net>
In-Reply-To: <4118EEEB.4010602@superbug.demon.co.uk>
References: <4117AB9A.9010909@dark-reality.de>     <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>     <1092073167.4564.26.camel@pegasus>     <4117C0AB.2010609@superbug.demon.co.uk>     <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>     <1092140041.4564.96.camel@pegasus>     <4118C562.1050300@superbug.demon.co.uk>     <Pine.LNX.4.59.9999.0408101435250.22497@brava.dcs.gla.ac.uk> <4118DAF9.2080204@csr.com> <4118EEEB.4010602@superbug.demon.co.uk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3A71B5F8-EAFD-11D8-A26F-000D932E1CC8@dcs.gla.ac.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
To: James Courtier-Dutton <James@superbug.demon.co.uk>
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
Date: Tue, 10 Aug 2004 19:43:53 +0100


On 10 Aug 2004, at 16:51, James Courtier-Dutton wrote:

> So, I suggest we might do better if we provide a number of different=20=

> ways to get sound to bluetooth devices, in order of preference.
> 1) PCM as Carl suggests
> 2) Bypass HCI stack and send SCO direct to USB devices. I don't think=20=

> one can do that for UART based devices. I don't know what is best for=20=

> PCI devices, as I have not looked at the PCI source code. I=20
> concentrated on the USB source code when I tried before.
> 3) Current HCI stack method. <- Last resort.

=10Perhaps somebody with more bluetooth know-how can comment here, but:

  1) I thought PCM was for connection from the bluetooth chip to some=20
other hardware (e.g., a physical earpiece). That's not an option for=20
getting audio to the computer unless the device in question has some=20
funky other connection to the computer.

  2) Isn't the SCO-over-USB standard defined in terms of the HCI=20
protocol? How do you go about bypassing it?



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
