Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm socket and rfcomm tty
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41DA46A2.9060801@avantwave.com>
References: <41D12158.6020206@avantwave.com>
	 <1104315958.6319.13.camel@notepaq>  <41D3600B.8000702@avantwave.com>
	 <1104604967.4253.4.camel@pegasus>  <41D8F10B.5050207@avantwave.com>
	 <1104745873.8894.44.camel@pegasus>  <41DA46A2.9060801@avantwave.com>
Content-Type: text/plain
Message-Id: <1104839485.8894.88.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 04 Jan 2005 12:51:25 +0100

Hi Mike,

>     Actually, i have tried to connect to Window base computer and test 
> with hyperterminal . my program does success in connection and send out 
> data. But when i try to connect to rfcomm listen in another computer, it 
> comes out a oops. and then my usb dongle halt and need a OS reboot.
>     Do you have any idea on below oops? Thanks for helping
> 
> ------------[ cut here ]------------
> kernel BUG at include/linux/module.h:325!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<129d25e1>]    Not tainted
> EFLAGS: 00010246   (2.6.5-1.358)
> EIP is at rfcomm_session_add+0x73/0x88 [rfcomm]
> eax: 00000000   ebx: 0e63a984   ecx: 00000000   edx: 11ee5400
> esi: 00000002   edi: 0e63a9b0   ebp: 0bda8080   esp: 0e283fa4
> ds: 007b   es: 007b   ss: 0068
> Process krfcommd (pid: 1835, threadinfo=0e283000 task=10ee39b0)
> Stack: 128daba0 0bda8080 0a7e1800 0397c91c 129d3b29 029d91a8 129d84f0 
> 00000000
>        0e283000 00000000 0e283fde 00000000 129d3f49 00000000 00000000 
> 0000007b
>        0000007b 129d3ef1 00000000 021041d9 00000000 00000000 00000000
> Call Trace:
>  [<129d3b29>] rfcomm_worker+0x10b/0x3a6 [rfcomm]
>  [<129d3f49>] rfcomm_run+0x58/0x6b [rfcomm]
>  [<129d3ef1>] rfcomm_run+0x0/0x6b [rfcomm]
>  [<021041d9>] kernel_thread_helper+0x5/0xb
>  
> Code: 0f 0b 45 01 ff 5f 9d 12 ff 05 00 89 9d 12 89 d8 5b 5e 5f 5d

what kernel is this? Try the latest one.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
