Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY102-W16AA72BD57037F1749B764F0060@phx.gbl>
References: <BAY102-W16AA72BD57037F1749B764F0060@phx.gbl>
Date: Mon, 09 Jul 2007 14:15:26 +0200
Message-Id: <1183983327.5105.27.camel@localhost>
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

m=E5n 2007-07-09 klockan 11:40 +0000 skrev Robert Rawlins:
> Morning Mats,
>  =

> Thanks for your reply. I haven't copied my header files across, i'm
> not even sure how too :-D
>  =

> Can you explain the installation process for me? at the moment I'm
> doing it as follows.
>  =

> 1) Download libs and utils files from bluez.org
> 2) Untar those files using tar xzf filename.tar.gz
> 3) cd to the directory for libs
> 4) ./configure, make, make install
> 5) cd to the utils directory
> 6) ./configure --with-bluez=3D/usr/local/lib
>  =

> And that's when i get my error, by the sounds of what you have been
> saying i must be missing something out but i have no idea what. I
> don't do much compiling from source so this is all quite new to me.
>  =

> Thanks again for your help, it really is appreciated.
>  =

> Rob
> =


The quickest way is to create a directory =


# mkdir -p /usr/local/include/bluetooth/

and then copy the header files by hand =


# cp /path/to/source/for/bluez-libs-3.12/include/*.h \
            /usr/local/include/bluetooth/

The lacking of those header files, i.e. detailed descriptions of
bluez-utils-3.12, is probably the reason why you could not build
bluez-utils, even though the static and shared libraries were
present. I am somewhat puzzeled that "make install" did not put
the headers in the correct place, but give the above manipulation
a chance, and we will figure out the rest when there is no hurry.

By the way, your very first effort with BLUEZ_LIBS essentially
only lacked a second necessary variable:

   BLUEZ_LDFLAGS=3D"-I/usr/local/include"
   BLUEZ_LIBS=3D"-L/usr/local/lib -lbluetooth"

but it is safer to use "--with-bluez=3D/usr/local"

Good luck this time!

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
