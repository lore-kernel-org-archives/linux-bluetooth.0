Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1203936194.2754.193.camel@cookie.hadess.net>
References: <1203878261.2754.140.camel@cookie.hadess.net>
	<BDDF9433-7A32-4CAB-B9C8-2A67635C8578@holtmann.org>
	<1203936194.2754.193.camel@cookie.hadess.net>
Date: Mon, 25 Feb 2008 21:31:02 +0100
Message-Id: <1203971462.28528.82.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Option for more-"gnomey" settings
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

> > > As you know, I have a problem with a few settings in bluez-gnome not
> > > matching up with the philosophy/target for GNOME.
> > >
> > > Right now it's:
> > > - "Use HAL" settings, and associated device selection
> > 
> > you know that the class of device selection will disappear when  
> > enabling the HAL setting. I did that a few releases ago.
> 
> Which is something that the HIG says shouldn't be done. The button
> should be visible, but disabled.
> 
> I'm actually asking for the "Use HAL" checkbox to not even be there.

if you wanna set a GConf value to make this go away. I am fine with it.
However with BlueZ 4.x I might seriously consider moving this into
bluez-utils anyway. Doing this within the UI is wrong. There is no need
for doing it there. Seemed like a good idea to have the class of device
configurable when we create BlueZ 3.x, but now I don't think that it
should be configured from the UI at all.

> > > - Sharing properties, which conflict with gnome-user-share (where we
> > > want to have most of the sharing preferences for GNOME, including
> > > sharing the screen using vino, etc.)
> > 
> > You can easily add an option to gnome-user-share for setting the GConf  
> > value that bluez-gnome is using. The whole incoming connection/accept  
> > thing should be handled inside bluetooth-applet.
> 
> Any particular reasons that should be the case? There's no telling that
> the bluetooth-applet will be running when that happens.

And there is no reason that gnome-user-share is running. You do need
support for pairing and that is handled within bluetooth-applet. Not
having the applet running won't allow you to successfully connect and
authenticate new devices.

> > And as I mentioned the gnome-user-share dependency chain of the  
> > distros is crazy. As long as it drags Apache + WebDAV into my desktop,  
> > I am against it.
> 
> Why is that so bad? It's a pretty small compared to say, docbook
> stylesheets (weighs in at 2.7 megs on an x86-64), and it means that all
> the sharing UI are in one place.

Of course there are other bad dependencies, but why do have to install
Apache when you want to share files over Bluetooth. I simply don't get
it. We depend on obex-data-server and then bluez-gnome and that's it.

> > > Would you accept a patch to add a --enable-gnome to configure to hide
> > > those settings away when bluez-gnome is compiled for use in the GNOME
> > > desktop? Or would you prefer a run-time option?
> > 
> > I prefer if you use the GConf values that bluez-gnome uses and move  
> > all Bluetooth related interaction into bluetooth-applet instead of  
> > hacking it into some other applications and bloat the dependencies.
> 
> Bloat what dependencies? We're not bloating the bluez-gnome
> dependencies, and gnome-user-share is already a default installation on
> many GNOME installations.

But not on all. See my point above.

> > If you really wanna shrink the settings of bluetooth-properties, we  
> > can do that at runtime with a GConf setting. I have no problem with  
> > that. I am against compile time options.
> 
> Ok. I'll prepare a patch for that. I guess this shouldn't have a UI
> though, right? :)

No. Simply define a GConf value and let me confirm it and then we can
disable these elements.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
