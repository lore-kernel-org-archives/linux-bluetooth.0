Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 25 Sep 2007 08:34:41 -0400
From: Martin Stolle <mstoll@sus.mcgill.ca>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070925123441.GA1032@sus.mcgill.ca>
References: <2759cf860709241213o33159203kad04d7a0fa2ecaf5@mail.gmail.com>
	<20070924192203.GA31266@sus.mcgill.ca>
	<2759cf860709241233w621bd23akf3882800ad48cc28@mail.gmail.com>
	<1190672090.5133.133.camel@aeonflux.holtmann.net>
	<20070924222152.GA13130@sus.mcgill.ca>
	<1190675554.5133.151.camel@aeonflux.holtmann.net>
	<20070924232149.GA14346@sus.mcgill.ca>
	<2759cf860709250450yc36a945m846bd529d006b289@mail.gmail.com>
	<e1effdeb0709250524n16217623p194a891fa858810c@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <e1effdeb0709250524n16217623p194a891fa858810c@mail.gmail.com>
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

On Tue, Sep 25, 2007 at 09:24:33AM -0300, Claudio Takahasi wrote:
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

If the above comments are correct, the "new" system has two problems I
can see:  What about the case where the device in question was reset?
In that case, bluez thinks it's already authenticated, but the device
doesn't connect to bluez, since it's still set up for another computer?

The other problem is - what about people who don't use gnome or kde?  I
always thought Linux was about choice.  Clearly, if I want to use
bluetooth, I am forced to use one of these desktop systems with their
desktops, wms etc..., which is quite restrictive.  That is quite a step
back from the  "hidd --search"  way of doing things!

(Now, I am not saying that hidd --search should be the only way -
definitely not.  Gnome and KDE integratino are really important.  But
please not at the expense of simple command-line tools!)

Martin


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
