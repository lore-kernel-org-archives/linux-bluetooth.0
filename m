Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid updated
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: Peter Klausler <pmk@cray.com>,
   BlueZ Users List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1068919368.15097.22.camel@saag>
References: <20031106014519.GA31868@schnell>
	 <1068919368.15097.22.camel@saag>
Content-Type: text/plain
Message-Id: <1068925159.19286.311.camel@pegasus>
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
Date: Sat, 15 Nov 2003 20:39:20 +0100

Hi Edd,

> > I've updated my bthid daemon with some tweaks that
> > may or may not have been necessary to get the new
> > Apple Bluetooth keyboard to work
> 
> Is there any chance you might update your module to work against the 2.6
> kernel too?

the "User level driver support for input subsystem" should replace the
fake.o driver. For the 2.4 series I have posted a backport to the LKML,
but Marcelo don't picked it up by now.

Regards

Marcel




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
