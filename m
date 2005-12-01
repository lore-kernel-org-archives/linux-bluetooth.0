Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <438EBCF9.4090909@web.de>
From: Orkan Eryilmaz <ivzork@web.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] l2cap Connection refused
References: <1481541716@web.de> <1133210301.31513.60.camel@blade>
In-Reply-To: <1133210301.31513.60.camel@blade>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 01 Dec 2005 10:06:01 +0100

Hi Marcel,

Thanks for the support.  Meanwhile I updated to Ubuntu 5.10 but had the same problem.

By luck I found a way to get the USB-Bluetootch run but it is not the most convenient one.

When I type as root the command: sudo /etc/init.d/bluez-utils restart

and after that the sudo ciptool search 

suddenly the bluetooth connection is establishe and I can connect to the internet.

But following you will find as feedback to the proposed command:

orkan@ubuntu510:~$ sudo hcidump -X -V

Password:

HCI sniffer - Bluetooth packet analyzer ver 1.23

device: hci0 snap_len: 1028 filter: 0xffffffff

on a second terminal I typed in the command

sudo ciptool search (without to restart bluetooth) and received following:

< HCI Command: Inquiry (0x01|0x0001) plen 5

    lap 0x9e8b33 len 8 num 0

> HCI Event: Command Status (0x0f) plen 4

    Inquiry (0x01|0x0001) status 0x00 ncmd 1

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:04:0E:8B:74:E1 mode 1 clkoffset 0x2a11 class 0x420214

> HCI Event: Inquiry Complete (0x01) plen 1

    status 0x00

< HCI Command: Create Connection (0x01|0x0005) plen 13

    bdaddr 00:04:0E:8B:74:E1 ptype 0xcc18 rswitch 0x01 clkoffset 0x2a11 (valid)

    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

> HCI Event: Command Status (0x0f) plen 4

    Create Connection (0x01|0x0005) status 0x00 ncmd 1

> HCI Event: Connect Complete (0x03) plen 11

    status 0x00 handle 1 bdaddr 00:04:0E:8B:74:E1 type ACL encrypt 0x00

< ACL data: handle 1 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

    handle 1 policy 0x0f

    Link policy: RSWITCH HOLD SNIFF PARK

> HCI Event: Command Complete (0x0e) plen 6

    Write Link Policy Settings (0x02|0x000d) ncmd 1

    status 0x00 handle 1

> HCI Event: Max Slots Change (0x1b) plen 3

    handle 1 slots 5

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 1 packets 1

> ACL data: handle 1 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 0 status 0

      Connection successful

< ACL data: handle 1 flags 0x02 dlen 12

    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 0

> ACL data: handle 1 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

      MTU 672

< ACL data: handle 1 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0

      Success

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 1 packets 1

> ACL data: handle 1 flags 0x02 dlen 18

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4

      Success

      MTU 672

< ACL data: handle 1 flags 0x02 dlen 22

    L2CAP(d): cid 0x0044 len 18 [psm 1]

        SDP SSA Req: tid 0x0 len 0xd

          pat uuid-16 0x1128 (CIP)

          max 65535

          aid(s) 0x0004 (ProtocolDescList)

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 1 packets 1

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 1 packets 1

> ACL data: handle 1 flags 0x02 dlen 34

    L2CAP(d): cid 0x0040 len 30 [psm 1]

        SDP SSA Rsp: tid 0x0 len 0x19

          count 22

          record #0

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) uint 0x1003 > <

                 uuid-16 0x001b (CMTP) > >

          cont 00

< ACL data: handle 1 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0044 scid 0x0040

< ACL data: handle 1 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 4099 scid 0x0041

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 1 packets 1

> ACL data: handle 1 flags 0x02 dlen 12

    L2CAP(s): Disconn rsp: dcid 0x0044 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 1 packets 1

> ACL data: handle 1 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0041 result 1 status 1

      Connection pending - Authentication pending

> HCI Event: Role Change (0x12) plen 8

    status 0x00 bdaddr 00:04:0E:8B:74:E1 role 0x01

    Role: Slave

> HCI Event: Link Key Request (0x17) plen 6

    bdaddr 00:04:0E:8B:74:E1

< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22

    bdaddr 00:04:0E:8B:74:E1 key 8A0705CD073CD2E28621DD396993975F

