Return-Path: <cyrus@holtmann.org>
From: Murat Kilivan <Murat.Kilivan@csr.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluetooth Low Energy service crash report - when trying read a
 HID feature report
Date: Thu, 24 Jul 2014 09:43:10 +0000
Message-ID: <45F17F5803927D43967AFEED068E781E0879ACDB@CAMEUREXM02.EUROPE.ROOT.PRI>
References: <45F17F5803927D43967AFEED068E781E0879A30E@CAMEUREXM02.EUROPE.ROOT.PRI>
 <20140724083116.GB9891@t440s.lan>
In-Reply-To: <20140724083116.GB9891@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com] 
Sent: 24 July 2014 09:31
To: Murat Kilivan
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth Low Energy service crash report - when trying read a HID feature report

Hi Murat,

Hi Johan,

On Wed, Jul 23, 2014, Murat Kilivan wrote:
> I have successfully connected to a BLE HID (peripheral) device and /dev/hidraw1 file is created. I am able to read raw data successfully from hidraw1. However, when I try to read a feature report from this device, the Bluetooth service crashes. The bluetooth service log and my source code are below.
> 
> Enviroments:
> ------------
> Linux Mint-17 KDE
> Kernel 3.13.0-24-generic
> BlueZ 5.21
> 
> Output of Bluetooth service:
> ----------------------------
> # bluetooth -d -n
> ...
> ...
> bluetoothd[2610]: profiles/input/hog.c:forward_report() Sending report 
> type 3 to device 0x000C handle 0x1C
> (bluetoothd:2610): GLib-ERROR **: 
> /build/buildd/glib2.0-2.40.0/./glib/gmem.c:103: failed to allocate 
> 4294967295 bytes

4294967295 is the same as (uint32_t) -1 so seems like there might be a missing error check somewhere. Could you please try to get the full bluetoothd backtrace by running it through gdb or valgrind? If possible do this with the latest git version.

git revision: 5a67d00d3fcfafa40cbf80de48f08768cb3b132d

