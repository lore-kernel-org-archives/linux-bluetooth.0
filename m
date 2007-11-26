Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <474AA430.6010307@uni-koeln.de>
References: <4745D9EE.4020101@uni-koeln.de> <4749FAD6.6080403@uni-koeln.de>
	<1196055526.4217.44.camel@aeonflux>  <474AA430.6010307@uni-koeln.de>
Date: Mon, 26 Nov 2007 13:27:23 +0100
Message-Id: <1196080043.17196.4.camel@aeonflux>
Mime-Version: 1.0
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

Hi Paul,

> thanks a lot for your fast resonse.
> I have installed dbus on my System so I assumed that bluez would use it. 
> Is this wrong?
> I tried to find a archive for 3.21, but found none.
> So I load the CVS Version by:
> 
>   cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez login
>   cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez co -P libs
> 
> 
> for some reason autoconf -o configure configure.in  on my  embedded box  
> didn't  create anything, so I ran it on my PC, copyed the resulting 
> configure script to the box, and run  bootstrap and bootstrap-configure.
> make and make install, produced  /usr/lib/libbluetooth.so.2.9.2

use the bootstrap-configure and make sure it gets installed in /usr
prefix to make it available. The tarball is at the same location as the
3.22 version, but only one version earlier.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
