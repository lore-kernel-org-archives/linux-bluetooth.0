Return-Path: <cyrus@holtmann.org>
Subject: SSP KeyboardOnly crasher
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 19:35:33 +0100
Message-Id: <1245868533.26486.17432.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

Got bluetoothd to crash.

Machine 1, bluez 4.37 from Fedora 11, running simple-agent with
KeyboardOnly as the capability, Belkin BT 2.1 dongle.

Machine 2, running bluez from git master, running gnome-bluetooth
master, same Belkin dongle.

Run bluetooth-wizard on Machine 2 and attempt pairing against Machine 1.
When the passkey prompt appears on Machine 1, enter some junk.

The pairing on Machine 2 will timeout, and bluetoothd crash.
Program terminated with signal 4, Illegal instruction.
#0  0x00007f4b07bb0fa8 in ?? () from /home/hadess/Projects/Cvs/bluez/src/.libs/lt-bluetoothd
(gdb) bt
#0  0x00007f4b07bb0fa8 in ?? () from /home/hadess/Projects/Cvs/bluez/src/.libs/lt-bluetoothd
#1  0x00007f4b07b9e98d in passkey_cb (agent=0x7f4b092b8110, err=0x7fff0fbbada0, passkey=153909344, data=0x7fff0fbbada0) at device.c:2079
#2  0x00007f4b07b91ef3 in agent_free (agent=0x7f4b092b8110) at agent.c:168
#3  0x00007f4b07b9206b in agent_destroy (agent=0x7f4b092b8110, exited=0) at agent.c:215
#4  0x00007f4b07b9daaa in bonding_request_free (bonding=0x7f4b092b4260) at device.c:1665
#5  0x00007f4b07b9e0aa in bonding_connect_cb (io=0x7f4b092c7c60, err=0x7f4b092d27a0, user_data=0x7f4b092cfcc0) at device.c:1829
#6  0x00007f4b07ba690c in connect_cb (io=0x7f4b092c7c60, cond=28, user_data=0x7f4b092b5b70) at btio.c:163
#7  0x00007f4b0705eafe in g_main_dispatch (context=<value optimized out>) at gmain.c:1814
#8  IA__g_main_context_dispatch (context=<value optimized out>) at gmain.c:2367
#9  0x00007f4b070621d8 in g_main_context_iterate (context=0x7f4b092b8680, block=<value optimized out>, dispatch=<value optimized out>, self=<value optimized out>) at gmain.c:2445
#10 0x00007f4b07062635 in IA__g_main_loop_run (loop=0x7f4b092bf520) at gmain.c:2653
#11 0x00007f4b07b87cf3 in main (argc=1, argv=0x7fff0fbbb288) at main.c:482
(gdb) frame 1
#1  0x00007f4b07b9e98d in passkey_cb (agent=0x7f4b092b8110, err=0x7fff0fbbada0, passkey=153909344, data=0x7fff0fbbada0) at device.c:2079
2079		((agent_passkey_cb) auth->cb)(agent, err, passkey, device);

Ideas?


