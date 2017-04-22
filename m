Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Lukas Wagner <lwagner94@posteo.at>
Subject: Segfault when pairing A2DP device
Message-ID: <a489fffc-6960-fbe9-a15e-0aba90adec39@posteo.at>
Date: Sat, 22 Apr 2017 15:13:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

when I try to pair my Bose QC35 Headset, bluetoothd crashes with the
following stack trace:

#0  0x000000000048d932 ba2str (bluetoothd)
#1  0x00000000004882d1 update_bredr_services (bluetoothd)
#2  0x0000000000488b9e browse_cb (bluetoothd)
#3  0x000000000045e6cc search_completed_cb (bluetoothd)
#4  0x00000000004a03f2 sdp_process (bluetoothd)
#5  0x000000000045e780 search_process_cb (bluetoothd)
#6  0x00007f28aca7545a g_main_context_dispatch (libglib-2.0.so.0)
#7  0x00007f28aca75810 n/a (libglib-2.0.so.0)
#8  0x00007f28aca75b32 g_main_loop_run (libglib-2.0.so.0)
#9  0x000000000044d267 main (bluetoothd)
#10 0x00007f28ac04b511 __libc_start_main (libc.so.6)
#11 0x000000000040ad6a _start (bluetoothd)

Coredump: http://wikisend.com/download/366074/core

Version: bluez 5.44-17-g677a3456a

Steps to reproduce:
	- Remove (if already paired) bluetooth headset
	- Pair in bluetoothctl

I believe this might be related to the bug reported here:
http://marc.info/?l=linux-bluetooth&m=149121146509800&w=2

Please let me know any more information on this.
I'm also willing to do some debugging myself if anybody can point me
in the right direction.

Cheers
