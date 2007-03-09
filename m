Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45F18561.7040005@idlum.be>
Date: Fri, 09 Mar 2007 17:03:45 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45F176B0.3090507@idlum.be>
In-Reply-To: <45F176B0.3090507@idlum.be>
Subject: Re: [Bluez-devel] Problem with RFCOMM kernel module
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I just got a kernel crash on the same box. Here is the trace I was able 
to gather (was connected per ssh and this suddenly appeared). No screen 
was connected to the box at the time of the crash, I connected one, and 
there was some more info. There is a pic of the screen there if it may 
help: http://img409.imageshack.us/my.php?image=kernelcrashif0.jpg

In userspace, there was (as for my previous message) only hcid running, 
and obviously my app performing dbus calls to it.

Message from syslogd@p2a at Fri Mar  9 15:47:40 2007 ...
kernel: Oops: 0000 [#1]
kernel: CPU:    0
kernel: EIP is at rfcomm_tty_chars_in_buffer+0x6/0x18 [rfcomm]
kernel: eax: 00000000   ebx: c6c51800   ecx: 00000000   edx: c773f000
kernel: esi: 00000000   edi: c5c1e4a0   ebp: c6c5180c   esp: c3837c08
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process hcid (pid: 16185, ti=c3836000 task=c2f87ab0 
task.ti=c3836000)
kernel: Stack: c01ef32b c01ef253 c6c51800 c5c1e4a0 c01eb873 00000000 
00000000 c3837eb0
kernel:        c5c1e4a0 c3837e98 c01574aa c3837fb0 080808f0 08080920 
00000000 c3837e98
kernel:        c3837e98 c3837e98 c3837ed0 00000000 c0157f5e 00000000 
00000000 00000008
kernel: Call Trace:
kernel: Code: 8b 98 70 01 00 00 8b 43 3c 8b 48 48 8b 50 54 85 d2 75 02 
b2 01 8b 43 60 0f af ca 29 c1 89 c8 79 02 31 c0 5b c3 8b 80 70 01 00 00 
<8b> 50 3c 8d 42 0c 39 42 0c 75 03 31 c0 c3 8b 42 48 c3
c3 c3 31
kernel: EIP: [<c82d6d50>] rfcomm_tty_chars_in_buffer+0x6/0x18 [rfcomm] 
SS:ESP 0068:c3837c08

What happened?

Best Regards,
Pierre-Yves Paulus

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
