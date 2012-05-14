Return-Path: <cyrus@holtmann.org>
Message-id: <4FB0F45C.3000806@samsung.com>
Date: Mon, 14 May 2012 21:02:36 +0900
From: Chanyeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Question about l2cap_chan_destroy function()
Content-type: multipart/mixed; boundary=------------070807030503010903060605
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070807030503010903060605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello. Padovan

I have a question in the l2cap_chan_destroy().

If it is called from l2cap_sock_kill(),
  it would delete the channel from the global variable chan_list_lock.
and in the l2cap_chan_put() chan could be freed or left.

Personally I think this could make orphan..

Regarding this could you explain why you write in such a way?

Additionally
When we use bluetooth-next.git we faced problem l2cap crash. So my 
colleague recommended below patch.
Could you give me your opinion?

BR
Chanyeol Park.

 >From 718899ff11c307c3ae2f98b86524f095a18b728a Mon Sep 17 00:00:00 2001
From: Minho Ban <mhban@samsung.com>
Date: Wed, 9 May 2012 17:25:39 +0900
Subject: [PATCH] Bluetooth: Prevent list_del corruption for l2cap channel

One thread may wait on chan_list_lock while another thread remove 
channel in the
list. This lead to BUG when list_debug is enabled and also could lead to 
double
free of channel potentially.

This patch set mutex lock to ensure no other thread reference this channel.

2956.[  237.957061] l2cap_sock_kill: sk c607ca00 state BT_CLOSED
2957.[  237.957092] ------------[ cut here ]------------
2958.[  237.957092] WARNING: at lib/list_debug.c:47 
__list_del_entry+0x80/0xf0()
2959.[  237.957122] list_del corruption, c72a45c8->next is LIST_POISON1 
(00100100)
2960.[  237.957122] Modules linked in: omaplfb_sgx540_120 
pvrsrvkm_sgx540_120 bnep btwilink hidp rfcomm bluetooth compat
2961.[  237.957153] Backtrace:
2962.[  237.957183] [<c0058224>] (dump_backtrace+0x0/0x110) from 
[<c05cb5fc>] (dump_stack+0x18/0x1c)
2963.[  237.957183]  r6:0000002f r5:c0263210 r4:c68b9d50 r3:c68b8000
2964.[  237.957214] [<c05cb5e4>] (dump_stack+0x0/0x1c) from [<c00a0b90>] 
(warn_slowpath_common+0x5c/0x6c)
2965.[  237.957214] [<c00a0b34>] (warn_slowpath_common+0x0/0x6c) from 
[<c00a0c44>] (warn_slowpath_fmt+0x38/0x40)
2966.[  237.957214]  r8:c5ada2d8 r7:c5ada2d8 r6:00000067 r5:c72a4000 
r4:00200200
2967.[  237.957244] r3:00000009
2968.[  237.957244] [<c00a0c0c>] (warn_slowpath_fmt+0x0/0x40) from 
[<c0263210>] (__list_del_entry+0x80/0xf0)
2969.[  237.957244]  r3:c72a45c8 r2:c0714d10
2970.[  237.957275] [<c0263190>] (__list_del_entry+0x0/0xf0) from 
[<c0263294>] (list_del+0x14/0x2c)
2971.[  237.957275]  r5:c72a4000 r4:c72a45c8
2972.[  237.957397] [<c0263280>] (list_del+0x0/0x2c) from [<bf028c80>] 
(l2cap_chan_destroy+0x24/0x64 [bluetooth])
2973.[  237.957397]  r4:c72a4400 r3:c68b8000
2974.[  237.957519] [<bf028c5c>] (l2cap_chan_destroy+0x0/0x64 
[bluetooth]) from [<bf02a774>] (l2cap_sock_kill+0x68/0xac [bluetooth])
2975.[  237.957519]  r4:c607ca00 r3:c68b8000
2976.[  237.957641] [<bf02a70c>] (l2cap_sock_kill+0x0/0xac [bluetooth]) 
from [<bf02a858>] (l2cap_sock_close_cb+0x10/0x14 [bluetooth])
2977.[  237.957641]  r4:c5ada400 r3:c68b8000
2978.[  237.957733] [<bf02a848>] (l2cap_sock_close_cb+0x0/0x14 
[bluetooth]) from [<bf02019c>] (l2cap_conn_del+0xac/0x128 [bluetooth])
2979.[  237.957824] [<bf0200f0>] (l2cap_conn_del+0x0/0x128 [bluetooth]) 
from [<bf024340>] (l2cap_disconn_cfm+0x40/0x4c [bluetooth])
2980.[  237.957916] [<bf024300>] (l2cap_disconn_cfm+0x0/0x4c 
[bluetooth]) from [<bf00cfdc>] (hci_conn_hash_flush+0xc0/0xc8 [bluetooth])
2981.[  237.957946]  r5:c72a4000 r4:c72add00
2982.[  237.958007] [<bf00cf1c>] (hci_conn_hash_flush+0x0/0xc8 
[bluetooth]) from [<bf0073d8>] (hci_dev_do_close+0xe4/0x304 [bluetooth])
2983.[  237.958007]  r6:00000364 r5:c72adf5c r4:c72ad800 r3:00000000
2984.[  237.958099] [<bf0072f4>] (hci_dev_do_close+0x0/0x304 
[bluetooth]) from [<bf00afc8>] (hci_dev_close+0x3c/0x74 [bluetooth])
2985.[  237.958160] [<bf00af8c>] (hci_dev_close+0x0/0x74 [bluetooth]) 
from [<bf01d580>] (hci_sock_ioctl+0x1b4/0x428 [bluetooth])
2986.[  237.958190]  r5:00000000 r4:400448ca
2987.[  237.958221] [<bf01d3cc>] (hci_sock_ioctl+0x0/0x428 [bluetooth]) 
from [<c046825c>] (sock_ioctl+0x74/0x270)
2988.[  237.958251]  r8:c00540a8 r7:000000e5 r6:bf01d3cc r5:00000000 
r4:400448ca
2989.[  237.958282] [<c04681e8>] (sock_ioctl+0x0/0x270) from 
[<c0137284>] (do_vfs_ioctl+0x8c/0x5cc)
2990.[  237.958282]  r6:0000fdfd r5:c5f9fcc0 r4:00000000 r3:c04681e8
2991.[  237.958282] [<c01371f8>] (do_vfs_ioctl+0x0/0x5cc) from 
[<c0137804>] (sys_ioctl+0x40/0x68)
2992.[  237.958312] [<c01377c4>] (sys_ioctl+0x0/0x68) from [<c0053f00>] 
(ret_fast_syscall+0x0/0x30)
2993.[  237.958312]  r7:00000036 r6:00000004 r5:000000e5 r4:4000d5a8
2994.[  237.958343] ---[ end trace f85a67edb626ff33 ]---

