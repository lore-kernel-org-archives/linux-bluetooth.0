Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Emil Lenngren <emil.lenngren@gmail.com>
Date: Tue, 6 Dec 2016 20:35:11 +0000
Message-ID: <CAO1O6seNa8C_q05ViME5SKOV4Rn7isZW6f3jg1zmpK5F5UVU=Q@mail.gmail.com>
Subject: BLE bug: Intel Bluetooth 7260 fails to scan and connect concurrently
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I recently saw on this mailing list that the intel firmware patches
have been updated, so I downloaded the latest firmware to see it being
applied on my Asus TP300L computer with Intel Bluetooth 7260:

[ 2044.429868] usb 1-1.4: new full-speed USB device number 8 using ehci-pci
[ 2044.524374] usb 1-1.4: New USB device found, idVendor=8087, idProduct=07dc
[ 2044.524383] usb 1-1.4: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[ 2044.539193] Bluetooth: hci0: read Intel version: 3707100180012d0d00
[ 2044.539242] Bluetooth: hci0: Intel Bluetooth firmware file:
intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
[ 2044.728245] Bluetooth: hci0: Intel Bluetooth firmware patch
completed and activated
[ 2394.965515] usb 1-1.4: reset full-speed USB device number 8 using ehci-pci
[ 2395.072161] Bluetooth: hci0: read Intel version: 3707100180012d0d27
[ 2395.072167] Bluetooth: hci0: Intel device is already patched. patch num: 27

I have a custom application talking HCI directly and according to the
LE supported states it supports both scanning and initiating a
connection at the same time. But if I start a LE scan and then
initiate a connection, it fails with the error code Connection
Rejected due to Limited Resources (0x0d). If I however do it the other
way around, first starting the connection attempt followed by starting
scan, everything works as normal. This is clearly a bug in the
firmware so I was just wondering if there were any Intel guys here
willing to fix this? I've actually seen the same problem as well on a
cheap Android Asus tablet having some Intel bluetooth chip in a snoop
log.

This is btmon log where it fails:


< HCI Command: Reset (0x03|0x0003) plen 0
                                      [hci0] 2238.125717
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2238.138612
      Reset (0x03|0x0003) ncmd 2
        Status: Success (0x00)
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
                                      [hci0] 2238.138702
> HCI Event: Command Complete (0x0e) plen 12                                                                 [hci0] 2238.139583
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 3584 (0x0e00)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 3584 (0x0e00)
        Manufacturer: Intel Corp. (2)
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0
                                      [hci0] 2238.139624
> HCI Event: Command Complete (0x0e) plen 12                                                                 [hci0] 2238.140580
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000000001fffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
< HCI Command: Set Event Mask (0x03|0x0001) plen 8
                                      [hci0] 2238.140615
        Mask: 0x2000000000018010
          Disconnection Complete
          Hardware Error
          Flush Occurred
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2238.141588
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Set Controller To Host Flow Control (0x03|0x0031) plen
1                                      [hci0] 2238.141631
        Flow control: Off (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2238.142587
      Set Controller To Host Flow Control (0x03|0x0031) ncmd 1
        Status: Success (0x00)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
                                      [hci0] 2238.142628
> HCI Event: Command Complete (0x0e) plen 10                                                                 [hci0] 2238.143580
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 80:19:34:A6:44:B4 (Intel Corporate)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0
                                      [hci0] 2238.143785
> HCI Event: Command Complete (0x0e) plen 7                                                                  [hci0] 2238.144579
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 27
        Num data packets: 7
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0
                                      [hci0] 2238.144607
> HCI Event: Command Complete (0x0e) plen 5                                                                  [hci0] 2238.145573
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 32
< HCI Command: LE Clear White List (0x08|0x0010) plen 0
                                      [hci0] 2238.145649
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2238.146580
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
                                      [hci0] 2238.146610
        Type: Passive (0x00)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2238.147569
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                                      [hci0] 2278.538597
        Scanning: Enabled (0x01)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2278.539579
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
                                      [hci0] 2283.040471
        Address type: Public (0x00)
        Address: 80:E4:DA:70:57:6F (OUI 80-E4-DA)
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2283.041654
      LE Add Device To White List (0x08|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
                                      [hci0] 2283.041752
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is used (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Own address type: Public (0x00)
        Min connection interval: 20.00 msec (0x0010)
        Max connection interval: 25.00 msec (0x0014)
        Connection latency: 0x0000
        Supervision timeout: 200 msec (0x0014)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                    [hci0] 2283.042597
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Connection Rejected due to Limited Resources (0x0d)





And this is the btmon log where the commands are sent in the other order:


< HCI Command: Reset (0x03|0x0003) plen 0
                                      [hci0] 2639.104712
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2639.117781
      Reset (0x03|0x0003) ncmd 2
        Status: Success (0x00)
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
                                      [hci0] 2639.117842
> HCI Event: Command Complete (0x0e) plen 12                                                                 [hci0] 2639.118772
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 3584 (0x0e00)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 3584 (0x0e00)
        Manufacturer: Intel Corp. (2)
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0
                                      [hci0] 2639.118818
> HCI Event: Command Complete (0x0e) plen 12                                                                 [hci0] 2639.119771
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000000001fffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
< HCI Command: Set Event Mask (0x03|0x0001) plen 8
                                      [hci0] 2639.119796
        Mask: 0x2000000000018010
          Disconnection Complete
          Hardware Error
          Flush Occurred
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2639.120773
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Set Controller To Host Flow Control (0x03|0x0031) plen
1                                      [hci0] 2639.120800
        Flow control: Off (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2639.121775
      Set Controller To Host Flow Control (0x03|0x0031) ncmd 1
        Status: Success (0x00)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
                                      [hci0] 2639.121799
> HCI Event: Command Complete (0x0e) plen 10                                                                 [hci0] 2639.122772
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 80:19:34:A6:44:B4 (Intel Corporate)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0
                                      [hci0] 2639.122952
> HCI Event: Command Complete (0x0e) plen 7                                                                  [hci0] 2639.123772
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 27
        Num data packets: 7
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0
                                      [hci0] 2639.123803
> HCI Event: Command Complete (0x0e) plen 5                                                                  [hci0] 2639.124771
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 32
< HCI Command: LE Clear White List (0x08|0x0010) plen 0
                                      [hci0] 2639.124829
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2639.125780
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
                                      [hci0] 2639.125824
        Type: Passive (0x00)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2639.126797
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
                                      [hci0] 2677.822165
        Address type: Public (0x00)
        Address: 80:E4:DA:70:57:6F (OUI 80-E4-DA)
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2677.822857
      LE Add Device To White List (0x08|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
                                      [hci0] 2677.822939
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is used (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Own address type: Public (0x00)
        Min connection interval: 20.00 msec (0x0010)
        Max connection interval: 25.00 msec (0x0014)
        Connection latency: 0x0000
        Supervision timeout: 200 msec (0x0014)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                    [hci0] 2677.823814
      LE Create Connection (0x08|0x000d) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
                                      [hci0] 2686.689549
        Scanning: Enabled (0x01)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                  [hci0] 2686.690890
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
