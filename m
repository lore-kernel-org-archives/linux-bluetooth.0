Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] krfcommd or kernel bug?
From: Marcel Holtmann <marcel@holtmann.org>
To: aquamala@o2.pl
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040522121543.GA1546@reynevan>
References: <20040522121543.GA1546@reynevan>
Content-Type: text/plain
Message-Id: <1085228729.22191.63.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 22 May 2004 14:25:29 +0200

Hi Aquamala,

> I have two machines: first - win2k with CSR USB dongle (BlueTake) and second - linux
> with Ericsson's ROK101008 starter kit.
> I'm trying to connect to linux bluetooth-serial-port from win2k.
> Just after receivig SABM frame I got such info:
> 
> May 18 05:08:31 localhost kernel: ------------[ cut here
> ]------------
> May 18 05:08:31 localhost kernel: kernel BUG at
> include/linux/module.h:302!
> May 18 05:08:31 localhost kernel: invalid operand: 0000 [#1]
> May 18 05:08:31 localhost kernel: CPU:    0
> May 18 05:08:31 localhost kernel: EIP:    0060:[<c285a913>]    Not
> tainted
> May 18 05:08:31 localhost kernel: EFLAGS: 00010246
> May 18 05:08:31 localhost kernel: EIP is at
> rfcomm_session_add+0xb3/0xc0 [rfcomm]
> May 18 05:08:31 localhost kernel: eax: 00000000   ebx: c11c0e20
> ecx: 00000000   edx: c2862060
> May 18 05:08:31 localhost kernel: esi: 00000002   edi: c11c0e4c
> ebp: 00000000   esp: c1299f8c
> May 18 05:08:31 localhost kernel: ds: 007b   es: 007b   ss: 0068
> May 18 05:08:31 localhost kernel: Process krfcommd (pid: 1127,
> threadinfo=c1298000 task=c1d20660)
> May 18 05:08:31 localhost kernel: Stack: c1fbb340 c283eec0 c1fbb340
> c1d614e0 c283eec0 c285c62f c1d614e0 00000002
> May 18 05:08:31 localhost kernel:        c1fbb340 04000000 c129ffff
> c0116161 c1298000 c2861d70 c1298000 00000000
> May 18 05:08:31 localhost kernel:        00000000 00000000 c285c83d
> c1299fdc 00000000 00000000 0000007b ffffffff
> May 18 05:08:31 localhost kernel: Call Trace:
> May 18 05:08:31 localhost kernel:  [<c285c62f>]
> rfcomm_worker+0x48f/0x4e0 [rfcomm]
> May 18 05:08:31 localhost kernel:  [<c0116161>]
> set_user_nice+0x61/0x120
> May 18 05:08:31 localhost kernel:  [<c285c83d>] rfcomm_run+0x5d/0x80
> [rfcomm]
> May 18 05:08:31 localhost kernel:  [<c285c7e0>] rfcomm_run+0x0/0x80
> [rfcomm]
> May 18 05:08:31 localhost kernel:  [<c0106f81>]
> kernel_thread_helper+0x5/0x24
> May 18 05:08:32 localhost kernel:
> May 18 05:08:32 localhost kernel: Code: 0f 0b 2e 01 37 f7 85 c2 eb
> ca 8d 76 00 56 53 8b 5c 24 0c 8b
> 
> That is what I'm using:
> 
> $uname -a
> Linux localhost.localdomain 2.6.2 #16 Tue May 18 02:08:00 CEST 2004
> i586 i586 i386 GNU/Linux

and here is the problem. Your kernel is buggy and you should better use
the latest 2.6 kernel with our Bluetooth patch. For exmaple 2.6.6-mh1.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
