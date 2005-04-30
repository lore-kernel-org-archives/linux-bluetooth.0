Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0504291520167b9bb8@mail.gmail.com>
References: <e1effdeb05042813004f4609a6@mail.gmail.com>
	 <1114768038.8836.42.camel@pegasus>
	 <e1effdeb05042905267bc91413@mail.gmail.com>
	 <1114778617.8836.88.camel@pegasus>
	 <e1effdeb0504291520167b9bb8@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1114819470.8836.124.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 30 Apr 2005 02:04:30 +0200

Hi Claudio,

> My application will provide a DBUS service and
> APIs to alows user mode applications interact
> with diferent types of Wireless/Wired connections.
> This is the reason to create a BlueZ library based
> on pand and hcitool functions. My application should
> the able to retrieve bluetooth device information,
> including establish connection, disconnect, link
> status, new devices/services, ...
> The DBUS service will not be provided at BlueZ level.
> 
> The current DBUS message in the hcid is used to handle
> security/authentication issues. This message has a
> different proposal. Therefore, use the same macro
> "--enable-dbus" to enable/disable is not a good ideia.
> 
> Another important information is: the user mode
> application doesn't need root privileges to create
> a bluetooth connection, because it will request using
> APIs and DBUS service.
> 
> Can I create a library in the pand directory and
> reuse the common codes?
> I suggest a directive like "--enable-panz" because
> this library aims provide functions to hide connection
> details.

I think you get the whole idea of D-Bus wrong and this is not about the
current D-Bus support of hcid for the PIN helper.

As I said if you wanna control something from your application via D-Bus
then make sure there is a D-Bus enabled pand service is running. If you
wanna do it at another level, then I don't see any benefit from it. Why
should we create another library only to help your special D-Bus daemon
if it is not Bluetooth only. In that case you should simply duplicate
the code and integrate it into your daemon directly. There is no need to
make things more complicate.

For me the only thing that makes sense if you enhance the pand with
D-Bus support and then you use that D-Bus interface in your application.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
