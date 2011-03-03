Return-Path: <cyrus@holtmann.org>
Message-ID: <574436.88358.qm@web161820.mail.bf1.yahoo.com>
References: <635561.59590.qm@web161820.mail.bf1.yahoo.com> <20110302140055.GA15047@jh-x301>
Date: Thu, 3 Mar 2011 02:54:05 -0800 (PST)
From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: re "bluetooth disabled" and "[BUG] usb problems in .38-rc3+"
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	Ed Tomlinson <edt@aei.ca>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <20110302140055.GA15047@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg:

> 
> I can't reproduce this issue with any of my Bluetooth  adapters (I tested
> with 6 different ones). Could you get us the hcidump of  what happens
> when bluetoothd tries to switch on the adapter for the very  first time?
> Probably you'll need to disable starting of bluetoothd when your  system
> boots so that you have the chance to run hcidump first. Additionally,  if
> possible, could you enable dynamic debug in your kernel and get the  logs
> from hci_core.c and hci_event.c? Typically you'd enable this  with
> something like:
> 
> echo 'file hci_event.c +p' >  /sys/kernel/debug/dynamic_debug/control
> echo 'file hci_core.c +p' >  /sys/kernel/debug/dynamic_debug/control
> 
> Hopefully those logs will give  some better idea of what's going on since
> the logs provided so far aren't  really helpful.
> 

- Compiled the kernel (2.6.38-rc7 now) with dynamic debug
- Commented out the lines to start bluetoothd from /lib/udev/rules.d/
- Killed bluetoothd
- rmmod'ed all bluetooth modules and then modprobe'd rfcomm (which pulls
in all the others) (this resets the situation so that the bug appears -
when unplugging and plugging the adapter in the working state it keeps
on working)
- enabled dynamic debug for hci_core.c, hci_event.c, and rfcomm/core.c
- plugged in the bluetooth adapter
- hcidump -w hcidump_ddebug (parsed version below)
- bluetoothd -d
- run hciconfig (without parameters) a couple of times
- waited some minutes
- run hciconfig -a (around 08:18:37 in the logs)
- adapter led starts blinking (and e.g. blueman-applet sees it)
- messages from syslog further below

Do these help?

The commit we tried to revert (23bb57633df) changes when processes
are woken up. Is there any command which would show if some process
is waiting for a wake up?


Mikko


HCI sniffer - Bluetooth packet analyzer ver 2.0
btsnoop version: 1 datalink type: 1002
2011-03-03 08:14:38.386728 < HCI Command: Reset (0x03|0x0003) plen 0
2011-03-03 08:14:38.386759 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2011-03-03 08:14:38.386810 < HCI Command: Read Local Supported Features 
(0x04|0x0003) plen 0
2011-03-03 08:14:38.524768 > HCI Event: Command Complete (0x0e) plen 4
    Reset (0x03|0x0003) ncmd 1
    status 0x00
2011-03-03 08:14:38.524819 < HCI Command: Read Local Version Information 
(0x04|0x0001) plen 0
2011-03-03 08:14:38.528758 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 2.0 (0x3) HCI Revision: 0x7a6
    LMP Version: 2.0 (0x3) LMP Subversion: 0x7a6
    Manufacturer: Cambridge Silicon Radio (10)
2011-03-03 08:14:38.528806 < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
2011-03-03 08:14:38.532764 > HCI Event: Command Complete (0x0e) plen 11
    Read Buffer Size (0x04|0x0005) ncmd 1
    status 0x00
    ACL MTU 384:8 SCO MTU 64:8
2011-03-03 08:14:38.532822 < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
2011-03-03 08:14:38.535758 > HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 1
    status 0x00 bdaddr 00:0D:3C:38:FA:B5
2011-03-03 08:14:38.535820 < HCI Command: Read Class of Device (0x03|0x0023) 
plen 0
2011-03-03 08:14:38.538765 > HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x000000
2011-03-03 08:14:38.538818 < HCI Command: Read Local Name (0x03|0x0014) plen 0
2011-03-03 08:14:38.573755 > HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'CSR - bc4'
2011-03-03 08:14:38.573808 < HCI Command: Read Voice Setting (0x03|0x0025) plen 
0
2011-03-03 08:14:38.576766 > HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
2011-03-03 08:14:38.576828 < HCI Command: Set Event Filter (0x03|0x0005) plen 1
    type 0 condition 0
    Clear all filters
