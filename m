Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] /usr/include/bluetooth/bnep.h
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1083862669.16650.28.camel@saag>
References: <1083857533.16650.25.camel@saag>
	 <1083862218.4420.62.camel@pegasus>  <1083862669.16650.28.camel@saag>
Content-Type: text/plain
Message-Id: <1083919105.4420.115.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 07 May 2004 10:38:25 +0200

Hi Edd,

> > I will also deprecate bluez-pan and move dund and pand into the
> > bluez-utils package. You can expect the bluez-utils-2.7 this weekend.
> 
> Just when I thought my life was getting simpler :-)

sorry for that, but actually your life (like mine) will be much easier
after the 2.7 release. You only have to decide how many packages you are
going to build from the bluez-utils source. However with that release we
have one init script (please name it /etc/init.d/bluetooth) that will do
the complete start and stop of all Bluetooth daemons if they are
activated.

> btw, the section number in the l2ping and hciconfig man pages now
> mismatches the suffix of the man pages. should be 8 rather than 1 if I
> remember correctly.

The l2ping was already corrected and I fixed hciconfig now. Thanks.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
