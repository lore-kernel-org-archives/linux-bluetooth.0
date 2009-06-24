Return-Path: <cyrus@holtmann.org>
Subject: Re: SSP KeyboardOnly crasher
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1245868533.26486.17432.camel@localhost.localdomain>
References: <1245868533.26486.17432.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 19:39:30 +0100
Message-Id: <1245868770.26486.17442.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2009-06-24 at 19:35 +0100, Bastien Nocera wrote:
> Heya,
> 
> Got bluetoothd to crash.
> 
> Machine 1, bluez 4.37 from Fedora 11, running simple-agent with
> KeyboardOnly as the capability, Belkin BT 2.1 dongle.
> 
> Machine 2, running bluez from git master, running gnome-bluetooth
> master, same Belkin dongle.
> 
> Run bluetooth-wizard on Machine 2 and attempt pairing against Machine 1.
> When the passkey prompt appears on Machine 1, enter some junk.
> 
> The pairing on Machine 2 will timeout, and bluetoothd crash.

And under valgrind:
vex amd64->IR: unhandled instruction bytes: 0x43 0x61 0x6E 0x63 0x65 0x6C
==26202== valgrind: Unrecognised instruction at address 0x13dfa8.
==26202== Your program just tried to execute an instruction that Valgrind
==26202== did not recognise.  There are two possible reasons for this.
==26202== 1. Your program has a bug and erroneously jumped to a non-code
==26202==    location.  If you are running Memcheck and you just saw a
==26202==    warning about a bad jump, it's probably your program's fault.
==26202== 2. The instruction is legitimate but Valgrind doesn't handle it,
==26202==    i.e. it's Valgrind's fault.  If you think this is the case or
==26202==    you are not sure, please let us know and we'll try to fix it.
==26202== Either way, Valgrind will now raise a SIGILL signal which will
==26202== probably kill your program.
==26202== 
==26202== Process terminating with default action of signal 4 (SIGILL): dumping core
==26202==  Illegal opcode at address 0x13DFA8
==26202==    at 0x13DFA8: (within /home/hadess/Projects/Cvs/bluez/src/.libs/lt-bluetoothd)
==26202==    by 0x11EEF2: agent_free (agent.c:168)
==26202==    by 0x11F06A: agent_destroy (agent.c:215)
==26202==    by 0x12AAA9: bonding_request_free (device.c:1665)
==26202==    by 0x12B0A9: bonding_connect_cb (device.c:1829)
==26202==    by 0x13390B: connect_cb (btio.c:163)
==26202==    by 0x52B4AFD: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2000.3)
==26202==    by 0x52B81D7: (within /lib64/libglib-2.0.so.0.2000.3)
==26202==    by 0x52B8634: g_main_loop_run (in /lib64/libglib-2.0.so.0.2000.3)
==26202==    by 0x114CF2: main (main.c:482)

Cheers

