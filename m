Return-Path: <georg@chini.tk>
Subject: Re: SCO socket MTU problem in PulseAudio
To: Marcel Holtmann <marcel@holtmann.org>, Tanu Kaskinen <tanuk@iki.fi>
References: <1485867673.2993.5.camel@iki.fi>
 <A00CAB7E-3131-4430-8AEA-4132E28CE8FE@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
        Renjith Thomas <renjith@lightlevitate.com>
From: Georg Chini <georg@chini.tk>
Message-ID: <c7e8dbd8-37be-035b-b432-d2225029984c@chini.tk>
Date: Sat, 4 Feb 2017 13:37:34 +0100
MIME-Version: 1.0
In-Reply-To: <A00CAB7E-3131-4430-8AEA-4132E28CE8FE@holtmann.org>
Content-Type: multipart/mixed;
 boundary="------------1F138D78D00B5403B0A4082E"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------1F138D78D00B5403B0A4082E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 01.02.2017 20:47, Marcel Holtmann wrote:
> Hi Tanu,
>
>> PulseAudio recently started to use
>>
>>     getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len);
>>     read_mtu = sco_opt.mtu;
>>     write_mtu = sco_opt.mtu;
>>
>> to query the MTU of the SCO socket. Previously we used a fixed value of
>> 48, but that didn't work for some bluetooth chipsets (see the commit
>> message[1]). Now, however, it was reported[2] that the new code doesn't
>> work on some hardware where the old fixed MTU used to work.
> can you share details here and btmon traces for the data buffer sizes and the USB descriptor details. We would need to figure out where this goes wrong and maybe introduce some driver quirks to ensure that it returns usable values.
>
> Regards
>
> Marcel
>
Hi Marcel,

attached you find the btmon trace. The headset connects OK, so
this is just what happens when I try to play back something to the
HSP sink. The symptom is that I cannot hear anything and the
headset disconnects after a while. Maybe this is a bug in the headset?
The device is a Plantronics Backbeat Pro, I have the same issue with
an older 590Plantronics. Recording works, but I see in the trace
that recording still uses an MTU of 48.
Let me know if you need more information.

Regards
              Georg


--------------1F138D78D00B5403B0A4082E
Content-Type: text/plain; charset=UTF-8;
 name="btmon_64.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="btmon_64.txt"

Bluetooth monitor ver 5.28
* Unknown packet (code 12 len 29)                           [hci65535] 0.116051
        4c 69 6e 75 78 20 76 65 72 73 69 6f 6e 20 34 2e  Linux version 4.
        39 2e 30 20 28 78 38 36 5f 36 34 29 00           9.0 (x86_64).   
* Unknown packet (code 12 len 33)                           [hci65535] 0.116054
        42 6c 75 65 74 6f 6f 74 68 20 73 75 62 73 79 73  Bluetooth subsys
        74 65 6d 20 76 65 72 73 69 6f 6e 20 32 2e 32 32  tem version 2.22
        00                                               .               
= New Index: 00:15:83:73:FD:06 (BR/EDR,USB,hci0)                [hci0] 0.116056
* Unknown packet (code 8 len 0)                                 [hci0] 0.116056
* Unknown packet (code 10 len 8)                                [hci0] 0.116057
        06 fd 73 83 15 00 0a 00                          ..s.....        
= New Index: 00:18:E4:07:2B:C8 (BR/EDR,USB,hci1)                [hci1] 0.116057
* Unknown packet (code 8 len 0)                                 [hci1] 0.116058
* Unknown packet (code 10 len 8)                                [hci1] 0.116058
        c8 2b 07 e4 18 00 0a 00                          .+......        
* Unknown packet (code 14 len 30)                           [hci65535] 0.116060
        01 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 6c  ..............bl
        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
* Unknown packet (code 14 len 30)                           [hci65535] 0.116080
        02 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 74  ..............bt
        6d 6f 6e 00 00 00 00 00 00 00 00 00 00 00        mon...........  
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.123172
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.123178
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.123178
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.123179
< SCO Data TX: Handle 45 flags 0x00 dlen 64                     [hci0] 0.123304
< SCO Data TX: Handle 45 flags 0x00 dlen 64                     [hci0] 0.123317
< SCO Data TX: Handle 45 flags 0x00 dlen 64                     [hci0] 0.123332
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.133178
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.133182
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.133183
< SCO Data TX: Handle 45 flags 0x00 dlen 64                     [hci0] 0.133299
< SCO Data TX: Handle 45 flags 0x00 dlen 64                     [hci0] 0.133343
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.143188
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.143194
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.143195
< SCO Data TX: Handle 45 flags 0x00 dlen 64                     [hci0] 0.143327
< SCO Data TX: Handle 45 flags 0x00 dlen 64                     [hci0] 0.143339
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.153174
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.153179
> SCO Data RX: Handle 45 flags 0x00 dlen 48                     [hci0] 0.153180

