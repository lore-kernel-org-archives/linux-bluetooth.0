Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Charles Bueche <charles@bueche.ch>
To: bluez-devel@lists.sourceforge.net, peter@klausler.com
In-Reply-To: <1070201531.8187.20.camel@bluez.bueche.ch>
References: <1070201531.8187.20.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1070218289.8534.30.camel@bluez.bueche.ch>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 30 Nov 2003 19:51:29 +0100

Hi again,

responding to my own email after studying fake.c : I got it to compile
on 2.6, but this code isn't able to run as module on 2.6 kernels, which
changed the module format.

Peter : do you plan a 2.6 version anytime soon ?

TIA,
Charles

On Sun, 2003-11-30 at 15:12, Charles Bueche wrote:
> Hi,
> 
> I have this hardware combination : the new Logitech MX900, which is
> talking bluetooth to its hub. This hub goes to my laptop using USB.
> 
> I'm using gentoo linux, with kernel 2.6.0test11. I have patched my
> XFree86 (xfree-4.3.99.16.ebuild) with
> http://www.yhbt.net/normalperson/files/linux/LogitechMX_kernel_and_X_patch/
> to make it understand the PS2++ protocol, and the mouse somewhat works.
> 
> The setup is working fine, even if I didn't finish the setup completely
> (all buttons aren't working yet).
> 
> Now, having a internal bluetooth module within my Dell Inspiron 8600, I
> would like to connect the mouse directly, without going through the hub
> and USB.
> 
> When I use the basic tools (hcitool scan, hcitool info), I get this info
> block from the mx900 :
> 
> ==============
> Requesting information ...
> BD Address:  00:07:61:08:7E:2E
> Device Name: Logitech MX900 Mouse
> LMP Version: 1.1 (0x1) LMP Subversion: 0x350
> Manufacturer: Cambridge Silicon Radio (10)
> Features: 0xfc 0xff 0x0f 0x00
> <encryption> <slot offset> <timing accuracy> <role switch> <hold mode>
> <sniff mode> <park mode> <RSSI> <channel quality> <SCO link> <HV2
> packets> <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
> <power control> <transparent SCO> 
> ==============
> 
> I now understand that I need some piece of software to get the mouse
> events from the bluez stack and pass them to a device that X would
> understand.
> 
>  I tried to compile bthid from Peter Klauser. bthid itself compile, but
> fake.o choke on line 87 of fake.c :
> 
> ====================
> make -f make.fake fake.o
> make[1]: Entering directory `/data/util/bthid-0.8'
> gcc -pipe   -Iinclude/asm-i386/mach-default  -DMODULE -DMODVERSIONS
> -include /usr/src/linux-2.6.0-test11-gentoo/include/config/modversions.h
> -D__KERNEL__ -DMAJORNUM=250 -I/usr/src/linux-2.6.0-test11-gentoo/include
> -fno-strict-aliasing -fno-common   -c -o fake.o fake.c
> fake.c:86: parse error before "devfs_handle"
> fake.c:86: warning: data definition has no type or storage class
> make[1]: *** [fake.o] Error 1
> make[1]: Leaving directory `/data/util/bthid-0.8'
> make: *** [fake.o] Error 2
> ====================
> 
> hints welcome. I can test whatewer piece of code you throw at me. I'm
> however not knowledeable enough to code it myself.
> 
> Charles
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
