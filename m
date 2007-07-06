Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <468EB809.3090203@gmail.com>
Date: Fri, 06 Jul 2007 18:45:45 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <BAY102-W2777B5DBF6DAA26AA0CA9EF0010@phx.gbl>
In-Reply-To: <BAY102-W2777B5DBF6DAA26AA0CA9EF0010@phx.gbl>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Robert,
It's quite easy to set the path where you want to install an app:
./configure --prefix=<ABSOLUTE_PATH>

Thanks,
Manuel
> Just as an extra note, during the make install all the libs it says:
>  
> Libraries have been installed in:
>    /usr/local/lib
> If you ever happen to want to link against installed libraries
> in a given directory, LIBDIR, you must either use libtool, and
> specify the full pathname of the library, or use the `-LLIBDIR'
> flag during linking and do at least one of the following:
>    - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
>      during execution
>    - add LIBDIR to the `LD_RUN_PATH' environment variable
>      during linking
>    - use the `-Wl,--rpath -Wl,LIBDIR' linker flag
>    - have your system administrator add LIBDIR to `/etc/ld.so.conf'
> See any operating system documentation about shared libraries for
> more information, such as the ld(1) and ld.so(8) manual pages.
>
> And then when trying to configure my bluez utils i use
>  
> ./configure BLUEZ_LIBS=/usr/local/lib
>  
> And i still get the same issue that it cannot find the bluetooth 
> libraries.
>  
> Thanks,
>  
> Rob
>
> ------------------------------------------------------------------------
> The next generation of MSN Hotmail has arrived - Windows Live Hotmail 
> <http://www.newhotmail.co.uk>
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
