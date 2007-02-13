Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 13 Feb 2007 09:02:12 -0500
Message-ID: <2EB6297382462046A9427D7324788A4801A38CD0@MCLNEXVS06.resource.ds.bah.com>
In-Reply-To: <1171308791.11774.6.camel@violet>
References: <2EB6297382462046A9427D7324788A4801A3898D@MCLNEXVS06.resource.ds.bah.com>
	<1171308791.11774.6.camel@violet>
From: "Williams, Richard" <williams_richard_b@bah.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Oops with multiple hcitool commands
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

 
Greetings Marcel,

When the oops occurs, I lose the keyboard on my PC and I can only reboot
with the mouse.

So, the best I can do is to tail -f /var/log/messages in another
terminal window, and then copy the oops output to send to you. Is there
another way ??

So I did 
hcitool -i hci0 info xx:xx:xx:xx:xx:xx in one window,
hcitool -i hci1 info xx:xx:xx:xx:xx:xx in a second window,

Note that the remote BD address is the same, but two USB dongles are
installed.

Here is the output from /var/log/messages. I hope this is sufficient for
what you need.

Feb 13 08:34:42 eaton-230-112 pcscd: winscard.c:219:SCardConnect()
Reader E-Gate 0 0 Not Found
Feb 13 08:34:42 eaton-230-112 last message repeated 3 times
Feb 13 08:34:44 eaton-230-112 kernel: mtrr: 0xc0000000,0x8000000
overlaps existing 0xc0000000,0x4000000
Feb 13 08:34:44 eaton-230-112 last message repeated 2 times
Feb 13 08:34:44 eaton-230-112 kernel: [drm] Setting GART location based
on new memory map
Feb 13 08:34:44 eaton-230-112 kernel: [drm] Loading R300 Microcode
Feb 13 08:34:44 eaton-230-112 kernel: [drm] writeback test succeeded in
1 usecs
Feb 13 08:35:00 eaton-230-112 gconfd (rich-3341): starting (version
2.14.0), pid 3341 user 'rich'
Feb 13 08:35:00 eaton-230-112 gconfd (rich-3341): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only
configuration source at position 0
Feb 13 08:35:00 eaton-230-112 gconfd (rich-3341): Resolved address
"xml:readwrite:/home/rich/.gconf" to a writable configuration source at
position 1
Feb 13 08:35:00 eaton-230-112 gconfd (rich-3341): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only
configuration source at position 2
Feb 13 08:35:01 eaton-230-112 gconfd (rich-3341): Resolved address
"xml:readwrite:/home/rich/.gconf" to a writable configuration source at
position 0
Feb 13 08:35:02 eaton-230-112 hcid[2720]: Default passkey agent (:1.8,
/org/bluez/applet) registered
Feb 13 08:35:04 eaton-230-112 pcscd: winscard.c:219:SCardConnect()
Reader E-Gate 0 0 Not Found
Feb 13 08:35:04 eaton-230-112 last message repeated 4 times
Feb 13 08:36:16 eaton-230-112 kernel: add_conn: Failed to register
connection device
Feb 13 08:36:17 eaton-230-112 kernel: BUG: unable to handle kernel NULL
pointer dereference at virtual address 0000001c
Feb 13 08:36:17 eaton-230-112 kernel:  printing eip:
Feb 13 08:36:17 eaton-230-112 kernel: c061b254
Feb 13 08:36:17 eaton-230-112 kernel: *pde = 0326c067
Feb 13 08:36:17 eaton-230-112 kernel: Oops: 0000 [#1]
Feb 13 08:36:17 eaton-230-112 kernel: SMP 
Feb 13 08:36:17 eaton-230-112 kernel: last sysfs file:
/module/libata/version
Feb 13 08:36:17 eaton-230-112 kernel: Modules linked in: autofs4 hidp
rfcomm l2cap sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state
ip_conntrack nfnetlink iptable_filter ip_tables ip6t_REJECT xt_tcpudp
ip6table_filter ip6_tables x_tables dm_multipath video sbs i2c_ec dock
button battery ac radeon drm ipv6 lp snd_intel8x0m joydev sg serio_raw
floppy snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device ipw2200
snd_pcm_oss snd_mixer_oss snd_pcm ieee80211 snd_timer ieee80211_crypt
snd soundcore snd_page_alloc ide_cd iTCO_wdt i2c_i801 pcspkr cdrom
ohci1394 i2c_core ieee1394 tg3 hci_usb nsc_ircc bluetooth irda crc_ccitt
parport_pc parport dm_snapshot dm_zero dm_mirror dm_mod ahci ata_piix
libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Feb 13 08:36:17 eaton-230-112 kernel: CPU:    0
Feb 13 08:36:17 eaton-230-112 kernel: EIP:    0060:[<c061b254>]    Not
tainted VLI
Feb 13 08:36:17 eaton-230-112 kernel: EFLAGS: 00010282
(2.6.19-1.2895.fc6 #1)
Feb 13 08:36:17 eaton-230-112 kernel: EIP is at klist_del+0x9/0x3b
Feb 13 08:36:17 eaton-230-112 kernel: eax: 00000000   ebx: 00000000
ecx: dfecf000   edx: 00000282
Feb 13 08:36:17 eaton-230-112 kernel: esi: d79098e8   edi: c14d4dc0
ebp: da8dc9dc   esp: dfecff44
Feb 13 08:36:17 eaton-230-112 kernel: ds: 007b   es: 007b   ss: 0068
Feb 13 08:36:17 eaton-230-112 kernel: Process events/0 (pid: 5,
ti=dfecf000 task=c14de030 task.ti=dfecf000)
Feb 13 08:36:17 eaton-230-112 kernel: Stack: d7909898 d79098c8 c14d4dc0
c0554802 d7909898 d790989c c14d4dc0 00000282 
Feb 13 08:36:17 eaton-230-112 kernel:        c043271b 00000282 c14d4dc0
c14d4de0 e098c244 d7909800 c14d4de0 c14d4dc0 
Feb 13 08:36:17 eaton-230-112 kernel:        c14d4dd8 00000000 c04330e0
00000001 00000000 00000000 00010000 00000000 
Feb 13 08:36:17 eaton-230-112 kernel: Call Trace:
Feb 13 08:36:17 eaton-230-112 kernel:  [<c0554802>]
device_del+0x18/0x19a
Feb 13 08:36:17 eaton-230-112 kernel:  [<c043271b>]
run_workqueue+0x97/0xdd
Feb 13 08:36:17 eaton-230-112 kernel:  [<c04330e0>]
worker_thread+0xd9/0x10d
Feb 13 08:36:17 eaton-230-112 kernel:  [<c0435660>] kthread+0xc0/0xec
Feb 13 08:36:17 eaton-230-112 kernel:  [<c0405257>]
kernel_thread_helper+0x7/0x10
Feb 13 08:36:17 eaton-230-112 kernel:  =======================
Feb 13 08:36:17 eaton-230-112 kernel: Code: 8b 04 24 89 46 08 8b 06 e8
87 22 00 00 85 ed 74 08 85 ff 74 04 89 f8 ff d5 8b 04 24 5a 5b 5e 5f 5d
c3 57 56 89 c6 53 8b 18 89 d8 <8b> 7b 1c e8 8e 22 00 00 89 f0 e8 6e ff
ff ff 85 c0 74 11 89 d8 
Feb 13 08:36:17 eaton-230-112 kernel: EIP: [<c061b254>]
klist_del+0x9/0x3b SS:ESP 0068:dfecff44




Many thanks and best regards,

Rich Williams




-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Monday, February 12, 2007 2:33 PM
To: BlueZ development
Subject: Re: [Bluez-devel] Oops with multiple hcitool commands

Hi Richard,

> I am building a project that will use multiple HCI devices on a single

> Linux PC. I have a USB hub, and several Linksys Bluetooth dongles. On 
> my PC I open two terminal windows and then run the following commands:
>  
> window 1#  hcitool -i hci0 info 00:18:C5:2C:5E:C2 window 2#  hcitool 
> -i hci1 info 00:18:C5:2C:5E:C2
>  
> The two commands must run simultaneously. Just these two commands run 
> quickly one after the other will almost always cause the oops. The 
> problem does not occur if the two hcitool info commands are examining 
> different remote devices. You must go after the same remote device.

please post the oops message from the kernel.

Regards

Marcel



------------------------------------------------------------------------
-
Using Tomcat but need to do more? Need to support web services,
security?
Get stuff done quickly with pre-integrated technology to make your job
easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache
Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
