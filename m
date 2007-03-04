Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-F192F81B0DBADE11579F926BF850@phx.gbl>
In-Reply-To: <1173029811.5752.11.camel@aeonflux.holtmann.net>
From: "Kelvin Xu" <kyoxu@hotmail.com>
To: bluez-users@lists.sourceforge.net
Date: Mon, 05 Mar 2007 01:28:17 +0800
Mime-Version: 1.0
Subject: Re: [Bluez-users] pin code
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

Hi,

Thanks for the help.

How do i double check if my system bus is running andwhether the security 
settings are correct?

Regards,
Kelvin


>From: Marcel Holtmann <marcel@holtmann.org>
>Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
>To: BlueZ users <bluez-users@lists.sourceforge.net>
>Subject: Re: [Bluez-users] pin code
>Date: Sun, 04 Mar 2007 18:36:50 +0100
>
>Hi Kelvin,
>
> > i am faced with the sam problems as KS H. I have also cross compiled 
>dBus
> > and Bluez Util for ARM using Scratchbox.
> > I followed the similar steps provided by Prabhu. However, I do not have 
>the
> > message.pid entry in /var/run but have an additional "pid" entry in
> > /var/run/dbus.
> >
> > And when i try to execute hcid i received the following error:
> > # hcid -n -f /etc/bluetooth/hcid.conf
> > hcid[790]: Bluetooth HCI daemon
> > hcid[790]: Can't open system message bus connection: Failed to connect 
>to
> > socket /var/run/dbus/system_bus_socket: Connection refused
> > hcid[790]: Unable to get on D-Bus
> >
> > Please advice. Thank you
>
>this can mean two things. Either the system bus is not running or the
>security settings for hcid to claim the org.bluez namespace are not
>correctly set.
>
>Regards
>
>Marcel
>
>
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share 
>your
>opinions on IT & business topics through brief surveys-and earn cash
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Get an advanced look at the new version of Windows Live Messenger. 
http://get.live.com/messenger/overview


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
