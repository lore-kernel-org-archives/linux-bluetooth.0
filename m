Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 28 Jul 2016 17:25:45 -0700
From: Christopher Collins <ccollins476ad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Disconnect ~4 seconds after connection complete
Message-ID: <20160729002545.GY3769@pseudoephedrine.nightmare-heaven.no-ip.biz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BZaMRJmqxGScZ8Mx"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

First, my apologies if this is not an appropriate forum for this
question.  Any redirections are appreciated.

I am using an LE controller via UART with btattach.  I am controlling
BlueZ with btmgmt.  The problem is this: every time a connection is
established, the BlueZ host terminates it after about four seconds.
This disconnect occurs regardless of role, and it happens whether or not
data is being sent at the time.  When I use a different controller
(built-in Intel Bluetooth radio), I don't see this problem.

I don't have a log to prove it, but I am pretty certain I have
successfully used the same controller and used the same version of the
BlueZ tools in the past.  Is there perhaps some place where the reason
for the disconnect might get logged?

I am attaching the full btmon, btattach, and btmgmt logs.  Here is an
excerpt showing the connection establishment and disconnect.

> HCI Event: LE Meta Event (0x3e) plen 19                     [hci1] 104.559053
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 1
        Role: Slave (0x01)
        Peer address type: Public (0x00)
        Peer address: 0A:0B:0C:0D:0E:0F (OUI 0A-0B-0C)
        Connection interval: 50.00 msec (0x0028)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 2560 msec (0x0100)
        Master clock accuracy: 0x04
< HCI Command: LE Read Remote Used Fe.. (0x08|0x0016) plen 2  [hci1] 104.559859
        Handle: 1
@ Device Connected: 0A:0B:0C:0D:0E:0F (1) flags 0x0000
> HCI Event: Command Status (0x0f) plen 4                     [hci1] 104.566395
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                     [hci1] 104.710001
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 1
        Features: 0x2d 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Data Packet Length Extension
< HCI Command: Disconnect (0x01|0x0006) plen 3                [hci1] 108.714782
        Handle: 1
        Reason: Remote User Terminated Connection (0x13)

Thanks,
Chris

--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="disconn-btattach.txt"

[admin@bleh:~/Downloads/bluez-5.39]$ sudo tools/btattach -B /dev/ttyUSB0
Attaching BR/EDR controller to /dev/ttyUSB0
Switched line discipline from 0 to 15
Device index 1 attached

--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="disconn-btmgmt.txt"

[admin@bleh:~/Downloads/bluez-5.39]$ sudo tools/btmgmt
[mgmt]# select 1
Selected index 1
[hci1]# static-addr cc:11:22:33:44:55
Static address successfully set
[hci1]# connectable on
hci1 Set Connectable complete, settings: connectable le static-addr
[hci1]# advertising on
hci1 Set Advertising complete, settings: connectable le advertising static-addr
[hci1]# discov on
hci1 Set Discoverable complete, settings: connectable discoverable le advertising static-addr
[hci1]# power on
hci1 Set Powered complete, settings: powered connectable discoverable le advertising static-addr
hci1 0A:0B:0C:0D:0E:0F type LE Public connected eir_len 0
hci1 0A:0B:0C:0D:0E:0F type LE Public disconnected with reason 2
[hci1]#

--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="disconn-btmon.txt"

[admin@bleh:~]$ sudo btmon
[sudo] password for admin:
Bluetooth monitor ver 5.37
= New Index: E0:94:67:A0:61:CA (BR/EDR,USB,hci0)                [hci0] 0.369909
= New Index: 00:00:00:00:00:00 (BR/EDR,UART,hci1)              [hci1] 66.722172
= Open Index: 00:00:00:00:00:00                                [hci1] 66.722190
< HCI Command: Reset (0x03|0x0003) plen 0                      [hci1] 66.725001
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 66.726521
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Supported Fe.. (0x04|0x0003) plen 0  [hci1] 66.726560
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 66.728701
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0x00 0x00 0x00 0x00 0x60 0x00 0x00 0x00
          BR/EDR Not Supported
          LE Supported (Controller)
< HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0  [hci1] 66.728744
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 66.731694
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.2 (0x08) - Revision 0 (0x0000)
        LMP version: Bluetooth 4.2 (0x08) - Subversion 0 (0x0000)
        Manufacturer: internal use (65535)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0               [hci1] 66.731738
> HCI Event: Command Complete (0x0e) plen 10                   [hci1] 66.733468
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0        [hci1] 66.733519
> HCI Event: Command Complete (0x0e) plen 7                    [hci1] 66.735669
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 260
        Num data packets: 7
