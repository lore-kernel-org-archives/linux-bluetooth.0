Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <2759cf860709250541p76c4e9e8qa39aac0bacbb756@mail.gmail.com>
Date: Tue, 25 Sep 2007 08:41:27 -0400
From: "Jared Greenwald" <greenwaldjared@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <e1effdeb0709250524n16217623p194a891fa858810c@mail.gmail.com>
MIME-Version: 1.0
References: <2759cf860709241213o33159203kad04d7a0fa2ecaf5@mail.gmail.com>
	<20070924192203.GA31266@sus.mcgill.ca>
	<2759cf860709241233w621bd23akf3882800ad48cc28@mail.gmail.com>
	<1190672090.5133.133.camel@aeonflux.holtmann.net>
	<20070924222152.GA13130@sus.mcgill.ca>
	<1190675554.5133.151.camel@aeonflux.holtmann.net>
	<20070924232149.GA14346@sus.mcgill.ca>
	<2759cf860709250450yc36a945m846bd529d006b289@mail.gmail.com>
	<e1effdeb0709250524n16217623p194a891fa858810c@mail.gmail.com>
Subject: Re: [Bluez-users] help with Logitech Travel Mouse
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

But, I guess the question is, why is it reporting that the device is
already there?  Also, if the device is already there and its not "just
recognizing" the device, then what else could be the issue?  The other
thing is, I am running KDE with kbluetooth on and kbluetooth is
reporting the mac address when I'm running the search, but I still
don't get any connectivity.

-Jared

On 9/25/07, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi,
>
> Once the input device is created(using CreateDevice) the device will
> reconnect automatically to the host when the user presses any key or
> moves the mouse. Currently, there isn't a wizard applet to setup input
> device, bluez-gnome and KDEBluetooth will support this functionality
> soon. Bear in mind that an authorization agent(bluez-gnome implements
> it) is required to authorize the incomming connection, alternatively
> you can add this device in the trusted list to skip authorizations.
>
> dbus-send examples are a workaround for testing purpose.
>
> We have reconnect problems with some buggy keyboards, otherwise the
> service is working fine.
>
> BR,
> Claudio.
>
> On 9/25/07, Jared Greenwald <greenwaldjared@gmail.com> wrote:
> > Someone else in #bluez-users pointed me to a page on this wiki with a
> > bunch of little python scripts that would do the connection from
> > bluetooth to device and vice-versa (HOWTO/InputDevices).
> >
> > I find it interesting that someone on this list would explicitly say
> > to not use the hidd commands, but people readily offer these python
> > scripts as fixes.  If these are so ubiquitous, why aren't they already
> > part of the bluez-utils package?
> >
> > In any case, I tried running the dbus-send commands that are listed
> > next to the python scripts and got nowhere.
> >
> > $dbus-send --system --type=method_call --print-reply --dest=org.bluez \
> > /org/bluez org.bluez.Manager.ActivateService string:input
> >    string ":1.8"
> >
> > $ dbus-send --system --type=method_call --print-reply --dest=":1.8"
> > /org/bluez/input org.bluez.input.Manager.CreateDevice
> > string:00:07:61:48:FC:DB
> > Error org.bluez.input.Error.AlreadyExists: Input Already exists
> >
> > This can't be good.  Maybe this is around from me trying to run hidd --search?
> >
> > $ dbus-send --system --type=method_call --print-reply --dest=":1.8"
> > /org/bluez/input/mouse0 org.bluez.input.Device.Connect
> > Error org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with
> > signature "" on interface "org.bluez.input.Device" doesn't exist
> >
> > I'm not sure I understand what this error is telling me, but I assume
> > that it's not going to be good.
> >
> > Thoughts?
> >
> > -Jared
> >
> > On 9/24/07, Martin Stolle <mstoll@sus.mcgill.ca> wrote:
> > > On Tue, Sep 25, 2007 at 01:12:34AM +0200, Marcel Holtmann wrote:
> > > > Hi Martin,
> > > >
> > > > > > > Yea, I would think that would fix things, but I tried that (the hidd
> > > > > > > --connect) and it doesn't seem to work to get connected...
> > > > > >
> > > > > > use the new input service and don't use hidd. The input service will
> > > > > > convert your configured devices automatically. There is no need to use
> > > > > > hidd --search or hidd --connect more than once. Whoever tells you
> > > > > > differently is wrong. Period.
> > > > >
> > > > > Thanks, I didn't know that. how do you solve the problem at hand then?
> > > > > What are the commands to use for the new input service?  Which man pages
> > > > > should I look at?
> > > >
> > > > checkout wiki.bluez.org. It has all the examples.
> > > >
> > >
> > > Sorry, but I can't find any end-user examples on the wiki.  They are all
> > > programming examples in C and python.  Are you saying that the simple
> > > "hidd --search" tool call has been replaced by having to write a whole
> > > python program?  That's seems like quite a regression.  Or maybe I am
> > > not able to find the appropriate page?
> > >
> > > Martin
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
