Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20151117085459.GA12500@t440s.lan>
References: <CAKafyqqXugV5ceP2i=a9UEeYU1VR4yDNjqFFkQw5mv6kzraiCA@mail.gmail.com>
	<20151117085459.GA12500@t440s.lan>
Date: Tue, 17 Nov 2015 14:47:45 +0530
Message-ID: <CAKafyqoH=NAfK3TK_1nZLKe_RCb=dG8+mXDc-6ogN9gJeyz=9w@mail.gmail.com>
Subject: Re: HoG device : Authentication Failure while connecting after reboot.
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Nov 17, 2015 at 2:24 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Prabhu,
>
> On Tue, Nov 17, 2015, Prabhu Chawandi wrote:
>>   I have a HoG device, first time I pair and connect work fine...
>> in the next reboot while connecting I saw multiple disconnection,
>> after looking into hcidump
>> I found that disconnection was due to authentication failure.  After
>> multiple attempts (which it does) one attempt will succeed to
>> establish the connection.
>>
>> I also found that while initializing adapter stored link keys are
>> being deleted. is this the reason for Authentication failure ?
>>
>> > HCI Event: Command Complete (0x0e) plen 14
>>     Read Local Extended Features (0x04|0x0004) ncmd 1
>>     status 0x00 page 1 max 1
>>     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>> < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
>>     bdaddr 00:00:00:00:00:00 all 1
>
> I can't really help you with the cause of your issue (not enough
> information) but regarding the above: Link Keys are for BR/EDR, so
> nothing to do with HoG or LE. Also, the above command just requests the
> controller to clear its memory, i.e. it doesn't affect the keys that
> BlueZ manages.
>
> Johan

initialization dump below.

