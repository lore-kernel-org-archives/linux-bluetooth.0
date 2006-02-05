Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY114-F6DB2D39DF285EB6E71FC8950F0@phx.gbl>
From: "Peter Scott" <peter_scottie@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [Bluez-users] HT820 pairing causes crash of hcid
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
Date: Mon, 06 Feb 2006 08:10:56 +1100

Hello there,

I have version 2.15 of hcid running on a fedora core 4 complied kernal 
2.6.15-1.1830_FC4.

I have successfully managed to pair with my mobile phone, and copy files to 
it.

However when i try to pair with a motorola headset ht820 hcid crashes. here 
are some printouts from hcid.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/usr/sbin/hcid -n
hcid[4266]: Bluetooth HCI daemon
hcid[4266]: Starting security manager 0
hcid[4266]: pin_code_request (sba=00:10:60:AD:6D:DC, dba=00:07:A4:B6:1F:AB)
4266: arguments to dbus_type_is_basic() were incorrect, assertion 
"_dbus_type_is_valid (typecode) || typecode == DBUS_TYPE_INVALID" f ailed in 
file dbus-signature.c line 259.
This is normally a bug in some application using the D-BUS library.
type unknown isn't supported yet in dbus_message_append_args_valist
*** buffer overflow detected ***: hcid: processing events terminated
======= Backtrace: =========
/lib/libc.so.6(__chk_fail+0x41)[0x85bc45]
hcid: processing events[0xcf6e8b]
/usr/lib/libdbus-1.so.1[0xb1b155]
/usr/lib/libdbus-1.so.1[0xafb49b]
/usr/lib/libdbus-1.so.1(dbus_connection_dispatch+0x20a)[0xafff37]
hcid: processing events[0xcf69c0]
hcid: processing events[0xcf68b0]
hcid: processing events(main+0x4c5)[0xcf2fef]
/lib/libc.so.6(__libc_start_main+0xdf)[0x792d5f]
hcid: processing events[0xcf2071]
======= Memory map: ========
00156000-0015f000 r-xp 00000000 03:03 2540282    
/lib/libgcc_s-4.0.2-20051126.so.1
0015f000-00160000 rwxp 00009000 03:03 2540282    
/lib/libgcc_s-4.0.2-20051126.so.1
0077e000-008a1000 r-xp 00000000 03:03 2541235    /lib/libc-2.3.5.so
008a1000-008a3000 r-xp 00123000 03:03 2541235    /lib/libc-2.3.5.so
008a3000-008a5000 rwxp 00125000 03:03 2541235    /lib/libc-2.3.5.so
008a5000-008a7000 rwxp 008a5000 00:00 0
00aef000-00b58000 r-xp 00000000 03:03 2706238    /usr/lib/libdbus-1.so.1.0.0
00b58000-00b5d000 rwxp 00069000 03:03 2706238    /usr/lib/libdbus-1.so.1.0.0
00bd0000-00bd1000 r-xp 00bd0000 00:00 0          [vdso]
00cf0000-00cfa000 r-xp 00000000 03:03 2708464    /usr/sbin/hcid
00cfa000-00cfb000 rwxp 00009000 03:03 2708464    /usr/sbin/hcid
00d50000-00d5c000 r-xp 00000000 03:03 2701357    
/usr/lib/libbluetooth.so.1.0.15
00d5c000-00d5d000 rwxp 0000c000 03:03 2701357    
/usr/lib/libbluetooth.so.1.0.15
00e70000-00e82000 r-xp 00000000 03:03 2541236    /lib/libnsl-2.3.5.so
00e82000-00e83000 r-xp 00011000 03:03 2541236    /lib/libnsl-2.3.5.so
00e83000-00e84000 rwxp 00012000 03:03 2541236    /lib/libnsl-2.3.5.so
00e84000-00e86000 rwxp 00e84000 00:00 0
00f30000-00f4a000 r-xp 00000000 03:03 2541234    /lib/ld-2.3.5.so
00f4a000-00f4b000 r-xp 00019000 03:03 2541234    /lib/ld-2.3.5.so
00f4b000-00f4c000 rwxp 0001a000 03:03 2541234    /lib/ld-2.3.5.so
0887f000-088a0000 rw-p 0887f000 00:00 0          [heap]
b7f64000-b7f66000 rw-p b7f64000 00:00 0
b7f81000-b7f82000 rw-p b7f81000 00:00 0
bff6d000-bff82000 rw-p bff6d000 00:00 0          [stack]
Aborted
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

I know that other people have managed to pair with this device, and would 
apreaciate any comments or helpful tips.

If there is anything I can do to help please let me know.

Many thanks
Peter Scott

_________________________________________________________________
New year, new job – there's more than 100,00 jobs at SEEK 
http://a.ninemsn.com.au/b.aspx?URL=http%3A%2F%2Fninemsn%2Eseek%2Ecom%2Eau&_t=752315885&_r=Jan05_tagline&_m=EXT



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