... this goes on for a while ...

> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 13.992896
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 13.993218
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 13.993317
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.002893
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.002901
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.002902
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.003168
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.003243
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.012775
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.012783
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.012785
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.012786
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.013005
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.013119
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.013206
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.022899
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.022907
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.022908
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.023263
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.023274
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.023278
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.032762
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.032770
> SCO Data RX: Handle 45 flags 0x00 dlen 48                    [hci0] 14.032770
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.033090
< SCO Data TX: Handle 45 flags 0x00 dlen 64                    [hci0] 14.033102
@ Class of Device Changed: 0x000000
@ New Settings: 0x0090
            bondable br/edr 
* Unknown packet (code 17 len 9)                               [hci0] 14.067817
        02 00 00 00 07 00 00 00 00                       .........       
* Unknown packet (code 17 len 9)                               [hci0] 14.067817
        01 00 00 00 07 00 00 00 00                       .........       
* Unknown packet (code 17 len 10)                              [hci0] 14.067836
        02 00 00 00 06 00 90 00 00 00                    ..........      
* Unknown packet (code 17 len 10)                              [hci0] 14.067836
        01 00 00 00 06 00 90 00 00 00                    ..........      
* Unknown packet (code 9 len 0)                                [hci0] 14.165887
* Unknown packet (code 17 len 6)                               [hci0] 14.165896
        02 00 00 00 05 00                                ......          
* Unknown packet (code 17 len 6)                               [hci0] 14.165896
        01 00 00 00 05 00                                ......          
= Delete Index: 00:15:83:73:FD:06                              [hci0] 14.165904
@ Index Removed
= New Index: 00:00:00:00:00:00 (BR/EDR,USB,hci0)               [hci0] 16.719636
* Unknown packet (code 8 len 0)                                [hci0] 16.719775
< HCI Command: Reset (0x03|0x0003) plen 0                      [hci0] 16.719820
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 16.720462
      NOP (0x00|0x0000) ncmd 1
        Status: Success (0x00)
* Unknown packet (code 14 len 30)                          [hci65535] 16.743847
        03 00 00 00 00 00 02 16 00 01 00 00 00 10 68 63  ..............hc
        69 63 6f 6e 66 69 67 00 00 00 00 00 00 00        iconfig.......  
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 16.884445
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Supported Fe.. (0x04|0x0003) plen 0  [hci0] 16.884480
> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 16.886441
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Hold mode
          Sniff mode
          Park state
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          u-law log synchronous data
          A-law log synchronous data
          CVSD synchronous data
          Paging parameter negotiation
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended features
< HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0  [hci0] 16.886489
> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 16.895442
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 2.0 (0x03) - Revision 5276 (0x149c)
        LMP version: Bluetooth 2.0 (0x03) - Subversion 5276 (0x149c)
        Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0               [hci0] 16.895477
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 16.897441
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:15:83:73:FD:06 (IVT corporation)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0           [hci0] 16.897549
> HCI Event: Command Complete (0x0e) plen 11                   [hci0] 16.904438
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 384  ACL max packet: 8
        SCO MTU: 64   SCO max packet: 8
