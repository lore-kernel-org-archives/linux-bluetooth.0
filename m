Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <32766726.1078835177020.JavaMail.ngmail@webmail06.arcor-online.net>
From: damou@nexgo.de
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Toshiba Portege M200 internal bluetooth adapter
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 9 Mar 2004 13:26:16 +0100 (CET)

>Hi
Hi,
>
>It's a relief to know it works for someone at least.
>
>I think part of the trouble is I'm using libc 2.3. It's clear that the
>macro "TOSH_SMM" that won't compile invokes another macro (_IOWR) with
>the wrong
>arguments, at least for 2.3. In the unmodified sources, the third
>argument is the number '24' but the third argument is supposed to be a
>type that can be applied to sizeof() to *produce* the size (ends up
>being 24).
>
>Even so, It doesn't work for me under 2.4.25-mh1 or 2.6.4rc1-mm2. They
>both complain "Can't access Toshiba device /dev/toshiba" and strace 
>shows that the error happens with the first ioctl.
>
>/dev/toshiba is there, the "toshiba" module is loaded. I installed
>toshutils from debian using apt... I'm not sure what else to try.
>

I also installed toshutils using apt-get on my Knoppix Remaster CD.

>
>ACPI is the only way I could get suspend to work. (but only in 2.6.4). 
>The APM module won't load under either kernel, but I thought that was 
>because the m200 had no APM bios.
>

Here 
http://www.sfires.net/toshiba/
you can find how to enable Bluetooth with an ACPI enabled Kernel

>
>What does lsmod show on your knoppix machine?

Here it is:
===========
Module                  Size  Used by    Not tainted
smbfs                  33008   1  (autoclean)
toshiba                 2752   0  (autoclean)
l2cap                  16876   1  (autoclean)
hci_usb                 7612   1  (autoclean)
bluez                  30308   3  (autoclean) [l2cap hci_usb]
autofs4                 8724   1  (autoclean)
nls_cp437               4380   0  (autoclean)
nls_iso8859-1           2876   0  (autoclean)
ntfs                   50784   0  (autoclean)
i810_audio             23112   0 
ac97_codec              9992   0  [i810_audio]
soundcore               3364   2  [i810_audio]
serial                 51876   0  (autoclean)
usb-uhci               21836   0  (unused)
usbcore                57088   1  [hci_usb usb-uhci]
ds                      6472   1 
yenta_socket            8640   1 
pcmcia_core            37568   0  [ds yenta_socket]
rtc                     6908   0  (autoclean)
cloop                   5168   1 
e100                   54208   1 
00_mii                  1952   0 
nfs                    66648   1 
lockd                  47952   1  [nfs]
sunrpc                 62780   1  [nfs lockd]
af_packet              13224   0 
>
>
cu
Martl
>Brad







-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
