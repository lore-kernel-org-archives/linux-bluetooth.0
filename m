Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] option "--activesync" and "--msdun"
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <9c68c0a70512230043j2de1d4ccx@mail.gmail.com>
References: <9c68c0a70512230043j2de1d4ccx@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1135350880.3985.8.camel@localhost>
Mime-Version: 1.0
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
Date: Fri, 23 Dec 2005 16:14:40 +0100

Hi,

> Can option "--activesync" and "--msdun" in "dund"  work  in  kernel
> 2.4.18  which has
> patched patch-2.4.18-mh15.gz ?

it should work, but this kernel is very old and might contain bugs. I am
not supporting this kernel anymore.

> I run the command on my arm linux:
> 
> "dund --listen --msdun -a -n call dun"
> 
> then I used a ms smartphone to conncet to my usb adaptor.
> I got the following outputs:
> 
> dund[60]: Bluetooth DUN daemon version 2.21
> dund[65]: New connection from 00:09:2D:12:FE:86
> using channel 1
> Using interface ppp0
> Connect: ppp0 <--> /dev/bluetooth/rfcomm/0
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xd791249e> <pcomp> <accomp>]
> rcvd [LCP ConfReq id=0x0 <asyncmap 0x0> <pcomp> <accomp>]
> sent [LCP ConfAck id=0x0 <asyncmap 0x0> <pcomp> <accomp>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xd791249e> <pcomp> <accomp>]
> rcvd [LCP ConfAck id=0x1 <asyncmap 0x0> <magic 0xd791249e> <pcomp> <accomp>]
> sent [IPCP ConfReq id=0x1 <addr 192.168.55.100> <compress VJ 0f 01>]
> rcvd [CCP ConfReq id=0x0 < 12 06 00 00 00 01>]
> sent [CCP ConfReq id=0x1]
> sent [CCP ConfRej id=0x0 < 12 06 00 00 00 01>]
> rcvd [IPCP ConfReq id=0x0 <compress VUnable to handle kernel NULL
> pointer dereference at virtual address 00000000
> pgd = c0004000
> *pgd = 00000000, *pmd = 00000000
> Internal error: Oops: ffffffff
> CPU: 0
> pc : [<c00274b8>]    lr : [<c00275c0>]    Not tainted
> sp : c03cfcc8  ip : 00000001  fp : c03cfce8
> r10: 00000020  r9 : 80000093  r8 : c3dabd6c
> r7 : c03fe0a0  r6 : 00001000  r5 : 00000004  r4 : 00000004
> r3 : 00000000  r2 : c3dabd6c  r1 : 000001f1  r0 : 000001f1
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
> Control: C000317F  Table: 33B44000  DAC: 0000001D
> Process krfcommd (pid: 9, stackpage=c03cf000)

I can't tell you if this is an RFCOMM problem or if it is a PPP problem.
Try to reproduce it with a decent 2.6 kernel.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
