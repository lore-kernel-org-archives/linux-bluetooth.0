Return-Path: <cyrus@holtmann.org>
Message-ID: <23235828.1208489743849.JavaMail.tomcat@fe-ps03>
Date: Fri, 18 Apr 2008 00:35:43 -0300 (UYT)
From: "fpml@adinet.com.uy" <fpml@adinet.com.uy>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] inconsistent lock state
Reply-To: "fpml@adinet.com.uy" <fpml@adinet.com.uy>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


2.6.25 (final), bluez-libs/utils 3.30, dbus 1.2.1, ALSA 1.0.16, uClibc-
20080416, gcc 4.2.3 (-O2)

Fresh boot, loading just udevd, dbus-daemon and hcid (removed all plugins 
except libaudio).

passkey-agent --default 0000 00:02:5B:10:9D:E4 &
auth-agent &
hcitool cc 00:02:5B:10:9D:E4
hcitool auth 00:02:5B:10:9D:E4
speaker-test -D headset -t wav -w Side_Left.wav -r 8000 -b 100000

hcid[806]: /org/bluez/audio/device0: Connecting to 00:02:5B:10:9D:E4 channel 2
hcid[806]: State changed /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -
> HEADSET_STATE_CONNECT_IN_PROGRESS
hcid[806]: link_key_request (sba=00:09:DD:10:0C:5C, dba=00:02:5B:10:9D:E4)
hcid[806]: /org/bluez/audio/device0: Connected to 00:02:5B:10:9D:E4
hcid[806]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
kernel: [   90.749038] kobject: 'sco' (c803a448): kobject_add_internal: 
parent: 'module', set: 'module'
kernel: [   90.790219] kobject: 'holders' (c7310600): kobject_add_internal: 
parent: 'sco', set: '<NULL>'
kernel: [   90.790708] kobject: 'sco' (c803a448): kobject_uevent_env
kernel: [   90.790875] kobject: 'sco' (c803a448): fill_kobj_path: path = 
'/module/sco'
kernel: [   90.792899] kobject: 'notes' (c73106c0): kobject_add_internal: 
parent: 'sco', set: '<NULL>'
kernel: [   90.793801] Bluetooth: SCO (Voice Link) ver 0.5
kernel: [   90.793866] Bluetooth: SCO socket layer initialized
kernel: [   90.850325] device: 'sco00025B109DE4': device_add
kernel: [   90.851038] kobject: 'sco00025B109DE4' (c73041a4): 
kobject_add_internal: parent: 'hci0', set: 'devices'
kernel: [   90.851913] PM: Adding info for bluetooth:sco00025B109DE4
kernel: [   90.852040] bus: 'bluetooth': add device sco00025B109DE4
kernel: [   90.852559] kobject: 'sco00025B109DE4' (c73041a4): 
kobject_uevent_env
kernel: [   90.853593] kobject: 'sco00025B109DE4' (c73041a4): fill_kobj_path: 
path = '/devices/pci0000:00/0000:00:01.2/usb1/1-2/1-2:1.0/hci0/sco00025B109DE4'
hcid[806]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECTED -> 
HEADSET_STATE_PLAY_IN_PROGRESS
hcid[806]: SCO socket opened for headset /org/bluez/audio/device0
hcid[806]: SCO fd=18
hcid[806]: Audio API: sending BT_SETCONFIGURATION_RSP
hcid[806]: State changed /org/bluez/audio/device0: 
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
hcid[806]: Audio API: received BT_STREAMSTART_REQ
hcid[806]: Audio API: sending BT_STREAMSTART_RSP
hcid[806]: Audio API: sending BT_STREAMFD_IND
hcid[806]: Unix client disconnected (fd=16)
kernel: [   92.246692] 
kernel: [   92.246736] =================================
kernel: [   92.246995] [ INFO: inconsistent lock state ]
kernel: [   92.247160] 2.6.25 #1
kernel: [   92.247284] ---------------------------------
kernel: [   92.247434] inconsistent {in-softirq-W} -> {softirq-on-W} usage.
kernel: [   92.247609] hcid/806 [HC0[0]:SC0[0]:HE1:SE1] takes:
kernel: [   92.247668]  (&conn->lock#2){-+..}, at: [<c80380d8>] 
sco_chan_del+0x28/0xd0 [sco]
kernel: [   92.247668] {in-softirq-W} state was registered at:
kernel: [   92.247668]   [<c0137d42>] __lock_acquire+0x372/0x1010
kernel: [   92.247668]   [<c0138a45>] lock_acquire+0x65/0x90
kernel: [   92.247668]   [<c02cb28a>] _spin_lock+0x1a/0x30
kernel: [   92.247668]   [<c803851f>] sco_connect_cfm+0x4f/0x220 [sco]
kernel: [   92.247668]   [<c8073668>] hci_event_packet+0x368/0x1a10 
[bluetooth]
kernel: [   92.247668]   [<c8070827>] hci_rx_task+0x1e7/0x260 [bluetooth]
kernel: [   92.247668]   [<c011e548>] tasklet_action+0x38/0x80
kernel: [   92.247668]   [<c011e3b7>] __do_softirq+0x57/0xb0
kernel: [   92.247668]   [<c011e456>] do_softirq+0x46/0x50
kernel: [   92.247668]   [<c011e8c5>] irq_exit+0x65/0x80
kernel: [   92.247668]   [<c01068bd>] do_IRQ+0x4d/0x90
kernel: [   92.247668]   [<c0104eae>] common_interrupt+0x2e/0x40
kernel: [   92.247668]   [<c0102998>] cpu_idle+0x38/0x80
kernel: [   92.247668]   [<c02c4423>] rest_init+0x43/0x50
kernel: [   92.247668]   [<ffffffff>] 0xffffffff
kernel: [   92.247668] irq event stamp: 33669
kernel: [   92.247668] hardirqs last  enabled at (33669): [<c011e729>] 
local_bh_enable+0x89/0x100
kernel: [   92.247668] hardirqs last disabled at (33667): [<c011e6cb>] 
local_bh_enable+0x2b/0x100
hcid[806]: State changed /org/bluez/audio/device0: HEADSET_STATE_PLAYING -> 
HEADSET_STATE_CONNECTED
kernel: [   92.247668] softirqs last  enabled at (33668): [<c02587cc>] 
lock_sock_nested+0x9c/0xb0
kernel: [   92.247668] softirqs last disabled at (33666): [<c02cb2ab>] 
_spin_lock_bh+0xb/0x30
kernel: [   92.247668] 
kernel: [   92.247668] other info that might help us debug this:
kernel: [   92.247668] 1 lock held by hcid/806:
kernel: [   92.247668]  #0:  (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){--..}, at: 
[<c8038795>] sco_sock_close+0x15/0xa0 [sco]
kernel: [   92.247668] 
kernel: [   92.247668] stack backtrace:
kernel: [   92.247668] Pid: 806, comm: hcid Not tainted 2.6.25 #1
kernel: [   92.247668]  [<c013666a>] print_usage_bug+0x11a/0x130
kernel: [   92.247668]  [<c013723d>] mark_lock+0x3cd/0x530
kernel: [   92.247668]  [<c0137d88>] __lock_acquire+0x3b8/0x1010
kernel: [   92.247668]  [<c01373e0>] ? mark_held_locks+0x40/0x80
kernel: [   92.247668]  [<c0138a45>] lock_acquire+0x65/0x90
kernel: [   92.247668]  [<c80380d8>] ? sco_chan_del+0x28/0xd0 [sco]
kernel: [   92.247668]  [<c02cb28a>] _spin_lock+0x1a/0x30
kernel: [   92.247668]  [<c80380d8>] ? sco_chan_del+0x28/0xd0 [sco]
kernel: [   92.247668]  [<c80380d8>] sco_chan_del+0x28/0xd0 [sco]
kernel: [   92.247668]  [<c80387d2>] sco_sock_close+0x52/0xa0 [sco]
kernel: [   92.247668]  [<c8038841>] sco_sock_release+0x21/0xb0 [sco]
kernel: [   92.247668]  [<c0257044>] sock_release+0x14/0x60
kernel: [   92.247668]  [<c025744c>] sock_close+0x1c/0x40
kernel: [   92.247668]  [<c015ccd1>] __fput+0x91/0x160
kernel: [   92.247668]  [<c015cf58>] fput+0x18/0x20
kernel: [   92.247668]  [<c015a3fe>] filp_close+0x3e/0x70
kernel: [   92.247668]  [<c015b643>] sys_close+0x63/0xb0
kernel: [   92.247668]  [<c0103ec2>] syscall_call+0x7/0xb
kernel: [   92.247668]  =======================
kernel: [   92.352625] hci_scodata_packet: hci0 SCO packet for unknown 
connection handle 44

asound.conf:

pcm.bluetooth {
  type bluetooth
  device 00:02:5B:10:9D:E4
}
ctl.bluetooth {
  type bluetooth
  device 00:02:5B:10:9D:E4
}
pcm.headset {
  type plug
  slave {
    pcm "bluetooth"
    rate 8000
    format S16_LE
    channels 1
  }
}


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
