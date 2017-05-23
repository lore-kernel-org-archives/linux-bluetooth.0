Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Determining whether a Bluetooth device supports pairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170522121503.126355ed.john@metanate.com>
Date: Tue, 23 May 2017 07:33:13 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C90C2336-57FC-4036-B475-DF26138C8CB0@holtmann.org>
References: <20170512154514.5a51d896.john@metanate.com>
 <5C9B4D2C-2410-4FB9-9BBF-F6FDB60BB6B6@holtmann.org>
 <20170522121503.126355ed.john@metanate.com>
To: John Keeping <john@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

>>> Am I missing some method for determining whether or not a device
>>> supports pairing?  Or do we need to handle SMP_PAIRING_NOTSUPP
>>> specially?
>> 
>> I do not remember any indication from the Bluetooth Core specification
>> that would tell you in advance if you support pairing or not. Mainly
>> since most devices actually just support pairing. Can you show us the
>> btmon trace output of the advertising reports.
> 
> Here's the advertising report and scan response:
> 
> -- >8 --
>> HCI Event: LE Meta Event (0x3e) plen 33
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Connectable undirected - ADV_IND (0x00)
>        Address type: Public (0x00)
>        Address: A0:E6:F8:4A:AE:AD (Texas Instruments)
>        Data length: 21
>        Flags: 0x06
>          LE General Discoverable Mode
>          BR/EDR Not Supported
>        128-bit Service UUIDs (complete): 1 entry
>          Vendor specific (03b80e5a-ede8-4b33-a751-6ce34ec4c700)
>        RSSI: -66 dBm (0xbe)
>> HCI Event: LE Meta Event (0x3e) plen 42
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Scan response - SCAN_RSP (0x04)
>        Address type: Public (0x00)
>        Address: A0:E6:F8:4A:AE:AD (Texas Instruments)
>        Data length: 30
>        Name (complete): Akai LPK25 Wireless
>        Slave Conn. Interval: 0x000a - 0x0014
>        TX power: 0 dBm
>        RSSI: -67 dBm (0xbd)
> -- 8< --

so there is nothing that tells us that pairing is not support. Except the UI could use the Vendor specific UUID to decide to do special handling of this device.

>> One thing that I can think of is that Pair Device should return a
>> reasonable error code so that bluetoothd can detect non-supported
>> pairing and treat it as non-bonded device. Best would be a full btmon
>> -w trace.log trace with a recent kernel that also monitors mgmt
>> commands and events.
> 
> I've attached the full trace, but I think this is the interesting
> section:
> 
> -- >8 --
> @ MGMT Command: Pair Device (0x0019) plen 8
>        LE Address: A0:E6:F8:4A:AE:AD (Texas Instruments)
>        Capability: KeyboardDisplay (0x04)
> < ACL Data TX: Handle 3585 flags 0x00 dlen 11
>      SMP: Pairing Request (0x01) len 6
>        IO capability: KeyboardDisplay (0x04)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, MITM, SC, No Keypresses, CT2 (0x2d)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey Sign LinkKey (0x0d)
>        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)
>> HCI Event: Number of Completed Packets (0x13) plen 5
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> ACL Data RX: Handle 3585 flags 0x02 dlen 6
>      SMP: Pairing Failed (0x05) len 1
>        Reason: Pairing not supported (0x05)
> @ MGMT Event: Authentication Failed (0x0011) plen 8
>        LE Address: A0:E6:F8:4A:AE:AD (Texas Instruments)
>        Status: Authentication Failed (0x05)
> @ MGMT Event: Command Complete (0x0001) plen 10
>      Pair Device (0x0019) plen 7
>        Status: Authentication Failed (0x05)
>        LE Address: A0:E6:F8:4A:AE:AD (Texas Instruments)

So I think we should return a proper error code that indicates that Pairing is not supported here. That way then bluetoothd can decide to handle this gracefully. Frankly I have not seen a device that doesn't support pairing in a long time. Also we should add proper mgmt-tester test cases for pairing not supported cases.

Regards

Marcel


