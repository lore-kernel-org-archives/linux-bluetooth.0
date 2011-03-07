Return-Path: <cyrus@holtmann.org>
Message-ID: <359639.21781.qm@web161807.mail.bf1.yahoo.com>
References: <635561.59590.qm@web161820.mail.bf1.yahoo.com> <20110302140055.GA15047@jh-x301> <574436.88358.qm@web161820.mail.bf1.yahoo.com> <20110303143154.GA2342@jh-x301>
Date: Mon, 7 Mar 2011 11:50:25 -0800 (PST)
From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: re "bluetooth disabled" and "[BUG] usb problems in .38-rc3+"
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	Ed Tomlinson <edt@aei.ca>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <20110303143154.GA2342@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Johan Hedberg wrote:

> In any case what's happening is  that there's never a command complete
> for the local features. This is one of  those commands that user space
> tracks to determine that the adapter is  initialized so if it never comes
> the adapter remains uninitialized from a  bluetoothd perspective. There
> is supposed to be some work-around code in  bluetoothd for this kind of
> situations, but due to the patch you found in the  kernel the code
> doesn't get triggered since the "up" flag is not set when the  situation
> happens. The patch I've attached removed this check for the flag.  Could
> you try and see if it helps?


I compiled bluez 4.89-71-gdc920af from git, which seems to contain the
patch that was as an attachment (9bae9813abf29344cc3d84af2ee59efd9e9e78fc).

It sometimes helps, but not always. Maybe there are some alternative code
paths, races, or something. Below some logs for a case when it doesn't
help. Also, it doesn't seem to work when bluetoothd is started before
plugging in the adapter or if the adapter is unplugged and replugged.

adapter in; start hcidump; start self-compiled bluetoothd

hcidump log ("hcidump -a" ran around 21.27.30):

HCI sniffer - Bluetooth packet analyzer ver 2.0
btsnoop version: 1 datalink type: 1002
2011-03-07 21:27:08.891188 < HCI Command: Reset (0x03|0x0003) plen 0
2011-03-07 21:27:08.891722 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2011-03-07 21:27:08.891747 < HCI Command: Read Local Supported Features 
(0x04|0x0003) plen 0
2011-03-07 21:27:09.029713 > HCI Event: Command Complete (0x0e) plen 4
    Reset (0x03|0x0003) ncmd 1
    status 0x00
2011-03-07 21:27:09.029785 < HCI Command: Read Local Version Information 
(0x04|0x0001) plen 0
2011-03-07 21:27:09.033720 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 2.0 (0x3) HCI Revision: 0x7a6
    LMP Version: 2.0 (0x3) LMP Subversion: 0x7a6
    Manufacturer: Cambridge Silicon Radio (10)
2011-03-07 21:27:09.033767 < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
2011-03-07 21:27:09.037700 > HCI Event: Command Complete (0x0e) plen 11
    Read Buffer Size (0x04|0x0005) ncmd 1
    status 0x00
    ACL MTU 384:8 SCO MTU 64:8
2011-03-07 21:27:09.037726 < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
2011-03-07 21:27:09.040717 > HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 1
    status 0x00 bdaddr 00:0D:3C:38:FA:B5
2011-03-07 21:27:09.040756 < HCI Command: Read Class of Device (0x03|0x0023) 
plen 0
2011-03-07 21:27:09.043704 > HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x000000
2011-03-07 21:27:09.043741 < HCI Command: Read Local Name (0x03|0x0014) plen 0
2011-03-07 21:27:09.078711 > HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'CSR - bc4'
2011-03-07 21:27:09.078749 < HCI Command: Read Voice Setting (0x03|0x0025) plen 
0
2011-03-07 21:27:09.081733 > HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
2011-03-07 21:27:09.081764 < HCI Command: Set Event Filter (0x03|0x0005) plen 1
    type 0 condition 0
    Clear all filters
2011-03-07 21:27:09.084712 > HCI Event: Command Complete (0x0e) plen 4
    Set Event Filter (0x03|0x0005) ncmd 1
    status 0x00
2011-03-07 21:27:09.084738 < HCI Command: Write Page Timeout (0x03|0x0018) plen 
2
    timeout 32768
2011-03-07 21:27:09.087703 > HCI Event: Command Complete (0x0e) plen 4
    Write Page Timeout (0x03|0x0018) ncmd 1
    status 0x00
2011-03-07 21:27:09.087726 < HCI Command: Write Connection Accept Timeout 
(0x03|0x0016) plen 2
    timeout 32000
2011-03-07 21:27:09.090699 > HCI Event: Command Complete (0x0e) plen 4
    Write Connection Accept Timeout (0x03|0x0016) ncmd 1
    status 0x00
2011-03-07 21:27:09.091818 < HCI Command: Write Page Timeout (0x03|0x0018) plen 
2
    timeout 8192
2011-03-07 21:27:09.094704 > HCI Event: Command Complete (0x0e) plen 4
    Write Page Timeout (0x03|0x0018) ncmd 1
    status 0x00
