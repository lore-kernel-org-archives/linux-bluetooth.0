Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY102-W27ED8AC7D297D3969CA322F0060@phx.gbl>
References: <BAY102-W27ED8AC7D297D3969CA322F0060@phx.gbl>
Date: Mon, 09 Jul 2007 15:54:58 +0200
Message-Id: <1183989298.5105.56.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] configure: error: Bluetooth library is required
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dear Robert,

m=E5n 2007-07-09 klockan 12:34 +0000 skrev Robert Rawlins:
> Thank you Mats,
>  =

> I ran the commands that you gave me and they appeared to run ok, and
> when i ls the /usr/local/bluetooth/ folder it displays the following
> files:
>  =

> bluetooth.h  bnep.h  cmtp.h  hci.h  hci_lib.h  hidp.h  l2cap.h
> rfcomm.h  sco.h  sdp.h  sdp_lib.h
> =

> However, i still get this error when using the configure :-s it really
> is most odd. I notice in your last mail that you mention the static
> and shared libraries, i'm not sure if this is of any use, but here is
> a little more information from my ./configure on the utils, notice it
> says build static ... no? is that normal?
>  =

> checking whether to build shared libraries... yes
> checking whether to build static libraries... no
> configure: creating libtool
> checking for ppoll... no
> checking for pkg-config... no
> checking for BLUEZ... configure: error: Bluetooth library is required
> =

> Thanks for all your help on this mats, I'm sure we're getting closer,
>  =


Yes, first and most importantly do

   # apt-get install pkg-config

which is lacking by your printout (the line second to last). This =

explains most of the present problems, since it provides a mechanism
to out locations of libraries, and then to configure source code that
depends on these libraries.

I did the following to check your prospects, likewise an Debian Etch
system, but this machine is only slowly getting to the expanded stage
where my Debian Sarge is at.

$ mkdir /tmp/blind

$ cd /tmp/bluez-libs-3.12
$ ./configure --prefix=3D/tmp/blind

$ make              # No errors should occur
$ make install      # You can perform a dry run using "make -n install",
		    # read the output, and se where things go.
		    # Somewhat technical output, though.

$ cd ../bluez-utils-3.12
$ ./configure --prefix=3D/tmp/blind --with-bluez=3D/tmp/blind
$ make =


This aborts with an error for device.c complaining about
LMP_PAUSE_ENC, LMP_NFLUSH_PKTS, and LMP_LSTO. The Bluez spacialist
have to take over if your machine gets stuck here, since I only
use Bluez-utils 2.25 and 3.7. But at least, when you can reach this
stage the original hurdle has been overcome, since you have a working
copy of libbluetooth2.

Just a reminder, this.so is a dynamic/shared library, whereas that.a
is a static library. Most users will never need to tell them apart.
You will soon learn when progressing further on the road of tailoring
your own software.

Best regards,	Mats E A

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
