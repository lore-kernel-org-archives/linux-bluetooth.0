Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5dccebe0611210636l574f6e67y204c613e780e302f@mail.gmail.com>
Date: Tue, 21 Nov 2006 15:36:10 +0100
From: "Mikael Lindqvist" <li.mikael.spam@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] obex and d-bus (was permissions to set local name)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 11/21/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mikael,
>
> > > > Do you know of something that makes it possible to use d-bus to do
> > > > obex pushes? I have been looking for that but not found anything. The
> > > > reason why I haven't used d-bus for my project before is mainly
> > > > because of this, it would feel strange to have half the application
> > > > use d-bus and the other half not.
> > >
> > > It is actually on my list of things that I like to have, but my time is
> > > limited and so I might work on other stuff first.
> >
> > It would be useful... Just in case I would feel extra productive some
> > day, how would you envision this? By a separate daemon that would sit
> > and provide this service over d-bus, or would it be built in to hcid?
> > Or maybe first as a separate daemon, and if it seems stable enough
> > later it would be built into hcid?
>
> it should be a separate daemon or even process implementing the service
> agent interface.
>
> > And would it be a good idea to build it on top of openobex? What other
> > implementations of obex are there?
>
> Non that I know of and yes, OpenOBEX is the way to go.
>

I have been looking a bit at openobex (I need it for another project)
and I would like to have it using non-blocking sockets when doing
connects. Would I be right in assuming that this would be needed if we
were to implement a dbus service for obex as well? Unless we want the
dbus-obex-daemon to be multi threaded, and that gives me strange
feelings in the stomach. At least that's not the way hcid is made,
i.e. it uses non blocking sockets when doing sdp connections, am I
right?

I'm asking because I'm going to ask the openobex developers to accept
a patch which adds the possibility to use non blocking sockets for
connections (like sdp_lib can in bluez), and if I could say that it's
required for a d-bus service, it would add a bit of weight to my
arguments.

What do you think?

-- Mikael

-- Mikael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
