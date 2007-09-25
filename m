Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 25 Sep 2007 17:32:54 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Pierre-Yves Paulus <py@idlum.be>
Message-ID: <20070925173254.15c4e6bf@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <46F92364.3080603@idlum.be>
References: <46F92364.3080603@idlum.be>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] Warnings and Oops on 2.6.23-rc6 while activily
 using rfcomm links (mm/slab.c)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Tue, 25 Sep 2007 17:04:04 +0200,
Pierre-Yves Paulus <py@idlum.be> wrote:

> Hello,
> 
> Putting the bluetooth system under load (opening and closing several 
> rfcomm links off several USB adapters, and transmitting data over them), 
> I got the Oops below. The computer hung completely, as you can see. Just 
> before, I also got those warnings.
> 
> I'm not sure if I'm providing the right and useful informations to allow 
> fixing of those problems, as I'm definitely no expert. Please tell me if 
> I do something the wrong way.
> 
> 
> WARNING: at lib/kref.c:33 kref_get()
>   [<c01c537b>] kref_get+0x34/0x3d
>   [<c01c484b>] kobject_get+0xf/0x13
>   [<c0223b2f>] get_device+0xe/0x14
>   [<c0223b48>] device_move+0x13/0xe2
>   [<d02f4b78>] rfcomm_tty_close+0x23/0x61 [rfcomm]
>   [<c020e0a4>] release_dev+0x1c0/0x54a
>   [<d02f40c9>] rfcomm_dev_destruct+0x59/0x65 [rfcomm]
>   [<d02f470c>] rfcomm_dev_ioctl+0x328/0x4e6 [rfcomm]
>   [<c012a3a8>] autoremove_wake_function+0x0/0x35
>   [<c02460bc>] release_sock+0xc/0x74
>   [<c0243f4e>] sock_ioctl+0x19f/0x1be
>   [<c020e435>] tty_release+0x7/0xa
>   [<c015be91>] __fput+0x93/0x147
>   [<c0159a39>] filp_close+0x51/0x58
>   [<c015aad1>] sys_close+0x54/0x83
>   [<c0103c72>] syscall_call+0x7/0xb
>   =======================

This looks like some refcounting is messed up...

> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_KOBJECT is not set

Switching these two on may provide helpful information.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