2011-03-07 21:27:09.094758 < HCI Command: Read Stored Link Key (0x03|0x000d) 
plen 7
    bdaddr 00:00:00:00:00:00 all 1
2011-03-07 21:27:09.098714 > HCI Event: Command Complete (0x0e) plen 8
    Read Stored Link Key (0x03|0x000d) ncmd 1
    status 0x00 max 16 num 0
2011-03-07 21:27:33.036962 < HCI Command: Read Local Name (0x03|0x0014) plen 0
2011-03-07 21:27:33.088144 > HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'CSR - bc4'
2011-03-07 21:27:33.088386 < HCI Command: Read Class of Device (0x03|0x0023) 
plen 0
2011-03-07 21:27:33.091152 > HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x000000
2011-03-07 21:27:33.091181 < HCI Command: Read Local Supported Features 
(0x04|0x0003) plen 0
2011-03-07 21:27:33.094151 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 1
    status 0x00
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
2011-03-07 21:27:33.094175 < HCI Command: Read Local Version Information 
(0x04|0x0001) plen 0
2011-03-07 21:27:33.098150 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 2.0 (0x3) HCI Revision: 0x7a6
    LMP Version: 2.0 (0x3) LMP Subversion: 0x7a6
    Manufacturer: Cambridge Silicon Radio (10)
2011-03-07 21:27:33.150368 < HCI Command: Set Event Mask (0x03|0x0001) plen 8
    Mask: 0xfffffbff07180000
2011-03-07 21:27:33.153142 > HCI Event: Command Complete (0x0e) plen 4
    Set Event Mask (0x03|0x0001) ncmd 1
    status 0x00
2011-03-07 21:27:33.153176 < HCI Command: Write Inquiry Mode (0x03|0x0045) plen 
1
    mode 1
2011-03-07 21:27:33.156136 > HCI Event: Command Complete (0x0e) plen 4
    Write Inquiry Mode (0x03|0x0045) ncmd 1
    status 0x00
2011-03-07 21:27:33.156168 < HCI Command: Write Default Link Policy Settings 
(0x02|0x000f) plen 2
    policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
2011-03-07 21:27:33.159136 > HCI Event: Command Complete (0x0e) plen 4
    Write Default Link Policy Settings (0x02|0x000f) ncmd 1
    status 0x00
2011-03-07 21:27:33.159163 < HCI Command: Write Local Name (0x03|0x0013) plen 
248
    name 'koni-0'
2011-03-07 21:27:33.162140 > HCI Event: Command Complete (0x0e) plen 4
    Write Local Name (0x03|0x0013) ncmd 1
    status 0x00
2011-03-07 21:27:33.162167 < HCI Command: Write Class of Device (0x03|0x0024) 
plen 3
    class 0x480100
2011-03-07 21:27:33.165143 > HCI Event: Command Complete (0x0e) plen 4
    Write Class of Device (0x03|0x0024) ncmd 1
    status 0x00
2011-03-07 21:27:33.165180 < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 3
2011-03-07 21:27:33.169143 > HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
2011-03-07 21:27:33.169175 < HCI Command: Read Local Name (0x03|0x0014) plen 0
2011-03-07 21:27:33.190186 > HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'koni-0'
2011-03-07 21:27:33.190246 < HCI Command: Read Scan Enable (0x03|0x0019) plen 0
2011-03-07 21:27:33.193155 > HCI Event: Command Complete (0x0e) plen 5
    Read Scan Enable (0x03|0x0019) ncmd 1
    status 0x00 enable 3
2011-03-07 21:27:50.114574 < HCI Command: Reset (0x03|0x0003) plen 0

syslog:

