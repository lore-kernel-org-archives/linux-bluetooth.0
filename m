Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <474AA430.6010307@uni-koeln.de>
Date: Mon, 26 Nov 2007 11:47:12 +0100
From: Paul Wachendorf <pwachend@uni-koeln.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4745D9EE.4020101@uni-koeln.de> <4749FAD6.6080403@uni-koeln.de>
	<1196055526.4217.44.camel@aeonflux>
In-Reply-To: <1196055526.4217.44.camel@aeonflux>
Subject: Re: [Bluez-users] hcitool scan returns wrong bdaddr
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

Hi Marcel,
thanks a lot for your fast resonse.
I have installed dbus on my System so I assumed that bluez would use it. 
Is this wrong?
I tried to find a archive for 3.21, but found none.
So I load the CVS Version by:

  cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez login
  cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez co -P libs


for some reason autoconf -o configure configure.in  on my  embedded box  
didn't  create anything, so I ran it on my PC, copyed the resulting 
configure script to the box, and run  bootstrap and bootstrap-configure.
make and make install, produced  /usr/lib/libbluetooth.so.2.9.2

but an hcitool scan, still returns
Scanning ...
        02:01:00:12:EE:58       n/a

ldd `which hcitool`:
        libbluetooth.so.2 => /usr/lib/libbluetooth.so.2 (0x40025000)
        libc.so.6 => /lib/libc.so.6 (0x4003f000)
        /lib/ld-linux.so.2 (0x40000000)

ls -l /usr/lib/libbluetooth.so.2:
 /usr/lib/libbluetooth.so.2 -> libbluetooth.so.2.9.2

What's going wrong?
Greetings,

Paul


Marcel Holtmann schrieb:
> if you would use the D-Bus API, then you don't have this problem.
> However there was a bug in the 3.22 library that I fixed now. Install
> the library from CVS and you should be good. Or use 3.21.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
