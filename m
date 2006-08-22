Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: sean <seandarcy2@gmail.com>
Date: Tue, 22 Aug 2006 16:08:59 -0400
Message-ID: <ecfo8s$790$1@sea.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] recursive locking on pairing: 2.6.18-rc4
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I'm trying to pair my nokia 770 with my desktop which is 
running fc6t2, kernel-2.6.18-rc4. bluez-libs-3.0. Using a 
zonet usb dongle.

The 770 returns a "no services" message. On the desktop, 
/var/log/messages:

Aug 22 15:41:57 localhost hcid[24880]: pin_code_request 
(sba=00:02:72:C4:26:F1, dba=00:12:37:46:DB:31)
Aug 22 15:41:57 localhost hcid[24880]: link_key_notify 
(sba=00:02:72:C4:26:F1, dba=00:12:37:46:DB:31)
Aug 22 15:41:59 localhost kernel:
Aug 22 15:41:59 localhost kernel: 
=============================================
Aug 22 15:41:59 localhost kernel: [ INFO: possible recursive 
locking detected ]
Aug 22 15:41:59 localhost kernel: 2.6.17-1.2573.fc6 #1
Aug 22 15:41:59 localhost kernel: 
---------------------------------------------
Aug 22 15:41:59 localhost kernel: sdpd/24884 is trying to 
acquire lock:
Aug 22 15:41:59 localhost kernel: 
(sk_lock-AF_BLUETOOTH){--..}, at: [<ffffffff885622b8>] 
bt_accept_dequeue+0x37/0xfa [bluetooth]
Aug 22 15:41:59 localhost kernel:
Aug 22 15:41:59 localhost kernel: but task is already 
holding lock:
Aug 22 15:41:59 localhost kernel: 
(sk_lock-AF_BLUETOOTH){--..}, at: [<ffffffff88584464>] 
l2cap_sock_accept+0x52/0x162 [l2cap]
Aug 22 15:41:59 localhost kernel:
Aug 22 15:41:59 localhost kernel: other info that might help 
us debug this:
Aug 22 15:41:59 localhost kernel: 1 lock held by sdpd/24884:
Aug 22 15:41:59 localhost kernel:  #0: 
(sk_lock-AF_BLUETOOTH){--..}, at: [<ffffffff88584464>] 
l2cap_sock_accept+0x52/0x162 [l2cap]
Aug 22 15:41:59 localhost kernel:
Aug 22 15:41:59 localhost kernel: stack backtrace:
Aug 22 15:41:59 localhost kernel:
Aug 22 15:41:59 localhost kernel: Call Trace:
Aug 22 15:41:59 localhost kernel:  [<ffffffff8026e8fd>] 
show_trace+0xae/0x319
Aug 22 15:41:59 localhost kernel:  [<ffffffff8026eb7d>] 
dump_stack+0x15/0x17
Aug 22 15:41:59 localhost kernel:  [<ffffffff802a8278>] 
__lock_acquire+0x135/0xa64
Aug 22 15:41:59 localhost kernel:  [<ffffffff802a914a>] 
lock_acquire+0x4b/0x69
Aug 22 15:41:59 localhost kernel:  [<ffffffff802360ca>] 
lock_sock+0xd5/0xe7
Aug 22 15:41:59 localhost kernel:  [<ffffffff885622b8>] 
:bluetooth:bt_accept_dequeue+0x37/0xfa
Aug 22 15:41:59 localhost kernel:  [<ffffffff88584528>] 
:l2cap:l2cap_sock_accept+0x116/0x162
Aug 22 15:41:59 localhost kernel:  [<ffffffff8041f9cd>] 
sys_accept+0x102/0x1af
Aug 22 15:41:59 localhost kernel:  [<ffffffff8026058e>] 
system_call+0x7e/0x83
Aug 22 15:41:59 localhost kernel: DWARF2 unwinder stuck at 
system_call+0x7e/0x83
Aug 22 15:41:59 localhost kernel: Leftover inexact backtrace:
Aug 22 15:41:59 localhost kernel:

sean


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
