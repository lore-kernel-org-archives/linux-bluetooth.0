Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jeffrey Arbuckle <jbarbuc@nmt.edu>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401031458050.20028-100000@speare5-1-11.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] bthid and console switching
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
Date: Sat, 3 Jan 2004 15:14:22 -0700 (MST)


I'm using the cvs bthid with kernel 2.6 with
Microsoft's Bluetooth desktop.

Everything is working great except when using the bluetooth
keyboard to switch to console with CNTL-ALT-F[1-6] from xwindows.

Doing so causes bthid to crash.  Syslog reveals:

Unable to handle kernel paging request at virtual address 00100100
 printing eip:
 c024b1ee
 *pde = 00000000
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[<c024b1ee>]    Tainted: P  
 EFLAGS: 00010246
 EIP is at mousedev_event+0x80/0x1fc
 eax: 00100100   ebx: 001000f8   ecx: 00100100   edx: f7264000
 esi: c03ae3a0   edi: 00000000   ebp: f7265efc   esp: f7265ed4
 ds: 007b   es: 007b   ss: 0068
 Process bthid (pid: 902, threadinfo=f7264000 task=f7269310)
 Stack: f7d26900 0000001d 00020001 0000001e 00000001 f7272a00 c03ae3a0 00000000 
        f7265f00 f7272a00 c03ae3a0 00000000 00000000 f7272a34 f723ce38 00000000 
        00000000 c024976b f7272a34 00000000 00000000 00000000 00000000 00000000 
 Call Trace:
  [<c024976b>] input_event+0xef/0x3fa
  [<f8830541>] uinput_write+0xa9/0xd2 [uinput]
  [<c015beee>] vfs_write+0xbc/0x127
  [<c015bffe>] sys_write+0x42/0x63
  [<c010953b>] syscall_call+0x7/0xb

Code: 8b 53 08 89 d1 0f 18 02 90 8d 56 2c 39 d0 75 cf 8b 44 24 10 

Note that when using a ps/2 keyboard and the bluetooth keyboard, the
ps/2 keyboard will not cause bthid to crash when switching consoles, but the
bluetooth keyboard will.

After bthid crashes and the machine is in console, no input from the ps/2
keyboard appears on the screen.  However, CNTL-ALT-F7 returns the machine
to xwindows where input from the ps/2 allows bthid to be run again.
Bluetooth keyboard and mouse then work as normal but switching consoles
repeats the cyle all over again.

Any ideas?

-jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