< HCI Command: Read Class of Device (0x03|0x0023) plen 0       [hci0] 16.904484
> HCI Event: Command Complete (0x0e) plen 7                    [hci0] 16.906438
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0            [hci0] 16.906478
> HCI Event: Command Complete (0x0e) plen 252                  [hci0] 16.990444
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: Bluetooth2.1+EDR CLASS1
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0         [hci0] 16.990494
> HCI Event: Command Complete (0x0e) plen 6                    [hci0] 16.992445
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Supporte.. (0x03|0x0038) plen 0  [hci0] 16.992490
> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 16.994419
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 2
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0       [hci0] 16.994477
> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 16.996414
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1           [hci0] 16.996455
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 16.998446
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection Accept.. (0x03|0x0016) plen 2  [hci0] 16.998491
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.000445
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Supported Co.. (0x04|0x0002) plen 0  [hci0] 17.000479
> HCI Event: Command Complete (0x0e) plen 68                   [hci0] 17.038414
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 118 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Master Link Key (Octet 2 - Bit 2)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Hold Mode (Octet 4 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          Park State (Octet 4 - Bit 4)
          Exit Park State (Octet 4 - Bit 5)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Create New Unit Key (Octet 6 - Bit 4)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Authentication Enable (Octet 8 - Bit 4)
          Write Authentication Enable (Octet 8 - Bit 5)
          Read Encryption Mode (Octet 8 - Bit 6)
          Write Encryption Mode (Octet 8 - Bit 7)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
          Read Hold Mode Activity (Octet 10 - Bit 0)
          Write Hold Mode Activity (Octet 10 - Bit 1)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Read Page Scan Period Mode (Octet 11 - Bit 5)
          Write Page Scan Period Mode (Octet 11 - Bit 6)
          Read Page Scan Mode (Octet 11 - Bit 7)
          Write Page Scan Mode (Octet 12 - Bit 0)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Commands (Octet 14 - Bit 4)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read Country Code (Octet 15 - Bit 0)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1         [hci0] 17.038468
        Mode: Inquiry Result with RSSI (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.040439
      Write Inquiry Mode (0x03|0x0045) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Extended Fea.. (0x04|0x0004) plen 1  [hci0] 17.040477
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14                   [hci0] 17.042438
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/0
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Set Event Mask (0x03|0x0001) plen 8             [hci0] 17.042544
        Mask: 0x00001807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
          Remote Name Request Complete
          Encryption Change
          Change Connection Link Key Complete
          Master Link Key Complete
          Read Remote Supported Features Complete
          Read Remote Version Information Complete
          QoS Setup Complete
          Command Complete
          Command Status
          Hardware Error
          Flush Occurred
          Role Change
          Mode Change
          Return Link Keys
          PIN Code Request
          Link Key Request
          Link Key Notification
          Loopback Command
          Data Buffer Overflow
          Max Slots Change
          Read Clock Offset Complete
          Connection Packet Type Changed
          QoS Violation
          Page Scan Mode Change
          Page Scan Repetition Mode Change
          Flow Specification Complete
          Inquiry Result with RSSI
          Read Remote Extended Features Complete
          Synchronous Connection Complete
          Synchronous Connection Changed
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.044447
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7       [hci0] 17.044489
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 17.048437
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 16
        Num keys: 0
< HCI Command: Write Default Link Poli.. (0x02|0x000f) plen 2  [hci0] 17.048480
        Link policy: 0x000f
          Enable Role Switch
          Enable Hold Mode
          Enable Sniff Mode
          Enabled Park State
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.050434
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0    [hci0] 17.050475
> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 17.052434
      Read Page Scan Activity (0x03|0x001b) ncmd 1
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0        [hci0] 17.052467
> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 17.054435
      Read Page Scan Type (0x03|0x0046) ncmd 1
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7     [hci0] 17.054526
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6                    [hci0] 17.061439
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
* Unknown packet (code 10 len 8)                               [hci0] 17.061508
        06 fd 73 83 15 00 0a 00                          ..s.....        
* Unknown packet (code 17 len 6)                               [hci0] 17.061519
        02 00 00 00 04 00                                ......          
* Unknown packet (code 17 len 6)                               [hci0] 17.061519
        01 00 00 00 04 00                                ......          
@ Index Added
* Unknown packet (code 15 len 4)                           [hci65535] 17.061593
        03 00 00 00                                      ....            
* Unknown packet (code 16 len 6)                               [hci0] 17.061666
        01 00 00 00 04 00                                ......          
* Unknown packet (code 17 len 289)                             [hci0] 17.061678
        01 00 00 00 01 00 04 00 00 06 fd 73 83 15 00 03  ...........s....
        0a 00 bf 10 00 00 81 00 00 00 00 00 00 42 6c 75  .............Blu
        65 74 6f 6f 74 68 32 2e 31 2b 45 44 52 20 43 4c  etooth2.1+EDR CL
        41 53 53 31 00 00 00 00 00 00 00 00 00 00 00 00  ASS1............
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00                                               .               
* Unknown packet (code 16 len 22)                              [hci0] 17.064975
        01 00 00 00 11 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00                                ......          
* Unknown packet (code 17 len 12)                              [hci0] 17.064989
        01 00 00 00 01 00 11 00 00 00 00 00              ............    
* Unknown packet (code 16 len 13)                              [hci0] 17.065036
        01 00 00 00 34 00 00 00 00 00 00 00 00           ....4........   
* Unknown packet (code 17 len 16)                              [hci0] 17.065045
        01 00 00 00 01 00 34 00 00 00 00 00 00 00 00 00  ......4.........
* Unknown packet (code 16 len 23)                              [hci0] 17.065084
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 00 18 00 00 00                             .......         
* Unknown packet (code 17 len 12)                              [hci0] 17.065090
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.065132
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 01 18 00 00 00                             .......         
* Unknown packet (code 17 len 12)                              [hci0] 17.065135
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 266)                             [hci0] 17.065176
        01 00 00 00 0f 00 6d 69 6e 69 20 23 31 00 00 00  ......mini #1...
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00                    ..........      
< HCI Command: Write Local Name (0x03|0x0013) plen 248         [hci0] 17.065208
        Name: mini #1
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.067421
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
* Unknown packet (code 17 len 266)                             [hci0] 17.067441
        02 00 00 00 08 00 6d 69 6e 69 20 23 31 00 00 00  ......mini #1...
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00                    ..........      
* Unknown packet (code 17 len 269)                             [hci0] 17.067449
        01 00 00 00 01 00 0f 00 00 6d 69 6e 69 20 23 31  .........mini #1
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00           .............   
@ Local Name Changed: mini #1 ()
* Unknown packet (code 16 len 23)                              [hci0] 17.086705
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 0e 11 00 00 00                             .......         
* Unknown packet (code 17 len 12)                              [hci0] 17.086715
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.086761
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 0c 11 00 00 00                             .......         
* Unknown packet (code 17 len 12)                              [hci0] 17.086765
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.086881
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 33 11 00 00 00                             ..3....         
* Unknown packet (code 17 len 12)                              [hci0] 17.086887
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.086930
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 32 11 00 00 00                             ..2....         
* Unknown packet (code 17 len 12)                              [hci0] 17.086933
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.086974
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 2f 11 00 00 10                             ../....         
* Unknown packet (code 17 len 12)                              [hci0] 17.086980
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.087021
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 04 11 00 00 10                             .......         
* Unknown packet (code 17 len 12)                              [hci0] 17.087026
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.087067
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 06 11 00 00 10                             .......         
* Unknown packet (code 17 len 12)                              [hci0] 17.087072
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.087114
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 05 11 00 00 10                             .......         
* Unknown packet (code 17 len 12)                              [hci0] 17.087117
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.087158
        01 00 00 00 10 00 01 00 00 ee 02 00 00 80 00 10  ................
        00 00 05 50 00 00 00                             ...P...         
* Unknown packet (code 17 len 12)                              [hci0] 17.087163
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.087204
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 1e 11 00 00 20                             ......          
* Unknown packet (code 17 len 12)                              [hci0] 17.087208
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 23)                              [hci0] 17.087249
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 12 11 00 00 00                             .......         
* Unknown packet (code 17 len 12)                              [hci0] 17.087253
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 13)                              [hci0] 17.087294
        01 00 00 00 27 00 00 00 00 00 00 00 00           ....'........   
