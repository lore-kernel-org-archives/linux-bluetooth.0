Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Ed Tomlinson <edt@aei.ca>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Johan Hedberg <johan.hedberg@nokia.com>
Message-Id: <AA9D47E2-B1F0-4BA1-8432-2F16C89A74A3@gmail.com>
From: Justin Mattock <justinmattock@gmail.com>
To: Mikko Vinni <mmvinni@yahoo.com>
In-Reply-To: <635561.59590.qm@web161820.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: re "bluetooth disabled" and "[BUG] usb problems in .38-rc3+"
Date: Mon, 28 Feb 2011 21:51:50 -0800
References: <635561.59590.qm@web161820.mail.bf1.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Feb 28, 2011, at 2:29 PM, Mikko Vinni wrote:

> Hi all,
>
> Just wondering what is the status of "bluetooth disabled with current
> 2.6.38-rc4"
> from Justin (http://www.spinics.net/lists/linux-bluetooth/msg10745.html 
> ) and
> "[BUG] usb problems in .38-rc3+"" (http://marc.info/?t=129693396800003&r=1&w=2 
> )
> from Ed? (apologies for not being able to reply to those threads)
>
good im not going crazy!!!(thought I was the only one)

> The first one because I think I see the same problem and the second  
> one because
> for me also "hciconfig -a" makes the bluetooth adapter work. Maybe  
> they have
> a common cause.
>
> For me, reverting 23bb57633df ("Bluetooth: Fix __hci_request  
> synchronization
> for hci_open_dev"; suggested by Justin) on top of
> 2.6.38-rc6-166-g493f335 makes everything work as before.
>

thankfully the revert is not that big.. if/when I get time(in the  
process of relocating)
I would not mind going through that commit and plucking things to find  
exactly what's causing
the problem then go from there(if somebody gets to that before, Ill  
gladly supply info and/or test anything
for them!!)

> bluez version and bluetooth adapter model:
>
> [root@koni ~]# pacman -Qo /usr/sbin/bluetoothd
> /usr/sbin/bluetoothd is owned by bluez 4.89-1
> [root@koni ~]# lsusb | grep i.Tech
> Bus 003 Device 002: ID 13dd:0001 i.Tech Dynamic Limited
>
> Part of bluetoothd -d dump below. The printout only really got  
> started when
> I run "hciconfig -a" after 22:01:42 (hciconfig hci0 down and  
> hciconfig hci0 up
> can also be used to make it work):
>
> [root@koni ~]# hciconfig
> hci0:   Type: BR/EDR  Bus: USB
>        BD Address: 00:0D:3C:38:xx:yy  ACL MTU: 384:8  SCO MTU: 64:8
>        UP RUNNING
>        RX bytes:356 acl:0 sco:0 events:13 errors:0
>        TX bytes:53 acl:0 sco:0 commands:13 errors:0
>
> [root@koni ~]# date
> Mon Feb 28 22:01:42 EET 2011
> [root@koni ~]# hciconfig -a
> hci0:   Type: BR/EDR  Bus: USB
>        BD Address: 00:0D:3C:38:xx:yy  ACL MTU: 384:8  SCO MTU: 64:8
>        UP RUNNING
>        RX bytes:356 acl:0 sco:0 events:13 errors:0
>        TX bytes:53 acl:0 sco:0 commands:13 errors:0
>        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>        Packet type: DM1 DH1 HV1
>        Link policy:
>        Link mode: SLAVE ACCEPT
>        Name: 'CSR - bc4'
>        Class: 0x000000
>        Service Classes: Unspecified
>        Device Class: Miscellaneous,
>        HCI Version: 2.0 (0x3)  Revision: 0x7a6
>        LMP Version: 2.0 (0x3)  Subversion: 0x7a6
>        Manufacturer: Cambridge Silicon Radio (10)
>
>
> Feb 28 21:55:39 koni bluetoothd[3256]: src/rfkill.c:rfkill_event()  
> RFKILL event
> idx 0 type 1 op 0 soft 1 hard 0
> Feb 28 21:55:39 koni bluetoothd[3256]: plugins/ 
> hciops.c:init_known_adapters()
> Feb 28 21:56:14 koni blueman-mechanism: Starting blueman-mechanism
> Feb 28 21:56:14 koni kernel: fuse init (API version 7.16)
> Feb 28 21:56:14 koni blueman-mechanism: reload 0 0
> Feb 28 21:56:15 koni kernel: Bluetooth: RFCOMM TTY layer initialized
> Feb 28 21:56:15 koni kernel: Bluetooth: RFCOMM socket layer  
> initialized
> Feb 28 21:56:15 koni kernel: Bluetooth: RFCOMM ver 1.11
> Feb 28 21:56:28 koni kernel: usb 6-1: new full speed USB device  
> using ohci_hcd
> and address 2
> Feb 28 21:56:29 koni kernel: usb 6-1: New USB device found,  
> idVendor=13dd,
> idProduct=0001
> Feb 28 21:56:29 koni kernel: usb 6-1: New USB device strings: Mfr=1,  
> Product=2,
> SerialNumber=0
> Feb 28 21:56:29 koni kernel: usb 6-1: Product: BlueCON U2
> Feb 28 21:56:29 koni kernel: usb 6-1: Manufacturer: i.Tech Dynamic
> Feb 28 21:56:29 koni kernel: Bluetooth: Generic Bluetooth USB driver  
> ver 0.6
> Feb 28 21:56:29 koni bluetoothd[3256]: src/rfkill.c:rfkill_event()  
> RFKILL event
> idx 1 type 2 op 0 soft 0 hard 0
> Feb 28 21:56:29 koni bluetoothd[3256]: HCI dev 0 registered
> Feb 28 21:56:29 koni bluetoothd[3256]: plugins/ 
> hciops.c:init_device() hci0
> Feb 28 21:56:29 koni bluetoothd[3256]: Listening for HCI events on  
> hci0
> Feb 28 21:56:29 koni bluetoothd[3256]: plugins/ 
> hciops.c:init_device() child 3317
> forked
> Feb 28 21:56:29 koni bluetoothd[3256]: src/rfkill.c:rfkill_event()  
> RFKILL event
> idx 1 type 2 op 2 soft 0 hard 0
> Feb 28 21:56:29 koni kernel: usbcore: registered new interface  
> driver btusb
> Feb 28 21:56:29 koni bluetoothd[3256]:
> plugins/hciops.c:read_local_version_complete() Got version for hci0
> Feb 28 21:56:29 koni bluetoothd[3256]: plugins/ 
> hciops.c:read_bd_addr_complete()
> hci0 status 0
> Feb 28 21:56:29 koni bluetoothd[3256]: plugins/ 
> hciops.c:read_bd_addr_complete()
> Got bdaddr for hci0
> Feb 28 21:56:29 koni bluetoothd[3256]:
> plugins/hciops.c:read_local_name_complete() hci0 status 0
> Feb 28 21:56:29 koni bluetoothd[3256]:
> plugins/hciops.c:read_local_name_complete() Got name for hci0
> Feb 28 21:56:29 koni bluetoothd[3256]: plugins/hciops.c:child_exit()  
> child 3317
> exited
> Feb 28 21:56:29 koni bluetoothd[3256]: HCI dev 0 up
> Feb 28 21:56:29 koni bluetoothd[3256]: plugins/ 
> hciops.c:device_devup_setup()
> hci0
> Feb 28 21:56:44 koni blueman-mechanism: Exiting
> Feb 28 22:01:45 koni bluetoothd[3256]:
> plugins/hciops.c:read_local_name_complete() hci0 status 0
> Feb 28 22:01:45 koni bluetoothd[3256]:
> plugins/hciops.c:read_local_name_complete() Got name for hci0
> Feb 28 22:01:45 koni bluetoothd[3256]:
> plugins/hciops.c:read_local_features_complete() Got features for hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: src/adapter.c:btd_adapter_ref()
> 0x7f2d7b862e10: ref=1
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> hciops.c:hciops_read_bdaddr()
> hci0
> Feb 28 22:01:45 koni bluetoothd[3256]:
> plugins/hciops.c:hciops_read_local_version() hci0
> Feb 28 22:01:45 koni bluetoothd[3256]:
> plugins/hciops.c:hciops_read_local_features() hci0
> Feb 28 22:01:45 koni bluetoothd[3256]:
> src/sdpd-database.c:sdp_init_services_list()
>
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> hciops.c:hciops_add_uuid() hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> hciops.c:update_service_classes()
> hci0 value 0
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> hciops.c:hciops_add_uuid() hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> hciops.c:update_service_classes()
> hci0 value 0
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> hciops.c:hciops_add_uuid() hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> hciops.c:update_service_classes()
> hci0 value 16
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> hciops.c:hciops_add_uuid() hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> hciops.c:update_service_classes()
> hci0 value 16
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> service.c:register_interface()
> path /org/bluez/3256/hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: plugins/ 
> service.c:register_interface()
> Registered interface org.bluez.Service on path /org/bluez/3256/hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: network/ 
> manager.c:network_server_probe()
> path /org/bluez/3256/hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: src/adapter.c:btd_adapter_ref()
> 0x7f2d7b862e10: ref=2
> Feb 28 22:01:45 koni bluetoothd[3256]: network/ 
> server.c:server_register()
> Registered interface org.bluez.NetworkServer on path /org/bluez/3256/ 
> hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: serial/ 
> manager.c:proxy_probe() path
> /org/bluez/3256/hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: src/adapter.c:btd_adapter_ref()
> 0x7f2d7b862e10: ref=3
> Feb 28 22:01:45 koni bluetoothd[3256]: serial/proxy.c:proxy_register()
> Registered interface org.bluez.SerialProxyManager on path /org/bluez/ 
> 3256/hci0
> Feb 28 22:01:45 koni bluetoothd[3256]: src/adapter.c:btd_adapter_ref()
> 0x7f2d7b862e10: ref=4
> ...
>
> Mikko
>
>
>

