Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <b5c638dc0503290934170df12@mail.gmail.com>
From: David Vitrant <prussia@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluez and billionton pcbtc1
In-Reply-To: <b5c638dc05032909155d940a3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <b5c638dc05032815321b2739c5@mail.gmail.com>
	 <1112075117.9016.60.camel@pegasus>
	 <b5c638dc05032907582bf771dc@mail.gmail.com>
	 <1112114217.9016.92.camel@pegasus>
	 <b5c638dc050329084145c6fecd@mail.gmail.com>
	 <1112114986.9016.94.camel@pegasus>
	 <b5c638dc05032908584e207be8@mail.gmail.com>
	 <b5c638dc05032909155d940a3c@mail.gmail.com>
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
Date: Tue, 29 Mar 2005 12:34:39 -0500

ok sorry for the update.. i ran this command

hciattach ttyS14 any 16550

(From the above hints you gave me :) ) and something happenned in dmesg.. 

i think it's working .. gnome-bluetooth manager still gives me the
gconf error . and gnome authentication error (no ideas.. and nobody
has been able to answer me on what that error is.. plus a google
search didn't pull anything up"

i think this great now :) gotta figure out how to get my mouse working
somehow.. thanks again for your time patience and the great utility.

David 
p.s. anymore hints would be great


"
(Bluetooth Device Manager:7464): GnomeUI-WARNING **: While connecting
to session manager:
Authentication Rejected, reason : None of the authentication protocols
specified are supported and host-based authentication failed.

(Bluetooth Device Manager:7464): GConf-CRITICAL **: file
gconf-client.c: line 547 (gconf_client_add_dir): assertion
`gconf_valid_key (dirname, NULL)' failed

"


On Tue, 29 Mar 2005 12:15:37 -0500, David Vitrant <prussia@gmail.com> wrote:
> one more question actually
> 
> i looked at the list.. and i wanted to use my little mouse as hid (one
> of the reasons for bt, and also gettign phone and axim working)
> 
> but didn't find it on the list..
> 
> http://www.holtmann.org/linux/bluetooth/hid.html
> 
> http://computerlogin.com/sales/productfile/Y_BlueTMouse.html
> 
> do i need to do anything special to "pair" them.. like do i need a
> hardware id from the mouse or can i just push the paring button on the
> mouse.. look for it.. and poof it's there (minus the paring pin i need
> i think"
> 
> Thanks again
> David
> 
> 
> On Tue, 29 Mar 2005 11:58:20 -0500, David Vitrant <prussia@gmail.com> wrote:
> > hmm.. cool.. how do i do that ? where should i look
> >
> > (completely clueless asi  mentioned before :) )
> >
> > thanks,
> > David
> >
> >
> > On Tue, 29 Mar 2005 18:49:46 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> > > Hi David,
> > >
> > > > yep i saw that last time i stuck the card in, but didn't quite figure it out
> > > >
> > > > here's the output from dmesg:
> > > >
> > > > ttyS14 at I/O 0x400 (irq = 3) is a 16C950/954
> > >
> > > and now you only need to find the right hciattach parameters to get this
> > > serial port attached to the Bluetooth subsystem.
> > >
> > > Regards
> > >
> > > Marcel
> > >
> > > -------------------------------------------------------
> > > SF email is sponsored by - The IT Product Guide
> > > Read honest & candid reviews on hundreds of IT Products from real users.
> > > Discover which products truly live up to the hype. Start reading now.
> > > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >
> >
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
