Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1173125981.6638.88.camel@aeonflux.holtmann.net>
References: <1173113177.23027.34.camel@bnocera.surrey.redhat.com>
	<1173125981.6638.88.camel@aeonflux.holtmann.net>
Date: Wed, 07 Mar 2007 00:58:15 +0000
Message-Id: <1173229095.10237.66.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] More thoughts on bluez-gnome
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

On Mon, 2007-03-05 at 21:19 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > I was taking a look at the bluez-gnome source code on Friday, and this
> > week-end, as well as the interface in general.
> > 
> > I wanted to know what the target use of the bluetooth-applet (and
> > -properties) was.
<snip>

That's not quite what I meant.

I wanted to know why the Bluetooth applet even allowed the user to
disable HAL support, why it would ask to define the device class when it
can be guessed, or why one could disable the bluetooth applet's icon in
the notification area.

> > The sort of thing that I'd like to see in a GNOME bluetooth applet:
> > - remove class of device drop-down menus (made a GConf-only option if
> > really necessary).
> 
> I am all for it, but it must be an alternate based on the GConf option
> and the presence of HAL support. Right now only the missing part is to
> make the drop-down menu invisible when the HAL option is selected.

Again, I don't see why this should even be an option.

> > - add some integration into HAL (Software on/off, state restoration
> > after sleep)
> 
> I have no idea what you mean by that. If it is the rfkill switch then I
> fully agree that we need to have this. However in case of rfkill it is
> kinda complicated since the device will disappear physically from the
> bus and so it makes it kinda complicated to view it any different than a
> dongle that got removed and later re-attached.

I know. For the applet it would be as easy as finding the rfkill switch
in the HAL tree, and using the GetPower/SetPower methods on it. If the
device is present, there's a bluetooth adapter ready to be used.

This would need HAL support, which should be a requirement, not an
option.

> > - always display the bluetooth icon if a bluetooth device is present,
> > grayed out if the device is disabled (see above), removed if no adapter
> > is present at all
> 
> I am all for having different icon. One that means the device is
> inactive, one if it is scanning, one if it has an active connection and
> so on. However to have this really nicely integrated with the theme
> engine, I think someone has to come up with some Tango icons for us.

So you'd be happy to remove the "Notification area" options in the
applet?

> > - more integration into existing GNOME software (gnome-vfs2-obexftp to
> > browse phones with Nautilus, gnome-obex-send and gnome-obex-server to
> > send and receive files).
> 
> I am not actively looking at the VFS integration. For the OBEX stuff, I
> am working on a transfer service that gives a simple D-Bus based API for
> task like pushing and receiving files. So in general it will be as
> simple ask calling a D-Bus method with a remote address and a filename
> to actually push files. For the receiving parts we need some integration
> with the applet. It should display an authorization request and then a
> file selector. Not fully sure how this will finally look like, but we
> might have this sorted out until the end of this week.

The integration I was talking about was about adding menu items to the
applet to allow sending files from it, or browsing a device using the
applet as a starting point.

As for the sharing service, the only part I could find was an incomplete
API doc in CVS. I couldn't find much information about the services
either. Would those services be running as root or the user? If the
former, it could be a security issue, and would cause problems on
SELinux systems.

I'd like to see an API (even a draft one). The current libbtctl obex API
is pretty good, and has all the information needed for UIs to be
implemented on top.

> > The applet and the properties windows could also use a lot of cleanup,
> > codewise, to follow the GNOME style a bit more closely (separate the
> > auth/passkey code, make the "applet" into an object, use Glade when
> > possible to generate the interface).
> 
> The passkey and authorization agent should be nice GOjects that can be
> used by every application in the bluez-gnome source code. I have this on
> my todo list, but I never got around actually getting this done. So feel
> free to send a patch for this.
> 
> The applet itself is not an object. It is an application. However the
> separate parts should be created as objects.

static globals don't help much when extending an application though, and
packing the important parts in a struct would help see what parts of the
application depends on which.

> About the coding style, it has to follow the BlueZ coding style since it
> is not part of the GNOME project. None of the applications are not
> really GNOME applications. The only dependency is GTK and personally I
> like to keep it this way. The name bluez-gnome might be misleading, but
> original the idea was to have one package for GNOME and another one for
> KDE. However the KDE is developed completely outside the scope of the
> BlueZ project.

I meant coding style, but not meaning indentation style. Depending on
libglade wouldn't be much of a stretch. It's self-contained, and only
depends on libxml and glib (and will soon be integrated in GTK+ itself,
most likely with compatible UI files).

> > Finally, I'd like to see convenience dialogues (as currently badly
> > implemented in gnome-bluetooth) for selecting particular Bluetooth
> > devices. Something aking to MacOS X' Bluetooth UI classes:
> > http://developer.apple.com/documentation/DeviceDrivers/Reference/IOBluetoothUI/index.html
> > and
> > http://developer.apple.com/documentation/DeviceDrivers/Conceptual/Bluetooth/BT_Bluetooth_On_MOSX/chapter_3_section_7.html#//apple_ref/doc/uid/TP30000997-CH215-TPXREF110
> > 
> > If the plan of bluez-gnome is to cater for the advanced Bluetooth
> > user[1], or the users of desktops other than GNOME, then I think I'll
> > move my focus onto bringing functionality to gnome-bluetooth instead.
> 
> I am not happy with taking the control from the user. I think that they
> should have a choice to enable expert settings if they want to. However
> having automatic settings by default is a good idea.

Good documentation and/or a FAQ would go a longer way than trying to fit
in "expert" settings in the UI.

> The idea of having a libbluetooth-gtk with generic Bluetooth related UI
> objects has crossed my mind already multiple times. The idea looks
> pretty good. However I am not sure if we should rush into it. I would
> prefer to see it as a private library inside bluez-gnome first and let
> it evolve a little bit before we make it system wide available.

There are already applications with Bluetooth support that could make
use of it. gnome-pilot to sync Palms over Bluetooth for example, or
Rhythmbox to sync your phone's music over Bluetooth.

> I already started with a generic object that will listen for inquiry
> results and populate a tree of local and remote devices. This tree
> should be the base for all dialogs. Then you can apply filters on it to
> get the correct list that need. For example all phone devices. This
> object needs to be created first by every UI application and it will
> take care of all state changes and propagate them to the child trees or
> lists and also to the UI. Check the test-client code in the CVS.

I saw it, and it would be easy to create useful widgets on top of it.

> > Otherwise, I'd kindly request a CVS account so that my trivial cleanups
> > can get in faster.
> 
> In general no problem, but I wanna first get the repository in a better
> shape. That is mainly the reason why I haven't done a new release so
> far. I a quite busy at the moment, so apologies for the inconvenience
> that your patches currently have to go through. We will change that in
> the future.

Thanks. I wouldn't want to have to reimplement loads of code, and
maintain it apart, just because we couldn't agree on the UI bits...

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
