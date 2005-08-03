Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Nelson Murilo <nelson@pangeia.com.br>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problem Debian Sarge and btscanner-1.0
Message-ID: <20050803143209.GC5192@pangeia.com.br>
References: <42F0D2F0.8090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42F0D2F0.8090709@gmail.com>
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
Date: Wed, 3 Aug 2005 11:32:11 -0300


Maybe this help:
debian:/usr/share/doc/libsdp2# zcat NEWS.Debian.gz 
bluez-sdp (1.5-3) experimental; urgency=low

  * If you compile your packages against libsdp, please drop the
    dependency.  libsdp has been entirely assimilated into libbluetooth1.
    All you need to do is compile against that.

    The libsdp transitional dummy packages will be removed from the
    archive in due course.

 -- Edd Dumbill <ejad@debian.org>  Tue,  8 Jun 2004 13:13:56 +0100



On Wed, Aug 03, 2005 at 04:21:36PM +0200, Oliver Leitner wrote:
> Dear Ladies and Gentleman
> 
> I have a slight problem with the current stable branch of debian, and bluez.
> 
> when i try to run ./configure within the btscanner-1.0 directory, i get
> the following error:
> 
> lappy:/home/nevermind/btscanner-1.0# ./configure
> checking for gcc... gcc
> checking for C compiler default output... a.out
> checking whether the C compiler works... yes
> checking whether we are cross compiling... no
> checking for suffix of executables...
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ANSI C... none needed
> checking for main in -lcurses... yes
> checking for main in -lbluetooth... yes
> checking for main in -lsdp... no
> configure: error: SDP not found
> 
> the next thing ive tried was to install the bluetooth things from your
> page via the apt repository:
> 
> deb http://bluez.sourceforge.net/download/debian/ ./
> deb-src http://bluez.sourceforge.net/download/debian/ ./
> 
> which gave me the following error for the bluez-sdp package (amongst
> other errors with version dependencies...)


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