# hcidump -i hci0
HCI sniffer - Bluetooth packet analyzer ver 5.35
device: hci0 snap_len: 1500 filter: 0xffffffff
< HCI Command: Reset (0x03|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 4
    Reset (0x03|0x0003) ncmd 1
    status 0x00
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 1
    status 0x00
    Features: 0xff 0xff 0x8f 0xfe 0xdb 0xff 0x5b 0x87
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 4.0 (0x6) HCI Revision: 0x22bb
    LMP Version: 4.0 (0x6) LMP Subversion: 0x22bb
    Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 1
    status 0x00 bdaddr 00:15:83:D1:1B:F0
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 11
    Read Buffer Size (0x04|0x0005) ncmd 1
    status 0x00
    ACL MTU 310:10 SCO MTU 64:8
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x000000
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'CSR8510 A10'
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Read Number of Supported IAC (0x03|0x0038) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Number of Supported IAC (0x03|0x0038) ncmd 1
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0
> HCI Event: Command Complete (0x0e) plen 8
    Read Current IAC LAP (0x03|0x0039) ncmd 1
    IAC 0x9e8b33 (General Inquiry Access Code)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1
    type 0 condition 0
    Clear all filters
> HCI Event: Command Complete (0x0e) plen 4
    Set Event Filter (0x03|0x0005) ncmd 1
    status 0x00
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
    timeout 32000
> HCI Event: Command Complete (0x0e) plen 4
    Write Connection Accept Timeout (0x03|0x0016) ncmd 1
    status 0x00
< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0
> HCI Event: Command Complete (0x0e) plen 8
    Read Page Scan Activity (0x03|0x001b) ncmd 1
    status 0x00 interval 2048 window 18
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Page Scan Type (0x03|0x0046) ncmd 1
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0
> HCI Event: Command Complete (0x0e) plen 7
    LE Read Buffer Size (0x08|0x0002) ncmd 1
    status 0x00 pktlen 0x0000 maxpkt 0x00
< HCI Command: LE Read Local Supported Features (0x08|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    LE Read Local Supported Features (0x08|0x0003) ncmd 1
    status 0x00 features 0x0100000000000000 (Link Layer supports LE Encryption)
< HCI Command: LE Read Advertising Channel Tx Power (0x08|0x0007) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    LE Read Advertising Channel Tx Power (0x08|0x0007) ncmd 1
    status 0x00 level 0x8 (dBm)
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    LE Read White List Size (0x08|0x000f) ncmd 1
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    LE Read Supported States (0x08|0x001c) ncmd 1
< HCI Command: Set Event Mask (0x03|0x0001) plen 8
    Mask: 0xfffffbff07f8bf3d
> HCI Event: Command Complete (0x0e) plen 4
    Set Event Mask (0x03|0x0001) ncmd 1
    status 0x00
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8
    mask 0x1f00000000000000 (Reserved)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Event Mask (0x08|0x0001) ncmd 1
    status 0x00
< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> HCI Event: Command Complete (0x0e) plen 68
    Read Local Supported Commands (0x04|0x0002) ncmd 1
    status 0x00
    Commands: ffffff03fefffffffffffffff30fe8fe3ff783ff1c00000061f7ffff7f
< HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1
    mode 0x01
> HCI Event: Command Complete (0x0e) plen 4
    Write Simple Pairing Mode (0x03|0x0056) ncmd 1
    status 0x00
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
    mode 2
> HCI Event: Command Complete (0x0e) plen 4
    Write Inquiry Mode (0x03|0x0045) ncmd 1
    status 0x00
< HCI Command: Read Inquiry Response Transmit Power Level (0x03|0x0058) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Inquiry Response Transmit Power Level (0x03|0x0058) ncmd 1
    status 0x00 level 4
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
    page 1
> HCI Event: Command Complete (0x0e) plen 14
    Read Local Extended Features (0x04|0x0004) ncmd 1
    status 0x00 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
    bdaddr 00:00:00:00:00:00 all 1
> HCI Event: Command Complete (0x0e) plen 6
    Delete Stored Link Key (0x03|0x0012) ncmd 1
    status 0x00 deleted 0
< HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2
    policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 4
    Write Default Link Policy Settings (0x02|0x000f) ncmd 1
    status 0x00
< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2
> HCI Event: Command Complete (0x0e) plen 4
    Write LE Host Supported (0x03|0x006d) ncmd 1
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Advertising Data (0x08|0x0008) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Response Data (0x08|0x0009) plen 32
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Response Data (0x08|0x0009) ncmd 1
    status 0x00
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 2
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
    class 0x08020c
> HCI Event: Command Complete (0x0e) plen 4
    Write Class of Device (0x03|0x0024) ncmd 1
    status 0x00
< HCI Command: Write Local Name (0x03|0x0013) plen 248
    name 'BlueZ for Android'
> HCI Event: Command Complete (0x0e) plen 4
    Write Local Name (0x03|0x0013) ncmd 1
    status 0x00
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
    fec 0x00
    Complete local name: 'BlueZ for Android'
    TX power level: 4
    Unknown type 0x10 with 8 bytes data
    Complete service classes: 0x113b 0x1112 0x111f 0x110a 0x1800 0x180a 0x1801
> HCI Event: Command Complete (0x0e) plen 4
    Write Extended Inquiry Response (0x03|0x0052) ncmd 1
    status 0x00

-------------------------------------------Disconnection hci dump
follwed-----------------------------------------------------
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr 22:55:5B:00:15:10 type 0
    interval 96 window 48 initiator_filter 0
    own_bdaddr_type 0 min_interval 40 max_interval 56
    latency 0 supervision_to 42 min_ce 0 max_ce 0
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 70, role master
      bdaddr 22:55:5B:00:15:10 (Public)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
> HCI Event: Command Status (0x0f) plen 4
    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x3e handle 70 encrypt 0x00
    Error: Connection Failed to be Established
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 70 reason 0x05
    Reason: Authentication Failure
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 70 reason 0x3e
    Reason: Connection Failed to be Established

Please let me know, what more information to be given, looking forward
to for your reply on it.

Many Thanks,
Prabhu Chawandi