> HCI Event: Command Complete (0x0e) plen 10

    Link Key Request Reply (0x01|0x000b) ncmd 1

    status 0x00 bdaddr 00:04:0E:8B:74:E1

> HCI Event: Max Slots Change (0x1b) plen 3

    handle 1 slots 5

> HCI Event: PIN Code Request (0x16) plen 6

    bdaddr 00:04:0E:8B:74:E1

< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6

    bdaddr 00:04:0E:8B:74:E1

> HCI Event: Command Complete (0x0e) plen 10

    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1

    status 0x06 bdaddr 00:04:0E:8B:74:E1

    Error: PIN or Key Missing

> ACL data: handle 1 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0041 result 3 status 0

      Connection refused - security block

< HCI Command: Disconnect (0x01|0x0006) plen 3

    handle 1 reason 0x13

    Reason: Remote User Terminated Connection

> HCI Event: Command Status (0x0f) plen 4

    Disconnect (0x01|0x0006) status 0x00 ncmd 1

> HCI Event: Disconn Complete (0x05) plen 4

    status 0x00 handle 1 reason 0x16

    Reason: Connection Terminated by Local Host

After restarting the bluetooth (sudo /etc/init.d/bluez-utils restart) following came up.

orkan@ubuntu510:~$ sudo hcidump -X -V

HCI sniffer - Bluetooth packet analyzer ver 1.23

device: hci0 snap_len: 1028 filter: 0xffffffff

< HCI Command: Write Scan Enable (0x03|0x001a) plen 1

    enable 3

> HCI Event: Command Complete (0x0e) plen 4

    Write Scan Enable (0x03|0x001a) ncmd 1

    status 0x00

< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7

    bdaddr 00:00:00:00:00:00 all 1

> HCI Event: Command Complete (0x0e) plen 8

    Read Stored Link Key (0x03|0x000d) ncmd 1

    status 0x00 max 8 num 0

< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1

    enable 0

> HCI Event: Command Complete (0x0e) plen 4

    Write Authentication Enable (0x03|0x0020) ncmd 1

    status 0x00

< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1

    enable 0

> HCI Event: Command Complete (0x0e) plen 4

    Write Authentication Enable (0x03|0x0020) ncmd 1

    status 0x00

< HCI Command: Write Encryption Mode (0x03|0x0022) plen 1

    mode 0

> HCI Event: Command Complete (0x0e) plen 4

    Write Encryption Mode (0x03|0x0022) ncmd 1

    status 0x00

< HCI Command: Write Local Name (0x03|0x0013) plen 248

    name 'ubuntu510-0'

> HCI Event: Command Complete (0x0e) plen 4

    Write Local Name (0x03|0x0013) ncmd 1

    status 0x00

< HCI Command: Write Class of Device (0x03|0x0024) plen 3

    class 0x3e0100

> HCI Event: Command Complete (0x0e) plen 4

    Write Class of Device (0x03|0x0024) ncmd 1

    status 0x00

Aganin the command hcidump -X -V but with established ciptool search command

orkan@ubuntu510:~$ sudo hcidump -X -V

HCI sniffer - Bluetooth packet analyzer ver 1.23

device: hci0 snap_len: 1028 filter: 0xffffffff

< HCI Command: Inquiry (0x01|0x0001) plen 5

    lap 0x9e8b33 len 8 num 0

> HCI Event: Command Status (0x0f) plen 4

    Inquiry (0x01|0x0001) status 0x00 ncmd 1

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:04:0E:8B:74:E1 mode 1 clkoffset 0x2a0d class 0x420214

> HCI Event: Inquiry Complete (0x01) plen 1

    status 0x00

< HCI Command: Create Connection (0x01|0x0005) plen 13

    bdaddr 00:04:0E:8B:74:E1 ptype 0xcc18 rswitch 0x01 clkoffset 0x2a0d (valid)

    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

> HCI Event: Command Status (0x0f) plen 4

    Create Connection (0x01|0x0005) status 0x00 ncmd 1

> HCI Event: Connect Complete (0x03) plen 11

    status 0x00 handle 2 bdaddr 00:04:0E:8B:74:E1 type ACL encrypt 0x00

