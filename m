Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: jvp@lateapex.net, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1063441693.19165.31.camel@h9n1fls20o980.bredband.comhem.se>
References: <200309130612.h8D6CKs06276@localhost.lateapex.net>
	<1063441693.19165.31.camel@h9n1fls20o980.bredband.comhem.se>
Content-Type: text/plain
Message-Id: <1063449127.28890.407.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 13 Sep 2003 12:32:00 +0200

Hi Fredrik,

> > I was successful in getting the Palm and laptop to find one another via BT;
> > thanks a bunch for all the help.  Now, is there any way to get an
> > application like jpilot to sync over BT?  
> 
> I don't know if it's possible to get jpilot or gnome-pilot running with
> Bluetooth, but pilot-xfer works atleast:
> 
>      1) Make your Palm able to connect to the computer using 
>         PPP over Bluetooth. (This is somewhat complicated - search for
>         "linux bluetooth ppp tungsten" or similar to get some howtos.)
> 
>      2) Run "pilot-xfer -p net:any -s ." etc. 
> 
> The Gnome MultiSync project looks interesting but I don't know if Palm
> is supported. The Gnome Bluetooth project also looks promising.

I don't have a Palm, but I assume that this device can also sync over
Bluetooth directly, because the only thing that it needs is a RFCOMM
connection. The SDP records of the Palm are not in the public browse
group, so it will be difficult to find the correct one and of course
they will use some uuid128. The Nokia phone 6310 for example have also a
special service record that allows them to run their own protocol over
Bluetooth and we now have to find the special SDP record for the Palm.
Please, can someone post the result of a SDP search with --tree option
for the OBEX push profile.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
