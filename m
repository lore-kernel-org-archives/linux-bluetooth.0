Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Przemek <aquamala@o2.pl>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] krfcommd or kernel bug?
Message-ID: <20040522191501.GA1700@reynevan>
Reply-To: aquamala@o2.pl
References: <20040522121543.GA1546@reynevan> <1085228729.22191.63.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1085228729.22191.63.camel@pegasus>
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
Date: Sat, 22 May 2004 21:15:01 +0200

> > $uname -a
> > Linux localhost.localdomain 2.6.2 #16 Tue May 18 02:08:00 CEST 2004
> > i586 i586 i386 GNU/Linux
> 
> and here is the problem. Your kernel is buggy and you should better use
> the latest 2.6 kernel with our Bluetooth patch. For exmaple 2.6.6-mh1.

Ok, I've just upgreaded to 2.6.6-mh1.
Now, I can't even hciattach my device :/

#modprobe serport
#modprobe hci_uart
#hciattach ttyS0 ericsson 57600 flow

...and then:

May 22 19:42:40 localhost kernel: Unable to handle kernel NULL
pointer dereference at virtual address 00000014
May 22 19:42:40 localhost kernel:  printing eip:
May 22 19:42:40 localhost kernel: c6817289
May 22 19:42:40 localhost kernel: *pde = 00000000
May 22 19:42:40 localhost kernel: Oops: 0002 [#1]
May 22 19:42:40 localhost kernel: PREEMPT
May 22 19:42:40 localhost kernel: CPU:    0
May 22 19:42:40 localhost kernel: EIP:    0060:[<c6817289>]    Not
tainted
May 22 19:42:40 localhost kernel: EFLAGS: 00010286   (2.6.6-mh1)
May 22 19:42:40 localhost kernel: EIP is at hci_uart_close+0x9/0x40
[hci_uart]
May 22 19:42:40 localhost kernel: eax: 00000002   ebx: c1320d3c
ecx: c0274b7c   edx: 00000000
May 22 19:42:40 localhost kernel: esi: 00000000   edi: c5dbfa00
ebp: 00000000   esp: c5315ebc
May 22 19:42:40 localhost kernel: ds: 007b   es: 007b   ss: 0068
May 22 19:42:40 localhost kernel: Process hciattach (pid: 1238,
threadinfo=c5314000 task=c5f1a5f0)
May 22 19:42:40 localhost kernel: Stack: c6817403 00000000 c52de000
00000000 c01c1a00 c52de000 00000000 00000000
May 22 19:42:40 localhost kernel:        00000001 00000000 c02fd108
0000000a c02d6a00 c01151fc c02fd108 00000046
May 22 19:42:40 localhost kernel:        c5314000 00000000 00000046
c5314000 c0105a59 c0276424 c523d768 00000126
May 22 19:42:40 localhost kernel: Call Trace:
May 22 19:42:40 localhost kernel:  [<c6817403>]
hci_uart_tty_close+0x23/0x60 [hci_uart]
May 22 19:42:40 localhost kernel:  [<c01c1a00>]
release_dev+0x4e0/0x5e0
May 22 19:42:40 localhost kernel:  [<c01151fc>]
__do_softirq+0x7c/0x80
May 22 19:42:40 localhost kernel:  [<c0105a59>] do_IRQ+0xf9/0x140
May 22 19:42:40 localhost kernel:  [<c01c1ea1>]
tty_release+0x21/0x60
May 22 19:42:41 localhost kernel:  [<c014313b>] __fput+0xfb/0x120
May 22 19:42:41 localhost kernel:  [<c0141a43>] filp_close+0x43/0x80
May 22 19:42:41 localhost kernel:  [<c0112cd5>]
put_files_struct+0x55/0xc0
May 22 19:42:41 localhost kernel:  [<c0113910>] do_exit+0x1b0/0x3e0
May 22 19:42:41 localhost kernel:  [<c0113c30>]
do_group_exit+0x70/0xc0
May 22 19:42:41 localhost kernel:  [<c0103ed7>] syscall_call+0x7/0xb
May 22 19:42:41 localhost kernel:
May 22 19:42:41 localhost kernel: Code: 0f b3 42 14 19 c0 85 c0 75
0d b8 00 00 00 00 c3 8d b4 26 00

I have no idea what to do... 

Best Regards, 
Przemek


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
