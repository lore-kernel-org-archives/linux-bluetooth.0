Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Klaus <projectu@gmail.com>
Date: Sun, 29 Apr 2007 16:17:10 +0000 (UTC)
Message-ID: <loom.20070429T175311-236@post.gmane.org>
References: <20070415095728.GA6212@ifup.org>
	<20070424184826.GD6853@torres.zugschlus.de>
	<loom.20070429T141323-596@post.gmane.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Unable to set number of SCO buffers : please
	upgrade your Kernel !
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

Klaus <projectu <at> gmail.com> writes:
> 
> In plugz/../pcm_sco.c: sco_headset_hw_params(), 
>    setsockopt(...,SOL_SCO,...) is called, but it fails with ENOPROTOOPT
> "Protocol not available".
> 
>    setsockopt() for protocol level SOL_SCO is implemented in the kernel in
> net/bluetooth/sco.c: sco_sock_setsockopt(), but this function only does one
> thing - it returns ENOPROTOOPT:

If the method isn't implemented in the kernel, then IMHO, the obvious thing to
do is to remove the offending calls to setsockopt() from pcm_sco.c.

And - surprice surprice, it works - there is sound in the headset. But the joy
is short.

----
 $ mplayer -ao alsa:device=headset ~/eyes_on_me.ogg
[...]
Playing /home/kp/eyes_on_me.ogg.
Audio file file format detected.
[...]
AO: [alsa] 8000Hz 1ch s16le (2 bytes per sample)
Video: no video
Starting playback...
A: 334.3 (05:34.3) of 333.0 (05:33.0)  1.2%        
----

mplayer stops playing after a few sec, and then after another few secs this
happens:

pingus kernel: invalid opcode: 0000 [#1]
[...]

In syslog it looks like this:
----
Apr 29 17:01:00 pingus headsetd[3175]: Bluetooth headset daemon version 0.5
Apr 29 17:01:17 pingus headsetd[3175]: Configuration phase ended: target bdaddr
is 00:02:76:80:27:1F, timeout is 6000 ms
Apr 29 17:01:17 pingus headsetd[3175]: Changing state: Idle-->Paging
Apr 29 17:01:18 pingus headsetd[3175]: Changing state: Paging-->Connecting
Apr 29 17:01:18 pingus hcid[2230]: link_key_request (sba=00:01:53:00:CF:08,
dba=00:02:76:80:27:1F)
Apr 29 17:01:18 pingus headsetd[3175]: Changing state: Connecting-->Ready
Apr 29 17:01:18 pingus kernel: Bluetooth: SCO (Voice Link) ver 0.5
Apr 29 17:01:18 pingus kernel: Bluetooth: SCO socket layer initialized
Apr 29 17:01:18 pingus headsetd[3175]: Changing state: Ready-->Opening
Apr 29 17:01:19 pingus headsetd[3175]: SCO channel opened handle=0x002d mtu=64
Apr 29 17:01:19 pingus headsetd[3175]: Changing state: Opening-->Streaming
Apr 29 17:01:26 pingus headsetd[3175]: Appli closed socket
Apr 29 17:01:26 pingus headsetd[3175]: Changing state: Streaming-->Zombie
Apr 29 17:01:30 pingus headsetd[3175]: Nobody uses SCO channel anymore, 
  closing it.
Apr 29 17:01:30 pingus headsetd[3175]: Changing state: Zombie-->Connected
Apr 29 17:01:30 pingus kernel: hci_scodata_packet: hci0 SCO packet for unknown
  connection handle 45
Apr 29 17:01:30 pingus last message repeated 2 times
Apr 29 17:01:45 pingus kernel: usb 1-1: USB disconnect, address 3
Apr 29 17:01:45 pingus kernel: __tx_submit: hci0 tx submit failed urb c1e722bc
  type 3 err -19
Apr 29 17:01:45 pingus kernel: __tx_submit: hci0 tx submit failed urb c1e722bc
  type 3 err -19
Apr 29 17:01:45 pingus kernel: slab error in verify_redzone_free(): cache
  `size-512': memory outside object was overwritten
Apr 29 17:01:45 pingus kernel:  [<c04061e9>] show_trace_log_lvl+0x1a/0x2f
Apr 29 17:01:45 pingus kernel:  [<c04067ad>] show_trace+0x12/0x14
Apr 29 17:01:45 pingus kernel:  [<c0406831>] dump_stack+0x16/0x18
Apr 29 17:01:45 pingus kernel:  [<c04791e6>] __slab_error+0x29/0x2b
Apr 29 17:01:45 pingus kernel:  [<c047979a>] cache_free_debugcheck+0xa9/0x19d
Apr 29 17:01:45 pingus kernel:  [<c0479ae0>] kfree+0x74/0xc2
Apr 29 17:01:45 pingus kernel:  [<e098d34b>] hci_usb_close+0xc2/0x121 [hci_usb]
Apr 29 17:01:45 pingus kernel:  [<e098dd0e>] hci_usb_disconnect+0x2a/0x6f
   [hci_usb]
Apr 29 17:01:45 pingus kernel:  [<c057a61e>] usb_unbind_interface+0x30/0x63
Apr 29 17:01:45 pingus kernel:  [<c05628ba>] __device_release_driver+0x74/0x90
Apr 29 17:01:45 pingus kernel:  [<c0562d39>] device_release_driver+0x35/0x4c
Apr 29 17:01:45 pingus kernel:  [<c05622c7>] bus_remove_device+0x73/0x82
Apr 29 17:01:45 pingus kernel:  [<c056090e>] device_del+0x16e/0x1d2
Apr 29 17:01:45 pingus kernel:  [<c057840c>] usb_disable_device+0x5f/0xbc
Apr 29 17:01:45 pingus kernel:  [<c057514b>] usb_disconnect+0x9a/0x119
Apr 29 17:01:45 pingus kernel:  [<c0575df2>] hub_thread+0x2e2/0x992
Apr 29 17:01:45 pingus kernel:  [<c043832b>] kthread+0xb3/0xdc
Apr 29 17:01:45 pingus kernel:  [<c0405cd3>] kernel_thread_helper+0x7/0x10
Apr 29 17:01:45 pingus kernel:  =======================
Apr 29 17:01:45 pingus kernel: c0c27ca5: redzone 1:0x5a5a5a5a, 
  redzone 2:0x46c05ac8.
Apr 29 17:01:45 pingus kernel: ------------[ cut here ]------------
Apr 29 17:01:45 pingus kernel: kernel BUG at mm/slab.c:2877!
Apr 29 17:01:45 pingus kernel: invalid opcode: 0000 [#1]
Apr 29 17:01:45 pingus kernel: SMP 
Apr 29 17:01:45 pingus kernel: last sysfs file:
/devices/pci0000:00/0000:00:02.0/usb1/idVendor
[...]
----

Klaus


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