murat@murat-VirtualBox:~/git/bluez >sudo valgrind --leak-check=full src/bluetoothd -d -n
...
...
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:03, rssi -61 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:09, rssi -72 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:09, rssi -71 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:06, rssi -65 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:06, rssi -65 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:01, rssi -53 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -53 delta 12
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:01, rssi -52 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:08, rssi -72 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:08, rssi -72 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:discovery_disconnect() owner :1.76
bluetoothd[10991]: src/adapter.c:discovery_destroy() owner :1.76
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:02, rssi -55 flags 0x0000 eir_len 23
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:02, rssi -55 flags 0x0000 eir_len 0
bluetoothd[10991]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[10991]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[10991]: src/adapter.c:discovering_callback() hci0 type 7 discovering 0
bluetoothd[10991]: src/adapter.c:start_discovery() sender :1.77
bluetoothd[10991]: src/adapter.c:trigger_start_discovery() 
bluetoothd[10991]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[10991]: src/adapter.c:start_discovery_timeout() 
bluetoothd[10991]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[10991]: src/adapter.c:discovering_callback() hci0 type 7 discovering 1
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -51 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_create() dst 00:02:5B:00:19:99
bluetoothd[10991]: src/device.c:device_new() address 00:02:5B:00:19:99
bluetoothd[10991]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_00_02_5B_00_19_99
bluetoothd[10991]: src/device.c:btd_device_set_temporary() temporary 1
bluetoothd[10991]: src/adapter.c:adapter_connect_list_remove() device /org/bluez/hci0/dev_00_02_5B_00_19_99 is not on the list, ignoring
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -51
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -51 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -51 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -51 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -51 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -55 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -51 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -51 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -51 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -51 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -52 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -52 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -52 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:04, rssi -69 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -69
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:04, rssi -69 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -52 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -52 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:07, rssi -53 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -53
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:07, rssi -52 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:03, rssi -75 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -75
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:03, rssi -74 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:05, rssi -69 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -69
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:05, rssi -69 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:09, rssi -75 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -75
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:09, rssi -74 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -52 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:01, rssi -72 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -72
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:02, rssi -61 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -61
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:02, rssi -61 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:08, rssi -68 flags 0x0000 eir_len 23
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -68
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:33:08, rssi -67 flags 0x0000 eir_len 0
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr E4:13:87:11:68:68, rssi -80 flags 0x0000 eir_len 27
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -80
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr E4:13:87:11:68:68, rssi -79 flags 0x0000 eir_len 9
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -53 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -55 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -54 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr D7:B2:49:E8:EB:7C, rssi -79 flags 0x0000 eir_len 27
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi -79
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr D7:B2:49:E8:EB:7C, rssi -78 flags 0x0000 eir_len 8
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -55 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -55 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -55 flags 0x0000 eir_len 28
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:device_found_callback() hci0 addr 00:02:5B:00:19:99, rssi -55 flags 0x0000 eir_len 3
bluetoothd[10991]: src/device.c:device_set_legacy() legacy 0
bluetoothd[10991]: src/adapter.c:discovery_disconnect() owner :1.77
bluetoothd[10991]: src/adapter.c:discovery_destroy() owner :1.77
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/device.c:device_set_rssi() rssi 0
bluetoothd[10991]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[10991]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[10991]: src/adapter.c:discovering_callback() hci0 type 7 discovering 0
bluetoothd[10991]: src/agent.c:agent_ref() 0x4f0d478: ref=1
bluetoothd[10991]: src/agent.c:register_agent() agent :1.78
bluetoothd[10991]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[10991]: src/agent.c:agent_ref() 0x4f0d478: ref=2
bluetoothd[10991]: src/device.c:bonding_request_new() Requesting bonding for 00:02:5B:00:19:99
bluetoothd[10991]: src/agent.c:agent_ref() 0x4f0d478: ref=3
bluetoothd[10991]: src/agent.c:agent_unref() 0x4f0d478: ref=2
bluetoothd[10991]: src/device.c:device_connect_le() Connection attempt to: 00:02:5B:00:19:99
bluetoothd[10991]: src/adapter.c:connected_callback() hci0 device 00:02:5B:00:19:99 connected eir_len 0
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=1
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=2
bluetoothd[10991]: src/adapter.c:adapter_connect_list_remove() device /org/bluez/hci0/dev_00_02_5B_00_19_99 is not on the list, ignoring
bluetoothd[10991]: src/adapter.c:suspend_discovery() 
bluetoothd[10991]: src/adapter.c:adapter_bonding_attempt() hci0 bdaddr 00:02:5B:00:19:99 type 1 io_cap 0x03
bluetoothd[10991]: src/adapter.c:pair_device_complete() Success (0x00)
bluetoothd[10991]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:02:5B:00:19:99 type 1 status 0x0
bluetoothd[10991]: src/device.c:device_bonding_complete() bonding 0x4f34860 status 0x00
bluetoothd[10991]: src/device.c:device_bonding_complete() Proceeding with service discovery
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=3
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=4
bluetoothd[10991]: src/agent.c:agent_unref() 0x4f0d478: ref=1
bluetoothd[10991]: src/adapter.c:resume_discovery() 
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=3
bluetoothd[10991]: src/adapter.c:new_long_term_key_callback() hci0 new LTK for 00:02:5B:00:19:99 type 0 enc_size 16
bluetoothd[10991]: src/device.c:device_set_bonded() 
bluetoothd[10991]: src/device.c:device_bonding_complete() bonding (nil) status 0x00
bluetoothd[10991]: src/adapter.c:resume_discovery() 
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=3
bluetoothd[10991]: src/device.c:primary_cb() status 0
bluetoothd[10991]: src/device.c:find_included_services() service count 5
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=5
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=3
bluetoothd[10991]: src/device.c:find_included_cb() status 0
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=5
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=3
bluetoothd[10991]: src/device.c:find_included_cb() status 0
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=5
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=3
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=3
bluetoothd[10991]: src/device.c:find_included_cb() status 0
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=5
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=3
bluetoothd[10991]: src/device.c:find_included_cb() status 0
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=5
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=3
bluetoothd[10991]: src/device.c:find_included_cb() status 0
bluetoothd[10991]: src/device.c:update_gatt_services() UUID Added: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[10991]: src/device.c:update_gatt_services() UUID Added: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[10991]: src/device.c:update_gatt_services() UUID Added: 00001812-0000-1000-8000-00805f9b34fb
bluetoothd[10991]: src/device.c:update_gatt_services() UUID Added: 0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[10991]: src/device.c:update_gatt_services() UUID Added: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[10991]: src/device.c:device_probe_profiles() Probing profiles for device 00:02:5B:00:19:99
bluetoothd[10991]: src/device.c:btd_device_add_attio_callback() 0x4d74a50 registered ATT connection callback
bluetoothd[10991]: src/device.c:device_set_auto_connect() 00:02:5B:00:19:99 auto connect: 1
bluetoothd[10991]: src/device.c:device_set_auto_connect() Already connected
bluetoothd[10991]: src/service.c:change_state() 0x4fbbde8: device 00:02:5B:00:19:99 profile deviceinfo state changed: unavailable -> disconnected (0)
bluetoothd[10991]: src/device.c:btd_device_add_attio_callback() 0x4d74a50 registered ATT connection callback
bluetoothd[10991]: src/device.c:device_set_auto_connect() 00:02:5B:00:19:99 auto connect: 1
bluetoothd[10991]: src/service.c:change_state() 0x4fc4ad8: device 00:02:5B:00:19:99 profile gap-gatt-profile state changed: unavailable -> disconnected (0)
bluetoothd[10991]: profiles/input/hog.c:hog_probe() path /org/bluez/hci0/dev_00_02_5B_00_19_99
bluetoothd[10991]: src/device.c:btd_device_add_attio_callback() 0x4d74a50 registered ATT connection callback
bluetoothd[10991]: src/device.c:device_set_auto_connect() 00:02:5B:00:19:99 auto connect: 1
bluetoothd[10991]: src/service.c:change_state() 0x4fc5cd0: device 00:02:5B:00:19:99 profile input-hog state changed: unavailable -> disconnected (0)
bluetoothd[10991]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00_02_5B_00_19_99 err 0
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=2
bluetoothd[10991]: src/device.c:notify_attios() 
bluetoothd[10991]: src/device.c:attio_connected() 
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=3
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=4
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=5
bluetoothd[10991]: src/device.c:attio_connected() 
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=6
bluetoothd[10991]: profiles/gatt/gas.c:attio_connected_cb() MTU Exchange: Requesting 672
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: src/device.c:attio_connected() 
bluetoothd[10991]: profiles/input/hog.c:attio_connected_cb() HoG connected
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: src/device.c:notify_attios() 
bluetoothd[10991]: src/device.c:notify_attios() 
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: src/device.c:btd_device_set_trusted() trusted 1
bluetoothd[10991]: src/agent.c:agent_disconnect() Agent :1.78 disconnected
bluetoothd[10991]: src/agent.c:agent_destroy() agent :1.78
bluetoothd[10991]: src/agent.c:agent_unref() 0x4f0d478: ref=0
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: profiles/gatt/gas.c:exchange_mtu_cb() MTU exchange succeeded: 23
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=10
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: profiles/gatt/gas.c:discover_ccc_cb() CCC: 0x0004
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=7
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=8
bluetoothd[10991]: profiles/input/hog.c:char_discovered_cb() 0x000e UUID: 00002a4a-0000-1000-8000-00805f9b34fb properties: 02
bluetoothd[10991]: profiles/input/hog.c:char_discovered_cb() 0x0010 UUID: 00002a4b-0000-1000-8000-00805f9b34fb properties: 02
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: profiles/input/hog.c:char_discovered_cb() 0x0013 UUID: 00002a4d-0000-1000-8000-00805f9b34fb properties: 12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=10
bluetoothd[10991]: profiles/input/hog.c:char_discovered_cb() 0x0017 UUID: 00002a4d-0000-1000-8000-00805f9b34fb properties: 12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=11
bluetoothd[10991]: profiles/input/hog.c:char_discovered_cb() 0x001b UUID: 00002a4d-0000-1000-8000-00805f9b34fb properties: 0a
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=12
bluetoothd[10991]: profiles/input/hog.c:char_discovered_cb() 0x001e UUID: 00002a4d-0000-1000-8000-00805f9b34fb properties: 0e
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: profiles/input/hog.c:char_discovered_cb() 0x0021 UUID: 00002a4d-0000-1000-8000-00805f9b34fb properties: 12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=14
bluetoothd[10991]: profiles/input/hog.c:char_discovered_cb() 0x0025 UUID: 00002a4d-0000-1000-8000-00805f9b34fb properties: 0e
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=15
bluetoothd[10991]: profiles/input/hog.c:char_discovered_cb() 0x0028 UUID: 00002a4c-0000-1000-8000-00805f9b34fb properties: 04
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=14
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=14
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: profiles/gatt/gas.c:ccc_written_cb() Service Changed indications enabled
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() Report MAP:
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 05 0c
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 a1 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 85 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 19 00
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 2a 9c 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 15 00
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 26 9c 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 10
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 81 00
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 c0
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 05 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 a1 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 85 03
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 a1 00
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 05 09
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 19 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 29 03
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 15 00
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 25 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 03
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 81 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 05
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 81 03
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 05 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 30
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 31
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 16 00 f8
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 26 ff 07
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 10
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 81 06
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 38
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 15 80
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 25 7f
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 81 06
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 c0
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 c0
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 06 00 ff
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 a1 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 85 05
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 15 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 25 04
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 b1 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 b1 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 15 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 25 04
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 91 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 91 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 12
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 91 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 15 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 25 04
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 81 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 81 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 12
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 81 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 85 06
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 75 08
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 95 14
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 09 01
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 91 02
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() 	 c0
bluetoothd[10991]: profiles/input/hog.c:report_map_read_cb() DIS information: vendor_src=0x0, vendor=0x0, product=0x0, version=0x0
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=13
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=11
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=12
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=11
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=10
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=11
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=10
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=10
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=9
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=7
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=8
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=7
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=5
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=6
bluetoothd[10991]: profiles/input/hog.c:info_read_cb() bcdHID: 0x0213 bCountryCode: 0x40 Flags: 0x01
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=5
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=5
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=6
bluetoothd[10991]: profiles/input/hog.c:external_report_reference_cb() External report reference read, external report characteristic UUID: 0x192a
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: profiles/input/hog.c:report_ccc_written_cb() Report characteristic descriptor written: notifications enabled
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: profiles/input/hog.c:report_reference_cb() Report ID: 0x01 Report type: 0x01
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: profiles/input/hog.c:report_ccc_written_cb() Report characteristic descriptor written: notifications enabled
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: profiles/input/hog.c:report_reference_cb() Report ID: 0x03 Report type: 0x01
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: profiles/input/hog.c:report_reference_cb() Report ID: 0x05 Report type: 0x03
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: profiles/input/hog.c:report_reference_cb() Report ID: 0x05 Report type: 0x02
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: profiles/input/hog.c:report_ccc_written_cb() Report characteristic descriptor written: notifications enabled
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: profiles/input/hog.c:report_reference_cb() Report ID: 0x05 Report type: 0x01
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: attrib/gattrib.c:g_attrib_ref() 0x4f3d998: ref=7
bluetoothd[10991]: profiles/input/hog.c:report_reference_cb() Report ID: 0x06 Report type: 0x02
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=6
bluetoothd[10991]: profiles/input/hog.c:external_service_char_cb() Discover external service characteristic failed: Invalid handle
bluetoothd[10991]: attrib/gattrib.c:g_attrib_unref() 0x4f3d998: ref=5
bluetoothd[10991]: src/attrib-server.c:channel_handler() op 0x1b
bluetoothd[10991]: profiles/input/hog.c:report_value_cb() HoG report (3 bytes)
bluetoothd[10991]: src/attrib-server.c:channel_handler() op 0x1b
bluetoothd[10991]: profiles/input/hog.c:report_value_cb() HoG report (3 bytes)
bluetoothd[10991]: profiles/input/hog.c:forward_report() Sending report type 3 to device 0x000C handle 0x1C
==10991== Warning: silly arg (-1) to malloc()