* Unknown packet (code 17 len 13)                              [hci0] 17.087298
        02 00 00 00 15 00 00 00 00 00 00 00 00           .............   
* Unknown packet (code 17 len 16)                              [hci0] 17.087302
        01 00 00 00 01 00 27 00 00 00 00 00 00 00 00 00  ......'.........
@ Device Unblocked: 00:00:00:00:00:00 (0)
* Unknown packet (code 16 len 14)                              [hci0] 17.087340
        01 00 00 00 33 00 2e db 41 7f 19 00 00 01        ....3...A.....  
* Unknown packet (code 17 len 14)                              [hci0] 17.087348
        02 00 00 00 1a 00 2e db 41 7f 19 00 00 01        ........A.....  
* Unknown packet (code 17 len 16)                              [hci0] 17.087352
        01 00 00 00 01 00 33 00 00 2e db 41 7f 19 00 00  ......3....A....
@ Device Added: 00:19:7F:41:DB:2E (0) 1
* Unknown packet (code 16 len 14)                              [hci0] 17.087401
        01 00 00 00 33 00 2d 23 31 e4 e0 0c 00 01        ....3.-#1.....  
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 17.087406
        Scan enable: Page Scan (0x02)
* Unknown packet (code 17 len 14)                              [hci0] 17.087408
        02 00 00 00 1a 00 2d 23 31 e4 e0 0c 00 01        ......-#1.....  
* Unknown packet (code 17 len 16)                              [hci0] 17.087414
        01 00 00 00 01 00 33 00 00 2d 23 31 e4 e0 0c 00  ......3..-#1....
@ Device Added: 0C:E0:E4:31:23:2D (0) 1
* Unknown packet (code 16 len 59)                              [hci0] 17.087457
        01 00 00 00 12 00 00 02 00 2e db 41 7f 19 00 00  ...........A....
        00 13 ab 9b d9 19 43 47 55 c0 74 24 d7 36 57 93  ......CGU.t$.6W.
        3d 04 2d 23 31 e4 e0 0c 00 00 5e 24 d0 bf df c5  =.-#1.....^$....
        d2 8c 84 de 0c ca 2e 51 85 35 00                 .......Q.5.     
