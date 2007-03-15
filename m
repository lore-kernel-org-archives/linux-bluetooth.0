Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45F8FD55.1050702@idlum.be>
Date: Thu, 15 Mar 2007 09:01:25 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45F176B0.3090507@idlum.be> <45F18561.7040005@idlum.be>
In-Reply-To: <45F18561.7040005@idlum.be>
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

Hello,

I got this a few minutes ago. It was on a Xubuntu edgy box, running 
2.6.17-10-generic #2 SMP Tue Dec 5 22:28:26 UTC 2006 i686 unknown. Hcid 
v3.7 was running at the time it happened, and data was sent over one or 
more /dev/rfcommX.

There has been no answer to my previous messages to the list regarding 
those crashes. Should I give more details? Which ones? Are those 
problems known and perhaps already fixed upstream?

Please let me know!

Best Regards,
Pierre-Yves Paulus


Mar 15 08:51:58 uber2 kernel: [20442837.220000] BUG: unable to handle 
kernel NULL pointer dereference at virtual address 0000003c
Mar 15 08:51:58 uber2 kernel: [20442837.220000]  printing eip:
Mar 15 08:51:58 uber2 kernel: [20442837.220000] f8f46b7a
Mar 15 08:51:58 uber2 kernel: [20442837.220000] *pde = 00000000
Mar 15 08:51:58 uber2 kernel: [20442837.220000] Oops: 0000 [#1]
Mar 15 08:51:58 uber2 kernel: [20442837.220000] SMP
Mar 15 08:51:58 uber2 kernel: [20442837.220000] Modules linked in: 
usbhid nls_utf8 nls_iso8859_1 nls_cp437 vfat fat usb_storage libusual 
ppdev vmnet vmmon rfcomm l2cap cpufreq_powersave cpufreq_stats 
cpufreq_userspace cpufreq_ondemand cpufreq_conservative freq_table 
tc1100_wmi video battery container sbs button pcc_acpi sony_acpi i2c_ec 
ac dev_acpi asus_acpi hotkey af_packet ext2 lp tsdev nvidia snd_intel8x0 
snd_ac97_codec snd_ac97_bus ipv6 psmouse serio_raw hci_usb bluetooth 
snd_pcm_oss snd_mixer_oss sg snd_pcm snd_timer snd soundcore evdev 
pcspkr parport_pc parport floppy analog gameport snd_page_alloc shpchp 
pci_hotplug nvidia_agp agpgart i2c_nforce2 i2c_core reiserfs forcedeth 
ohci_hcd usbcore ide_generic sd_mod ide_disk sata_nv libata scsi_mod 
generic amd74xx thermal processor fan fbcon tileblit font bitblit 
softcursor vesafb capability commoncap
Mar 15 08:51:58 uber2 kernel: [20442837.220000] CPU:    0
Mar 15 08:51:58 uber2 kernel: [20442837.220000] EIP: 
0060:[pg0+950709114/1068901376]    Tainted: P      VLI
Mar 15 08:51:58 uber2 kernel: [20442837.220000] EFLAGS: 00010206 
(2.6.17-10-generic #2)
Mar 15 08:51:58 uber2 kernel: [20442837.220000] EIP is at 
rfcomm_tty_write+0x1a/0x190 [rfcomm]
Mar 15 08:51:58 uber2 kernel: [20442837.220000] eax: 00000000   ebx: 
ef725e00   ecx: 00000003   edx: ea0ca000
Mar 15 08:51:58 uber2 kernel: [20442837.220000] esi: 00000003   edi: 
dc0f0800   ebp: ea0ca000   esp: c574deec
Mar 15 08:51:58 uber2 kernel: [20442837.220000] ds: 007b   es: 007b 
ss: 0068
Mar 15 08:51:58 uber2 kernel: [20442837.220000] Process java (pid: 4807, 
threadinfo=c574c000 task=c6c25050)
Mar 15 08:51:58 uber2 kernel: [20442837.220000] Stack: 00000003 ea0ca000 
00000000 c043b1e0 00000246 ef725e00 00000003 dc0f0800
Mar 15 08:51:58 uber2 kernel: [20442837.220000]        ea0ca000 c0229369 
dc0f0934 ea0ca000 dfa879e0 dc0f0800 00000000 c6c25050
Mar 15 08:51:58 uber2 kernel: [20442837.220000]        c011bde0 dc0f0938 
dc0f0938 00000003 dc0f0800 dfa879e0 00000003 c02267d8
Mar 15 08:51:58 uber2 kernel: [20442837.220000] Call Trace:
Mar 15 08:51:58 uber2 kernel: [20442837.220000]  <c0229369> 
write_chan+0x219/0x320  <c011bde0> default_wake_function+0x0/0x10
Mar 15 08:51:58 uber2 kernel: [20442837.220000]  <c02267d8> 
tty_write+0x138/0x1f0  <c0229150> write_chan+0x0/0x320
Mar 15 08:51:58 uber2 kernel: [20442837.220000]  <c016aece> 
vfs_write+0xbe/0x190  <c02266a0> tty_write+0x0/0x1f0
Mar 15 08:51:58 uber2 kernel: [20442837.220000]  <c016b641> 
sys_write+0x41/0x70  <c0102fbb> sysenter_past_esp+0x54/0x79
Mar 15 08:51:58 uber2 kernel: [20442837.220000] Code: d8 e8 fb f1 ff ff 
eb e1 89 f6 8d bc 27 00 00 00 00 55 57 56 53 83 ec 14 85 c9 89 54 24 04 
89 0c 24 8b 80 80 01 00 00 89 44 24 08 <8b> 40 3c c7 44 24 10 00 00 00 
00 89 44 24 0c 0f 84 e8 00 00 00
Mar 15 08:51:58 uber2 kernel: [20442837.220000] EIP: 
[pg0+950709114/1068901376] rfcomm_tty_write+0x1a/0x190 [rfcomm] SS:ESP 
0068:c574deec


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
