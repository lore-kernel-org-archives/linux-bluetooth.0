Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT3C_CS broken in kernel 2.6.14?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20051107T122754-207@post.gmane.org>
References: <loom.20051107T122754-207@post.gmane.org>
Content-Type: text/plain
Message-Id: <1131371019.5824.123.camel@blade>
Mime-Version: 1.0
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
Date: Mon, 07 Nov 2005 14:43:39 +0100

Hi Antti,

>   After upgrading to Kernel 2.6.14 my 3Com bluetooth card does not work 
> anymore. I tried applying the mh2 patch at bluez.org. On 2.6.13 it works just 
> fine.
> 
>   Now, when I insert the PCMCIA card, the card does not work and I get the 
> following error at the console:
> 
> kernel BUG at fs/sysfs/symlink.c:87!
> invalid operand: 0000 [#1]
> PREEMPT
> Modules linked in: bt3c_cs rfcomm hidp l2cap 3c59x
> CPU:    0
> EIP:    0060:[<c01a9f58>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.14-ck1)
> EIP is at sysfs_create_link+0x58/0x70
> eax: fac7df01   ebx: 00000000   ecx: dfb84c80   edx: da41cd00
> esi: da41cd20   edi: e0871640   ebp: dfb84c80   esp: da5b58bc
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 7867, threadinfo=da5b4000 task=dfaa2540)
> Stack: da563910 c05b3865 e08716a8 c05b3865 c034190d e08716a8 da41cd28 dfb84c80
>        da41cd28 00000000 c0631f00 da41cda0 da41cd20 e0871640 da5b5938 c0344e42
>        da41cd20 e08716dc 00000014 0000000a c15fac00 dffda0c0 00000286 dfb84fc0
> Call Trace:
>  [<c034190d>] class_device_add+0x21d/0x240
>  [<c0344e42>] fw_register_class_device+0x112/0x190
>  [<c0344ef5>] fw_setup_class_device+0x35/0x110
>  [<c034503e>] _request_firmware+0x6e/0x180
>  [<e086f790>] bt3c_hci_send_frame+0x0/0x120 [bt3c_cs]
>  [<c0345178>] request_firmware+0x28/0x30
>  [<e086fd32>] bt3c_open+0xc2/0x190 [bt3c_cs]
>  [<e08703be>] bt3c_config+0x26e/0x390 [bt3c_cs]

I expected this problem. It is request_firmware() related, but I can't
remember what the real problem or even the solution was when it came up
on LKML. Try to do some research on LKML by yourself and also check the
latest 2.6.14-git10 kernel.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
