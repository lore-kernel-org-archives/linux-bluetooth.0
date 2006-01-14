Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ISSC USB dongle Bluetooth problem (Patching the Kernel)
References: <43C9629D.8010405@emajor.net>
In-Reply-To: <43C9629D.8010405@emajor.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601150016.58417.yann.morin.1998@anciens.enib.fr>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 15 Jan 2006 00:16:58 +0100

Hi all,
Ehab,

On Saturday 14 January 2006 214, Ehab El Maraghy wrote:
> [root@Ehab src]# patch -p0 < patch-2.4.20-mh18.gz

How comes you can use gziped data as input to patch?

> can't find file to patch at input line 4
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |diff -urN linux-2.4.20/arch/sparc64/kernel/ioctl32.c=20
> linux-2.4.20-mh18/arch/sparc64/kernel/ioctl32.c
> |--- linux-2.4.20/arch/sparc64/kernel/ioctl32.c 2002-11-29=20
> 00:53:12.000000000 +0100
> |+++ linux-2.4.20-mh18/arch/sparc64/kernel/ioctl32.c    2004-08-01=20
> 16:31:28.000000000 +0200
> --------------------------
> File to patch:
>=20
> Kernel source is in folder called linux-2.4.20-8 not 2.4.20
> should I change overy instant in the patch file to add -8 ?

$ cd linux-2.4.20-8
$ zcat /some/where/patch-2.4.20-mh18.gz |patch -p1

That tells patch to ignore the first directory, and tells it to assume to be
in the correct directory (which is true because you cd'ed in there in the f=
irst
place).

> Whats the next step ?  make menuconfig ?

Assuming you get your kernel from your distribution maker (RedHat I saw in =
the
archives) it should be already configured. If not, do a menuconfig first, t=
hen
run :
$ make dep clean bzImage modules modules_install
$ cp arch/i386/boot/bzImage /boot/vmlinuz-2.4.20-8-bluez-issc

and add it to your bootloader menu (lilo I guess).

=46rom your other message, you seem to have been able to put it in the 'up'
state. How ddid you do that (yeah, hciconfig hci0 up), but apart that?
Mine refuses to go up, and it even has no BT address... :-/

Regards,
Yann E. MORIN.

=2D-=20
=2E-----------------.--------------------.------------------.--------------=
=2D-----.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspira=
cy: |
| +0/33 662376056 | Software  Designer | \ / CAMPAIGN     |   ^            =
    |
| --=3D=3D< =B0_=B0 >=3D=3D-- =B0---.----------------:  X  AGAINST      |  =
/e\  There is no  |
| web: ymorin.free.fr | SETI@home 3808 | / \ HTML MAIL    |  """  conspirac=
y.  |
=B0---------------------=B0----------------=B0------------------=B0--------=
=2D-----------=B0


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