2011-03-03 08:14:38.579757 > HCI Event: Command Complete (0x0e) plen 4
    Set Event Filter (0x03|0x0005) ncmd 1
    status 0x00
2011-03-03 08:14:38.579802 < HCI Command: Write Page Timeout (0x03|0x0018) plen 
2
    timeout 32768
2011-03-03 08:14:38.582766 > HCI Event: Command Complete (0x0e) plen 4
    Write Page Timeout (0x03|0x0018) ncmd 1
    status 0x00
2011-03-03 08:14:38.582829 < HCI Command: Write Connection Accept Timeout 
(0x03|0x0016) plen 2
    timeout 32000
2011-03-03 08:14:38.585770 > HCI Event: Command Complete (0x0e) plen 4
    Write Connection Accept Timeout (0x03|0x0016) ncmd 1
    status 0x00
2011-03-03 08:14:38.586767 < HCI Command: Write Page Timeout (0x03|0x0018) plen 
2
    timeout 8192
2011-03-03 08:14:38.589774 > HCI Event: Command Complete (0x0e) plen 4
    Write Page Timeout (0x03|0x0018) ncmd 1
    status 0x00
2011-03-03 08:14:38.589820 < HCI Command: Read Stored Link Key (0x03|0x000d) 
plen 7
    bdaddr 00:00:00:00:00:00 all 1
2011-03-03 08:14:38.593763 > HCI Event: Command Complete (0x0e) plen 8
    Read Stored Link Key (0x03|0x000d) ncmd 1
    status 0x00 max 16 num 0
2011-03-03 08:18:37.515128 < HCI Command: Read Local Name (0x03|0x0014) plen 0
2011-03-03 08:18:37.566070 > HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'CSR - bc4'
2011-03-03 08:18:37.566326 < HCI Command: Read Local Supported Features 
(0x04|0x0003) plen 0
2011-03-03 08:18:37.569055 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 1
    status 0x00
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
2011-03-03 08:18:37.569121 < HCI Command: Read Class of Device (0x03|0x0023) 
plen 0
2011-03-03 08:18:37.572061 > HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x000000
2011-03-03 08:18:37.572532 < HCI Command: Read Local Version Information 
(0x04|0x0001) plen 0
2011-03-03 08:18:37.576057 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 2.0 (0x3) HCI Revision: 0x7a6
    LMP Version: 2.0 (0x3) LMP Subversion: 0x7a6
    Manufacturer: Cambridge Silicon Radio (10)
2011-03-03 08:18:37.618553 < HCI Command: Set Event Mask (0x03|0x0001) plen 8
    Mask: 0xfffffbff07180000
2011-03-03 08:18:37.621056 > HCI Event: Command Complete (0x0e) plen 4
    Set Event Mask (0x03|0x0001) ncmd 1
    status 0x00
...

