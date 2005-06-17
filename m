Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B2D0B0.8010403@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: GCC-4 Patch for btsco
References: <loom.20050617T115730-392@post.gmane.org>  <1119003833.8980.116.camel@pegasus>  <loom.20050617T124909-183@post.gmane.org> <1119006318.8980.126.camel@pegasus> <loom.20050617T133130-516@post.gmane.org>
In-Reply-To: <loom.20050617T133130-516@post.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 17 Jun 2005 07:31:28 -0600

Bastien,

Could you help to just disable the role switch call at compile time if 
bluez-libs is too old? Most people don't need it. I don't know the 
autoconf stuff well enough to make it a conditional compile.

Brad

Bastien Nocera wrote:
> Marcel Holtmann <marcel <at> holtmann.org> writes:
> 
> 
>>the bug was also present in the function itself. I have no idea how it
>>slipped into the source. I fixed it with the bluez-libs-2.11 release.
> 
> 
> Excellent, here's a patch to btsco to require bluez-libs 2.11.
> 
> $ ./configure
> <snip
> checking for hci_open_dev in -lbluetooth... yes
> checking for sdp_connect in -lbluetooth... yes
> configure: error: bluez-libs 2.11 or better is required to compile btsco
> make: *** [config.status] Error 1
> $ grep hci_switch_role config.log
> conftest.c:35: error: incompatible type for argument 2 of 'hci_switch_role'
> |       hci_switch_role(dd, addr, role, to);
> 
> Index: configure.in
> ===================================================================
> RCS file: /cvsroot/bluetooth-alsa/btsco/configure.in,v
> retrieving revision 1.8
> diff -u -r1.8 configure.in
> --- configure.in        22 Apr 2005 17:17:25 -0000      1.8
> +++ configure.in        17 Jun 2005 11:36:39 -0000
> @@ -19,6 +19,22 @@
>  AC_PROG_RANLIB
>  AC_PATH_BLUEZ
> 
> +AC_TRY_COMPILE([
> +       #include <bluetooth/bluetooth.h>
> +       #include <sys/socket.h>
> +       #include <bluetooth/hci.h>
> +       #include <bluetooth/hci_lib.h>
> +       ],[
> +       bdaddr_t *addr;
> +       int dd = 0;
> +       int role = 0;
> +       int to = 0;
> +       hci_switch_role(dd, addr, role, to);
> +       ],HAVE_BLUEZ=yes,HAVE_BLUEZ=no)
> +if test x$HAVE_BLUEZ != xyes; then
> +       AC_MSG_ERROR(bluez-libs 2.11 or better is required to compile btsco)
> +fi
> +
>  AM_PATH_ALSA(1.0.3)
> 
>  XIPH_PATH_AO
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