Signed-off-by: Minho Ban <mhban@samsung.com>
---
  net/bluetooth/l2cap_core.c |   13 +++++++++----
  1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 870116a..76c54c8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -394,11 +394,16 @@ struct l2cap_chan *l2cap_chan_create(void)

  void l2cap_chan_destroy(struct l2cap_chan *chan)
  {
-    write_lock(&chan_list_lock);
-    list_del(&chan->global_l);
-    write_unlock(&chan_list_lock);
+    struct l2cap_conn *conn = chan->conn;

-    l2cap_chan_put(chan);
+    mutex_lock(&conn->chan_lock);
+    if (atomic_dec_and_test(&chan->refcnt)) {
+        write_lock(&chan_list_lock);
+        list_del(&chan->global_l);
+        write_unlock(&chan_list_lock);
+        kfree(chan);
+    }
+    mutex_unlock(&conn->chan_lock);
  }

  void l2cap_chan_set_defaults(struct l2cap_chan *chan)
-- 
1.7.5.4



--------------070807030503010903060605
Content-Type: text/x-patch;
 name="0001-Bluetooth-Prevent-list_del-corruption-for-l2cap-chan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Bluetooth-Prevent-list_del-corruption-for-l2cap-chan.pa";
 filename*1="tch"

>>From 718899ff11c307c3ae2f98b86524f095a18b728a Mon Sep 17 00:00:00 2001
From: Minho Ban <mhban@samsung.com>
Date: Wed, 9 May 2012 17:25:39 +0900
Subject: [PATCH] Bluetooth: Prevent list_del corruption for l2cap channel

One thread may wait on chan_list_lock while another thread remove channel in the
list. This lead to BUG when list_debug is enabled and also could lead to double
free of channel potentially.

This patch set mutex lock to ensure no other thread reference this channel.