< HCI Command: LE Read Local Supported.. (0x08|0x0003) plen 0  [hci1] 66.735730
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 66.738465
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0x2d 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Data Packet Length Extension
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0   [hci1] 66.738491
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 66.740503
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000003ffffffffff
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
          Low Duty Cycle Directed Advertising State
          Low Duty Cycle Directed Advertising State
            and Passive Scanning State
          Low Duty Cycle Directed Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Initiating State
            and Master Role & Slave Role
          High Duty Cycle Directed Advertising State
            and Initiating State
            and Master Role & Slave Role
          Low Duty Cycle Directed Advertising State
            and Initiating State
            and Master Role & Slave Role
          Connectable Advertising State
            and Connection State (Master Role)
            and Master Role & Slave Role
          High Duty Cycle Directed Advertising State
            and Connection State (Master Role)
            and Master Role & Slave Role
          Low Duty Cycle Directed Advertising State
            and Connection State (Master Role)
            and Master Role & Slave Role
          Connectable Advertising State
            and Connection State (Slave Role)
            and Master Role & Slave Role
          High Duty Cycle Directed Advertising State
            and Connection State (Slave Role)
            and Slave Role & Slave Role
          Low Duty Cycle Directed Advertising State
            and Connection State (Slave Role)
            and Slave Role & Slave Role
          Initiating State
            and Connection State (Slave Role)
            and Master Role & Slave Role
