Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050709041029.GF16487@beta.private.mielke.cc>
References: <1120649879.8836.5.camel@pegasus> <20050706120934.GW21449@beta.private.mielke.cc> <1120652788.8836.7.camel@pegasus> <20050706123359.GY21449@beta.private.mielke.cc> <1120653839.8836.10.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120653839.8836.10.camel@pegasus>
Subject: [Bluez-devel] hcid dies on socket connect attempt.
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
Date: Sat, 9 Jul 2005 00:10:30 -0400

On a Fedora Core 4 system we have:

   dbus-0.33-3
   bluez-utils-2.15-7
   bluez-libs-2.15-1

hcid starts up fine: 

==============================================================================
hcid -n
hcid[12537]: Bluetooth HCI daemon
hcid[12537]: Starting security manager 0
==============================================================================

As soon as I try to get a Bluetooth connection, however, it dies (see 
below). 
What might be wrong? 

This code works well on Fedora Core 3. Has something changed? We establish the
connection as follows:

   int connection;
   connection = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

   struct sockaddr_rc local;
   local.rc_family = AF_BLUETOOTH;
   local.rc_channel = 0;
   bacpy(&local.rc_bdaddr, BDADDR_ANY);
   bind(connection, (struct sockaddr *)&local, sizeof(local));
   
   struct sockaddr_rc remote;
   remote.rc_family = AF_BLUETOOTH;
   remote.rc_channel = /* supplied channel number */;
   bacpy(&remote.rc_bdaddr, &/* supplied addreess */);
   connect(connection, (struct sockaddr *)&remote, sizeof(remote));

Now here's now hcid dies:

==============================================================================
hcid[12537]: link_key_request (sba=00:0A:3A:53:D7:FC, dba=00:A0:96:0A:C9:10)
hcid[12537]: pin_code_request (sba=00:0A:3A:53:D7:FC, dba=00:A0:96:0A:C9:10)
12537: arguments to dbus_type_is_basic() were incorrect, assertion 
"_dbus_type_is_valid (typecode) || typecode == DBUS_TYPE_INVALID" failed in 
file dbus-signature.c line 259.
This is normally a bug in some application using the D-BUS library.
type unknown isn't supported yet in dbus_message_append_args_valist
*** buffer overflow detected ***: hcid: processing events terminated
======= Backtrace: =========
/lib/libc.so.6(__chk_fail+0x41)[0x781565]
hcid: processing events[0x880e8b]
/usr/lib/libdbus-1.so.1[0x296155]
/usr/lib/libdbus-1.so.1[0x27649e]
/usr/lib/libdbus-1.so.1(dbus_connection_dispatch+0x20a)[0x27af44]
hcid: processing events[0x8809c0]
hcid: processing events[0x8808b0]
hcid: processing events(main+0x4c5)[0x87cfef]
/lib/libc.so.6(__libc_start_main+0xc6)[0x6b7de6]
hcid: processing events[0x87c071]
======= Memory map: ========
0026a000-002d3000 r-xp 00000000 fd:00 3051963    /usr/lib/libdbus-1.so.1.0.0
002d3000-002d8000 rwxp 00069000 fd:00 3051963    /usr/lib/libdbus-1.so.1.0.0
00301000-0031b000 r-xp 00000000 fd:00 8676400    /lib/ld-2.3.5.so
0031b000-0031c000 r-xp 00019000 fd:00 8676400    /lib/ld-2.3.5.so
0031c000-0031d000 rwxp 0001a000 fd:00 8676400    /lib/ld-2.3.5.so
003cd000-003ce000 r-xp 003cd000 00:00 0
006a3000-007c7000 r-xp 00000000 fd:00 8676401    /lib/libc-2.3.5.so
007c7000-007c9000 r-xp 00124000 fd:00 8676401    /lib/libc-2.3.5.so
007c9000-007cb000 rwxp 00126000 fd:00 8676401    /lib/libc-2.3.5.so
007cb000-007cd000 rwxp 007cb000 00:00 0
0085c000-00865000 r-xp 00000000 fd:00 8676405    
/lib/libgcc_s-4.0.0-20050520.so.1
00865000-00866000 rwxp 00009000 fd:00 8676405    
/lib/libgcc_s-4.0.0-20050520.so.1
0087a000-00884000 r-xp 00000000 fd:00 3051713    /usr/sbin/hcid
00884000-00885000 rwxp 00009000 fd:00 3051713    /usr/sbin/hcid
00a09000-00a15000 r-xp 00000000 fd:00 3048829    
/usr/lib/libbluetooth.so.1.0.15
00a15000-00a16000 rwxp 0000c000 fd:00 3048829    
/usr/lib/libbluetooth.so.1.0.15
00eb6000-00ec8000 r-xp 00000000 fd:00 8676413    /lib/libnsl-2.3.5.so
00ec8000-00ec9000 r-xp 00011000 fd:00 8676413    /lib/libnsl-2.3.5.so
00ec9000-00eca000 rwxp 00012000 fd:00 8676413    /lib/libnsl-2.3.5.so
00eca000-00ecc000 rwxp 00eca000 00:00 0
08462000-08483000 rw-p 08462000 00:00 0          [heap]
b7f78000-b7f7a000 rw-p b7f78000 00:00 0
b7f9e000-b7f9f000 rw-p b7f9e000 00:00 0
bfb89000-bfb9f000 rw-p bfb89000 00:00 0          [stack]
Aborted
==============================================================================

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://FamilyRadio.com/                   | http://Mielke.cc/bible/


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