2956.[  237.957061] l2cap_sock_kill: sk c607ca00 state BT_CLOSED
2957.[  237.957092] ------------[ cut here ]------------
2958.[  237.957092] WARNING: at lib/list_debug.c:47 __list_del_entry+0x80/0xf0()
2959.[  237.957122] list_del corruption, c72a45c8->next is LIST_POISON1 (00100100)
2960.[  237.957122] Modules linked in: omaplfb_sgx540_120 pvrsrvkm_sgx540_120 bnep btwilink hidp rfcomm bluetooth compat
2961.[  237.957153] Backtrace:
2962.[  237.957183] [<c0058224>] (dump_backtrace+0x0/0x110) from [<c05cb5fc>] (dump_stack+0x18/0x1c)
2963.[  237.957183]  r6:0000002f r5:c0263210 r4:c68b9d50 r3:c68b8000
2964.[  237.957214] [<c05cb5e4>] (dump_stack+0x0/0x1c) from [<c00a0b90>] (warn_slowpath_common+0x5c/0x6c)
2965.[  237.957214] [<c00a0b34>] (warn_slowpath_common+0x0/0x6c) from [<c00a0c44>] (warn_slowpath_fmt+0x38/0x40)
2966.[  237.957214]  r8:c5ada2d8 r7:c5ada2d8 r6:00000067 r5:c72a4000 r4:00200200
2967.[  237.957244] r3:00000009
2968.[  237.957244] [<c00a0c0c>] (warn_slowpath_fmt+0x0/0x40) from [<c0263210>] (__list_del_entry+0x80/0xf0)
2969.[  237.957244]  r3:c72a45c8 r2:c0714d10
2970.[  237.957275] [<c0263190>] (__list_del_entry+0x0/0xf0) from [<c0263294>] (list_del+0x14/0x2c)
2971.[  237.957275]  r5:c72a4000 r4:c72a45c8
2972.[  237.957397] [<c0263280>] (list_del+0x0/0x2c) from [<bf028c80>] (l2cap_chan_destroy+0x24/0x64 [bluetooth])
2973.[  237.957397]  r4:c72a4400 r3:c68b8000
2974.[  237.957519] [<bf028c5c>] (l2cap_chan_destroy+0x0/0x64 [bluetooth]) from [<bf02a774>] (l2cap_sock_kill+0x68/0xac [bluetooth])
2975.[  237.957519]  r4:c607ca00 r3:c68b8000
2976.[  237.957641] [<bf02a70c>] (l2cap_sock_kill+0x0/0xac [bluetooth]) from [<bf02a858>] (l2cap_sock_close_cb+0x10/0x14 [bluetooth])
2977.[  237.957641]  r4:c5ada400 r3:c68b8000
2978.[  237.957733] [<bf02a848>] (l2cap_sock_close_cb+0x0/0x14 [bluetooth]) from [<bf02019c>] (l2cap_conn_del+0xac/0x128 [bluetooth])
2979.[  237.957824] [<bf0200f0>] (l2cap_conn_del+0x0/0x128 [bluetooth]) from [<bf024340>] (l2cap_disconn_cfm+0x40/0x4c [bluetooth])
2980.[  237.957916] [<bf024300>] (l2cap_disconn_cfm+0x0/0x4c [bluetooth]) from [<bf00cfdc>] (hci_conn_hash_flush+0xc0/0xc8 [bluetooth])
2981.[  237.957946]  r5:c72a4000 r4:c72add00
2982.[  237.958007] [<bf00cf1c>] (hci_conn_hash_flush+0x0/0xc8 [bluetooth]) from [<bf0073d8>] (hci_dev_do_close+0xe4/0x304 [bluetooth])
2983.[  237.958007]  r6:00000364 r5:c72adf5c r4:c72ad800 r3:00000000
2984.[  237.958099] [<bf0072f4>] (hci_dev_do_close+0x0/0x304 [bluetooth]) from [<bf00afc8>] (hci_dev_close+0x3c/0x74 [bluetooth])
2985.[  237.958160] [<bf00af8c>] (hci_dev_close+0x0/0x74 [bluetooth]) from [<bf01d580>] (hci_sock_ioctl+0x1b4/0x428 [bluetooth])
2986.[  237.958190]  r5:00000000 r4:400448ca
2987.[  237.958221] [<bf01d3cc>] (hci_sock_ioctl+0x0/0x428 [bluetooth]) from [<c046825c>] (sock_ioctl+0x74/0x270)
2988.[  237.958251]  r8:c00540a8 r7:000000e5 r6:bf01d3cc r5:00000000 r4:400448ca
2989.[  237.958282] [<c04681e8>] (sock_ioctl+0x0/0x270) from [<c0137284>] (do_vfs_ioctl+0x8c/0x5cc)
2990.[  237.958282]  r6:0000fdfd r5:c5f9fcc0 r4:00000000 r3:c04681e8
2991.[  237.958282] [<c01371f8>] (do_vfs_ioctl+0x0/0x5cc) from [<c0137804>] (sys_ioctl+0x40/0x68)
2992.[  237.958312] [<c01377c4>] (sys_ioctl+0x0/0x68) from [<c0053f00>] (ret_fast_syscall+0x0/0x30)
2993.[  237.958312]  r7:00000036 r6:00000004 r5:000000e5 r4:4000d5a8
2994.[  237.958343] ---[ end trace f85a67edb626ff33 ]---

Signed-off-by: Minho Ban <mhban@samsung.com>
---
 net/bluetooth/l2cap_core.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 870116a..76c54c8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -394,11 +394,16 @@ struct l2cap_chan *l2cap_chan_create(void)
 
 void l2cap_chan_destroy(struct l2cap_chan *chan)
 {
-	write_lock(&chan_list_lock);
-	list_del(&chan->global_l);
-	write_unlock(&chan_list_lock);
+	struct l2cap_conn *conn = chan->conn;
 
-	l2cap_chan_put(chan);
+	mutex_lock(&conn->chan_lock);
+	if (atomic_dec_and_test(&chan->refcnt)) {
+		write_lock(&chan_list_lock);
+		list_del(&chan->global_l);
+		write_unlock(&chan_list_lock);
+		kfree(chan);
+	}
+	mutex_unlock(&conn->chan_lock);
 }
 
 void l2cap_chan_set_defaults(struct l2cap_chan *chan)
-- 
1.7.5.4


--------------070807030503010903060605--