< ACL data: handle 2 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

    handle 2 policy 0x0f

    Link policy: RSWITCH HOLD SNIFF PARK

> HCI Event: Command Complete (0x0e) plen 6

    Write Link Policy Settings (0x02|0x000d) ncmd 1

    status 0x00 handle 2

> HCI Event: Max Slots Change (0x1b) plen 3

    handle 2 slots 5

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

> ACL data: handle 2 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0040 result 0 status 0

      Connection successful

< ACL data: handle 2 flags 0x02 dlen 12

    L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 0

> ACL data: handle 2 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

      MTU 672

< ACL data: handle 2 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0

      Success

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

> ACL data: handle 2 flags 0x02 dlen 18

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4

      Success

      MTU 672

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

< ACL data: handle 2 flags 0x02 dlen 22

    L2CAP(d): cid 0x0046 len 18 [psm 1]

        SDP SSA Req: tid 0x0 len 0xd

          pat uuid-16 0x1128 (CIP)

          max 65535

          aid(s) 0x0004 (ProtocolDescList)

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

> ACL data: handle 2 flags 0x02 dlen 34

    L2CAP(d): cid 0x0040 len 30 [psm 1]

        SDP SSA Rsp: tid 0x0 len 0x19

          count 22

          record #0

              aid 0x0004 (ProtocolDescList)

                 < < uuid-16 0x0100 (L2CAP) uint 0x1003 > <

                 uuid-16 0x001b (CMTP) > >

          cont 00

< ACL data: handle 2 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0046 scid 0x0040

< ACL data: handle 2 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 4099 scid 0x0041

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

> ACL data: handle 2 flags 0x02 dlen 12

    L2CAP(s): Disconn rsp: dcid 0x0046 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

> ACL data: handle 2 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0041 result 1 status 1

      Connection pending - Authentication pending

> HCI Event: Role Change (0x12) plen 8

    status 0x00 bdaddr 00:04:0E:8B:74:E1 role 0x01

    Role: Slave

> HCI Event: PIN Code Request (0x16) plen 6

    bdaddr 00:04:0E:8B:74:E1

< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23

    bdaddr 00:04:0E:8B:74:E1 len 16 pin '****************'

> HCI Event: Command Complete (0x0e) plen 10

    PIN Code Request Reply (0x01|0x000d) ncmd 1

    status 0x00 bdaddr 00:04:0E:8B:74:E1

> HCI Event: Max Slots Change (0x1b) plen 3

    handle 2 slots 5

> HCI Event: Link Key Notification (0x18) plen 23

    bdaddr 00:04:0E:8B:74:E1 key 146FD4D8C2F3AAEFC0017E7EA7B19381 type 0

> HCI Event: Encrypt Change (0x08) plen 4

    status 0x00 handle 2 encrypt 0x01

> ACL data: handle 2 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0041 result 0 status 0

      Connection successful

< ACL data: handle 2 flags 0x02 dlen 12

    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 0

> ACL data: handle 2 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4

      MTU 672

< ACL data: handle 2 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0

      Success

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

> ACL data: handle 2 flags 0x02 dlen 18

    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4

      Success

      MTU 672

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

< ACL data: handle 2 flags 0x02 dlen 24

    L2CAP(d): cid 0x0047 len 20 [psm 4099]

      CMTP: complete CAPI Message: id 0 len 18

        CAPI_INTEROPERABILITY_REQ: appl 65535 msgnum 65280 len 10

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 2 (Get_Profile)

            Controller: 0

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

> ACL data: handle 2 flags 0x02 dlen 89

    L2CAP(d): cid 0x0041 len 85 [psm 4099]

      CMTP: complete CAPI Message: id 0 len 83

        CAPI_INTEROPERABILITY_CONF: appl 65535 msgnum 65280 len 75

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 2 (Get_Profile)

            Info: 0x0000 (No error)

            Number of controllers: 1

