Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <fb2ac3c90708101001v230e5f19j5f71a0213e163c89@mail.gmail.com>
References: <fb2ac3c90708092110y3a4ffff1ka8d5ea1ebdd17e32@mail.gmail.com>
	<1186736578.20129.202.camel@violet>
	<fb2ac3c90708101001v230e5f19j5f71a0213e163c89@mail.gmail.com>
Date: Fri, 10 Aug 2007 19:47:43 +0200
Message-Id: <1186768063.20129.253.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluetooth-applet and gnome-vfs-obexftp
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

> First let me say, Marcel, that I didn't mean any personal offense to
> you.  Please don't feel under-appreciated for all the good work you're
> putting into bluez-gnome.  I'm glad to get a response from you.

don't worry, I am really bad when it comes to UI programming. I do
prefer kernel code.

> If you don't agree with anything else I say please at least consider
> this:  The applet should not offer to browse an obex-ftp device unless
> gnome-vfs-obexftp is installed.  It probably needs to be a run-time
> dependency so that distros that offer vfs-obexftp but not by default
> can expect the applet to work properly.

We had a patch for it. It was so ugly that I simply dropped it.

> I'm trying to help Ubuntu's next release not have a prominent new
> feature that doesn't work out of the box.  They aren't including
> gnome-vfs-obexftp by default in gutsy (maybe they'll change their
> mind?) so it looks a bit ugly when you get an error message saying you
> can't browse the thing bluetooth-applet says you can browse.

I thought they gonna have it. I know that it has its bugs, but I don't
see any reason why it is not in there. Anyway you can patch it out of
the code if you really want to. It is only a few lines of code.

> > it is exactly the right entry point. You might wanna compare how MacOS X
> > handles it. The actual bonding will be done automatically. You are the
> > client and so we can rely on the actual FTP server to ask for a bonding
> > and not wasting time to try to pair a public FTP repository that has no
> > key anyway.
> 
> Good point that the bonding should be / is done automatically.  I
> still think the applet is the wrong place for OBEX though - mostly
> because I think nautilus /is/ the right place for it.
> 
> MacOS X does it the wrong way IMHO.  They treat their bluetooth ftp
> like a GUI ftp client rather than just another location in the Finder.
>  Gnome is doing it better by having a vfs module to support it, and
> Maemo (Nokia N800 / 770, for which gnome-vfs-obexftp was written)
> takes it one step further in the right direction by showing you your
> device in the file manager if it's connected.  It does this in much
> the way I proposed here.  (Yes, I know that this isn't the right place
> to propose that change.  Sorry about that.)

As I said, I don't care if someone actually starts integrating it much
deeper into GNOME. It won't be me since dealing with bluez-gnome and
getting that part right is hard enough.

> > It only supports Bluetooth FTP and is not meant to support everything.
> > So I have no idea what you are talking about. Use the preferences dialog
> > or the upcoming wizard to connect other type of Bluetooth devices.
> 
> I have discussed this with James Henstridge a little and while he's
> not opposed to adding support for other transports to
> gnome-vfs-obexftp he would agree that the other transports are a lower
> priority.  My main concern is that we'll hard-code obex = bluetooth
> everywhere so that if someone extends gnome-vfs-obexftp to support USB
> and other transports there won't be any place for it in gnome anyway.

I don't see a big problem here. It is only a matter of getting the URI
syntax right. You can easily differentiate between a USB device URI and
a Bluetooth address URI.

> I'd also love to see Edd Dumbill's gnome-obex-server and
> gnome-obex-send support other transports, particularly IrDA.  In a
> perfect world it would also advertise itself via Avahi and support
> file push over TCP.

Check out the obex-data-server project from Google SoC. It will
initially only support Bluetooth, but that one can be easily extended to
support transports like TCP/IP.

> > We know that OBEX supports more than the Bluetooth transport, but which
> > of these transports actually have devices that support FTP like
> > transactions. Most of them only allow to push or pull a file. However
> > feel free to fix gnome-vfs-obexftp to make this work.
> 
> Quite a lot of devices support OBEX FTP over USB - and USB is a lot
> faster and some more reliable than BT.  Probably far fewer devices
> that use OBEX over IrDA support anything but PUSH.  And there may in
> fact be no services or devices that do OBEX FTP over TCP, but the
> underlying library (openobex) and the commandline client (obexftp)
> support all of these.

Be my guest in addressing this. I only had a brief look at the
gnome-vfs-obexftp to make it use RFCOMM sockets directly and I didn't
even write the final patch. That's it. I am not involved in it.

> > If you wanna have the Bluetooth adapters (yes, plural. We can have more
> > than one) under computer:/// then go ahead a send patches upstream. I
> > personally don't care and I am not responsible for that part of
> > software.
> 
> Sorry, I shouldn't have mentioned what I thought could be done in
> other projects, that really has nothing to do with you.

The bluez-gnome project is open for everything, but some stuff that are
not tightly coupled should be better kept separate. Otherwise simply
send patches. We go from there.

> > As usual with these kind of things, I am not the UI expert and if you
> > wanna have fixed or changed something, you better send in a patch. We
> > always welcome new development blood.
> 
> I'm not a UI expert either.  I was just disappointed that the first
> gnome (non-cli) interface for connecting to a bluetooth device was
> really an interface to connect with an OBEX FTP device on a bluetooth
> transport.  I plainly admit that I had false assumptions about what
> that feature was supposed to be and my disappointment is due primarily
> to those false assumptions.  It sounds like the preferences dialog and
> the druid will cover my needs nicely.

Actually Bluetooth is so highly complicated that most of the times we
need at least three attempts to get it right. There is always something.
Even with our new infrastructure that uses solely D-Bus we are big step
into the right direction, but it is still way to complex for most people
to get it right. The D-Bus API is simply, but it still has its issues if
you start mis-using it. My hope is that a Bluetooth GTK widget library
will help people to develop Bluetooth enabled UI applications faster and
more easily since they don't have to worry about details.

> Also thank you for being welcoming to new developers.  I need to dive
> into one of the projects I am interested in.  I appreciate the idea
> that I'd be welcomed if I chose bluez-gnome.

Start fixing or extending stuff. I am simply the wrong person for
writing UI applications, but no one else wanting to write this passkey
agent support for GNOME. So here we are. Me writing UI code.

> May I ask, by the way, if bluez-users was the wrong place to bring this up?

I think it is fine. When you start sending patches, make sure they go to
bluez-devel.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