(bluetoothd:10991): GLib-ERROR **: /build/buildd/glib2.0-2.40.0/./glib/gmem.c:103: failed to allocate 4294967295 bytes
==10991== 
==10991== Process terminating with default action of signal 5 (SIGTRAP)
==10991==    at 0x40A340A: g_logv (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
==10991==    by 0x40A3522: g_log (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
==10991==    by 0x40A1C1D: g_malloc (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
==10991==    by 0x40B9E75: g_memdup (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
==10991==    by 0x80781C5: gatt_write_char (gatt.c:900)
==10991==    by 0x8072A7B: forward_report (hog.c:368)
==10991==    by 0x80A5B0D: queue_foreach (queue.c:206)
==10991==    by 0x807208E: uhid_read_handler (uhid.c:98)
==10991==    by 0x80A53F2: read_callback (io-glib.c:168)
==10991==    by 0x40E1E04: ??? (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
==10991==    by 0x409C0A6: g_main_context_dispatch (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
==10991==    by 0x409C467: ??? (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
==10991== Invalid free() / delete / delete[] / realloc()
==10991==    at 0x402B3D8: free (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==10991==    by 0x4304F54: __libc_freeres (in /lib/i386-linux-gnu/libc-2.19.so)
==10991==    by 0x4024526: _vgnU_freeres (in /usr/lib/valgrind/vgpreload_core-x86-linux.so)
==10991==    by 0x40E4F6D: ??? (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
==10991==  Address 0xffffffff is not stack'd, malloc'd or (recently) free'd
==10991== 
==10991== 
==10991== HEAP SUMMARY:
==10991==     in use at exit: 88,721 bytes in 1,435 blocks
==10991==   total heap usage: 25,247 allocs, 23,813 frees, 13,746,560 bytes allocated
==10991== 
==10991== LEAK SUMMARY:
==10991==    definitely lost: 0 bytes in 0 blocks
==10991==    indirectly lost: 0 bytes in 0 blocks
==10991==      possibly lost: 0 bytes in 0 blocks
==10991==    still reachable: 88,721 bytes in 1,435 blocks
==10991==         suppressed: 0 bytes in 0 blocks
==10991== Reachable blocks (those to which a pointer was found) are not shown.
==10991== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==10991== 
==10991== For counts of detected and suppressed errors, rerun with: -v
==10991== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)


Murat

Johan


 To report this email as spam click https://www.mailcontrol.com/sr/MZbqvYs5QwJvpeaetUwhCQ== .


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
