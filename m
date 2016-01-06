Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 100461] No BCM43341 uart support on T100TAF
Date: Wed, 06 Jan 2016 06:53:24 +0000
Message-ID: <bug-100461-62941-u6sVYK1tV3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-100461-62941@https.bugzilla.kernel.org/>
References: <bug-100461-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=100461

Weiwu Zhang <zhangweiwu@realss.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |zhangweiwu@realss.com

--- Comment #6 from Weiwu Zhang <zhangweiwu@realss.com> ---
Hi Luka Karinja - I followed your instruction to have a patched-up kernel 4.3.3
and bluez 5.37 and the set of firmwares provided by you. It doesn't work for
me.

Test 1: when I use the full set of your firmware:

[   15.264492] Bluetooth: hci1 sending frame failed (-16)
[   17.232626] cfg80211: Regulatory domain changed to country: AU
[   17.232636] cfg80211:  DFS Master region: unset
[   17.232640] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[   17.232647] cfg80211:   (2402000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000
mBm), (N/A)
[   17.232653] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz
AUTO), (N/A, 1700 mBm), (N/A)
[   17.232660] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz
AUTO), (N/A, 2400 mBm), (0 s)
[   17.232665] cfg80211:   (5490000 KHz - 5710000 KHz @ 160000 KHz), (N/A, 2400
mBm), (0 s)
[   17.232670] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 3000
mBm), (N/A)
[   17.265359] Bluetooth: hci1 command 0x0c03 tx timeout
[   25.258932] Bluetooth: hci1: BCM: Reset failed (-110)
[  106.138664] Bluetooth: hci1 command 0xfc45 tx timeout
[  114.136300] Bluetooth: hci1: BCM: failed to write clock command (-110)
[  116.135720] Bluetooth: hci1 command 0x0c03 tx timeout
[  124.133258] Bluetooth: hci1: BCM: Reset failed (-110)
[  151.460661] [drm:intel_pipe_update_end [i915]] *ERROR* Atomic update failure
on pipe A (start=9326 end=9327)

btattach command would not return from 

$ sudo btattach --bredr /dev/ttyS4 -P bcm
Attaching BR/EDR controller to /dev/ttyS4
Switched line discipline from 0 to 15
Device index 1 attached
[not returning to command line]

$ sudo hciconfig 
hci1:    Type: BR/EDR  Bus: UART
    BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
    DOWN 
    RX bytes:0 acl:0 sco:0 events:0 errors:0
    TX bytes:9 acl:0 sco:0 commands:2 errors:0

hci0:    Type: BR/EDR  Bus: SDIO
    BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
    DOWN 
    RX bytes:0 acl:0 sco:0 events:0 errors:0
    TX bytes:0 acl:0 sco:0 commands:0 errors:0

There is also a Call Trace of two weird errors in dmesg right before the above
quoted dmesg part:

