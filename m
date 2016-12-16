Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
To: "pulseaudio-bugs@lists.freedesktop.org"
        <pulseaudio-bugs@lists.freedesktop.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: FW: Pulseaudio segmentation fault after connecting to Bluetooth
 headset
Date: Fri, 16 Dec 2016 08:31:57 +0000
Message-ID: <E3B98393E6037849B63EA428240A65135BCACE@PGSMSX103.gar.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

*Sorry I forgot to turn HTML off in my previous message. Resending it again.
I have a Bluedio T+3 Bluetooth Headset that contains the HSP/HFP, A2DP and AVRCP profiles.
I am using kernel version 4.1.27 with BlueZ 5.40.

I have paired with the headset using bluetoothctl. After I have paired with the device, I receive kernel oops message in the console. Nonetheless, the system does not crash and I was able to configure it to play audio. Hence, it is a soft kernel panic. There are no issues to the Bluetooth audio streaming.
The steps that I have taken are as follows:

$ pulseaudio -D
$ bluetoothctl
$ scan on             (search for Bluetooth addresses)
$ pair <BT_HEADSET_MAC>
$ connect <BT_HEADSET_MAC>  (from this point on, the kernel displays kernel oops messages)

Please see the output as follows:
Kernel oops message (notice the segfault):

[ 1611.091465] pulseaudio[1270]: segfault at 694be0 ip 0000000000694be0 sp 00007ffe1b0b0158 error 15
[ 1627.873788] input: 16:01:14:24:15:59 as /devices/virtual/input/input9
[ 1627.892687] ------------[ cut here ]------------
[ 1627.899990] WARNING: CPU: 3 PID: 438 at /home/ilab/development/yocto_build/build/tmp/work-shared/intel-corei7-64-cavs-hda/kernel-source/lib/debugobjects.c:263 debug_print_object+0x89/0xb0()
[ 1627.921000] ODEBUG: assert_init not available (active state 0) object type: timer_list hint: stub_timer+0x0/0x20
[ 1627.934530] Modules linked in: uinput 8021q cmac ecb rfcomm bnep snd_hda_codec_hdmi fuse btusb btbcm btintel bluetooth hid_sensor_gyro_3d hid_sensor_als hid_sensor_accel_3d hid_sensor_press hid_sensor_incl_3d hid_sensor_trigger hid_sensor_iio_common hid_sensor_custom hid_sensor_hub mei_dal intel_spi_platform intel_spi sbi_apl intel_ishtp_hid mwifiex_usb mwifiex_pcie mwifiex cfg80211 i915 iTCO_wdt igb pcspkr iTCO_vendor_support lpc_ich spi_pxa2xx_platform mei_me mei portmux_intel_drcfg i2c_i801 snd_hda_intel snd_hda_codec dca snd_hda_core intel_ish_ipc intel_ishtp thermal tpm_crb tpm_tis tpm intel_pmc_ipc rtc_cmos
[ 1628.002994] CPU: 3 PID: 438 Comm: kworker/u9:11 Tainted: G     U  W       4.1.27apollolake #2
[ 1628.015045] Hardware name: Intel Corp. Broxton P/NOTEBOOK, BIOS APLIRVPA.X64.0138.B35.1608091058 08/09/2016
[ 1628.028488] Workqueue: hci0 hci_rx_work [bluetooth]
[ 1628.036435]  0000000000000086 00000000f240fc38 ffff880004bdf828 ffffffff81a738a5
[ 1628.047265]  ffff880004bdf880 ffffffff81f2e1a8 ffff880004bdf868 ffffffff81081e0a
[ 1628.058104]  0000000000000096 ffff880004bdf928 ffffffff82241280 ffffffff81f2d1cb
[ 1628.068989] Call Trace:
[ 1628.074303]  [<ffffffff81a738a5>] dump_stack+0x4d/0x63
[ 1628.082616]  [<ffffffff81081e0a>] warn_slowpath_common+0x8a/0xc0
[ 1628.091874]  [<ffffffff81081e95>] warn_slowpath_fmt+0x55/0x70
[ 1628.100863]  [<ffffffff810f39ab>] ? init_timer_key+0x6b/0xd0
[ 1628.109753]  [<ffffffff814bf8d9>] debug_print_object+0x89/0xb0
[ 1628.118864]  [<ffffffff810f3850>] ? ftrace_raw_event_tick_stop+0x100/0x100
[ 1628.129118]  [<ffffffff814c0934>] debug_object_assert_init+0x144/0x150
[ 1628.138971]  [<ffffffff810f4003>] del_timer+0x33/0xa0
[ 1628.147195]  [<ffffffff8109bb89>] try_to_grab_pending+0xa9/0x160
[ 1628.156456]  [<ffffffff8109c3e3>] cancel_delayed_work+0x33/0xe0
[ 1628.165573]  [<ffffffffa059b24c>] l2cap_chan_del+0x19c/0x340 [bluetooth]
[ 1628.175541]  [<ffffffffa059b59d>] l2cap_connect_create_rsp+0x1ad/0x290 [bluetooth]
[ 1628.186471]  [<ffffffffa05a4190>] ? l2cap_sig_channel+0x70/0x1390 [bluetooth]
[ 1628.196942]  [<ffffffffa05a474c>] l2cap_sig_channel+0x62c/0x1390 [bluetooth]
[ 1628.207340]  [<ffffffffa056ef78>] ? hci_rx_work+0x148/0x4a0 [bluetooth]
[ 1628.217221]  [<ffffffffa05a5703>] l2cap_recv_frame+0x253/0x370 [bluetooth]
[ 1628.227420]  [<ffffffffa05a646b>] l2cap_recv_acldata+0x33b/0x380 [bluetooth]
[ 1628.237754]  [<ffffffffa056f01e>] hci_rx_work+0x1ee/0x4a0 [bluetooth]
[ 1628.247402]  [<ffffffffa056ef62>] ? hci_rx_work+0x132/0x4a0 [bluetooth]
[ 1628.257264]  [<ffffffff8109c957>] process_one_work+0x217/0x5c0
[ 1628.266265]  [<ffffffff8109c8b9>] ? process_one_work+0x179/0x5c0
[ 1628.275441]  [<ffffffff8109cdc7>] ? worker_thread+0xc7/0x460
[ 1628.284241]  [<ffffffff8109cd4b>] worker_thread+0x4b/0x460
[ 1628.292847]  [<ffffffff8109cd00>] ? process_one_work+0x5c0/0x5c0
[ 1628.301998]  [<ffffffff810a27d9>] kthread+0xf9/0x110
[ 1628.310049]  [<ffffffff810b50b5>] ? local_clock+0x25/0x30
[ 1628.318542]  [<ffffffff810a26e0>] ? kthread_create_on_node+0x250/0x250
[ 1628.328315]  [<ffffffff81a7d0e2>] ret_from_fork+0x42/0x70
[ 1628.336806]  [<ffffffff810a26e0>] ? kthread_create_on_node+0x250/0x250
[ 1628.346605] ---[ end trace 0b6559d32b2a5c31 ]---
[ 1628.354291] ------------[ cut here ]------------
[ 1628.361929] WARNING: CPU: 3 PID: 438 at /home/ilab/development/yocto_build/build/tmp/work-shared/intel-corei7-64-cavs-hda/kernel-source/lib/debugobjects.c:263 debug_print_object+0x89/0xb0()
[ 1628.383395] ODEBUG: assert_init not available (active state 0) object type: timer_list hint: stub_timer+0x0/0x20
[ 1628.397426] Modules linked in: uinput 8021q cmac ecb rfcomm bnep snd_hda_codec_hdmi fuse btusb btbcm btintel bluetooth hid_sensor_gyro_3d hid_sensor_als hid_sensor_accel_3d hid_sensor_press hid_sensor_incl_3d hid_sensor_trigger hid_sensor_iio_common hid_sensor_custom hid_sensor_hub mei_dal intel_spi_platform intel_spi sbi_apl intel_ishtp_hid mwifiex_usb mwifiex_pcie mwifiex cfg80211 i915 iTCO_wdt igb pcspkr iTCO_vendor_support lpc_ich spi_pxa2xx_platform mei_me mei portmux_intel_drcfg i2c_i801 snd_hda_intel snd_hda_codec dca snd_hda_core intel_ish_ipc intel_ishtp thermal tpm_crb tpm_tis tpm intel_pmc_ipc rtc_cmos
[ 1628.467217] CPU: 3 PID: 438 Comm: kworker/u9:11 Tainted: G     U  W       4.1.27apollolake #2
[ 1628.479683] Hardware name: Intel Corp. Broxton P/NOTEBOOK, BIOS APLIRVPA.X64.0138.B35.1608091058 08/09/2016
[ 1628.493584] Workqueue: hci0 hci_rx_work [bluetooth]
[ 1628.502029]  0000000000000086 00000000f240fc38 ffff880004bdf828 ffffffff81a738a5
[ 1628.513307]  ffff880004bdf880 ffffffff81f2e1a8 ffff880004bdf868 ffffffff81081e0a
[ 1628.524574]  0000000000000096 ffff880004bdf928 ffffffff82241280 ffffffff81f2d1cb
[ 1628.535925] Call Trace:
[ 1628.541714]  [<ffffffff81a738a5>] dump_stack+0x4d/0x63
[ 1628.550492]  [<ffffffff81081e0a>] warn_slowpath_common+0x8a/0xc0
[ 1628.560242]  [<ffffffff81081e95>] warn_slowpath_fmt+0x55/0x70
[ 1628.569690]  [<ffffffff810f39ab>] ? init_timer_key+0x6b/0xd0
[ 1628.579041]  [<ffffffff814bf8d9>] debug_print_object+0x89/0xb0
[ 1628.588580]  [<ffffffff810f3850>] ? ftrace_raw_event_tick_stop+0x100/0x100
[ 1628.599315]  [<ffffffff814c0934>] debug_object_assert_init+0x144/0x150
[ 1628.609646]  [<ffffffff810f4003>] del_timer+0x33/0xa0
[ 1628.618358]  [<ffffffff8109bb89>] try_to_grab_pending+0xa9/0x160
[ 1628.628229]  [<ffffffff8109c3e3>] cancel_delayed_work+0x33/0xe0
[ 1628.637970]  [<ffffffffa059b260>] l2cap_chan_del+0x1b0/0x340 [bluetooth]
[ 1628.648624]  [<ffffffffa059b59d>] l2cap_connect_create_rsp+0x1ad/0x290 [bluetooth]
[ 1628.660266]  [<ffffffffa05a4190>] ? l2cap_sig_channel+0x70/0x1390 [bluetooth]
[ 1628.671445]  [<ffffffffa05a474c>] l2cap_sig_channel+0x62c/0x1390 [bluetooth]
[ 1628.682448]  [<ffffffffa056ef78>] ? hci_rx_work+0x148/0x4a0 [bluetooth]
[ 1628.692953]  [<ffffffffa05a5703>] l2cap_recv_frame+0x253/0x370 [bluetooth]
[ 1628.703720]  [<ffffffffa05a646b>] l2cap_recv_acldata+0x33b/0x380 [bluetooth]
[ 1628.714701]  [<ffffffffa056f01e>] hci_rx_work+0x1ee/0x4a0 [bluetooth]
[ 1628.724899]  [<ffffffffa056ef62>] ? hci_rx_work+0x132/0x4a0 [bluetooth]
[ 1628.735263]  [<ffffffff8109c957>] process_one_work+0x217/0x5c0
[ 1628.744690]  [<ffffffff8109c8b9>] ? process_one_work+0x179/0x5c0
[ 1628.754238]  [<ffffffff8109cdc7>] ? worker_thread+0xc7/0x460
[ 1628.763319]  [<ffffffff8109cd4b>] worker_thread+0x4b/0x460
[ 1628.772118]  [<ffffffff8109cd00>] ? process_one_work+0x5c0/0x5c0
[ 1628.781388]  [<ffffffff810a27d9>] kthread+0xf9/0x110
[ 1628.789423]  [<ffffffff810b50b5>] ? local_clock+0x25/0x30
[ 1628.797900]  [<ffffffff810a26e0>] ? kthread_create_on_node+0x250/0x250
[ 1628.807628]  [<ffffffff81a7d0e2>] ret_from_fork+0x42/0x70
[ 1628.816071]  [<ffffffff810a26e0>] ? kthread_create_on_node+0x250/0x250
[ 1628.825822] ---[ end trace 0b6559d32b2a5c32 ]---

Strangely, when I tried to connect to another device i.e. Bluetooth speaker that only has A2DP, the kernel oops message did not appear.
This lead me to some findings which I found in the following link. They encounter crashing/segfault when connecting to a Samsung Gear Circle. This was the closest to my issue. The difference being is that I do not encounter any crashes in the Linux system.
http://thread.gmane.org/gmane.linux.bluez.kernel/60329 

May I know how can I narrow down to find the root cause of this issue and also to prevent this from happening? 

Thank you.

Best regards,
Joshua

