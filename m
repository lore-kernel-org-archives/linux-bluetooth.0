Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth HID device doesn't work (HID create
	error)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060420141808.1D1892FB5@osiris.flexible.cz>
References: <20060420141808.1D1892FB5@osiris.flexible.cz>
Content-Type: text/plain
Message-Id: <1145543458.17818.6.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 20 Apr 2006 16:30:58 +0200

Hi Michal,

> I have Sony Ericsson K700 mobile phone, which supports standard HID profile (you
> can use it as remote control for your computer). I have tried this function in
> november (or december) last year and it had worked without problems. But when I
> tried it today, it doesn't work. My mobile phone freezes on "Connecting" and I
> must restart it.
> 
> I have kernel 2.6.16.4, udev 089, bluez-libs & bluez-utils 2.25. My phone is
> paired with my PC and every other bluetooth functions work without problems
> (file transfer, addressbook synchronization, internet connection via GPRS,
> etc.). hidp kernel module is loaded and hidd --server is running (as root). This
> is what hcid and hidd gives me when I try it:
> 
> hcid[2620]: link_key_request (sba=00:13:85:00:0E:62, dba=00:12:EE:7D:03:CF)
> hidd[2634]: HID create error 2 (No such file or directory)
> 
> I have tried also strace on hidd:
> 
> open("/usr/var/lib/bluetooth/00:13:85:00:0E:62/hidd", O_RDONLY) = -1 ENOENT (No
> such file or directory)
> 
> Well, this file really doesn't exist, so I have tried to create it manually
> (touch /usr/var/lib/bluetooth/00:13:85:00:0E:62/hidd) and then repeat it. I have
> also checked write permissions and it looks good. Now hidd gives me this error:
> 
> hidd[3846]: HID create error 22 (Invalid argument)
> 
> And if I try strace it:
> open("/usr/var/lib/bluetooth/00:13:85:00:0E:62/hidd", O_RDONLY) = 9
> flock(9, LOCK_SH)                       = 0
> fstat64(9, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
> mmap2(NULL, 0, PROT_READ, MAP_SHARED, 9, 0) = -1 EINVAL (Invalid argument)
> 
> I am really lost now, I don't know where is the problem. Can you please help me?

use "hidd --search" to connect to your phone. You need to do this at
least once to have the correct data in the hidd file.

Regards

Marcel




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