[   14.121726] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   14.121734] Bluetooth: BNEP filters: protocol multicast
[   14.121743] Bluetooth: BNEP socket layer initialized
[   14.578903] brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 2014
11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
[   14.596642] brcmf_cfg80211_reg_notifier: not a ISO3166 code
[   15.255733] brcmf_add_if: ERROR: netdev:wlan0 already exists
[   15.258928] brcmf_add_if: ignore IF event
[   15.259969] ------------[ cut here ]------------
[   15.259981] WARNING: CPU: 2 PID: 474 at drivers/clk/clk.c:675
clk_core_disable+0xb7/0xc0()
[   15.260044] Modules linked in: binfmt_misc bnep nls_iso8859_1 intel_rapl
intel_soc_dts_thermal asus_nb_wmi intel_powerclamp asus_wmi hid_multitouch
coretemp sparse_keymap gpio_keys kvm_intel kvm punit_atom_debug crc32_pclmul
aesni_intel xts aes_i586 btsdio lrw joydev brcmfmac gf128mul input_leds ak8975
ablk_helper cryptd brcmutil cfg80211 dm_multipath snd_soc_rt5640
snd_intel_sst_acpi snd_intel_sst_core snd_soc_rl6231 snd_soc_sst_mfld_platform
mei_txe mei lpc_ich snd_soc_core inv_mpu6050 8250_fintek
industrialio_triggered_buffer snd_compress ac97_bus kfifo_buf mac_hid
snd_pcm_dmaengine industrialio elan_i2c i2c_mux snd_pcm dw_dmac i2c_hid
snd_seq_midi soc_button_array dw_dmac_core tpm_crb snd_seq_midi_event hci_uart
snd_rawmidi btbcm snd_seq btintel bluetooth snd_seq_device snd_timer snd
rfkill_gpio
[   15.260083]  soundcore processor_thermal_device int3403_thermal
int3402_thermal int3400_thermal acpi_pad intel_soc_dts_iosf
int340x_thermal_zone acpi_thermal_rel pwm_lpss_platform iosf_mbi pwm_lpss
i2c_designware_platform 8250_dw spi_pxa2xx_platform i2c_designware_core
snd_soc_sst_acpi parport_pc ppdev lp parport sunrpc autofs4 btrfs xor raid6_pq
dm_mirror dm_region_hash dm_log hid_generic usbhid hid i915 mmc_block
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm
wmi video sdhci_acpi sdhci
[   15.260087] CPU: 2 PID: 474 Comm: kworker/u9:0 Tainted: G        W      
4.3.3 #1
[   15.260089] Hardware name: ASUSTeK COMPUTER INC. T100TAF/T100TAF, BIOS
T100TAF.207 09/10/2014
[   15.260117] Workqueue: hci1 hci_power_on [bluetooth]
[   15.260125]  00000000 00000000 f36dfd10 c13be678 00000000 f36dfd40 c1066579
c19fb760
[   15.260131]  00000002 000001da c1a5dc28 000002a3 c16c44c7 c16c44c7 f3f24c80
00000287
[   15.260136]  f59acd8c f36dfd50 c1066653 00000009 00000000 f36dfd60 c16c44c7
c0122d60
[   15.260137] Call Trace:
[   15.260145]  [<c13be678>] dump_stack+0x41/0x59
[   15.260151]  [<c1066579>] warn_slowpath_common+0x89/0xc0
[   15.260155]  [<c16c44c7>] ? clk_core_disable+0xb7/0xc0
[   15.260158]  [<c16c44c7>] ? clk_core_disable+0xb7/0xc0
[   15.260162]  [<c1066653>] warn_slowpath_null+0x23/0x30
[   15.260165]  [<c16c44c7>] clk_core_disable+0xb7/0xc0
[   15.260168]  [<c16c44f5>] clk_disable+0x25/0x30
[   15.260174]  [<f81686c8>] dw8250_set_termios+0x58/0xf0 [8250_dw]
[   15.260178]  [<f8168670>] ? dw8250_runtime_resume+0x70/0x70 [8250_dw]
[   15.260183]  [<c14f0d52>] serial8250_set_termios+0x12/0x30
[   15.260187]  [<c14ebcb5>] uart_change_speed.isra.8+0x35/0x100
[   15.260190]  [<c14ebe03>] uart_set_termios+0x83/0x1b0
[   15.260193]  [<c14ebd80>] ? uart_change_speed.isra.8+0x100/0x100
[   15.260198]  [<c14cd61b>] tty_set_termios+0x2fb/0x3c0
[   15.260206]  [<f8dd0e3d>] hci_uart_set_baudrate+0xad/0x110 [hci_uart]
[   15.260210]  [<c16e2cf1>] ? kfree_skb+0x61/0x80
[   15.260217]  [<f8dd6905>] ? bcm_set_baudrate+0xa5/0x150 [hci_uart]
[   15.260224]  [<f8dd0f91>] hci_uart_setup+0xf1/0x160 [hci_uart]
[   15.260229]  [<c1094e6d>] ? sched_clock_cpu+0x11d/0x130
[   15.260250]  [<f9603b64>] hci_dev_do_open+0xc4/0x520 [bluetooth]
[   15.260273]  [<f9604f2a>] hci_power_on+0x3a/0x1f0 [bluetooth]
[   15.260277]  [<c107dd65>] process_one_work+0x155/0x3e0
[   15.260280]  [<c107e027>] worker_thread+0x37/0x480
[   15.260284]  [<c107dff0>] ? process_one_work+0x3e0/0x3e0
[   15.260287]  [<c108405c>] kthread+0x9c/0xb0
[   15.260293]  [<c1803241>] ret_from_kernel_thread+0x21/0x30
[   15.260297]  [<c1083fc0>] ? kthread_create_on_node+0x110/0x110
[   15.260299] ---[ end trace aadeb8f6ef047b6e ]---
[   15.260301] ------------[ cut here ]------------
[   15.260306] WARNING: CPU: 2 PID: 474 at drivers/clk/clk.c:570
clk_core_unprepare+0xc7/0xf0()
[   15.260354] Modules linked in: binfmt_misc bnep nls_iso8859_1 intel_rapl
intel_soc_dts_thermal asus_nb_wmi intel_powerclamp asus_wmi hid_multitouch
coretemp sparse_keymap gpio_keys kvm_intel kvm punit_atom_debug crc32_pclmul
aesni_intel xts aes_i586 btsdio lrw joydev brcmfmac gf128mul input_leds ak8975
ablk_helper cryptd brcmutil cfg80211 dm_multipath snd_soc_rt5640
snd_intel_sst_acpi snd_intel_sst_core snd_soc_rl6231 snd_soc_sst_mfld_platform
mei_txe mei lpc_ich snd_soc_core inv_mpu6050 8250_fintek
industrialio_triggered_buffer snd_compress ac97_bus kfifo_buf mac_hid
snd_pcm_dmaengine industrialio elan_i2c i2c_mux snd_pcm dw_dmac i2c_hid
snd_seq_midi soc_button_array dw_dmac_core tpm_crb snd_seq_midi_event hci_uart
snd_rawmidi btbcm snd_seq btintel bluetooth snd_seq_device snd_timer snd
rfkill_gpio
[   15.260385]  soundcore processor_thermal_device int3403_thermal
int3402_thermal int3400_thermal acpi_pad intel_soc_dts_iosf
int340x_thermal_zone acpi_thermal_rel pwm_lpss_platform iosf_mbi pwm_lpss
i2c_designware_platform 8250_dw spi_pxa2xx_platform i2c_designware_core
snd_soc_sst_acpi parport_pc ppdev lp parport sunrpc autofs4 btrfs xor raid6_pq
dm_mirror dm_region_hash dm_log hid_generic usbhid hid i915 mmc_block
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm
wmi video sdhci_acpi sdhci
[   15.260389] CPU: 2 PID: 474 Comm: kworker/u9:0 Tainted: G        W      
4.3.3 #1
[   15.260390] Hardware name: ASUSTeK COMPUTER INC. T100TAF/T100TAF, BIOS
T100TAF.207 09/10/2014
[   15.260412] Workqueue: hci1 hci_power_on [bluetooth]
[   15.260418]  00000000 00000000 f36dfd14 c13be678 00000000 f36dfd44 c1066579
c19fb760
[   15.260424]  00000002 000001da c1a5dc28 0000023a c16c2ef7 c16c2ef7 f3f24c80
f2440eb8
[   15.260429]  f59acd8c f36dfd54 c1066653 00000009 00000000 f36dfd64 c16c2ef7
c0122d60
[   15.260430] Call Trace:
[   15.260434]  [<c13be678>] dump_stack+0x41/0x59
[   15.260438]  [<c1066579>] warn_slowpath_common+0x89/0xc0
[   15.260442]  [<c16c2ef7>] ? clk_core_unprepare+0xc7/0xf0
[   15.260445]  [<c16c2ef7>] ? clk_core_unprepare+0xc7/0xf0
[   15.260448]  [<c1066653>] warn_slowpath_null+0x23/0x30
[   15.260451]  [<c16c2ef7>] clk_core_unprepare+0xc7/0xf0
[   15.260455]  [<c16c35f2>] clk_unprepare+0x22/0x30
[   15.260459]  [<f81686d2>] dw8250_set_termios+0x62/0xf0 [8250_dw]
[   15.260463]  [<f8168670>] ? dw8250_runtime_resume+0x70/0x70 [8250_dw]
[   15.260467]  [<c14f0d52>] serial8250_set_termios+0x12/0x30
[   15.260470]  [<c14ebcb5>] uart_change_speed.isra.8+0x35/0x100
[   15.260473]  [<c14ebe03>] uart_set_termios+0x83/0x1b0
[   15.260477]  [<c14ebd80>] ? uart_change_speed.isra.8+0x100/0x100
[   15.260480]  [<c14cd61b>] tty_set_termios+0x2fb/0x3c0
[   15.260487]  [<f8dd0e3d>] hci_uart_set_baudrate+0xad/0x110 [hci_uart]
[   15.260491]  [<c16e2cf1>] ? kfree_skb+0x61/0x80
[   15.260498]  [<f8dd6905>] ? bcm_set_baudrate+0xa5/0x150 [hci_uart]
[   15.260504]  [<f8dd0f91>] hci_uart_setup+0xf1/0x160 [hci_uart]
[   15.260508]  [<c1094e6d>] ? sched_clock_cpu+0x11d/0x130
[   15.260530]  [<f9603b64>] hci_dev_do_open+0xc4/0x520 [bluetooth]
[   15.260552]  [<f9604f2a>] hci_power_on+0x3a/0x1f0 [bluetooth]
[   15.260555]  [<c107dd65>] process_one_work+0x155/0x3e0
[   15.260559]  [<c107e027>] worker_thread+0x37/0x480
[   15.260562]  [<c107dff0>] ? process_one_work+0x3e0/0x3e0
[   15.260566]  [<c108405c>] kthread+0x9c/0xb0
[   15.260570]  [<c1803241>] ret_from_kernel_thread+0x21/0x30
[   15.260573]  [<c1083fc0>] ? kthread_create_on_node+0x110/0x110
[   15.260576] ---[ end trace aadeb8f6ef047b6f ]---
[   15.264492] Bluetooth: hci1 sending frame failed (-16)

If I use another version of BCM43341B0.hcd I stole from an Android project:
https://github.com/lurepheonix/android_device_rk31board/blob/master/bluetooth/etc/firmware/bcm43341b0.hcd
the aforementioned two Call Traces would not show up in dmesg, but bluetooth
would not work, abeit with different kernel error messages. Do you want the
dmesg of that Android firmware?

-- 
You are receiving this mail because:
You are the assignee for the bug.