Mar  7 21:26:47 koni kernel: usb 5-3: New USB device found, idVendor=13dd, 
idProduct=0001
Mar  7 21:26:47 koni kernel: usb 5-3: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
Mar  7 21:26:47 koni kernel: usb 5-3: Product: BlueCON U2
Mar  7 21:26:47 koni kernel: usb 5-3: Manufacturer: i.Tech Dynamic
Mar  7 21:27:08 koni bluetoothd[18369]: Bluetooth deamon 4.89
Mar  7 21:27:08 koni bluetoothd[18369]: src/main.c:parse_config() parsing 
main.conf
Mar  7 21:27:08 koni bluetoothd[18369]: src/main.c:parse_config() discovto=0
Mar  7 21:27:08 koni bluetoothd[18369]: src/main.c:parse_config() pairto=0
Mar  7 21:27:08 koni bluetoothd[18369]: src/main.c:parse_config() pageto=8192
Mar  7 21:27:08 koni bluetoothd[18369]: src/main.c:parse_config() name=%h-%d
Mar  7 21:27:08 koni bluetoothd[18369]: src/main.c:parse_config() class=0x000100
Mar  7 21:27:08 koni bluetoothd[18369]: src/main.c:parse_config() 
discov_interval=0
Mar  7 21:27:08 koni bluetoothd[18369]: src/main.c:parse_config() Key file does 
not have key 'DeviceID'
Mar  7 21:27:08 koni bluetoothd[18369]: Starting SDP server
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:plugin_init() Loading 
builtin plugins
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading audio 
plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading input 
plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading serial 
plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading 
network plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading 
service plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading attrib 
plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading health 
plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading hciops 
plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading 
mgmtops plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading 
formfactor plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:add_plugin() Loading 
storage plugin
Mar  7 21:27:08 koni bluetoothd[18369]: src/plugin.c:plugin_init() Loading 
plugins /usr/lib/bluetooth/plugins
Mar  7 21:27:08 koni bluetoothd[18369]: plugins/service.c:register_interface() 
path /org/bluez/18369/any
Mar  7 21:27:08 koni bluetoothd[18369]: plugins/service.c:register_interface() 
Registered interface org.bluez.Service on path /org/bluez/18369/any
Mar  7 21:27:08 koni bluetoothd[18369]: health/hdp.c:hdp_manager_start() 
Starting Health manager
Mar  7 21:27:08 koni bluetoothd[18369]: network/manager.c:read_config() 
/etc/bluetooth/network.conf: Key file does not have key 'DisableSecurity'
Mar  7 21:27:08 koni bluetoothd[18369]: network/manager.c:read_config() Config 
options: Security=true
Mar  7 21:27:08 koni bluetoothd[18369]: input/manager.c:input_manager_init() 
input.conf: Key file does not have key 'IdleTimeout'
Mar  7 21:27:08 koni bluetoothd[18369]: audio/manager.c:audio_manager_init() 
audio.conf: Key file does not have key 'AutoConnect'
Mar  7 21:27:08 koni bluetoothd[18369]: audio/unix.c:unix_init() Unix socket 
created: 8
Mar  7 21:27:08 koni bluetoothd[18369]: plugins/hciops.c:hciops_init() 
Mar  7 21:27:08 koni bluetoothd[18369]: plugins/hciops.c:hciops_setup() 
Mar  7 21:27:08 koni bluetoothd[18369]: src/main.c:main() Entering main loop
Mar  7 21:27:08 koni kernel: Bluetooth: SCO (Voice Link) ver 0.6
Mar  7 21:27:08 koni kernel: Bluetooth: SCO socket layer initialized
Mar  7 21:27:08 koni bluetoothd[18369]: src/rfkill.c:rfkill_event() RFKILL event 
idx 0 type 1 op 0 soft 0 hard 0
Mar  7 21:27:08 koni bluetoothd[18369]: src/rfkill.c:rfkill_event() RFKILL event 
idx 16 type 2 op 0 soft 0 hard 0
Mar  7 21:27:08 koni bluetoothd[18369]: plugins/hciops.c:init_known_adapters() 
Mar  7 21:27:08 koni bluetoothd[18369]: plugins/hciops.c:init_device() hci0
Mar  7 21:27:08 koni bluetoothd[18369]: Listening for HCI events on hci0
Mar  7 21:27:08 koni bluetoothd[18369]: plugins/hciops.c:init_device() child 
18372 forked
Mar  7 21:27:09 koni bluetoothd[18369]: 
plugins/hciops.c:read_local_version_complete() Got version for hci0
Mar  7 21:27:09 koni bluetoothd[18369]: plugins/hciops.c:read_bd_addr_complete() 
hci0 status 0
Mar  7 21:27:09 koni bluetoothd[18369]: plugins/hciops.c:read_bd_addr_complete() 
Got bdaddr for hci0
Mar  7 21:27:09 koni bluetoothd[18369]: 
plugins/hciops.c:read_local_name_complete() hci0 status 0
Mar  7 21:27:09 koni bluetoothd[18369]: 
plugins/hciops.c:read_local_name_complete() Got name for hci0
Mar  7 21:27:09 koni bluetoothd[18369]: plugins/hciops.c:child_exit() child 
18372 exited
Mar  7 21:27:09 koni bluetoothd[18369]: HCI dev 0 up
Mar  7 21:27:09 koni bluetoothd[18369]: plugins/hciops.c:device_devup_setup() 
hci0
Mar  7 21:27:33 koni bluetoothd[18369]: 
plugins/hciops.c:read_local_name_complete() hci0 status 0
Mar  7 21:27:33 koni bluetoothd[18369]: 
plugins/hciops.c:read_local_name_complete() Got name for hci0
Mar  7 21:27:33 koni bluetoothd[18369]: 
plugins/hciops.c:read_local_features_complete() Got features for hci0
Mar  7 21:27:33 koni bluetoothd[18369]: src/adapter.c:btd_adapter_ref() 
0x7f28f49b3800: ref=1
Mar  7 21:27:33 koni bluetoothd[18369]: plugins/hciops.c:hciops_read_bdaddr() 
hci0
...

Mikko


      
