Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Foster <rfoster@mountainvisions.com.au>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1106739703.6665.5.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] problems with patch for 2.6.10...
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
Date: Wed, 26 Jan 2005 22:41:43 +1100

Hi,
I've just applied the latest patch ( 2.6.10-mh2 ) to the latest
available kernel source for Fedora Core 3 from their update site (2.6.10
with a few patches applied).  All was well except that a patch for the
Makefile was rejected due to the EXTRAVERSION flag being different.
Everything built and installed perfectly, but now I'm getting the
following on bootup.  I've also upgraded the stock bluez-libs and bluez-
utils rpms for FC3 with the latest from the bluez.org site.

Any help appreciated :)

Rob.

(from dmesg):
<snip>
Bluetooth: Core ver 2.7
kmem_cache_create: duplicate cache bt_sock
------------[ cut here ]------------
kernel BUG at mm/slab.c:1451!
invalid operand: 0000 [#1]
Modules linked in: bluetooth(U) ieee1394(U) yenta_socket(U) pcmcia_core
(U) uhci_hcd(U) ehci_hcd(U) i2c_i801(U) i2c_core(U) snd_intel8x0m(U)
snd_intel8x0(U) snd_ac97_codec(U) snd_pcm_oss(U) snd_mixer_oss(U)
snd_pcm(U) snd_timer(U) snd(U) wlan_wep(U) soundcore(U) snd_page_alloc
(U) tg3(U) ath_pci(U) ath_rate_onoe(U) wlan(U) ath_hal(U) floppy(U) ext3
(U) jbd(U)
CPU:    0
EIP:    0060:[<c0144fbe>]    Tainted: P      VLI
EFLAGS: 00010202   (2.6.10-prep)
EIP is at kmem_cache_create+0x407/0x474
eax: c030dac0   ebx: f78aeb40   ecx: c030dac0   edx: f8a283c4
esi: c0331cd8   edi: f8a283cc   ebp: c1972d88   esp: f6974f84
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3146, threadinfo=f6974000 task=f73f8c70)
Stack: c0000000 c0197afb f8a283c4 000001c0 f8a2db00 08da31a8 00000018
f6974000
       f883a047 00002000 00000000 00000000 c0135999 b7e01008 08da31a8
c010336f
       b7e01008 000c7479 08da31a8 08da31a8 00000018 bfee49d8 00000080
0000007b
Call Trace:
 [<c0197afb>] get_inode_number+0xa7/0x132
 [<f883a047>] bt_init+0x47/0x8c [bluetooth]
 [<c0135999>] sys_init_module+0x1c4/0x294
 [<c010336f>] syscall_call+0x7/0xb
Code: c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 24 ff 74 24 08 68 c0 da
30 c0 e8 ea 66 fd ff 58 5a ff 05 40 8c 3f c0 0f 8e c6 18 00 00 <0f> 0b
ab 05 0b da 30 c0 8b 6d 00 eb 8b 8b 0c 24 b8 00 f0 ff ff
 <6>Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
</snip>



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