syslog:
...
Mar  3 08:13:17 koni kernel: usb 6-1: new full speed USB device using ohci_hcd 
and address 2
Mar  3 08:13:17 koni kernel: usb 6-1: New USB device found, idVendor=13dd, 
idProduct=0001
Mar  3 08:13:17 koni kernel: usb 6-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
Mar  3 08:13:17 koni kernel: usb 6-1: Product: BlueCON U2
Mar  3 08:13:17 koni kernel: usb 6-1: Manufacturer: i.Tech Dynamic
Mar  3 08:13:17 koni kernel: Bluetooth: Generic Bluetooth USB driver ver 0.6
Mar  3 08:13:17 koni kernel: hci_register_dev: ffff88013c6b1000 name  bus 1 
owner ffffffffa038b7c0
Mar  3 08:13:17 koni kernel: hci_rfkill_set_block: ffff88013c6b1000 name hci0 
blocked 0
Mar  3 08:13:17 koni kernel: usbcore: registered new interface driver btusb
Mar  3 08:13:31 koni kernel: hci_dev_get: 0
Mar  3 08:13:37 koni kernel: hci_dev_get: 0
Mar  3 08:13:39 koni -- MARK --
Mar  3 08:14:04 koni kernel: hci_dev_get: 0
Mar  3 08:14:04 koni kernel: hci_dev_get: 0
Mar  3 08:14:04 koni kernel: hci_dev_get: 0
Mar  3 08:14:26 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni bluetoothd[3270]: Bluetooth deamon 4.89
Mar  3 08:14:38 koni bluetoothd[3270]: src/main.c:parse_config() parsing 
main.conf
Mar  3 08:14:38 koni bluetoothd[3270]: src/main.c:parse_config() discovto=0
Mar  3 08:14:38 koni bluetoothd[3270]: src/main.c:parse_config() pairto=0
Mar  3 08:14:38 koni bluetoothd[3270]: src/main.c:parse_config() pageto=8192
Mar  3 08:14:38 koni bluetoothd[3270]: src/main.c:parse_config() name=%h-%d
Mar  3 08:14:38 koni bluetoothd[3270]: src/main.c:parse_config() class=0x000100
Mar  3 08:14:38 koni bluetoothd[3270]: src/main.c:parse_config() 
discov_interval=0
Mar  3 08:14:38 koni bluetoothd[3270]: src/main.c:parse_config() Key file does 
not have key 'DeviceID'
Mar  3 08:14:38 koni bluetoothd[3270]: Starting SDP server
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:plugin_init() Loading 
builtin plugins
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:add_plugin() Loading audio 
plugin
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:add_plugin() Loading input 
plugin
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:add_plugin() Loading serial 
plugin
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:add_plugin() Loading network 
plugin
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:add_plugin() Loading service 
plugin
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:add_plugin() Loading hciops 
plugin
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:add_plugin() Loading mgmtops 
plugin
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:add_plugin() Loading 
formfactor plugin
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:add_plugin() Loading storage 
plugin
Mar  3 08:14:38 koni bluetoothd[3270]: src/plugin.c:plugin_init() Loading 
plugins /usr/lib/bluetooth/plugins
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/service.c:register_interface() 
path /org/bluez/3270/any
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/service.c:register_interface() 
Registered interface org.bluez.Service on path /org/bluez/3270/any
Mar  3 08:14:38 koni bluetoothd[3270]: network/manager.c:read_config() 
/etc/bluetooth/network.conf: Key file does not have key 'DisableSecurity'
Mar  3 08:14:38 koni bluetoothd[3270]: network/manager.c:read_config() Config 
options: Security=true
Mar  3 08:14:38 koni bluetoothd[3270]: input/manager.c:input_manager_init() 
input.conf: Key file does not have key 'IdleTimeout'
Mar  3 08:14:38 koni kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Mar  3 08:14:38 koni bluetoothd[3270]: audio/manager.c:audio_manager_init() 
audio.conf: Key file does not have key 'AutoConnect'
Mar  3 08:14:38 koni bluetoothd[3270]: audio/unix.c:unix_init() Unix socket 
created: 8
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/hciops.c:hciops_init() 
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/hciops.c:hciops_setup() 
Mar  3 08:14:38 koni bluetoothd[3270]: src/main.c:main() Entering main loop
Mar  3 08:14:38 koni bluetoothd[3270]: src/rfkill.c:rfkill_event() RFKILL event 
idx 0 type 1 op 0 soft 0 hard 0
Mar  3 08:14:38 koni bluetoothd[3270]: src/rfkill.c:rfkill_event() RFKILL event 
idx 5 type 2 op 0 soft 0 hard 0
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/hciops.c:init_known_adapters() 
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/hciops.c:init_device() hci0
Mar  3 08:14:38 koni bluetoothd[3270]: Listening for HCI events on hci0
Mar  3 08:14:38 koni kernel: hci_register_proto: ffffffffa057b000 name SCO id 1
Mar  3 08:14:38 koni kernel: Bluetooth: SCO (Voice Link) ver 0.6
Mar  3 08:14:38 koni kernel: Bluetooth: SCO socket layer initialized
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/hciops.c:init_device() child 3275 
forked
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_dev_open: hci0 ffff88013c6b1000
Mar  3 08:14:38 koni kernel: __hci_request: hci0 start
Mar  3 08:14:38 koni kernel: hci_init_req: hci0 0
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0xc03 plen 0
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 3
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0x1003 plen 0
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 3
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0x1001 plen 0
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 3
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0x1005 plen 0
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 3
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0x1009 plen 0
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 3
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0xc23 plen 0
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 3
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0xc14 plen 0
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 3
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0xc25 plen 0
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 3
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0xc05 plen 1
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 4
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0xc18 plen 2
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 5
Mar  3 08:14:38 koni kernel: hci_send_cmd: hci0 opcode 0xc16 plen 2
Mar  3 08:14:38 koni kernel: hci_send_cmd: skb len 5
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cmd_status_evt: hci0 opcode 0x0
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cc_reset: hci0 status 0x0
Mar  3 08:14:38 koni kernel: hci_req_complete: hci0 command 0x0c03 result 0x00 
(last cmd 0x0c16)
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cc_read_local_version: hci0 status 0x0
Mar  3 08:14:38 koni kernel: hci_cc_read_local_version: hci0 manufacturer 10 hci 
ver 3:1958
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni bluetoothd[3270]: 
plugins/hciops.c:read_local_version_complete() Got version for hci0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cc_read_buffer_size: hci0 status 0x0
Mar  3 08:14:38 koni kernel: hci_cc_read_buffer_size: hci0 acl mtu 384:8 sco mtu 
64:8
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/hciops.c:read_bd_addr_complete() 
hci0 status 0
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/hciops.c:read_bd_addr_complete() 
Got bdaddr for hci0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cc_read_bd_addr: hci0 status 0x0
Mar  3 08:14:38 koni kernel: hci_req_complete: hci0 command 0x1009 result 0x00 
(last cmd 0x0c16)
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cc_read_class_of_dev: hci0 status 0x0
Mar  3 08:14:38 koni kernel: hci_cc_read_class_of_dev: hci0 class 0x000000
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni bluetoothd[3270]: 
plugins/hciops.c:read_local_name_complete() hci0 status 0
Mar  3 08:14:38 koni bluetoothd[3270]: 
plugins/hciops.c:read_local_name_complete() Got name for hci0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cc_read_local_name: hci0 status 0x0
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cc_read_voice_setting: hci0 status 0x0
Mar  3 08:14:38 koni kernel: hci_cc_read_voice_setting: hci0 voice setting 
0x0060
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 4
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cmd_complete_evt: hci0 opcode 0xc05
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 5
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cmd_complete_evt: hci0 opcode 0xc18
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 5
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cc_write_ca_timeout: hci0 status 0x0
Mar  3 08:14:38 koni kernel: hci_req_complete: hci0 command 0x0c16 result 0x00 
(last cmd 0x0c16)
Mar  3 08:14:38 koni kernel: __hci_request: hci0 end: err 0
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/hciops.c:child_exit() child 3275 
exited
Mar  3 08:14:38 koni bluetoothd[3270]: HCI dev 0 up
Mar  3 08:14:38 koni bluetoothd[3270]: plugins/hciops.c:device_devup_setup() 
hci0
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 5
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 0
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cmd_complete_evt: hci0 opcode 0xc18
Mar  3 08:14:38 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:14:38 koni kernel: hci_send_frame: hci0 type 1 len 10
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:14:38 koni kernel: hci_rx_task: hci0
Mar  3 08:14:38 koni kernel: hci_cmd_complete_evt: hci0 opcode 0xc0d
Mar  3 08:14:38 koni kernel: hci_dev_get: 0
Mar  3 08:18:31 koni kernel: hci_dev_get: 0
Mar  3 08:18:37 koni kernel: hci_dev_get: 0
Mar  3 08:18:37 koni kernel: hci_dev_get: 0
Mar  3 08:18:37 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:18:37 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:18:37 koni bluetoothd[3270]: 
plugins/hciops.c:read_local_name_complete() hci0 status 0
Mar  3 08:18:37 koni bluetoothd[3270]: 
plugins/hciops.c:read_local_name_complete() Got name for hci0
Mar  3 08:18:37 koni kernel: hci_rx_task: hci0
Mar  3 08:18:37 koni kernel: hci_cc_read_local_name: hci0 status 0x0
Mar  3 08:18:37 koni kernel: hci_dev_get: 0
Mar  3 08:18:37 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:18:37 koni kernel: hci_dev_get: 0
Mar  3 08:18:37 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:18:37 koni kernel: hci_cmd_task: hci0 cmd 0
Mar  3 08:18:37 koni bluetoothd[3270]: 
plugins/hciops.c:read_local_features_complete() Got features for hci0
Mar  3 08:18:37 koni bluetoothd[3270]: src/adapter.c:btd_adapter_ref() 
0x7f84c3257950: ref=1
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_read_bdaddr() 
hci0
Mar  3 08:18:37 koni bluetoothd[3270]: 
plugins/hciops.c:hciops_read_local_version() hci0
Mar  3 08:18:37 koni bluetoothd[3270]: 
plugins/hciops.c:hciops_read_local_features() hci0
Mar  3 08:18:37 koni bluetoothd[3270]: 
src/sdpd-database.c:sdp_init_services_list() 

Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_add_uuid() hci0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:update_service_classes() 
hci0 value 0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_add_uuid() hci0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:update_service_classes() 
hci0 value 0
Mar  3 08:18:37 koni kernel: hci_rx_task: hci0
Mar  3 08:18:37 koni kernel: hci_cc_read_local_features: hci0 status 0x0
Mar  3 08:18:37 koni kernel: hci_cc_read_local_features: hci0 features 
0xffff8ffe9bf90080
Mar  3 08:18:37 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:18:37 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:18:37 koni kernel: hci_dev_get: 0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/service.c:register_interface() 
path /org/bluez/3270/hci0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/service.c:register_interface() 
Registered interface org.bluez.Service on path /org/bluez/3270/hci0
Mar  3 08:18:37 koni bluetoothd[3270]: network/manager.c:network_server_probe() 
path /org/bluez/3270/hci0
Mar  3 08:18:37 koni bluetoothd[3270]: src/adapter.c:btd_adapter_ref() 
0x7f84c3257950: ref=2
Mar  3 08:18:37 koni bluetoothd[3270]: network/server.c:server_register() 
Registered interface org.bluez.NetworkServer on path /org/bluez/3270/hci0
Mar  3 08:18:37 koni bluetoothd[3270]: serial/manager.c:proxy_probe() path 
/org/bluez/3270/hci0
Mar  3 08:18:37 koni bluetoothd[3270]: src/adapter.c:btd_adapter_ref() 
0x7f84c3257950: ref=3
Mar  3 08:18:37 koni bluetoothd[3270]: serial/proxy.c:proxy_register() 
Registered interface org.bluez.SerialProxyManager on path /org/bluez/3270/hci0
Mar  3 08:18:37 koni bluetoothd[3270]: src/adapter.c:btd_adapter_ref() 
0x7f84c3257950: ref=4
Mar  3 08:18:37 koni bluetoothd[3270]: audio/manager.c:headset_server_probe() 
path /org/bluez/3270/hci0
Mar  3 08:18:37 koni bluetoothd[3270]: src/adapter.c:btd_adapter_ref() 
0x7f84c3257950: ref=5
Mar  3 08:18:37 koni bluetoothd[3270]: audio/manager.c:audio_adapter_ref() 
0x7f84c3258000: ref=1
Mar  3 08:18:37 koni bluetoothd[3270]: audio/manager.c:headset_server_init() 
audio.conf: Key file does not have key 'Master'
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Adding record with handle 0x10000
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_add_uuid() hci0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:update_service_classes() 
hci0 value 0
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000003-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000100-0000-1000-8000-00805f9
Mar  3 08:18:37 koni kernel: rfcomm_dlc_clear_state: ffff88013ad69100
Mar  3 08:18:37 koni kernel: rfcomm_dlc_alloc: ffff88013ad69100
Mar  3 08:18:37 koni kernel: hci_rx_task: hci0
Mar  3 08:18:37 koni kernel: hci_cc_read_class_of_dev: hci0 status 0x0
Mar  3 08:18:37 koni kernel: hci_cc_read_class_of_dev: hci0 class 0x000000
Mar  3 08:18:37 koni kernel: hci_dev_get: 0
Mar  3 08:18:37 koni kernel: hci_cmd_task: hci0 cmd 1
Mar  3 08:18:37 koni kernel: hci_send_frame: hci0 type 1 len 3
Mar  3 08:18:37 koni kernel: rfcomm_dlc_clear_state: ffff88013c50c200
Mar  3 08:18:37 koni kernel: rfcomm_dlc_alloc: ffff88013c50c200
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00001002-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00001108-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00001112-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00001203-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: audio/headset.c:headset_config_init() 
audio.conf: Key file does not have key 'SCORouting'
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Adding record with handle 0x10001
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_add_uuid() hci0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:update_service_classes() 
hci0 value 64
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000003-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000100-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00001002-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 0000111e-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 0000111f-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00001203-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: audio/manager.c:state_changed() 
/org/bluez/3270/hci0 powered on
Mar  3 08:18:37 koni bluetoothd[3270]: audio/telephony.c:telephony_init() 
Mar  3 08:18:37 koni bluetoothd[3270]: audio/headset.c:telephony_ready_ind() 
Telephony plugin initialized
Mar  3 08:18:37 koni bluetoothd[3270]: audio/headset.c:print_ag_features() HFP 
AG features: "Ability to reject a call" "Enhanced call status" "Extended Error 
Result Codes" 

