Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Daniel Haensse <haensse@swissembedded.com>
Reply-To: Daniel Haensse <haensse@swissembedded.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <200309042240.32662.haensse@swissembedded.com>
Subject: [Bluez-devel] Can't init device hci0. No such device(19)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 4 Sep 2003 22:40:32 +0200
Content-Type: text/plain; CHARSET=us-ascii

Hi list,

I  have cross compiled bluez stack for uclinux on 68knommu platforms. So fa=
r,=20
the utils are "executable".=20
I had to make a couple of changes (background):
- I did subsitute fork with vfok which is not implemented on uclinux.
- Totally ripped off all the make files to fit it into the distro tree
- We have /dev read only on our romfs.
- Made some entries for the conf files on the romfs
- Enabled all kernel bluez stuff (without module support)
- I use some Mitsumi modules, which use a csr chip. (The modules work fine =
on=20
my SuSE 8.0 notebook.)

The problem is now:
I can start hcid, but when I try to start hciattach, I can see=20
Can't init device hci0. No such device(19) in /var/log/messages (see below =
the=20
log)


any idea?

regards

Dani


---------------------------------------------------------------------------=
-------
BlueZ HCI UART driver ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
kmem_create: Forcing size word alignment - ip_dst_cache
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ SCO ver 0.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ RFCOMM ver 1.0
Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
BlueZ BNEP ver 1.1
Copyright (C) 2001,2002 Inventel Systemes
Written 2001,2002 by Clement Moreau <clement.moreau@inventel.fr>
Written 2001,2002 by David Libault <david.libault@inventel.fr>
Copyright (C) 2002 Maxim Krasnyanskiy <maxk@qualcomm.com>
VFS: Mounted root (romfs filesystem) readonly.
eth0: using half-duplex 10Base-T (RJ-45)

dragonix login: root
Password:
# hcid -n &
30
# hcid[30]: HCI daemon ver 2.3 started

# hciattach /dev/ttyS1 csr 115200 flow
CSR build ID 0x01-0x75
ttyS1 console mode off
hcid[30]: HCI dev 0 registered
hcid[32]: Can't init device hci0. No such device(19)

hcid[30]: HCI dev 0 unregistered
#




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