< HCI Command: Read Local Supported Co.. (0x04|0x0002) plen 0  [hci1] 66.740544
> HCI Event: Command Complete (0x0e) plen 68                   [hci1] 66.747457
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 34 entries
          Disconnect (Octet 0 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read BD ADDR (Octet 15 - Bit 1)
          Read RSSI (Octet 15 - Bit 5)
          LE Set Event Mask (Octet 25 - Bit 0)
          LE Read Buffer Size (Octet 25 - Bit 1)
          LE Read Local Supported Features (Octet 25 - Bit 2)
          LE Set Random Address (Octet 25 - Bit 4)
          LE Set Advertising Parameters (Octet 25 - Bit 5)
          LE Read Advertising Channel TX Power (Octet 25 - Bit 6)
          LE Set Advertising Data (Octet 25 - Bit 7)
          LE Set Scan Response Data (Octet 26 - Bit 0)
          LE Set Advertise Enable (Octet 26 - Bit 1)
          LE Set Scan Parameters (Octet 26 - Bit 2)
          LE Set Scan Enable (Octet 26 - Bit 3)
          LE Create Connection (Octet 26 - Bit 4)
          LE Create Connection Cancel (Octet 26 - Bit 5)
          LE Read White List Size (Octet 26 - Bit 6)
          LE Clear White List (Octet 26 - Bit 7)
          LE Add Device To White List (Octet 27 - Bit 0)
          LE Remove Device From White List (Octet 27 - Bit 1)
          LE Connection Update (Octet 27 - Bit 2)
          LE Set Host Channel Classification (Octet 27 - Bit 3)
          LE Read Channel Map (Octet 27 - Bit 4)
          LE Read Remote Used Features (Octet 27 - Bit 5)
          LE Encrypt (Octet 27 - Bit 6)
          LE Rand (Octet 27 - Bit 7)
          LE Start Encryption (Octet 28 - Bit 0)
          LE Read Supported States (Octet 28 - Bit 3)
          LE Remote Connection Parameter Request Reply (Octet 33 - Bit 4)
          LE Remote Connection Parameter Request Negative Reply (Octet 33 - Bit 5)
          LE Read Maximum Data Length (Octet 35 - Bit 3)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8             [hci1] 66.747525
        Mask: 0x200080000204e890
          Disconnection Complete
          Encryption Change
          Read Remote Version Information Complete
          Command Complete
          Command Status
          Hardware Error
          Number of Completed Packets
          Data Buffer Overflow
          Encryption Key Refresh Complete
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 66.749456
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8          [hci1] 66.749494
        Mask: 0x000000000000005f
          LE Connection Complete
          LE Advertising Report
          LE Connection Update Complete
          LE Read Remote Used Features Complete
          LE Long Term Key Request
          LE Data Length Change
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 66.751446
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Advertising Cha.. (0x08|0x0007) plen 0  [hci1] 66.751472
> HCI Event: Command Complete (0x0e) plen 5                    [hci1] 66.753446
      LE Read Advertising Channel TX Power (0x08|0x0007) ncmd 1
        Status: Success (0x00)
        TX power: 0 dBm
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0    [hci1] 66.753480
> HCI Event: Command Complete (0x0e) plen 5                    [hci1] 66.755545
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 8
< HCI Command: LE Clear White List (0x08|0x0010) plen 0        [hci1] 66.755597
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 66.757443
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum Data Le.. (0x08|0x002f) plen 0  [hci1] 66.757480
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 66.759673
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120
< HCI Command: LE Read Suggested Defau.. (0x08|0x0023) plen 0  [hci1] 66.759735
> HCI Event: Command Complete (0x0e) plen 8                    [hci1] 66.761496
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 27
        TX time: 328
= Index Info: 00:00:00:00:00:00 (internal use)                 [hci1] 66.761590
= Close Index: 00:00:00:00:00:00                               [hci1] 66.761606
@ Index Added
@ New Settings: 0x8200
            le static-addr
@ New Settings: 0x8202
            connectable le static-addr
@ New Settings: 0x8602
            connectable le advertising static-addr
@ New Settings: 0x860a
            connectable discoverable le advertising static-addr
= Open Index: 00:00:00:00:00:00                                [hci1] 94.233853
< HCI Command: Reset (0x03|0x0003) plen 0                      [hci1] 94.233918
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 94.235466
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Supported Fe.. (0x04|0x0003) plen 0  [hci1] 94.235534
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 94.237463
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0x00 0x00 0x00 0x00 0x60 0x00 0x00 0x00
          BR/EDR Not Supported
          LE Supported (Controller)
< HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0  [hci1] 94.237762
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 94.240445
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.2 (0x08) - Revision 0 (0x0000)
        LMP version: Bluetooth 4.2 (0x08) - Subversion 0 (0x0000)
        Manufacturer: internal use (65535)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0               [hci1] 94.240740
> HCI Event: Command Complete (0x0e) plen 10                   [hci1] 94.242449
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0        [hci1] 94.242841
> HCI Event: Command Complete (0x0e) plen 7                    [hci1] 94.244454
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 260
        Num data packets: 7
< HCI Command: LE Read Local Supported.. (0x08|0x0003) plen 0  [hci1] 94.244737
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 94.247419
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0x2d 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Data Packet Length Extension
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0   [hci1] 94.247692
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 94.250417
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000003ffffffffff
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
          Low Duty Cycle Directed Advertising State
          Low Duty Cycle Directed Advertising State
            and Passive Scanning State
          Low Duty Cycle Directed Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Initiating State
            and Master Role & Slave Role
          High Duty Cycle Directed Advertising State
            and Initiating State
            and Master Role & Slave Role
          Low Duty Cycle Directed Advertising State
            and Initiating State
            and Master Role & Slave Role
          Connectable Advertising State
            and Connection State (Master Role)
            and Master Role & Slave Role
          High Duty Cycle Directed Advertising State
            and Connection State (Master Role)
            and Master Role & Slave Role
          Low Duty Cycle Directed Advertising State
            and Connection State (Master Role)
            and Master Role & Slave Role
          Connectable Advertising State
            and Connection State (Slave Role)
            and Master Role & Slave Role
          High Duty Cycle Directed Advertising State
            and Connection State (Slave Role)
            and Slave Role & Slave Role
          Low Duty Cycle Directed Advertising State
            and Connection State (Slave Role)
            and Slave Role & Slave Role
          Initiating State
            and Connection State (Slave Role)
            and Master Role & Slave Role
< HCI Command: Read Local Supported Co.. (0x04|0x0002) plen 0  [hci1] 94.250686
> HCI Event: Command Complete (0x0e) plen 68                   [hci1] 94.258419
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 34 entries
          Disconnect (Octet 0 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read BD ADDR (Octet 15 - Bit 1)
          Read RSSI (Octet 15 - Bit 5)
          LE Set Event Mask (Octet 25 - Bit 0)
          LE Read Buffer Size (Octet 25 - Bit 1)
          LE Read Local Supported Features (Octet 25 - Bit 2)
          LE Set Random Address (Octet 25 - Bit 4)
          LE Set Advertising Parameters (Octet 25 - Bit 5)
          LE Read Advertising Channel TX Power (Octet 25 - Bit 6)
          LE Set Advertising Data (Octet 25 - Bit 7)
          LE Set Scan Response Data (Octet 26 - Bit 0)
          LE Set Advertise Enable (Octet 26 - Bit 1)
          LE Set Scan Parameters (Octet 26 - Bit 2)
          LE Set Scan Enable (Octet 26 - Bit 3)
          LE Create Connection (Octet 26 - Bit 4)
          LE Create Connection Cancel (Octet 26 - Bit 5)
          LE Read White List Size (Octet 26 - Bit 6)
          LE Clear White List (Octet 26 - Bit 7)
          LE Add Device To White List (Octet 27 - Bit 0)
          LE Remove Device From White List (Octet 27 - Bit 1)
          LE Connection Update (Octet 27 - Bit 2)
          LE Set Host Channel Classification (Octet 27 - Bit 3)
          LE Read Channel Map (Octet 27 - Bit 4)
          LE Read Remote Used Features (Octet 27 - Bit 5)
          LE Encrypt (Octet 27 - Bit 6)
          LE Rand (Octet 27 - Bit 7)
          LE Start Encryption (Octet 28 - Bit 0)
          LE Read Supported States (Octet 28 - Bit 3)
          LE Remote Connection Parameter Request Reply (Octet 33 - Bit 4)
          LE Remote Connection Parameter Request Negative Reply (Octet 33 - Bit 5)
          LE Read Maximum Data Length (Octet 35 - Bit 3)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8             [hci1] 94.258904
        Mask: 0x200080000204e890
          Disconnection Complete
          Encryption Change
          Read Remote Version Information Complete
          Command Complete
          Command Status
          Hardware Error
          Number of Completed Packets
          Data Buffer Overflow
          Encryption Key Refresh Complete
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 94.261409
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8          [hci1] 94.261740
        Mask: 0x000000000000005f
          LE Connection Complete
          LE Advertising Report
          LE Connection Update Complete
          LE Read Remote Used Features Complete
          LE Long Term Key Request
          LE Data Length Change
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 94.264421
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Advertising Cha.. (0x08|0x0007) plen 0  [hci1] 94.264694
> HCI Event: Command Complete (0x0e) plen 5                    [hci1] 94.266410
      LE Read Advertising Channel TX Power (0x08|0x0007) ncmd 1
        Status: Success (0x00)
        TX power: 0 dBm
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0    [hci1] 94.266684
> HCI Event: Command Complete (0x0e) plen 5                    [hci1] 94.268413
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 8
< HCI Command: LE Clear White List (0x08|0x0010) plen 0        [hci1] 94.268815
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 94.270413
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum Data Le.. (0x08|0x002f) plen 0  [hci1] 94.270468
> HCI Event: Command Complete (0x0e) plen 12                   [hci1] 94.272431
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120
< HCI Command: LE Read Suggested Defau.. (0x08|0x0023) plen 0  [hci1] 94.272722
> HCI Event: Command Complete (0x0e) plen 8                    [hci1] 94.274410
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 27
        TX time: 328
= Index Info: 00:00:00:00:00:00 (internal use)                 [hci1] 94.274826
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32   [hci1] 94.274850
        Length: 6
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        TX power: 0 dBm
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 94.279382
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci1] 94.279653
        Address: CC:11:22:33:44:55 (Static)
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 94.281388
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertising Par.. (0x08|0x0006) plen 15  [hci1] 94.281719
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Random (0x01)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 94.284391
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1    [hci1] 94.284764
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci1] 94.286500
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
@ New Settings: 0x860b
            powered connectable discoverable le advertising static-addr