Mar  3 08:18:37 koni bluetoothd[3270]: audio/manager.c:a2dp_server_probe() path 
/org/bluez/3270/hci0
Mar  3 08:18:37 koni bluetoothd[3270]: audio/manager.c:audio_adapter_ref() 
0x7f84c3258000: ref=2
Mar  3 08:18:37 koni bluetoothd[3270]: audio/a2dp.c:a2dp_register() audio.conf: 
Key file does not have key 'Enable'
Mar  3 08:18:37 koni bluetoothd[3270]: audio/a2dp.c:a2dp_register() audio.conf: 
Key file does not have key 'Disable'
Mar  3 08:18:37 koni bluetoothd[3270]: audio/a2dp.c:a2dp_register() audio.conf: 
Key file does not have group 'A2DP'
Mar  3 08:18:37 koni bluetoothd[3270]: audio/a2dp.c:a2dp_register() audio.conf: 
Key file does not have group 'A2DP'
Mar  3 08:18:37 koni bluetoothd[3270]: audio/a2dp.c:a2dp_register() audio.conf: 
Key file does not have group 'A2DP'
Mar  3 08:18:37 koni bluetoothd[3270]: audio/a2dp.c:a2dp_register() audio.conf: 
Key file does not have group 'A2DP'
Mar  3 08:18:37 koni bluetoothd[3270]: audio/avdtp.c:avdtp_init() audio.conf: 
Key file does not have key 'Master'
Mar  3 08:18:37 koni bluetoothd[3270]: audio/avdtp.c:avdtp_register_sep() SEP 
0x7f84c3259ad0 registered: type:0 codec:0 seid:1
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Adding record with handle 0x10002
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_add_uuid() hci0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:update_service_classes() 
hci0 value 72
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000019-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000100-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00001002-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 0000110a-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 0000110d-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: audio/manager.c:avrcp_server_probe() path 
/org/bluez/3270/hci0
Mar  3 08:18:37 koni bluetoothd[3270]: audio/manager.c:audio_adapter_ref() 
0x7f84c3258000: ref=3
Mar  3 08:18:37 koni bluetoothd[3270]: audio/control.c:avrcp_register() 
audio.conf: Key file does not have key 'Master'
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Adding record with handle 0x10003
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_add_uuid() hci0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:update_service_classes() 
hci0 value 72
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000017-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000100-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00001002-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 0000110c-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 0000110e-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Adding record with handle 0x10004
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_add_uuid() hci0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:update_service_classes() 
hci0 value 72
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000017-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00000100-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 00001002-0000-1000-8000-00805f9
Mar  3 08:18:37 koni bluetoothd[3270]: src/sdpd-service.c:add_record_to_server() 
Record pattern UUID 0000110e-0000-1000-8000-00805f9
Mar  3 08:18:37 koni kernel: hci_rx_task: hci0
Mar  3 08:18:37 koni kernel: hci_cc_read_local_version: hci0 status 0x0
Mar  3 08:18:37 koni kernel: hci_cc_read_local_version: hci0 manufacturer 10 hci 
ver 3:1958
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/formfactor.c:formfactor_probe() 
Setting 0x000100 for major/minor device class
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_set_dev_class() 
hci0 major 1 minor 0
Mar  3 08:18:37 koni bluetoothd[3270]: plugins/hciops.c:hciops_unblock_device() 
hci0 dba 00:00:00:00:00:00
Mar  3 08:18:37 koni bluetoothd[3270]: src/device.c:device_create() Creating 
device /org/bluez/3270/hci0/dev_00_11_24_68_xx_yy
Mar  3 08:18:37 koni bluetoothd[3270]: src/device.c:btd_device_ref() 
0x7f84c3280fc0: ref=1
Mar  3 08:18:37 koni bluetoothd[3270]: src/device.c:device_set_temporary() 
temporary 0
Mar  3 08:18:37 koni bluetoothd[3270]: src/device.c:device_probe_drivers() 
Probing drivers for 00:11:24:68:xx:yy
... (a lot of bluetooth stuff, all only after hciconfig -a)


      
