Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42B447F2.9080801@eridani.co.uk>
From: Michael McConnell <soruk@eridani.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------080703040703030500090300"
Subject: [Bluez-users] Kernel panic on stopping pand
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
Date: Sat, 18 Jun 2005 17:12:34 +0100

This is a multi-part message in MIME format.
--------------080703040703030500090300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Trying kernel 2.6.11.12, I got this (attached) kernel panic message 
after trying to stop pand after the first set of messages logged appeared.

Before that are the messages, when the entire USB layer seems to stall.  
It's possibly worth noting this only happens going through a hub - when 
connected directly to the machine the problem doesn't occur.

There was a second panic, where the machine froze up, and the message 
was way too long to fit on the screen... this wasn't logged in syslog.

It's possible the fault could be the USB hub driver, but it doesn't play 
up like this when I run my USB hard disc through it. I haven't tried my 
DVD burner through the hub - they make expensive beermats :-/

-- 
-- Michael "Soruk" McConnell
   Eridani Star System

   MailStripper - "The easy spam filter."
   http://mailstripper.eridani.co.uk/


--------------080703040703030500090300
Content-Type: text/plain;
 name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages"

Jun 18 16:42:48 zeskia kernel: usb 4-1: USB disconnect, address 2 
Jun 18 16:42:48 zeskia kernel: usb 4-1.3: USB disconnect, address 5 
Jun 18 16:42:51 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f5f4 type 2 err -19 
Jun 18 16:42:52 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd3998f4 type 2 err -19 
Jun 18 16:42:53 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd399974 type 2 err -19 
Jun 18 16:43:00 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f674 type 2 err -19 
Jun 18 16:43:01 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f5f4 type 2 err -19 
Jun 18 16:43:02 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd3998f4 type 2 err -19 
Jun 18 16:43:03 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd399974 type 2 err -19 
Jun 18 16:43:04 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f674 type 2 err -19 
Jun 18 16:43:05 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f5f4 type 2 err -19 
Jun 18 16:43:07 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd3998f4 type 2 err -19 
Jun 18 16:43:08 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd399974 type 2 err -19 
Jun 18 16:43:09 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f674 type 2 err -19 
Jun 18 16:43:14 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f5f4 type 2 err -19 
Jun 18 16:43:15 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd3998f4 type 2 err -19 
Jun 18 16:43:16 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd399974 type 2 err -19 
Jun 18 16:43:28 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f674 type 2 err -19 
Jun 18 16:43:29 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f5f4 type 2 err -19 
Jun 18 16:43:30 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd3998f4 type 2 err -19 
Jun 18 16:43:56 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd399974 type 2 err -19 
Jun 18 16:43:57 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f674 type 2 err -19 
Jun 18 16:44:52 zeskia kernel: hci_acl_tx_to: hci0 ACL tx timeout 
Jun 18 16:44:52 zeskia kernel: hci_acl_tx_to: hci0 killing stalled ACL connection C1:9D:58:16:05:00 
Jun 18 16:44:52 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd399a74 type 1 err -19 
Jun 18 16:44:52 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd27f5f4 type 2 err -19 
Jun 18 16:44:53 zeskia kernel: hci_acl_tx_to: hci0 ACL tx timeout 
Jun 18 16:44:53 zeskia kernel: hci_acl_tx_to: hci0 killing stalled ACL connection C1:9D:58:16:05:00 
Jun 18 16:44:54 zeskia kernel: hci_acl_tx_to: hci0 ACL tx timeout 
Jun 18 16:44:54 zeskia kernel: hci_acl_tx_to: hci0 killing stalled ACL connection C1:9D:58:16:05:00 
Jun 18 16:44:54 zeskia kernel: hci_cmd_task: hci0 command tx timeout 
Jun 18 16:44:54 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd399a74 type 1 err -19 
Jun 18 16:44:54 zeskia kernel: __tx_submit: hci0 tx submit failed urb dd3998f4 type 2 err -19 
Jun 18 16:45:26 zeskia kernel: Unable to handle kernel paging request at virtual address e0989b8a 
Jun 18 16:45:26 zeskia kernel:  printing eip: 
Jun 18 16:45:26 zeskia kernel: e0989b8a 
Jun 18 16:45:26 zeskia kernel: *pde = 014da067 
Jun 18 16:45:26 zeskia kernel: *pte = 00000000 
Jun 18 16:45:26 zeskia kernel: Oops: 0000 [#1] 
Jun 18 16:45:26 zeskia kernel: Modules linked in: hci_usb bluetooth usb_storage ehci_hcd uhci_hcd usbcore ppa advansys tuner bttv video_buf firmware_class btcx_risc tveeprom 
Jun 18 16:45:26 zeskia kernel: CPU:    0 
Jun 18 16:45:26 zeskia kernel: EIP:    0060:[<e0989b8a>]    Tainted: GF     VLI 
Jun 18 16:45:26 zeskia kernel: EFLAGS: 00010286   (2.6.11.12)  
Jun 18 16:45:26 zeskia kernel: EIP is at 0xe0989b8a 
Jun 18 16:45:26 zeskia kernel: eax: 7fffffff   ebx: 7fffffff   ecx: 00000000   edx: 00000000 
Jun 18 16:45:26 zeskia kernel: esi: dd33a040   edi: dcc7e000   ebp: 00000000   esp: dcc7fe94 
Jun 18 16:45:26 zeskia kernel: ds: 007b   es: 007b   ss: 0068 
Jun 18 16:45:26 zeskia kernel: Process pand (pid: 1865, threadinfo=dcc7e000 task=dcc4ba60) 
Jun 18 16:45:26 zeskia kernel: Stack: 00000000 dcc4ba60 c01113d0 00000000 00000000 dd38eddc c01126a7 dcc7fef8  
Jun 18 16:45:26 zeskia kernel:        00000001 dcc4ba60 c01113d0 dcc6135c dcc6135c dcc7fef8 c14de800 dcc61340  
Jun 18 16:45:26 zeskia kernel:        e098dbe0 dcc61c40 dcc61340 bffffa10 c02a9cbc dcc61340 dcc61c40 00000002  
Jun 18 16:45:26 zeskia kernel: Call Trace: 
Jun 18 16:45:26 zeskia kernel:  [<c01113d0>] default_wake_function+0x0/0x20 
Jun 18 16:45:26 zeskia kernel:  [<c01126a7>] copy_mm+0x287/0x370 
Jun 18 16:45:26 zeskia kernel:  [<c01113d0>] default_wake_function+0x0/0x20 
Jun 18 16:45:26 zeskia kernel:  [<c02a9cbc>] sys_accept+0x8c/0x110 
Jun 18 16:45:26 zeskia kernel:  [<c01219e3>] attach_pid+0x23/0xb0 
Jun 18 16:45:26 zeskia kernel:  [<c02abf2e>] release_sock+0x4e/0x60 
Jun 18 16:45:26 zeskia kernel:  [<c0110bc2>] wake_up_new_task+0x82/0x1d0 
Jun 18 16:45:26 zeskia kernel:  [<c01cb796>] copy_from_user+0x46/0x70 
Jun 18 16:45:26 zeskia kernel:  [<c02aa62c>] sys_socketcall+0xac/0x1d0 
Jun 18 16:45:26 zeskia kernel:  [<c0144285>] sys_close+0x45/0x60 
Jun 18 16:45:26 zeskia kernel:  [<c0102c7f>] syscall_call+0x7/0xb 
Jun 18 16:45:26 zeskia kernel: Code:  Bad EIP value. 
Jun 18 16:45:26 zeskia kernel:  <1>Unable to handle kernel paging request at virtual address e0984704 
Jun 18 16:45:26 zeskia kernel:  printing eip: 
Jun 18 16:45:26 zeskia kernel: c02a8c4d 
Jun 18 16:45:26 zeskia kernel: *pde = 014da067 
Jun 18 16:45:26 zeskia kernel: *pte = 00000000 
Jun 18 16:45:26 zeskia kernel: Oops: 0000 [#2] 
Jun 18 16:45:26 zeskia kernel: Modules linked in: hci_usb bluetooth usb_storage ehci_hcd uhci_hcd usbcore ppa advansys tuner bttv video_buf firmware_class btcx_risc tveeprom 
Jun 18 16:45:26 zeskia kernel: CPU:    0 
Jun 18 16:45:26 zeskia kernel: EIP:    0060:[<c02a8c4d>]    Tainted: GF     VLI 
Jun 18 16:45:26 zeskia kernel: EFLAGS: 00010286   (2.6.11.12)  
Jun 18 16:45:26 zeskia kernel: EIP is at sock_release+0xd/0x70 
Jun 18 16:45:26 zeskia kernel: eax: e0984700   ebx: ddd94888   ecx: 00000000   edx: 00000001 
Jun 18 16:45:26 zeskia kernel: esi: ddd94860   edi: ddd94888   ebp: dcc23214   esp: dcc7fc60 
Jun 18 16:45:26 zeskia kernel: ds: 007b   es: 007b   ss: 0068 
Jun 18 16:45:26 zeskia kernel: Process pand (pid: 1865, threadinfo=dcc7e000 task=dcc4ba60) 
Jun 18 16:45:26 zeskia kernel: Stack: ddd94888 dffe44a0 c02a963c ddd94860 ffffffff dd239b00 00000000 dd239b00  
Jun 18 16:45:26 zeskia kernel:        c01456b0 ddd94888 dd239b00 c013d38d 00000000 dd38eddc 00000001 dd239b00  
Jun 18 16:45:26 zeskia kernel:        00000000 dd1f92a0 00000003 c014422c dd239b00 dd1f92a0 dd239b00 dd1f92a0  
Jun 18 16:45:26 zeskia kernel: Call Trace: 
Jun 18 16:45:26 zeskia kernel:  [<c02a963c>] sock_close+0x2c/0x40 
Jun 18 16:45:26 zeskia kernel:  [<c01456b0>] __fput+0x40/0xe0 
Jun 18 16:45:26 zeskia kernel:  [<c013d38d>] anon_vma_unlink+0x3d/0x50 
Jun 18 16:45:26 zeskia kernel:  [<c014422c>] filp_close+0x5c/0x70 
Jun 18 16:45:26 zeskia kernel:  [<c011520b>] put_files_struct+0x4b/0xc0 
Jun 18 16:45:26 zeskia kernel:  [<c0115d94>] do_exit+0x104/0x290 
Jun 18 16:45:26 zeskia kernel:  [<c010353a>] die+0x13a/0x140 
Jun 18 16:45:26 zeskia kernel:  [<c011418e>] call_console_drivers+0xee/0x100 
Jun 18 16:45:26 zeskia kernel:  [<c011436a>] vprintk+0xda/0xf0 
Jun 18 16:45:26 zeskia kernel:  [<c010fc27>] do_page_fault+0x3e7/0x557 
Jun 18 16:45:26 zeskia kernel:  [<c012fc17>] __alloc_pages+0xb7/0x3a0 
Jun 18 16:45:26 zeskia kernel:  [<c012feeb>] __alloc_pages+0x38b/0x3a0 
Jun 18 16:45:26 zeskia kernel:  [<c01373af>] pte_alloc_map+0x4f/0x80 
Jun 18 16:45:26 zeskia kernel:  [<c01375a9>] copy_pte_range+0x169/0x180 
Jun 18 16:45:26 zeskia kernel:  [<c0110a06>] deactivate_task+0x16/0x30 
Jun 18 16:45:26 zeskia kernel:  [<c030d347>] schedule+0x407/0x430 
Jun 18 16:45:26 zeskia kernel:  [<c010f840>] do_page_fault+0x0/0x557 
Jun 18 16:45:26 zeskia kernel:  [<c0102e93>] error_code+0x2b/0x30 
Jun 18 16:45:26 zeskia kernel:  [<c01113d0>] default_wake_function+0x0/0x20 
Jun 18 16:45:26 zeskia kernel:  [<c01126a7>] copy_mm+0x287/0x370 
Jun 18 16:45:26 zeskia kernel:  [<c01113d0>] default_wake_function+0x0/0x20 
Jun 18 16:45:26 zeskia kernel:  [<c02a9cbc>] sys_accept+0x8c/0x110 
Jun 18 16:45:26 zeskia kernel:  [<c01219e3>] attach_pid+0x23/0xb0 
Jun 18 16:45:26 zeskia kernel:  [<c02abf2e>] release_sock+0x4e/0x60 
Jun 18 16:45:26 zeskia kernel:  [<c0110bc2>] wake_up_new_task+0x82/0x1d0 
Jun 18 16:45:26 zeskia kernel:  [<c01cb796>] copy_from_user+0x46/0x70 
Jun 18 16:45:26 zeskia kernel:  [<c02aa62c>] sys_socketcall+0xac/0x1d0 
Jun 18 16:45:26 zeskia kernel:  [<c0144285>] sys_close+0x45/0x60 
Jun 18 16:45:26 zeskia kernel:  [<c0102c7f>] syscall_call+0x7/0xb 
Jun 18 16:45:26 zeskia kernel: Code: 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 b8 fa ff ff ff c3 8d 76 00 8d bc 27 00 00 00 00 56 53 8b 74 24 0c 8b 46 08 85 c0 74 29 <8b> 58 04 56 ff 50 08 c7 46 08 00 00 00 00 85 db 58 74 16 ff 8b  

--------------080703040703030500090300--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