< ACL data: handle 2 flags 0x02 dlen 84

    L2CAP(d): cid 0x0047 len 80 [psm 4099]

      CMTP: complete CAPI Message: id 0 len 18

        CAPI_INTEROPERABILITY_REQ: appl 65535 msgnum 65281 len 10

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 3 (Get_Manufacturer)

            Controller: 1

      CMTP: complete CAPI Message: id 0 len 18

        CAPI_INTEROPERABILITY_REQ: appl 65535 msgnum 65282 len 10

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 4 (Get_Version)

            Controller: 1

      CMTP: complete CAPI Message: id 0 len 18

        CAPI_INTEROPERABILITY_REQ: appl 65535 msgnum 65283 len 10

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 5 (Get_Serial_Number)

            Controller: 1

      CMTP: complete CAPI Message: id 0 len 18

        CAPI_INTEROPERABILITY_REQ: appl 65535 msgnum 65284 len 10

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 2 (Get_Profile)

            Controller: 1

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 2 packets 1

> ACL data: handle 2 flags 0x02 dlen 40

    L2CAP(d): cid 0x0041 len 36 [psm 4099]

      CMTP: complete CAPI Message: id 0 len 34

        CAPI_INTEROPERABILITY_CONF: appl 65535 msgnum 65281 len 26

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 3 (Get_Manufacturer)

            Info: 0x0000 (No error)

            Controller: 1

            Identification: "AVM Berlin"

> ACL data: handle 2 flags 0x02 dlen 46

    L2CAP(d): cid 0x0041 len 42 [psm 4099]

      CMTP: complete CAPI Message: id 0 len 40

        CAPI_INTEROPERABILITY_CONF: appl 65535 msgnum 65282 len 32

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 4 (Get_Version)

            Return value: 0x0000

            Controller: 1

            CAPI: 2.0

            Manufacture: 3.101-04 (49.20)

> ACL data: handle 2 flags 0x02 dlen 38

    L2CAP(d): cid 0x0041 len 34 [psm 4099]

      CMTP: complete CAPI Message: id 0 len 32

        CAPI_INTEROPERABILITY_CONF: appl 65535 msgnum 65283 len 24

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 5 (Get_Serial_Number)

            Return value: 0x0000

            Controller: 1

            Serial number: 0750817

> ACL data: handle 2 flags 0x02 dlen 89

    L2CAP(d): cid 0x0041 len 85 [psm 4099]

      CMTP: complete CAPI Message: id 0 len 83

        CAPI_INTEROPERABILITY_CONF: appl 65535 msgnum 65284 len 75

          Selector: 0x0001 (Bluetooth Device Management)

          Function: 2 (Get_Profile)

            Info: 0x0000 (No error)

            Controller: 1

            Number of B-channels: 2

            Global options: 0x0031

            B1 protocol support: 0xc000000f

            B2 protocol support: 0x00000b0b

            B3 protocol support: 0x8000000f

            Manufacturer-specific information:

            01 00 00 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00

By the way I also have to run the command capiinit to start internet connection.  Is 
there a way to automise the complete procedure and without root privileges?  My wife 
should also connect to the internet without my help.

Thank you in advance.

Orkan



Marcel Holtmann schrieb:

>Hi Orkan,
>
>  
>
>>this is the first time that I post a question to the mailing list.
>>A couple of days ago I bought an AVM Bluefritz Bluetooth set to connect my PC to the internet.
>>Unfortunately I was not able to set this up for my Ubuntu Linux (5.04).
>>After a serious internet research I achieved a point where I do need help by "linux professionals" because I tried out alot.
>>
>>When I type following:
>>
>>orkan@ubuntu:~$ sudo hcitool scan
>>Scanning ...
>>        00:04:03:02:93:41       Bluetooth ISDN Access Point
>>orkan@ubuntu:~$
>>
>>I find an access point.
>>
>>When I type following: 
>>
>>orkan@ubuntu:~$ sudo ciptool search
>>Searching ...
>>        Checking service for 00:04:0E:8B:74:E1
>>        Connecting to device 00:04:0E:8B:74:E1
>>Can't connect L2CAP socket: Connection refused
>>orkan@ubuntu:~$
>>
>>I receive that L2CAP connection was refused.  
>>My pin is set in the file /etc/bluetooth/pin and I also tried to edit the bluepin-perl-skript.  For Ubuntu it is /usr/bin/bluepin.  I followed the instructions from Marcel Holtmann.
>>
>>Would you be so kind and can give me support that I can connect via Linux and bluetooth to the internet?
>>    
>>
>
>run "hcidump -X -V" as in root in another terminal window and see what
>happens.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>  
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
