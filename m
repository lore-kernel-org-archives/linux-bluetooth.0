Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: 5.41 - Authentication Failed with kernel 4.2.0
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E92610C73D6DE84EB154DC52F5ECCE541D748ADC@S0MSMAIL111.arc.local>
Date: Wed, 10 Aug 2016 23:48:54 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <290E1247-5A7E-478D-8190-466484DCBC24@holtmann.org>
References: <E92610C73D6DE84EB154DC52F5ECCE541D74740E@S0MSMAIL111.arc.local> <20160808094255.GA8136@t440s.lan> <E92610C73D6DE84EB154DC52F5ECCE541D7479B6@S0MSMAIL111.arc.local> <20160809143212.GA10222@t440s.P-661HNU-F1> <E92610C73D6DE84EB154DC52F5ECCE541D748ADC@S0MSMAIL111.arc.local>
To: Kropf Johannes <Johannes.Kropf@ait.ac.at>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johannes,

>>>>> we had a problem when attempting to pair low energy devices on
>>>>> Ubuntu
>>>> with kernel version 4.2.0-42-generic:
>>>>> After scanning there always occured an "authentication failed" error.
>>>>> The devices we tried to pair were a A&D UC-352-BLE weighing scale
>>>>> and a
>>>> A&D UA-651BLE blood pressure monitor.
>>>>> Both devices can be paired on the same machine with the same setup
>>>>> but
>>>> with kernel version 3.13.0.92.
>>>>> Unfortunately the log doesn't give me an idea what the problem is.
>>>>> 
>>>>> Here is the output using bluetoothctl:
>>>>> [bluetooth]# pair 5C:31:3E:5E:54:5E Attempting to pair with
>>>>> 5C:31:3E:5E:54:5E [CHG] Device 5C:31:3E:5E:54:5E Connected: yes
>>>>> Failed to pair:
>>>>> org.bluez.Error.AuthenticationFailed
>>>>> [CHG] Device 5C:31:3E:5E:54:5E Connected: no
>>>> 
>>>> Did you also have an agent registered? (e.g. "agent KeyboardDisplay"
>>>> in
>>>> bluetoothctl)
>>> Yes, an agent was registered in bluetoothctl with "agent on"
>> 
>> Ok, good. It shouldn't make a difference for pairings initiated from the local
>> side, but just in case, did you also issue "default-agent"?
>> 
>>>> What would give an even better view of what's going on is the HCI logs.
>>>> You can get those with the btmon tool (found under monitor/ in the
>>>> BlueZ source tree).
>>> Here is the output of btmon. Does it mean anything to you?
>>> ....
>>> < ACL Data TX: Handle 70 flags 0x00 dlen 11                    [hci0] 28.489379
>>>      ATT: Read By Group Type Request (0x10) len 6
>>>        Handle range: 0x0018-0xffff
>>>        Attribute group type: Primary Service (0x2800)
>>>> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
>> 28.559451
>>>        Num handles: 1
>>>        Handle: 70
>>>        Count: 1
>>>> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
>> 28.560451
>>>        Num handles: 1
>>>        Handle: 70
>>>        Count: 1
>>>> ACL Data RX: Handle 70 flags 0x02 dlen 6                     [hci0] 28.628456
>>>      SMP: Pairing Failed (0x05) len 1
>>>        Reason: Confirm value failed (0x04)
>>> < HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 28.628506
>>>        Handle: 70
>>>        Reason: Authentication Failure (0x05)
>> 
>> To me this looks like the remote either rejected the pairing, or something else
>> went wrong there. It'd help to see the full HCI log, particularly from the
>> beginning of the SMP session, i.e. including the Pairing Request and Response
>> PDUs.
>> 
>> Johan
> 
> Here is the whole log:
> 
>> HCI Event: Command Status (0x0f) plen 4                      [hci0] 28.080411
>      LE Create Connection (0x08|0x000d) ncmd 1
>        Status: Success (0x00)
>> HCI Event: LE Meta Event (0x3e) plen 19                      [hci0] 28.086410
>      LE Connection Complete (0x01)
>        Status: Success (0x00)
>        Handle: 70
>        Role: Master (0x00)
>        Peer address type: Public (0x00)
>        Peer address: 5C:31:3E:5E:54:5E (OUI 5C-31-3E)
>        Connection interval: 70.00 msec (0x0038)
>        Connection latency: 0.00 msec (0x0000)
>        Supervision timeout: 420 msec (0x002a)
>        Master clock accuracy: 0x00
> < HCI Command: LE Read Remote Used Fea.. (0x08|0x0016) plen 2  [hci0] 28.086498
>        Handle: 70
> @ Device Connected: 5C:31:3E:5E:54:5E (1) flags 0x0000
>        02 01 05 03 02 1d 18 05 12 40 00 50 00           .........@.P.   
>> HCI Event: Command Status (0x0f) plen 4                      [hci0] 28.090427
>      LE Read Remote Used Features (0x08|0x0016) ncmd 1
>        Status: Success (0x00)
>> ACL Data RX: Handle 70 flags 0x02 dlen 6                     [hci0] 28.145172
>      SMP: Security Request (0x0b) len 1
>        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses (0x01)

this is an odd event. So we are initiation the pairing, but the remote side is sending Security Request for no apparent reason. This means I am suspecting that we are just dropping this PDU and not acting on it.

This could be tested by adding a debug print in smp_sig_channel() for this statement

        if (smp && !test_and_clear_bit(code, &smp->allow_cmd))                   
                goto drop;

What we might need to do is allow SMP_CMD_SECURITY_REQ and then let it set SMP_FLAG_LEGACY_SLAVE in case SC is not set.

>> HCI Event: LE Meta Event (0x3e) plen 12                      [hci0] 28.209459
>      LE Read Remote Used Features (0x04)
>        Status: Success (0x00)
>        Handle: 70
>        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>          LE Encryption
> < ACL Data TX: Handle 70 flags 0x00 dlen 11                    [hci0] 28.209526
>      SMP: Pairing Request (0x01) len 6
>        IO capability: NoInputNoOutput (0x03)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey Sign LinkKey (0x0d)
>        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)

If my suspicion is correct and we ignore Security Request above, that this Pairing Request is not a section based on Security Request. It is genuine new attempt to pair the device.

I would not be surprised if the auth requirement RFU bits or key distribution RFU bits are getting cleared by the peripheral and the raw PDU is used wrongly in confirm value calculation.

However that is easy to test and see if paring succeeds when manually doing "btmgmt sc off". Then the SC bit and LinkKey bits should not be set in the Pairing Request. If that succeeds then this is a broken peripheral.

Regards

Marcel

