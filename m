Return-Path: <linux-kernel-owner+marcel=40rvs.uni-bielefeld.de@vger.kernel.org>
Date: Wed, 10 Sep 2003 15:58:10 -0700
To: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
   Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BUG] BlueTooth socket busted in 2.6.0-test5
Message-ID: <20030910225810.GA7712@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <bluez-devel.lists.sourceforge.net>

	Hi,

	This is self explanatory :
-----------------------------------------------------------
kernel BUG at include/net/sock.h:459!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<d08ae64e>]    Not tainted
EFLAGS: 00010282
EIP is at l2cap_sock_alloc+0x36/0xb4 [l2cap]
eax: d08b3500   ebx: c6b4de40   ecx: 00000020   edx: d08ac440
esi: 00000000   edi: 00000000   ebp: ffffffa3   esp: c81abf1c
ds: 007b   es: 007b   ss: 0068
Process sdpd (pid: 390, threadinfo=c81aa000 task=ce634cc0)
Stack: 00000000 d08ac524 d08ae72c c20e7780 00000000 000000d0 d08a10f4 c20e7780 
       00000000 c20e7780 0000007c c033ecc0 ffffff9f c01e1236 c20e7780 00000000 
       0000001f bffff894 c81abfa8 00000001 c01e1325 0000001f 00000005 00000000 
Call Trace:
 [<d08ae72c>] l2cap_sock_create+0x60/0x7c [l2cap]
 [<d08a10f4>] bt_sock_create+0x8c/0xd0 [bluetooth]
 [<c01e1236>] sock_create+0x12e/0x200
 [<c01e1325>] sys_socket+0x1d/0x50
 [<c01e216c>] sys_socketcall+0xbc/0x260
 [<c0108cd3>] syscall_call+0x7/0xb

Code: 0f 0b cb 01 e2 1a 8b d0 89 83 28 01 00 00 85 c0 74 30 50 e8 
 
-----------------------------------------------------------

	Basically, the socket is already owned by the 'bluetooth'
module in bt_sock_alloc(), and the 'l2cap' module try to change the
ownersip to itself in l2cap_sock_alloc(). The socket layer doesn't
like it. At least, that's the way I read it.
	Without the ability to open BT socket, BT is pretty much
useless.

	Good luck...

	Jean
