Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List
	 <bluez-devel@lists.sourceforge.net>,
   Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
In-Reply-To: <20030910225810.GA7712@bougret.hpl.hp.com>
References: <20030910225810.GA7712@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1063237174.28890.6.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [BUG] BlueTooth socket busted in 2.6.0-test5
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 11 Sep 2003 01:39:28 +0200

Hi Jean,

> 	This is self explanatory :
> -----------------------------------------------------------
> kernel BUG at include/net/sock.h:459!
> invalid operand: 0000 [#1]
> CPU:    1
> EIP:    0060:[<d08ae64e>]    Not tainted
> EFLAGS: 00010282
> EIP is at l2cap_sock_alloc+0x36/0xb4 [l2cap]
> eax: d08b3500   ebx: c6b4de40   ecx: 00000020   edx: d08ac440
> esi: 00000000   edi: 00000000   ebp: ffffffa3   esp: c81abf1c
> ds: 007b   es: 007b   ss: 0068
> Process sdpd (pid: 390, threadinfo=c81aa000 task=ce634cc0)
> Stack: 00000000 d08ac524 d08ae72c c20e7780 00000000 000000d0 d08a10f4 c20e7780 
>        00000000 c20e7780 0000007c c033ecc0 ffffff9f c01e1236 c20e7780 00000000 
>        0000001f bffff894 c81abfa8 00000001 c01e1325 0000001f 00000005 00000000 
> Call Trace:
>  [<d08ae72c>] l2cap_sock_create+0x60/0x7c [l2cap]
>  [<d08a10f4>] bt_sock_create+0x8c/0xd0 [bluetooth]
>  [<c01e1236>] sock_create+0x12e/0x200
>  [<c01e1325>] sys_socket+0x1d/0x50
>  [<c01e216c>] sys_socketcall+0xbc/0x260
>  [<c0108cd3>] syscall_call+0x7/0xb
> 
> Code: 0f 0b cb 01 e2 1a 8b d0 89 83 28 01 00 00 85 c0 74 30 50 e8 
>  
> -----------------------------------------------------------
> 
> 	Basically, the socket is already owned by the 'bluetooth'
> module in bt_sock_alloc(), and the 'l2cap' module try to change the
> ownersip to itself in l2cap_sock_alloc(). The socket layer doesn't
> like it. At least, that's the way I read it.
> 	Without the ability to open BT socket, BT is pretty much
> useless.

yesterday David Woodhouse sent a patch which should fix this.

Regards

Marcel


===== net/bluetooth/af_bluetooth.c 1.22 vs edited =====
--- 1.22/net/bluetooth/af_bluetooth.c   Sun Aug 31 03:30:42 2003
+++ edited/net/bluetooth/af_bluetooth.c Tue Sep  9 11:28:51 2003
@@ -130,7 +130,6 @@
        }
 
        sock_init_data(sock, sk);
-       sk_set_owner(sk, THIS_MODULE);
        INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
        
        sk->sk_zapped   = 0;
===== net/bluetooth/hci_sock.c 1.24 vs edited =====
--- 1.24/net/bluetooth/hci_sock.c       Sat Jul  5 07:52:58 2003
+++ edited/net/bluetooth/hci_sock.c     Tue Sep  9 11:30:43 2003
@@ -587,6 +587,8 @@
        if (!sk)
                return -ENOMEM;
 
+       sk_set_owner(sk, THIS_MODULE);
+
        sock->state = SS_UNCONNECTED;
        sk->sk_state   = BT_OPEN;
 
===== net/bluetooth/bnep/sock.c 1.11 vs edited =====
--- 1.11/net/bluetooth/bnep/sock.c      Thu Jun  5 01:57:08 2003
+++ edited/net/bluetooth/bnep/sock.c    Tue Sep  9 11:29:54 2003
@@ -175,6 +175,9 @@
 
        if (!(sk = bt_sock_alloc(sock, PF_BLUETOOTH, 0, GFP_KERNEL)))
                return -ENOMEM;
+
+       sk_set_owner(sk, THIS_MODULE);
+
        sock->ops = &bnep_sock_ops;
 
        sock->state  = SS_UNCONNECTED;




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
