Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1521668904.13274.10.camel@deako.com>
Subject: BCM43341B0  Frame reassembly failed
From: Brennan Ashton <brn@deako.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 21 Mar 2018 14:48:24 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I recently brought an Intel Edison board with a BCM43341B0 chip up from
4.9 to 4.16.0-rc6 but I am having reliability issues when using
btattach instead of the previous brcm_patchram_plus utility to attach
the device.


The hci communication with the bluetooth chip gets corrupted almost
always when creating a GATT connection.  Thowing "Bluetooth: hci0:
Frame reassembly failed (-84)" and then requiring the device to be
reset to communicate again.

Kernel logs interleaved with attaching the device:
# /usr/bin/btattach --bredr /dev/ttyS0 -P bcm -S 3000000 &
# Attaching Primary controller to /dev/ttyS0
[   53.148206] Bluetooth: HCI UART driver ver 2.3
[   53.152758] Bluetooth: HCI UART protocol H4 registered
[   53.157970] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   53.164512] hci_bcm hci_bcm: hci_bcm device registered.
[   53.170445] Bluetooth: HCI UART protocol Broadcom registered
Switched line discipline from 0 to 15
Device index 0 attached
[   53.333220] Bluetooth: hci0: BCM: chip id 82
[   53.340184] Bluetooth: hci0: BCM: features 0x2f
[   53.368421] Bluetooth: hci0: BCM43341B0
[   53.372338] Bluetooth: hci0: BCM43341B0 (002.001.014) build 0000
[   57.843684] Bluetooth: hci0: BCM (002.001.014) build 0166



Tail of the btmon while it is attached:

> HCI Event: Command Complete (0x0e) plen 4               #299 [hci0]
62.947028
      Broadcom Write RAM (0x3f|0x004c) ncmd 1
        Status: Success (0x00)
< HCI Command: Broadcom Write RAM (0x3f|0x004c) plen 255  #300 [hci0]
62.947488
        Address: 0x000d7a7d
        0f 71 d0 09 dc bc f1 71 0f 6e d0 bc f1 73 0f
6c  .q.....q.n...s.l
        d0 bc f1 75 0f cb d1 29 e1 bc f1 79 0f 76 d0
bc  ...u...)...y.v..
        f1 85 0f 74 d0 bc f1 ad 0f c1 d1 12 e1 a8 78
10  ...t..........x.
        f0 60 0f 07 d1 e9 1c 38 46 fe f7 0b f8 60 f3
1f  .`.....8F....`..
        64 00 28 f2 d1 bd e8 f0 41 ff f7 c6 be e9 1c
