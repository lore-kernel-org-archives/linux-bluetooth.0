Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <E73D9A5BC4A2D711BBC600065BF3595F1C66CFA8@il06exm10>
From: Mandalia Hiren-AHM047 <hirenm@motorola.com>
To: "'bluez-users@lists.sourceforge.net'" <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth support on FC3
MIME-Version: 1.0
Content-Type: text/plain
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 21 Feb 2005 10:11:04 -0600

Thanks Alain. I tried that. The device now goes up for a while and resets after a few seconds. Any idea why that is happening?

Thanks,
hiren

> -----Original Message-----
> From: bluez-users-admin@lists.sourceforge.net [mailto:bluez-users-
> admin@lists.sourceforge.net] On Behalf Of Alain Volmat
> Sent: Friday, February 18, 2005 8:08 PM
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Bluetooth support on FC3
> 
> Hi Hiren,
> 
> the bluetooth device must be UP in order to be usable (and see the
> BDAddress
> with hcitool). Probably, hcid is not started in your current
> configuration so the module is not automatically put UP as soon as it is
> plugged.
> 
> or if you just want to put the module UP, then
> hcitool hci0 up
> is what you're looking for.
> 
> Alain
> 
> * Mandalia Hiren-AHM047 [Fri, 18 Feb 2005 at 17:24 -0600]
> <quote>
> > Hello,
> >
> > I recently installed Fedora Core 3 on my laptop. Before that I used
> Fedora Core 1. My Bluetooth USB device worked perfectly on FC1 but on FC3
> it doesn't. when I do a "hciconfig -a up" it shows my USB device but BD
> Address: 00:00:00:00:00:00 , and everything else zero. Basically it
> reports Bluetooth device DOWN.. following is the script..
> >
> > hci0: Type: USB
> > BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
> > DOWN
> > RX bytes:0 acl:0 sco:0 events:0 errors:0
> > TX bytes:0 acl:0 sco:0 commands:0 errors:0
> >
> > Any idea whats going on?
> >
> > Thanks
> > Hiren
> >
> >
> >
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> </quote>
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
