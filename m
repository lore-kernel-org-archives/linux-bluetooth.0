Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Krisztian Mark Szentes <office@produktivIT.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, benh@kernel.crashing.org
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
Cc: Edd Dumbill <ejad@debian.org>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<200305131047.39294.office@produktivIT.com>
	<1053083095.26552.49.camel@pegasus>
In-Reply-To: <1053083095.26552.49.camel@pegasus>
MIME-Version: 1.0
Message-Id: <200305161438.08919.office@produktivIT.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 16 May 2003 14:38:08 +0200
Content-Type: text/plain; CHARSET=iso-8859-15

{hello Ben}

On Friday 16 May 2003 13:04, Marcel Holtmann wrote:
> > > > I have trouble with the 3COM Cardbus bluetooth card on a Powerbook
> > > > Titanium (a powerpc notebook). I patched the 2.4.20 kernel with
> > > > the mh-6 patch (and the benh patch which does not collide). I
> > > > haven't found any hint on the list yet.
...
> You're using a Powerbook and the 3Com is currently not supported on the
> PowerPC architecture. The Kernel side of the driver should work fine
> (not tested), but the bluefw have no code to load the firmware. Take a
> look at the mailing list archive for this problem.
Thanks, I found the relevant part (by Edd Dumbill):

"Second, the bad news, there's still x86-arch specific code in there, for
the bt3card stuff.  At least ppc does not have sys/io.h. " 

There must be some uniform way to access I/O of a Cardbus PC-Card on the 
more common arch plattforms. (I did not find any - perhaps there is 
none??) Ben, can you please have a look at the code? (Sent by separate 
mail.)

Greets

Mark
kind of astonished, I chose the 3COM card explicitly according to the BlueZ 
hardware compatibility list, I could also have chosen the Xircom or Anycom 
cards; they would probably have saved a lot of messing around.
Perhaps you could correct 
http://www.holtmann.org/linux/bluetooth/bt3c.html
in order to reflect the missing powerpc support.

Furthermore, you could also enhance the hardware support page by adding 
vendor co-operation information like linuxprinting.org does. I saw Anycom 
directly links to Marcel's homepage. A simple sorting of the list 
according to driver openness etc. would just suffice


-- 
Krisztian Mark Szentes
produktivIT   -  Open-Source Solution Provider
Siebenbrunnengasse 55/7
A-1050 Wien



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
