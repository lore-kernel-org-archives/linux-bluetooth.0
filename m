Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46F2BC9D.8050206@idlum.be>
Date: Thu, 20 Sep 2007 20:31:57 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Kernel Oops on 2.6.23-rc6
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

Just got this:

CPU:    0
EFLAGS: 00010286   (2.6.23-rc6 #1)
esi: 00000068   edi: c9fc1000   ebp: ffffffea   esp: c2c6de28
Stack: 00000000 c1fcef80 c030a3a1 cd7fb2b8 00000068 c01c484b c9fc1068 
c01c4bda
Call Trace:
  [<c01c4bda>] kobject_move+0x24/0xec
  [<c0223bdf>] device_move+0xaa/0xe2
  [<c0118689>] default_wake_function+0x0/0xc
EIP:    0060:[<c01c534d>]    Not tainted VLI
EIP is at kref_get+0x6/0x3d
Oops: 0000 [#1]
eax: 00000080   ebx: 00000080   ecx: 00000000   edx: 00000068
ds: 007b   es: 007b   fs: 0000  gs: 0033  ss: 0068
        00000286 00000000 c9fc1068 ca9ca2a0 c02238fb 00000000 00000000 
cd7fb2b8
Process rfcomm (pid: 9031, ti=c2c6c000 task=c7e51570 task.ti=c2c6c000)
  [<c02238fb>] device_move_class_links+0x89/0x91
        c9fc1000 fffffffe c0223bdf c9fc1068 c62d73c0 cd7fb200 c9055800 
c9055904
  [<c01c484b>] kobject_get+0xf/0x13
  [<d034ca85>] rfcomm_tty_open+0x17c/0x192 [rfcomm]
  [<c015d0d2>] chrdev_open+0xc1/0xf6
  [<c0159ba5>] __dentry_open+0xb4/0x160
  [<c0159ccb>] nameidata_to_filp+0x24/0x33
  [<c0159a82>] get_unused_fd_flags+0x42/0xaa
  [<c0159d60>] do_sys_open+0x48/0xcf
  [<c0103c72>] syscall_call+0x7/0xb
Code: 14 72 f5 ff e8 8d 08 f4 ff ff 0b 0f 94 c0 31 d2 84 c0 74 09 89
  d8 ff d6 ba 01 00 00 00 83 c4 10 89 d0 5b 5e c3 53 89 c3 83 ec 10 <83> 
38 00 75
  29 c7 44 24 0c 1d 54 2b c0 c7 44 24 08 21 00 00 00
  [<c020f4b2>] tty_open+0x167/0x291
  [<c015d011>] chrdev_open+0x0/0xf6
  [<c0159d11>] do_filp_open+0x37/0x3e
EIP: [<c01c534d>] kref_get+0x6/0x3d SS:ESP 0068:c2c6de28
  =======================
  [<c0159e20>] sys_open+0x1c/0x1e


I was trying to open 4 RFCOMM links off one dongle. 3 were plugged in 
the box, and the second one was was performing inquiry. Third was up but 
idle.

I was opening the rfcomms using the "rfcomm" utility by hand. The Oops 
happened as the links were created (eg at the time were remote devices 
accepted the connection), and no data was sent on the links at that point.

If I can give more information, please ask, and tell me what you need. 
I'm not used to that kernel stuff, so please bear with me.

Best Regards,
Pierre-Yves

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
