Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multiple Bluetooth connections
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42381733.50901@futurlink.com>
References: <42372E0A.80002@futurlink.com>
	 <1110966130.9818.95.camel@pegasus>  <42381733.50901@futurlink.com>
Content-Type: text/plain
Message-Id: <1110973480.9818.145.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 16 Mar 2005 12:44:40 +0100

Hi Pedro,

> > this is a hardware limit and I don't know of any chip that is capable of
> > establishing two connections at the same time. From what I know this
> > will never be possible, but you should better ask a radio/baseband
> > expert for a correct answer.
> >   
> Thank you for the information. Together with the post of Peter
> Stephenson (thank you, Peter), it seems that this problem cannot be
> circumvented as I want to connect to different devices (as I
> understand, various ACL connections; is this right?). I will have to
> live with it. :-(

you can have multiple ACL connections. If this is a CSR chip you need at
least the HCI 16.4 firmware on it. However you can't create them at the
same time. If one is established you can create another one. Up to seven
if you keep the roles (master/slave) correct.

> > > On the other hand, some connections die before sending the data, but it 
> > > seems that the file descriptor of this connection does not receive any 
> > > notification (I use select() on all file descriptors, with the file 
> > > descriptor in the read mask). I know that this could be due to a problem 
> > > with my program, a problem with OpenOBEX or the BlueZ version I am using 
> > > (it is not the latest). In any case, to track down the cause, I would 
> > > like to know how can I monitor the Bluetooth connections (at any level, 
> > > but preferably RFCOMM) that a process (or the whole system) has. What I 
> > > am looking for is a tool like netstat.
> > >     
> > 
> > Using poll() or select() is the right way. About what version of the
> > kernel and library/utils are we talking?
> >   
> I am using SuSE 9.1 with the latest updates from SuSE: kernel
> 2.6.5-7.147-default, bluez-libs 2.5-43 and bluez-utils 2.4-65. I know
> they are old, so it could perfectly be a problem with them; therefore
> I am planning an upgrade, but I am not quite sure whether I will be
> able to use the latest BlueZ upgrades. The problem with the lost
> established connections does not happen always, so I still have to
> look exactly why this happens. In any case, besides that, everything
> else works as expected. The only thing I am missing is a tool like
> "netstat" for Internet an Unix sockets. "lsof" does not give any
> information either. Is there anything of the like for BlueZ?

We don't have any tool like this. May you wanna check /proc/bluetooth/
and make use of hcidump.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