> HCI Event: LE Meta Event (0x3e) plen 19                     [hci1] 104.559053
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 1
        Role: Slave (0x01)
        Peer address type: Public (0x00)
        Peer address: 0A:0B:0C:0D:0E:0F (OUI 0A-0B-0C)
        Connection interval: 50.00 msec (0x0028)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 2560 msec (0x0100)
        Master clock accuracy: 0x04
< HCI Command: LE Read Remote Used Fe.. (0x08|0x0016) plen 2  [hci1] 104.559859
        Handle: 1
@ Device Connected: 0A:0B:0C:0D:0E:0F (1) flags 0x0000
> HCI Event: Command Status (0x0f) plen 4                     [hci1] 104.566395
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                     [hci1] 104.710001
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 1
        Features: 0x2d 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Data Packet Length Extension
< HCI Command: Disconnect (0x01|0x0006) plen 3                [hci1] 108.714782
        Handle: 1
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                     [hci1] 108.717201
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                [hci1] 108.759271
        Status: Success (0x00)
        Handle: 1
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 0A:0B:0C:0D:0E:0F (1) reason 2
< HCI Command: LE Set Advertising Pa.. (0x08|0x0006) plen 15  [hci1] 108.786539
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Random (0x01)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4                   [hci1] 108.789161
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1   [hci1] 108.789206
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                   [hci1] 108.791541
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)



--BZaMRJmqxGScZ8Mx--