* Unknown packet (code 17 len 9)                               [hci0] 17.087462
        01 00 00 00 01 00 12 00 00                       .........       
* Unknown packet (code 16 len 6)                               [hci0] 17.087500
        01 00 00 00 15 00                                ......          
* Unknown packet (code 17 len 11)                              [hci0] 17.087505
        01 00 00 00 01 00 15 00 00 00 00                 ...........     
* Unknown packet (code 16 len 23)                              [hci0] 17.087543
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 00 12 00 00 00                             .......         
* Unknown packet (code 17 len 12)                              [hci0] 17.087548
        01 00 00 00 01 00 10 00 00 00 00 00              ............    
* Unknown packet (code 16 len 14)                              [hci0] 17.087589
        01 00 00 00 28 00 02 00 6b 1d 46 02 24 05        ....(...k.F.$.  
* Unknown packet (code 17 len 9)                               [hci0] 17.087594
        01 00 00 00 01 00 28 00 00                       ......(..       
* Unknown packet (code 16 len 8)                               [hci0] 17.087632
        01 00 00 00 0e 00 01 04                          ........        
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.091447
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Class of Device (0x03|0x0024) plen 3      [hci0] 17.091492
        Class: 0x300104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Object Transfer (v-Inbox, v-Folder)
          Audio (Speaker, Microphone, Headset)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.099441
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
* Unknown packet (code 17 len 9)                               [hci0] 17.099479
        02 00 00 00 07 00 04 01 30                       ........0       
* Unknown packet (code 17 len 9)                               [hci0] 17.099479
        01 00 00 00 07 00 04 01 30                       ........0       
* Unknown packet (code 17 len 12)                              [hci0] 17.099490
        01 00 00 00 01 00 0e 00 00 04 01 30              ...........0    
@ Class of Device Changed: 0x300104
* Unknown packet (code 16 len 266)                             [hci0] 17.099568
        01 00 00 00 0f 00 6d 69 6e 69 20 23 31 00 00 00  ......mini #1...
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00                    ..........      
* Unknown packet (code 17 len 269)                             [hci0] 17.099580
        01 00 00 00 01 00 0f 00 00 6d 69 6e 69 20 23 31  .........mini #1
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00           .............   
* Unknown packet (code 16 len 7)                               [hci0] 17.099623
        01 00 00 00 09 00 01                             .......         
* Unknown packet (code 17 len 13)                              [hci0] 17.099627
        01 00 00 00 01 00 09 00 00 91 00 00 00           .............   
* Unknown packet (code 17 len 10)                              [hci0] 17.099629
        02 00 00 00 06 00 91 00 00 00                    ..........      
@ New Settings: 0x0091
            powered bondable br/edr 
* Unknown packet (code 16 len 23)                              [hci0] 17.099676
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 0a 11 00 00 08                             .......         
< HCI Command: Write Class of Device (0x03|0x0024) plen 3      [hci0] 17.099725
        Class: 0x380104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Audio (Speaker, Microphone, Headset)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.101432
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
* Unknown packet (code 17 len 9)                               [hci0] 17.101464
        02 00 00 00 07 00 04 01 38                       ........8       
* Unknown packet (code 17 len 9)                               [hci0] 17.101464
        01 00 00 00 07 00 04 01 38                       ........8       
* Unknown packet (code 17 len 12)                              [hci0] 17.101473
        01 00 00 00 01 00 10 00 00 04 01 38              ...........8    
@ Class of Device Changed: 0x380104
* Unknown packet (code 16 len 23)                              [hci0] 17.101570
        01 00 00 00 10 00 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
        00 00 0b 11 00 00 04                             .......         
< HCI Command: Write Class of Device (0x03|0x0024) plen 3      [hci0] 17.101614
        Class: 0x3c0104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Rendering (Printing, Speaker)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Audio (Speaker, Microphone, Headset)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.104440
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
* Unknown packet (code 17 len 9)                               [hci0] 17.104477
        02 00 00 00 07 00 04 01 3c                       ........<       
* Unknown packet (code 17 len 9)                               [hci0] 17.104477
        01 00 00 00 07 00 04 01 3c                       ........<       
* Unknown packet (code 17 len 12)                              [hci0] 17.104488
        01 00 00 00 01 00 10 00 00 04 01 3c              ...........<    
@ Class of Device Changed: 0x3c0104

--------------1F138D78D00B5403B0A4082E--