38  d.(.....A......8
        46 fd f7 ff ff 28 78 40 1f c2 b2 eb 1d 03 e0
28  F....(x@.......(
        78 40 1e c2 b2 eb 1c a0 21 38 46 fe f7 b6 f9
ee  x@......!8F.....
        e0 e9 1c 38 46 fd f7 ed ff 28 78 40 1f c2 b2
eb  ...8F....(x@....
        1d 03 e0 28 78 40 1e c2 b2 eb 1c 00 21 ec e7
00  ...(x@......!...
        2e 6f d0 b7 70 ea 78 02 23 03 25 54 2a 26 d0
08  .o..p.x.#.%T*&..
        dc 3e 2a 35 d0 51 2a 15 d0 52 2a 08 d1 0a e0
c5  .>*5.Q*..R*.....
        e0 af e0 73 2a 36 d0 79 2a 3d d0 85 2a 42 d0
60  ...s*6.y*=..*B.`
        f3 1f 64 c8 e0 33 70 52 20 70 70 38 46 fd f7 89  ..d..3pR
pp8F...
        ff f0 70 c0 e0 05 20 30 70 51 20 70 70 f1 1c 38  ..p... 0pQ
pp..8
        46 fd f7 8a ff b7 e0 8d e0 62 e0 c4 e0 08 20 30  F........b....
0
        70 54 22 72 70 b0 70 f5 70 31
71                 pT"rp.p.p1q     
< HCI Command: Reset (0x03|0x0003) plen 0                 #301 [hci0]
63.278672
> HCI Event: Command Complete (0x0e) plen 4               #302 [hci0]
63.282869
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Version.. (0x04|0x0001) plen 0  #303 [hci0]
63.390748
> HCI Event: Command Complete (0x0e) plen 12              #304 [hci0]
63.393602
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 166 (0x00a6)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 16654 (0x410e)
        Manufacturer: Broadcom Corporation (15)
          Firmware: 002.001.014 (BCM43341B0)
          Build: 0166
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0          #305 [hci0]
63.639173
> HCI Event: Command Complete (0x0e) plen 10              #306 [hci0]
63.641588
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 43:34:1B:00:1F:AC (OUI 43-34-1B)
< HCI Command: Broadcom Set Slee.. (0x3f|0x0027) plen 12  #307 [hci0]
63.641961
        Sleep mode: UART (0x01)
        02 02 01 01 01 01 00 00 00 00
00                 ...........     
> HCI Event: Command Complete (0x0e) plen 4               #308 [hci0]
63.645219
      Broadcom Set Sleepmode Param (0x3f|0x0027) ncmd 1
        Status: Success (0x00)
< HCI Command: Reset (0x03|0x0003) plen 0                 #309 [hci0]
63.645426
> HCI Event: Command Complete (0x0e) plen 4               #310 [hci0]
63.663325
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)


bluetoothctl interleaved with btmon showing the device advertised and
then the connection starting:


# bluetoothctl
[NEW] Controller 43:34:1B:00:1F:AC TestDevice [default]
Agent registered
[bluetooth]# advertise yes
[bluetooth]# @ Control Command:
0xffff                            {0x0002} [hci0] 111.701388
        3e 00 01 03 00 00 00 00 00 00 00 00
00           >............   
@ MGMT Event: Advertising Added (0x0023) plen 1      {0x0003} [hci0]
111.701423
        Instance: 1
@ MGMT Event: Advertising Added (0x0023) plen 1      {0x0001} [hci0]
111.701423
        Instance: 1
< HCI Command: LE Set Advertisi.. (0x08|0x0008) plen 32  #311 [hci0]
111.701986
        Length: 3
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
> HCI Event: Command Complete (0x0e) plen 4              #312 [hci0]
111.723457
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Resp.. (0x08|0x0009) plen 32  #313 [hci0]
111.723629
        Length: 0
> HCI Event: Command Complete (0x0e) plen 4              #314 [hci0]
111.728550
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertisi.. (0x08|0x0006) plen 15  #315 [hci0]
111.728805
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Public (0x00)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect
Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #316 [hci0]
111.732270
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise... (0x08|0x000a) plen 1  #317 [hci0]
111.732431
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #318 [hci0]
111.734729
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
@ Control Event: 0xffff                              {0x0002} [hci0]
111.734864
        01 00 3e 00 00 01                                ..>...    
[CHG] Controller 43:34:1B:00:1F:AC SupportedInstances: 0x04
[CHG] Controller 43:34:1B:00:1F:AC ActiveInstances: 0x01
Advertising object registered
[bluetooth]# [  363.168061] Bluetooth: hci0: Frame reassembly failed (-
84)
[  363.426183] Bluetooth: hci0: ACL packet for unknown connection
handle 64
> ACL Data RX: Handle 64 flags 0x02 dlen 11              #319 [hci0]
122.280157
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: LE Meta Event (0x3e) plen 10                #320 [hci0]
122.648076
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 64
        Connection interval: 7.50 msec (0x0006)
        Connection latency: 0 (0x0000)
        Supervision timeout: 5000 msec (0x01f4)
[  368.353615] Bluetooth: hci0: ACL packet for unknown connection
handle 64
> ACL Data RX: Handle 64 flags 0x02 dlen 11              #321 [hci0]
127.207585
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
[  373.371672] Bluetooth: hci0: Frame reassembly failed (-84)
[  373.377296] Bluetooth: hci0: Frame reassembly failed (-84)
> HCI Event: Disconnect Complete (0x05) plen 4           #322 [hci0]
137.242761
        Status: Success (0x00)
        Handle: 64



If I change nothing but using this script instead of the btattach I do
not notice any of these issues:

echo 71 > /sys/class/gpio/export || true
echo out > /sys/class/gpio/gpio71/direction
echo 184 > /sys/class/gpio/export || true
echo out > /sys/class/gpio/gpio184/direction

echo 0 > /sys/class/gpio/gpio71/value
echo 0 > /sys/class/gpio/gpio184/value
sleep 1
echo 1 > /sys/class/gpio/gpio71/value
echo 1 > /sys/class/gpio/gpio184/value


/usr/sbin/brcm-patchram-plus                    \
        --use_baudrate_for_download             \
        --no2bytes                              \
        --enable_lpm                            \
        --enable_hci                            \
        --baudrate 3000000                      \
        --patchram /lib/firmware/brcm/BCM43341B0.hcd   \
        --bd_addr "97:4F:EE:03:0F:E8"           \
        -d                                      \
        /dev/ttyS0


Let me know if there is further debugging I can provide on this.

Thanks,
Brennan
