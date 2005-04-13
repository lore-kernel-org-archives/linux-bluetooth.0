Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY20-F36757559FB4EF0ADA8D4B185340@phx.gbl>
From: "Martin Rolsted Jensen" <mrj_ing@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: [Bluez-devel] Missing library libgcc_s.so.1 when using hciattach etc.
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
Date: Wed, 13 Apr 2005 18:25:36 +0000

Hello everybody!

I am trying to implement a UART bluetooth module on my Triton (PXA255) 
board.
I have compiled the necessary files in Scratchbox and made a new file 
system.
When I try to execute for example hciattach then I got the message:

root@triton1:/usr/sbin# hciattach
hciattach: error while loading shared libraries: libgcc_s.so.1: cannot open 
shared object file:
No such file or directory
root@triton1:/usr/sbin# ldd hciattach
   libbluetooth.so.1 => /usr/lib/libbluetooth.so.1 (0x40020000)
   libc.so.6 => /lib/libc.so.6 (0x40035000)
   /lib/ld-linux.so.2 => /lib/ld-linux.so.1 (0x40000000)
   libgcc_s.so.1 => not found

I have searched with the find command and there is no such library file in 
the file system.
Is it possible to naively include it in my file system, for example in /lib 
or /usr/lib?
If so, were can I find that missing library.

Best Regards

Martin Rolsted Jensen




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
