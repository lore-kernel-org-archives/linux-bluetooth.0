Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200705100944.39791.akohlsmith-bluez@benshaw.com>
References: <4641DA61.8040709@tao-group.com>
	<200705100719.36399.akohlsmith-bluez@benshaw.com>
	<1178801877.25565.114.camel@aeonflux.holtmann.net>
	<200705100944.39791.akohlsmith-bluez@benshaw.com>
Date: Thu, 10 May 2007 15:51:40 +0200
Message-Id: <1178805100.25565.126.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] API documentation?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Andrew,

> > D-Bus is the solution for a generic IPC between applications or daemons
> > and the size of the system doesn't matter. I never said that D-Bus is
> > perfect, but it is time that all the embedded people that complain about
> > D-Bus actually start fixing it. Believe it or not, D-Bus is the way to
> > go for shrinking the memory footprint in your embedded systems, because
> > all applications will use the same IPC.
> 
> I understand your reasons for using D-Bus; I really do.  It's a pain in the 
> ass to try and maintain more than one IPC mechanism for any project, BlueZ or 
> otherwise.  I honestly don't fault you at all for selecting D-Bus, and my 
> aside from my recognition of it elegantly solving a particular problem for 
> you, I also tend to think that if you're using bluetooth you've likely got 
> enough memory for a full-blown message bus such as D-Bus as well.  
> Complaining about the requirement for D-Bus for BlueZ is kind of like 
> complaining about the need for the TCP part of the IP stack if all you're 
> using is UDP and ICMP.
> 
> Having said that, I tend to complain about D-Bus because it's so goddamned 
> convoluted, even for a regular desktop application.  I am chalking that up 
> mostly to my own ignorance on the use of and architecture of the message bus.
> 
> I disagree, however, that it's the bees' knees when it comes to unifying IPC 
> in all circumstances.  For many applications, both embedded and not, there is 
> absolutely NO NEED for an abstraction layer this "thick" -- I don't give a 
> rat's ass for introspection, data typing, nor any of the loftier goals that 
> D-Bus addresses.  IOCTLs are more than enough for most of my applications, 
> and the fact that they change from time to time... who cares?  Embedded 
> systems don't evolve nor do they get updated anywhere NEAR as quickly as 
> desktops.  When something changes it's because of a damn good reason, not 
> because of "hey wow, there's a new version out!"  Besides that, I get by, as 
> many others do, with FAR lighter IPC mechanisms, including passing pointers 
> around to shared data structures.
> 
> As I review what I've written here, I find myself idly wondering about 
> a "dbus-lite" -- a very thin emulation of the D-Bus API which strips away 
> everything that makes D-Bus so cool and lets us smaller guys put this issue 
> to rest once and for all.

I was thinking about embedded D-Bus (edbus) like what we and the Mono
project does with GLib. There was a potential sponsor of that project,
but the backed out and so I might not get started on it. However feel
free to fill in and get this done.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
