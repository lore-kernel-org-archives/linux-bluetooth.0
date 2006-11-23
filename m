Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611231633.43210.denis.kenzior@trolltech.com>
References: <200611231526.09459.denis.kenzior@trolltech.com>
	<200611231552.16972.denis.kenzior@trolltech.com>
	<1164261535.4847.19.camel@localhost>
	<200611231633.43210.denis.kenzior@trolltech.com>
Date: Thu, 23 Nov 2006 07:51:07 +0100
Message-Id: <1164264667.16345.6.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus SDP API
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Denis,

> > > So hcid will never be responsible for allocating rfcomm channels?  I'm
> > > not sure that's a good idea, since everybody will implement it themselves
> > > (and probably get it wrong anyway)
> >
> > hcid can never be responsible for that, because that is the job of the
> > kernel. However I am playing with the idea of an RFCOMM server in form
> > of rfcommd in userspace that will allow simple RFCOMM based application
> > and services.
> >
> > For the more complex ones you have to do it by yourself anyway. And you
> > should make it open source anyway so we can tell you what went wrong ;)
> 
> Open sourcing it shouldn't be a problem.  Besides, our case is easy, we assume 
> we _own_ the device ;)  
> 
> I'm more thinking of KDE/GNOME useage and meshing with command line daemons.  
> I find it annoying that I have to know all the rfcomm channels, what they're 
> used by etc, as is the case now.  If there was a framework for doing this 
> intelligently, I think it would be of great benefit to everyone. The only 
> place to put it seems to be hcid at this time.  

actually you can ask the kernel to assign you the next free RFCOMM
channel if you really want to. That works perfectly fine and should be
enough for the complex applications.

If anyone mixes D-Bus and non D-Bus way of doing configuration and they
screw up, then I can't help them. We try to take everything possible
into account, but there are limits.

> > > I see two advantages to doing this.  The main use case would be to
> > > deprecate some aspects of sdptool and all the hairy code in there that
> > > does the registration.  Move all of it to XML/Binary files.  The second
> > > would be the completeness of the DBUS API.
> >
> > I am not buying the completeness argument. It is as simple as we don't
> > have a SetAddress method.
> >
> > The hairy code in sdptool is only for development and extending the
> > D-Bus API with development interfaces is not what I actually plan to do.
> > It should stay as clean as possible and every method must actually have
> > a user.
> 
> I understand, however such things are very useful to people who can't link to 
> GPL'd libraries.  I seem to recall that DBus API was supposed to address such 
> issues as well.  I'm not advocating throwing in everything and the kitchen 
> sink, but I feel in this particular case it is useful.

They can write a service-agent.c example a like to register their SDP
record without putting the source code under GPL. Again, it is doable,
but going the closed source path is maybe more complex than the open
source way. I can live with that.

> > > Well I can see several useful things you can do:
> > > - If hcid doesn't manage RFCOMM channels, how will an application know
> > > dynamically what channel is available?  Such an operation will never be
> > > atomic (another argument for doing it in hcid), but  at least you can do
> > > selection semi-intelligently.
> >
> > You should write a full service for any kind of these use cases.
> 
> Are you advocating writing a hcid interface for this? E.g.
> 
> org.bluez.RfcommChannelAllocator or ...?

As mentioned above. The operation is atomic, because the kernel controls
it. You either can listen on that channel or not. What I meant was that
you have to write your own service for all kinds of things, but that is
the whole point in separating everything into small pieces.

> > > - I can see a GNOME / KDE app that displays all services running on the
> > > local device, and use the UUIDs to identify exactly what type of service
> > > it is (e.g. for icons) without having to rely on Text descriptions from
> > > the DBus Service API.
> >
> > Then I would extend org.bluez.Service to return exactly that
> > information, but the whole intention of the D-Bus based API is to hide
> > as much Bluetooth specific things for the user interfaces as possible.
> 
> Hmm, this is a good idea by the way.  Perhaps the Service framework should 
> extract the Service UUID and make it available when a record is provided?  
> I'll try to look into this.

We will do this internally at some point to better support extended
inquiry, but I still don't see any need for an application to know that
kind of information.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
