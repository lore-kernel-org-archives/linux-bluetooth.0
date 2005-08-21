Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco - a few comments and a small .py script
Message-ID: <20050821192634.GA10231@uni-duesseldorf.de>
References: <20050819193855.GA25514@uni-duesseldorf.de> <43078EF3.4050702@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <43078EF3.4050702@xmission.com>
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
Date: Sun, 21 Aug 2005 21:26:34 +0200


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[had to resend that, as I forgot to use the right source address, sorry.
 Thus a few comments I make now in [] ]

Hi Brad,
> >   I'd suggest to put a simple exaple there, how the results from
> >   "hciconfig hci0 revision" should look like. I.e. that the line 
> >   "SCO mapping:  HCI" should exist.
> I cleaned this up a bit.

Great. That should be clear now.

> I don't know of such a command. /etc/bluetooth/link_key is how the keys 
> are stored in the older daemon so I've mentioned both in the docs.

Yeah - this might as well help.

 
> >3. I have written a small Python-Script and a .btscorc
> Perfect. I gave a talk about btsco at our usergroup meeting and this 
> very question came up! (slides at http://flamebot.com/blog)
> I will link to you or put these in a contrib dir (what do you think?)

I don't care. I don't think this will need updates, unless the skype
d-bus protocol gets changed in a fundamental way. So you might as well 
put it in a contrib dir. That makes it more obvious and readily
available.

License is PD as far as my part is concerned. It is derived from 
http://download.skype.com/share/devzone/example_linux.zip
which does not have any copyright or license notes.

However as it is a sample file from their API docs, I suppose this is
not a problem.

> >4. I also have the "microphone transmits noise" problem sometimes
> >   (rarely). Could it be, that there is a missed byte that swaps high
> >   and lowbyte? It sounded a bit like this to me.
> I think you are right. There is some kind of fundamental transport glitch.

If it gets annoying, I'll have a look at the btsco daemon and see if I
can introduce a signal that will purposefully skip a single byte thus 
regaining sync (if my assumption is correct - I got to look at the
code first or get a clue about the transmission format) if I have a 
noisy line.

[I just noticed, that the copying around is done in kernelspace. Got to
 check it there, then.]

> >5. My cheap (EUR 22.- incl. VAT) LevelOne BLH-1000 Headset works fine,
> >   except for the glitch just described. It ignores microphone level
> >   setup, though. Loopback control works. Using the buttons, you can
> >   only reach Speaker Level 12 (80%) - using the mixer you can go to
> >   100%.
> I added it to the list.

A nice addition for me would be a software mic-boost. The quality of the
sound is not bad, but (probably due to the ridiculously compact design
of my headset) the dynamic range is not used appropriately.

I'll have a look, if I can add something like a "--micboost" switch that
will just scale up the input before giving it to the sound device.

[ I have in the meantime done this - crude patch attached. Only use
  if you know what it does and what you are doing.
  It cures my problem, but it's of course ugly.

  What do you think about adding a third Mixer bar like "Mic Softboost"
  which will allow to adjust a value by which the mic data gets scaled
  between about *0.1 and *10.0?

  This would allow for better usability for devices that ignore the mic
  setup sequences when used with software that doesn't scale by itself.

  If someone feels like implementing it, it might as well be a good idea 
  to provide some kind of dynamic compression?
]


Another thing I noticed (which is probably not btsco related, but more
of a general bluez problem, maybe even a general kernel problem) is,
that I now had two occasions where my USB subsystem became unresponsive 
to a point where the machine froze.

I could still ping it, but mouse was unresponsive, and higher level
network protocols had also stopped working.

The syslogs say:

Aug 19 00:34:58 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 00:35:09 cupido kernel: uhci_hcd 0000:00:04.2: host system error, PCI problems?
Aug 19 00:35:09 cupido kernel: uhci_hcd 0000:00:04.2: host controller halted, very bad!
Aug 19 00:36:17 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 00:36:17 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 00:36:17 cupido kernel: snd-bt-sco: capture_trigger 0
Aug 19 00:36:17 cupido kernel: snd-bt-sco: setting capture to NULL
Aug 19 00:36:17 cupido kernel: snd-bt-sco: Disposing of previous socket count 2
Aug 19 00:36:59 cupido kernel: snd-bt-sco: playback_open
Aug 19 00:36:59 cupido kernel: snd-bt-sco: capture_open
Aug 19 00:36:59 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 672 count: 42
Aug 19 00:36:59 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 00:36:59 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 00:37:19 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 00:37:19 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 00:38:01 cupido /USR/SBIN/CRON[8130]: (mail) CMD (  if [ -x /usr/lib/exim/exim3 -a -f /etc/exim/exim.conf ]; then /usr/lib/exim/exim3 -q ; fi)
Aug 19 00:38:17 cupido kernel: hci_cmd_task: hci0 command tx timeout
Aug 19 00:39:12 cupido kernel: usb 1-2: USB disconnect, address 2
Aug 19 00:39:12 cupido kernel: usb 1-2.3: USB disconnect, address 8
Aug 19 00:39:12 cupido kernel: usb 1-2.6: USB disconnect, address 13
Aug 19 00:39:41 cupido kernel: __tx_submit: hci0 tx submit failed urb f53cabf4 type 1 err -19
Aug 19 00:39:41 cupido kernel: __tx_submit: hci0 tx submit failed urb f53cabf4 type 1 err -19
[about 10 more similar messages]
[at this point the system was still responsive to mouse/keyboard (PS/2
based) - I think I tried to reset the USB hub (Noname, called USB1007,
Vendor 05e3, Product 0604, Revision 0.05) by pulling it's inbound plug,
as it's link LEDs looked wrong (all off)]
Aug 19 00:39:41 cupido hcid[7720]: HCI dev 0 down
Aug 19 00:39:41 cupido hcid[7720]: Stoping security manager 0
Aug 19 00:39:42 cupido hcid[7720]: HCI dev 0 unregistered
Aug 19 00:39:43 cupido kernel: usb 1-2: new full speed USB device using uhci_hcd and address 14
Aug 19 00:39:43 cupido kernel: hub 1-2:1.0: USB hub found
Aug 19 00:39:43 cupido kernel: hub 1-2:1.0: 7 ports detected
Aug 19 00:39:43 cupido kernel: usb 1-2.3: new full speed USB device using uhci_hcd and address 15
Aug 19 00:39:43 cupido kernel: drivers/usb/media/ov511.c: USB OV518 video device found
Aug 19 00:39:43 cupido kernel: drivers/usb/media/ov511.c: Device revision 1
Aug 19 00:39:43 cupido kernel: drivers/usb/media/ov511.c: Compression required with OV518...enabling
Aug 19 00:39:44 cupido usb.agent[8289]:      ov511: already loaded
Aug 19 00:39:45 cupido usb.agent[8322]:      usbcore: already loaded
Aug 19 00:39:45 cupido kernel: drivers/usb/media/ov511.c: Sensor is an OV6630AF
Aug 19 00:39:46 cupido kernel: drivers/usb/media/ov511.c: Device at usb-0000:00:04.2-2.3 registered to minor 0
Aug 19 00:39:46 cupido kernel: usb 1-2.6: new full speed USB device using uhci_hcd and address 16
Aug 19 00:39:46 cupido kernel: Unable to load interpreter /lib/ld-linux.so.2
Aug 19 00:39:46 cupido kernel: Unable to handle kernel paging request at virtual address 000a7d02
Aug 19 00:39:46 cupido kernel:  printing eip:
Aug 19 00:39:46 cupido kernel: f88821e9
Aug 19 00:39:46 cupido kernel: *pde = 00000000
Aug 19 00:39:46 cupido kernel: Oops: 0000 [#1]
Aug 19 00:39:46 cupido kernel: PREEMPT 
Aug 19 00:39:46 cupido kernel: Modules linked in: hci_usb sco tun rfcomm l2cap actisys_sir irtty_sir sir_dev irda crc_ccitt sg via_agp nls_iso8859_1 nls_cp437 vfat eth1394 w83781d i2c_sensor i2c_viapro i2c_core usb_storage msr microcode cpuid smbfs msdos fat video1394 raw1394 ohci1394 ieee1394 mga drm agpgart parport_pc lp parport snd_bt_sco snd_hwdep usbmouse ide_cd via82cxxx ide_core 8250_pci 8250 serial_core snd_ens1371 snd_rawmidi snd_ac97_codec snd_pcm_oss ov511 videodev snd_mixer_oss bluetooth snd_pcm snd_timer snd snd_page_alloc uhci_hcd usbcore evdev
Aug 19 00:39:46 cupido kernel: CPU:    0
Aug 19 00:39:46 cupido kernel: EIP:    0060:[pg0+944181737/1069470720]    Not tainted VLI
Aug 19 00:39:46 cupido kernel: EFLAGS: 00010246   (2.6.12.5) 
Aug 19 00:39:46 cupido kernel: EIP is at usb_disable_interface+0x49/0x80 [usbcore]
Aug 19 00:39:46 cupido kernel: eax: 00000000   ebx: eec94848   ecx: 00000282   edx: 000a7d00
Aug 19 00:39:46 cupido kernel: esi: 00000001   edi: eb595000   ebp: eec94880   esp: f70abd74
Aug 19 00:39:46 cupido kernel: ds: 007b   es: 007b   ss: 0068
Aug 19 00:39:46 cupido kernel: Process khubd (pid: 1138, threadinfo=f70aa000 task=f70425e0)
Aug 19 00:39:46 cupido kernel: Stack: 0000000b 0000000b 00000000 eb595000 00000001 f8882533 eb595000 ea4c00a0 
Aug 19 00:39:46 cupido kernel:        0000000b 00000001 00000002 00000001 00000000 00000000 00001388 ea4c00a0 
Aug 19 00:39:46 cupido kernel:        f88a5ec0 ea4c0ba0 00000002 eb595000 f88a4c09 eb595000 00000001 00000002 
Aug 19 00:39:46 cupido kernel: Call Trace:
Aug 19 00:39:46 cupido usb.agent[8388]:      hci_usb: already loaded
Aug 19 00:39:47 cupido kernel:  [pg0+944182579/1069470720] usb_set_interface+0xe3/0x190 [usbcore]
Aug 19 00:39:47 cupido kernel:  [pg0+944323593/1069470720] hci_usb_probe+0x4a9/0x5e0 [hci_usb]
Aug 19 00:39:47 cupido kernel:  [new_inode+36/176] new_inode+0x24/0xb0
Aug 19 00:39:47 cupido kernel:  [sysfs_new_dirent+41/128] sysfs_new_dirent+0x29/0x80
Aug 19 00:39:47 cupido kernel:  [pg0+944148612/1069470720] usb_probe_interface+0x64/0x80 [usbcore]
Aug 19 00:39:47 cupido kernel:  [driver_probe_device+47/128] driver_probe_device+0x2f/0x80
Aug 19 00:39:47 cupido kernel:  [device_attach+123/208] device_attach+0x7b/0xd0
Aug 19 00:39:47 cupido kernel:  [kobject_get+23/32] kobject_get+0x17/0x20
Aug 19 00:39:47 cupido kernel:  [bus_add_device+95/208] bus_add_device+0x5f/0xd0
Aug 19 00:39:47 cupido kernel:  [device_pm_add+85/144] device_pm_add+0x55/0x90
Aug 19 00:39:47 cupido kernel:  [device_add+232/384] device_add+0xe8/0x180
Aug 19 00:39:47 cupido kernel:  [pg0+944183698/1069470720] usb_set_configuration+0x262/0x560 [usbcore]
Aug 19 00:39:47 cupido kernel:  [pg0+944159474/1069470720] usb_new_device+0x142/0x1e0 [usbcore]
Aug 19 00:39:47 cupido kernel:  [pg0+944163887/1069470720] hub_port_connect_change+0x36f/0x430 [usbcore]
Aug 19 00:39:47 cupido kernel:  [pg0+944164761/1069470720] hub_events+0x2a9/0x440 [usbcore]
Aug 19 00:39:47 cupido kernel:  [pg0+944165247/1069470720] hub_thread+0x4f/0x110 [usbcore]
Aug 19 00:39:47 cupido kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Aug 19 00:39:47 cupido kernel:  [pg0+944165168/1069470720] hub_thread+0x0/0x110 [usbcore]
Aug 19 00:39:47 cupido kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Aug 19 00:39:47 cupido kernel: Code: 75 10 8b 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 31 f6 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 8b 53 0c 89 f0 46 c1 e0 05 <0f> b6 44 10 02 89 3c 24 89 44 24 04 e8 36 ff ff ff 0f b6 43 04 
Aug 19 00:40:41 cupido sdpd[7722]: terminating...   
Aug 19 00:40:42 cupido hcid[8451]: Bluetooth HCI daemon
Aug 19 00:40:42 cupido sdpd[8453]: Bluetooth SDP daemon 
Aug 19 00:41:32 cupido kernel:  <6>usbcore: deregistering driver hci_usb
Aug 19 00:43:08 cupido kernel: usbcore: deregistering driver ov511
Aug 19 00:43:52 cupido modprobe: FATAL: Error running install command for sound_slot_2 
Aug 19 00:43:52 cupido modprobe: FATAL: Error running install command for sound_slot_2 
Aug 19 00:48:02 cupido kernel: mtrr: no MTRR for e2000000,1000000 found
Aug 19 00:48:02 cupido gdm[4128]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Aug 19 00:48:05 cupido kernel: mtrr: no MTRR for e2000000,1000000 found
Aug 19 00:48:06 cupido kernel: atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
Aug 19 00:48:06 cupido kernel: atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
Aug 19 00:48:23 cupido gconfd (becka-www-5389): GConf server is not in use, shutting down.
Aug 19 00:48:23 cupido gconfd (becka-www-5389): Exiting
Aug 19 00:48:23 cupido shutdown[8537]: shutting down for system reboot
Aug 19 00:48:24 cupido init: Switching to runlevel: 6
Aug 19 00:48:27 cupido irattach: got SIGTERM or SIGINT 
Aug 19 00:48:27 cupido irattach: exiting ... 
Aug 19 00:48:27 cupido kernel: sirdev_put_instance
Aug 19 00:48:27 cupido kernel: irtty_close - ttyS1: irda line discipline closed
Aug 19 00:48:28 cupido ovpn-client[5651]: event_wait : Interrupted system call (code=4)
Aug 19 00:48:28 cupido ovpn-client[5651]: TCP/UDP: Closing socket
Aug 19 00:48:28 cupido ovpn-client[5651]: /sbin/route del -net 192.168.111.0 netmask 255.255.255.0
Aug 19 00:48:28 cupido ovpn-client[5651]: ERROR: Linux route delete command failed: shell command exited with error status: 7
Aug 19 00:48:28 cupido ovpn-client[5651]: /sbin/route del -net 192.168.112.0 netmask 255.255.255.0
Aug 19 00:48:28 cupido ovpn-client[5651]: ERROR: Linux route delete command failed: shell command exited with error status: 7
Aug 19 00:48:28 cupido ovpn-client[5651]: Closing TUN/TAP interface
Aug 19 00:48:29 cupido ovpn-client[5651]: SIGTERM[hard,] received, process exiting
Aug 19 00:48:29 cupido xfs[3884]: terminating 
Aug 19 00:48:30 cupido ntpd[4026]: ntpd exiting on signal 15
Aug 19 01:08:33 cupido syslogd 1.4.1#17: restart.


On another occasion, it went down more drastically:
Aug 19 21:51:08 cupido kernel: snd-bt-sco: playback_open
Aug 19 21:51:08 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 8000 cou
Aug 19 21:51:08 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:51:08 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:59:52 cupido syslogd 1.4.1#17: restart.

However before that happened, I see a few occurences of

hci_scodata_packet: hci0 SCO packet for unknown connection handle [varies]

and a bit later:

snd-bt-sco: Disposing of previous socket count 3
snd-bt-sco: file_count is 1 (expected 3)

shortly before it went down, I got:


Aug 19 21:50:33 cupido kernel: hub 1-2:1.0: port 6 disabled by hub (EMI?), re-enabling...
Aug 19 21:50:33 cupido kernel: usb 1-2.6: USB disconnect, address 10
Aug 19 21:50:33 cupido kernel: __tx_submit: hci0 tx submit failed urb f46d5214 type 3 err -19
Aug 19 21:50:33 cupido kernel: __tx_submit: hci0 tx submit failed urb f46d5214 type 3 err -19
Aug 19 21:50:33 cupido hcid[4121]: HCI dev 0 down
Aug 19 21:50:33 cupido hcid[4121]: Stoping security manager 0
Aug 19 21:50:33 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:50:33 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:50:33 cupido hcid[4121]: HCI dev 0 unregistered
Aug 19 21:50:34 cupido kernel: usb 1-2.6: new full speed USB device using uhci_hcd and address 11
Aug 19 21:50:34 cupido kernel: usb 1-2.6: device descriptor read/64, error -71
Aug 19 21:50:34 cupido kernel: usb 1-2.6: device descriptor read/64, error -71
Aug 19 21:50:34 cupido kernel: usb 1-2.6: new full speed USB device using uhci_hcd and address 12
Aug 19 21:50:34 cupido kernel: usb 1-2.6: device descriptor read/64, error -71
Aug 19 21:50:34 cupido kernel: usb 1-2.6: device descriptor read/64, error -71
Aug 19 21:50:34 cupido kernel: usb 1-2.6: new full speed USB device using uhci_hcd and address 13
Aug 19 21:50:35 cupido kernel: usb 1-2.6: device not accepting address 13, error -71
Aug 19 21:50:35 cupido kernel: usb 1-2.6: new full speed USB device using uhci_hcd and address 14
Aug 19 21:50:35 cupido kernel: usb 1-2.6: device not accepting address 14, error -71
Aug 19 21:50:37 cupido kernel: usb 1-2.6: new full speed USB device using uhci_hcd and address 15
Aug 19 21:50:38 cupido hcid[4121]: HCI dev 0 registered
Aug 19 21:50:38 cupido usb.agent[26062]:      hci_usb: already loaded
Aug 19 21:50:38 cupido hcid[4121]: HCI dev 0 up
Aug 19 21:50:38 cupido usb.agent[26105]:      hci_usb: already loaded
Aug 19 21:50:38 cupido hcid[4121]: Starting security manager 0
Aug 19 21:50:38 cupido usb.agent[26122]:      hci_usb: already loaded
Aug 19 21:50:41 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 21:50:41 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 21:50:41 cupido kernel: snd-bt-sco: playback_open
Aug 19 21:50:41 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
Aug 19 21:50:41 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:50:41 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:50:45 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 21:50:45 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 21:50:45 cupido kernel: snd-bt-sco: playback_open
Aug 19 21:50:45 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
Aug 19 21:50:45 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:50:45 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:50:46 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 21:50:46 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 21:50:46 cupido kernel: snd-bt-sco: playback_open
Aug 19 21:50:46 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
Aug 19 21:50:46 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:50:46 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:50:49 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 21:50:49 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 21:50:49 cupido kernel: snd-bt-sco: playback_open
Aug 19 21:50:49 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
Aug 19 21:50:49 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:50:49 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:50:51 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 21:50:51 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 21:50:51 cupido kernel: snd-bt-sco: playback_open
Aug 19 21:50:51 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
Aug 19 21:50:51 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:50:51 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:50:56 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 21:50:56 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 21:50:56 cupido kernel: snd-bt-sco: playback_open
Aug 19 21:50:56 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
Aug 19 21:50:56 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:50:56 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:50:57 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 21:50:57 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 21:50:58 cupido kernel: snd-bt-sco: playback_open
Aug 19 21:50:58 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
Aug 19 21:50:58 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:50:58 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:51:02 cupido hcid[4121]: link_key_request (sba=00:09:DD:10:4E:8C, dba=00:0A:94:93:74:B7)
Aug 19 21:51:08 cupido kernel: snd-bt-sco: playback_trigger 0
Aug 19 21:51:08 cupido kernel: snd-bt-sco: setting playback to NULL
Aug 19 21:51:08 cupido kernel: snd-bt-sco: playback_open
Aug 19 21:51:08 cupido kernel: snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
Aug 19 21:51:08 cupido kernel: snd-bt-sco: playback_trigger 1
Aug 19 21:51:08 cupido kernel: snd-bt-sco: setting playback to bspcm
Aug 19 21:59:52 cupido syslogd 1.4.1#17: restart.


I'm not sure, what that means. It seems to be related to the USB Hub,
which also usually shows erratic LED Link display when that happens.
However I haven't seen this before using the BT dongle, and I was using
it for a webcam before, so it shouldn't be related just to the larger
amounts of traffic.

I have also noticed my system hanging on shutdown when trying to unload
the rfcomm stuff. This is usually cured by resetting the USB hub.
This looks like this:


Aug 21 04:12:14 cupido xfs[3928]: terminating 
Aug 21 04:12:15 cupido ntpd[4072]: ntpd exiting on signal 15
Aug 21 04:13:24 cupido kernel: usb 1-2: USB disconnect, address 2
Aug 21 04:13:24 cupido kernel: usb 1-2.3: USB disconnect, address 3
Aug 21 04:13:24 cupido kernel: usb 1-2.6: USB disconnect, address 4
Aug 21 04:13:26 cupido kernel:  1-2.6: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -110
Aug 21 04:13:26 cupido sdpd[4103]: terminating...   
Aug 21 04:13:26 cupido rpc.statd[4057]: Caught signal 15, un-registering and exiting.


CU, ANdy

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="btsco.diff"

Index: btsco.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/kernel/btsco.c,v
retrieving revision 1.6
diff -c -r1.6 btsco.c
*** btsco.c	19 Mar 2005 14:28:59 -0000	1.6
--- btsco.c	21 Aug 2005 19:23:16 -0000
***************
*** 790,795 ****
--- 790,796 ----
  	struct msghdr msg;
  	struct iovec iov;
  	sigset_t unblocked;
+ 	int i;
  
  	lock_kernel();
  
***************
*** 839,844 ****
--- 840,851 ----
  		len = sock_recvmsg(sock, &msg, BUF_SIZE, 0);
  		if (len > 0) {
  
+ 			for(i=0;i<len-1;i+=2) {
+ 				short int j=(buf[i]<<8)|buf[i+1];
+ 				j*=4;
+ 				buf[i]=j>>8;
+ 				buf[i+1]=j&0xff;
+ 			}
  			down(&bt_sco->capture_sem);
  			if (bt_sco->capture) {
  				snd_card_bt_sco_pcm_receive

--WIyZ46R2i8wDzkSu--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
