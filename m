Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
From: Fredrik Noring <noring@nocrew.org>
To: jvp@lateapex.net
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <200309130612.h8D6CKs06276@localhost.lateapex.net>
References: <200309130612.h8D6CKs06276@localhost.lateapex.net>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1063441693.19165.31.camel@h9n1fls20o980.bredband.comhem.se>
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
Date: Sat, 13 Sep 2003 10:28:13 +0200

Hi Jason,

l=F6r 2003-09-13 klockan 08.12 skrev Jason Van Patten:
> I was successful in getting the Palm and laptop to find one another via=
 BT;
> thanks a bunch for all the help.  Now, is there any way to get an
> application like jpilot to sync over BT? =20

I don't know if it's possible to get jpilot or gnome-pilot running with
Bluetooth, but pilot-xfer works atleast:

     1) Make your Palm able to connect to the computer using=20
        PPP over Bluetooth. (This is somewhat complicated - search for
        "linux bluetooth ppp tungsten" or similar to get some howtos.)

     2) Run "pilot-xfer -p net:any -s ." etc.=20

The Gnome MultiSync project looks interesting but I don't know if Palm
is supported. The Gnome Bluetooth project also looks promising.

	Fredrik




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
