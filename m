Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-F18C609BE5FB6D7B0004B03BF780@phx.gbl>
In-Reply-To: <1173029811.5752.11.camel@aeonflux.holtmann.net>
From: "Kelvin Xu" <kyoxu@hotmail.com>
To: bluez-users@lists.sourceforge.net
Date: Fri, 09 Mar 2007 17:27:50 +0800
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


Dear all,

I am still stuck in this problem.
I am login as 'root' in the my system. And the system-dbus is running on 
user 'messagebus'. I tried starting dbus using root as the user by modifying 
system.conf but the same problem occur.

The following are the configuration files that i am using, is there anything 
wrong?

# more bluez-hcid.conf
<!-- This configuration file specifies the required security policies
     for BlueZ hcid to work. -->

<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 
1.0//EN"
"http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- ../system.conf have denied everything, so we just punch some holes 
-->

  <policy user="root">
    <allow own="org.bluez"/>
  </policy>

  <policy at_console="true">
    <allow send_destination="org.bluez.Adapter"/>
    <allow receive_sender="org.bluez.Adapter"/>

    <allow send_path="/org/bluez/Adapter"/>

    <allow send_destination="org.bluez.Manager"/>
    <allow receive_sender="org.bluez.Manager"/>

    <allow send_path="/org/bluez/Manager"/>

    <allow send_destination="org.bluez.Security"/>
    <allow receive_sender="org.bluez.Security"/>
  </policy>

</busconfig>

Thank you for all help provided.

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
Find just what you are after with the more precise, more powerful new 
Windows Live Search. http://search.msn.com.sg/ Try it now.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
