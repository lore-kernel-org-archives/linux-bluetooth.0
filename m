Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <419FF902.40207@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BlueZ and the ALSA support
References: <1100995285.7250.17.camel@pegasus>
In-Reply-To: <1100995285.7250.17.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 21 Nov 2004 03:10:10 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

this is great news, thanks a lot!

I would have gone through the code sooner or later myself, I think I
could have managed it because I have a little kernel experience but I'm
pretty sure you are much more competent and were able to do it in a
fraction of the time :)

Maybe I'll be able to put some efforts into this project when I'm doing
my final exams "practical part" (what's "Diplomarbeit" called in
english? :) - so it could be possible that snd-bt-sco might get a
full-time coder for about three month :)

I'll be asking many questions, but it should be worth the effort :)

Anyway, thanks again for cleaning up the code for us (or everyone).

I'll check it out as soon as possible (maybe next week).

regards,
~  Lars

Marcel Holtmann wrote:
| Hi Folks,
|
| I spent some hours to clean up the btsco CVS repository from the ALSA
| Bluetooth project and also changed the code a little bit for easier use
| by non technical people. It should now compile and work without the need
| of reinstalling or changing any ALSA stuff. Here is a quick walktrough.
|
| First the CVS repository must be checked out:
|
| 	cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa login
| 	cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa co btsco
|
| After that is must be compiled:
|
| 	./bootstrap
| 	./configure
| 	make
| 	make install
| 	make maintainer-clean
|
| And you need the kernel module:
|
| 	cd kernel
| 	make
| 	make install
| 	make clean
|
| Now go ahead and use it like before.
|
| As you may now realized the snd-bt-sco kernel driver is also inside this
| repository and with a recent 2.6 kernel there are no problems with
| compiling a kernel module outside the kernel source directory. However
| if you haven't installed the running kernel by yourself you may need to
| install the kernel source package from your distribution.
|
| Every crappy header file is now removed and the needed IOCTL and the
| HWDEP definition is added to the source directly in a compatible way.
|
| The A2DP related programs are integrated into the Makefile and they are
| also compiled, but for now they are not installed.
|
| This should make the development a lot more easier :)
|
| Regards
|
| Marcel
|
|
|
|
| -------------------------------------------------------
| This SF.Net email is sponsored by: InterSystems CACHE
| FREE OODBMS DOWNLOAD - A multidimensional database that combines
| robust object and relational technologies, making it a perfect match
| for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
| _______________________________________________
| Bluez-devel mailing list
| Bluez-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/bluez-devel
|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBn/kBQWC6DTWkDAoRAnV9AKCF2V7wQcDsnSedthm/nLOJuokYNACghI/J
eS6B9cxs9R9MgXwPIHRxjTU=
=DkVP
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
