Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Michal Krenek <mikos@sg1.cz>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20060420141808.1D1892FB5@osiris.flexible.cz>
Subject: [Bluez-devel] Bluetooth HID device doesn't work (HID create error)
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
Date: Thu, 20 Apr 2006 16:18:08 +0200

Hello,
I have Sony Ericsson K700 mobile phone, which supports standard HID profile=
 (you
can use it as remote control for your computer). I have tried this function=
 in
november (or december) last year and it had worked without problems. But wh=
en I
tried it today, it doesn't work. My mobile phone freezes on "Connecting" an=
d I
must restart it.

I have kernel 2.6.16.4, udev 089, bluez-libs & bluez-utils 2.25. My phone i=
s
paired with my PC and every other bluetooth functions work without problems
(file transfer, addressbook synchronization, internet connection via GPRS,
etc.). hidp kernel module is loaded and hidd --server is running (as root).=
 This
is what hcid and hidd gives me when I try it:

hcid[2620]: link_key_request (sba=3D00:13:85:00:0E:62, dba=3D00:12:EE:7D:03=
:CF)
hidd[2634]: HID create error 2 (No such file or directory)

I have tried also strace on hidd:

open("/usr/var/lib/bluetooth/00:13:85:00:0E:62/hidd", O_RDONLY) =3D -1 ENOE=
NT (No
such file or directory)

Well, this file really doesn't exist, so I have tried to create it manually
(touch /usr/var/lib/bluetooth/00:13:85:00:0E:62/hidd) and then repeat it. I=
 have
also checked write permissions and it looks good. Now hidd gives me this er=
ror:

hidd[3846]: HID create error 22 (Invalid argument)

And if I try strace it:
open("/usr/var/lib/bluetooth/00:13:85:00:0E:62/hidd", O_RDONLY) =3D 9
flock(9, LOCK_SH)                       =3D 0
fstat64(9, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 0, PROT_READ, MAP_SHARED, 9, 0) =3D -1 EINVAL (Invalid argument=
)

I am really lost now, I don't know where is the problem. Can you please hel=
p me?

Thanks,
Michal Krenek (Mikos)


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
