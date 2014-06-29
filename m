Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: LE mouse reconnect problem
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABx3TkUP3Y9nJJk=u2ghFnunQRh9x-v6PG_ncyiM+mUqaoRtWg@mail.gmail.com>
Date: Sun, 29 Jun 2014 19:52:04 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <5A1EE16D-11BB-414E-B572-92FBF305B4E5@holtmann.org>
References: <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com> <CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com> <CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com> <CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com> <CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com> <CABx3TkW-PhVeD2=Nr2pj5iL2uUm8T0B+w+WFB2EwaeW7OtChtQ@mail.gmail.com> <CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com> <CABx3TkU+JvmekRYBS1iYuriJaprMznH=g6vw2MVYi+2Vqc7Y5w@mail.gmail.com> <CABx3TkXsRXUNG4RudXnYifyN4Tq4MssVGXZE6uQtPtxU34bw7A@mail.gmail.com> <20140629051442.GA31085@t440s.P-661HNU-F1> <20140629052949.GA32130@t440s> <E8C350F2-6B3C-4ECD-A281-DDC25C339489@holtmann.org> <CABx3TkUP3Y9nJJk=u2ghFnunQRh9x-v6PG_ncyiM+mUqaoRtWg@mail.gmail.com>
To: Ryan Press <ryan@presslab.us>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ryan,

>>>>>> It looks like Bluez is using random address and hcitool lescan is
>>>>>> using public address.  I don't know why to use random or public.
>>>>>> 
>>>>>> hcitool lescan:
>>>>>>  own address: 0x00 (Public) policy: All
>>>>>> bluetoothd:
>>>>>>  own address: 0x01 (Random) policy: All
>>>>>> 
>>>>>> And the advertise address from the mouse is the same.
>>>>>> 
>>>>>> hcitool:
>>>>>>  bdaddr C5:8C:97:E9:9C:81 (Random)
>>>>>> bluetoothctl:
>>>>>> [NEW] Device C5:8C:97:E9:9C:81 Arc Touch Mouse SE
>>>>>> 
>>>>>> 
>>>>>> Thanks.
>>>>>> Ryan
>>>>> 
>>>>> Hi Luiz,
>>>>> 
>>>>> I realized that 3.15+ kernel had the LE Privacy support, so I tried
>>>>> 3.14 and my mouse reconnects just fine.  So somehow my mouse does not
>>>>> work with the new LE Privacy in the kernel.
>>>>> 
>>>>> I couldn't find any way to disable this.  It seems that bluetoothd
>>>>> just uses the default setting which is LE Privacy enabled.  And I
>>>>> couldn't find any way in the kernel to disable it via a module option
>>>>> or sysfs.  Is there some other way I can disable this?
>>>> 
>>>> What the kernel does is it actually uses a non-resolvable private
>>>> address when doing active scanning. You should still be able to get
>>>> advertising indications even though you don't get scan responses (as the
>>>> remote can only choose to not send you the latter based on your
>>>> address). So it's a bit strange you just get complete silence when doing
>>>> active scanning with a non-resolvable private address.
>>>> 
>>>> It'd be interesting to know whether passive scanning discovers the
>>>> device (it should). This is what we should be using, but as the kernel
>>>> interface for it is not yet ready we're reusing the Start Discovery mgmt
>>>> command which uses active instead of passive scanning.
>>>> 
>>>> Btw, it would be *much* better if you used btmon instead of hcidump for
>>>> your investigation. It has much more complete decoding of all the
>>>> various commands and events. Now we have to guess part of the parameters
>>>> that you posted since hcidump doesn't show them.
>>> 
>>> One part I missed: it seems the mouse is using directed advertising:
>>> 
>>> 2014-06-28 12:54:01.425141 > HCI Event: LE Meta Event (0x3e) plen 12
>>>  LE Advertising Report
>>>    ADV_DIRECT_IND - Connectable directed advertising (1)
>>>    bdaddr C5:8C:97:E9:9C:81 (Random)
>>>    RSSI: -35
>>> 
>>> It's possible that this makes your local controller filter out even the
>>> indications as they don't match the local address.
>> 
>> that is pretty much the issue here. The controller will filter out any ADV_DIRECT_IND that are not directed to the own address that it is currently using. That is mainly the reason why nobody today is using direct advertising since it broken for non-resolvable and resolvable private addresses. This is the first LE device using advertising that I have seen so far.
>> In conclusion, we have one clear bug with our experimental passive scanning support. Since passive scanning is not sending SCAN_REQ, we should just scan with our current identity address (public or static random). We tried to be extra safe when doing background scanning, but we forgot to take direct advertising into account.
> 
>> 
>> The takeaway here is that active scanning (discovery) should be done using non-resolvable or resolvable private addresses, while passive scanning (background) should be done using identity address or resolvable private address.
>> 
>> Now the biggest problem is that with 3.15 and 3.16-rcX kernels we would need to go back to using our identity address for discovery. This means active scanning and it means we are broadcasting our identity address to everybody when trying to find this mouse. I rather not do that.
>> 
>> Regards
>> 
>> Marcel
>> 
> 
> Thanks guys, especially Marcel!  I have applied your patch and now the
> mouse reconnects correctly.
> 
> I have one other question with it.  When it first reconnects the mouse
> pointer is really jerky, like it's updating really slow.  Then after a
> few seconds it is normal; in fact it is very responsive compared to my
> old Bluetooth mouse.  With Windows 8.1 it reconnects lightning fast
> when I turn it on, and it is not jerky at first.
> 
> Bluetooth monitor ver 5.20
> = New Index: 5C:51:4F:0F:45:9B (BR/EDR,USB,hci0)                [hci0] 0.378098
> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7      [hci0] 2.291608
>        Type: Active (0x01)
>        Interval: 11.250 msec (0x0012)
>        Window: 11.250 msec (0x0012)
>        Own address type: Public (0x00)
>        Filter policy: Accept all advertisement (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 2.292495
>      LE Set Scan Parameters (0x08|0x000b) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2          [hci0] 2.292569
>        Scanning: Enabled (0x01)
>        Filter duplicates: Enabled (0x01)
>> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 2.293492
>      LE Set Scan Enable (0x08|0x000c) ncmd 2
>        Status: Success (0x00)
> @ Discovering: 0x01 (6)
>> HCI Event: LE Meta Event (0x3e) plen 12                       [hci0] 2.297493
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Connectable directed - ADV_DIRECT_IND (0x01)
>        Address type: Random (0x01)
>        Address: C5:8C:97:E9:9C:81 (Static)
>        Data length: 0
>        RSSI: -48 dBm (0xd0)
> @ Device Found: C5:8C:97:E9:9C:81 (2) rssi -48 flags 0x0000
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2          [hci0] 2.297704
>        Scanning: Disabled (0x00)
>        Filter duplicates: Disabled (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 2.301506
>      LE Set Scan Enable (0x08|0x000c) ncmd 2
>        Status: Success (0x00)
> @ Discovering: 0x00 (6)
> < HCI Command: LE Create Connection (0x08|0x000d) plen 25       [hci0] 2.302027
>        Scan interval: 60.000 msec (0x0060)
>        Scan window: 30.000 msec (0x0030)
>        Filter policy: White list is not used (0x00)
>        Peer address type: Random (0x01)
>        Peer address: C5:8C:97:E9:9C:81 (Static)
>        Own address type: Public (0x00)
>        Min connection interval: 50.00 msec (0x0028)
>        Max connection interval: 70.00 msec (0x0038)
>        Connection latency: 0x0000
>        Supervision timeout: 420 msec (0x002a)
>        Min connection length: 0.000 msec (0x0000)
>        Max connection length: 0.000 msec (0x0000)
>> HCI Event: Command Status (0x0f) plen 4                       [hci0] 2.303493
>      LE Create Connection (0x08|0x000d) ncmd 2
>        Status: Success (0x00)
>> HCI Event: LE Meta Event (0x3e) plen 19                       [hci0] 2.308593
>      LE Connection Complete (0x01)
>        Status: Success (0x00)
>        Handle: 3585
>        Role: Master (0x00)
>        Peer address type: Random (0x01)
>        Peer address: C5:8C:97:E9:9C:81 (Static)
>        Connection interval: 70.00 msec (0x0038)
>        Connection latency: 0.00 msec (0x0000)
>        Supervision timeout: 420 msec (0x002a)
>        Master clock accuracy: 0x00
> @ Device Connected: C5:8C:97:E9:9C:81 (2) flags 0x0000
> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28        [hci0] 2.308922
>        Handle: 3585
>        Random number: 0x42a37f88d3b5619c
>        Encrypted diversifier: 0x21e0
>        Long term key: 283980ebe520609d7af359b28e996572
>> HCI Event: Command Status (0x0f) plen 4                       [hci0] 2.310487
>      LE Start Encryption (0x08|0x0019) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Encryption Change (0x08) plen 4                    [hci0] 2.715586
>        Status: Success (0x00)
>        Handle: 3585
>        Encryption: Enabled with AES-CCM (0x01)
> < ACL Data TX: Handle 3585 flags 0x00 dlen 11                   [hci0] 2.715867
>      ATT: Read By Type Request (0x08) len 6
>        Handle range: 0x000c-0x0010
>        Attribute type: Characteristic (0x2803)
>> ACL Data RX: Handle 3585 flags 0x02 dlen 16                   [hci0] 2.785254
>      ATT: Handle Value Notification (0x1b) len 11
>        Handle: 0x0021
>          Data: 001500b7ff00000000
>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 2.785496
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> ACL Data RX: Handle 3585 flags 0x02 dlen 20                   [hci0] 2.855169
>      ATT: Read By Type Response (0x09) len 15
>        Attribute data length: 7
>        Attribute data list: 2 entries
>        Handle: 0x000d
>        Value: 020e00292a
>        Handle: 0x000f
>        Value: 021000502a
> < ACL Data TX: Handle 3585 flags 0x00 dlen 7                    [hci0] 2.855447
>      ATT: Exchange MTU Request (0x02) len 2
>        Client RX MTU: 672
>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 2.925588
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> ACL Data RX: Handle 3585 flags 0x02 dlen 7                    [hci0] 2.995043
>      ATT: Exchange MTU Response (0x03) len 2
>        Server RX MTU: 23
> < ACL Data TX: Handle 3585 flags 0x00 dlen 7                    [hci0] 2.995278
>      ATT: Read Request (0x0a) len 2
>        Handle: 0x0010
>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 3.065590
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> ACL Data RX: Handle 3585 flags 0x02 dlen 12                   [hci0] 3.135107
>      ATT: Read Response (0x0b) len 7
>        Value: 025e04f3070100
>> ACL Data RX: Handle 3585 flags 0x02 dlen 16                   [hci0] 7.405125
>      LE L2CAP: Connection Parameter Update Request (0x12) ident 2 len 8
>        Min interval: 6
>        Max interval: 6
>        Slave latency: 40
>        Timeout multiplier: 300
> < ACL Data TX: Handle 3585 flags 0x00 dlen 10                   [hci0] 7.405247
>      LE L2CAP: Connection Parameter Update Response (0x13) ident 2 len 2
>        Result: Connection Parameters accepted (0x0000)
> < HCI Command: LE Connection Update (0x08|0x0013) plen 14       [hci0] 7.405276
>        Handle: 3585
>        Min connection interval: 7.50 msec (0x0006)
>        Max connection interval: 7.50 msec (0x0006)
>        Connection latency: 0x0028
>        Supervision timeout: 3000 msec (0x012c)
>        Min connection length: 0.000 msec (0x0000)
>        Max connection length: 0.000 msec (0x0000)
>> HCI Event: Command Status (0x0f) plen 4                       [hci0] 7.407611
>      LE Connection Update (0x08|0x0013) ncmd 2
>        Status: Success (0x00)
>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 7.475614
>        Num handles: 1
>        Handle: 3585
>        Count: 1
>> HCI Event: LE Meta Event (0x3e) plen 10                       [hci0] 8.035642
>      LE Connection Update Complete (0x03)
>        Status: Success (0x00)
>        Handle: 3585
>        Connection interval: 7.50 msec (0x0006)
>        Connection latency: 50.00 msec (0x0028)
>        Supervision timeout: 3000 msec (0x012c)
>> ACL Data RX: Handle 3585 flags 0x02 dlen 16                  [hci0] 11.695162
>      ATT: Handle Value Notification (0x1b) len 11
>        Handle: 0x0021
>          Data: 000000000000000000
>> ACL Data RX: Handle 3585 flags 0x02 dlen 16                  [hci0] 11.920069
>      ATT: Handle Value Notification (0x1b) len 11
>        Handle: 0x0021
>          Data: 000000000000000000
>> ACL Data RX: Handle 3585 flags 0x02 dlen 16                  [hci0] 11.927662
>      ATT: Handle Value Notification (0x1b) len 11
>        Handle: 0x0021
>          Data: 000000010000000000
> 
> 
> I see at first this setting:
>        Min connection interval: 50.00 msec (0x0028)
>        Max connection interval: 70.00 msec (0x0038)
> And later this setting:
>        Min connection interval: 7.50 msec (0x0006)
>        Max connection interval: 7.50 msec (0x0006)
> 
> I guess this is why it's slow at first.  I wonder why it just doesn't
> start out at 7.5 ms?  And with the somewhat slower reconnection issue
> I believe it's due to bluetoothd not polling as quickly.

this is a kernel issue with not remembering the previous connection parameters. What you see is that we start connecting with the default values and then the slave (the mouse) will correct us and tell us what connection parameters it needs. We accept them and actually change the LE link to use these parameters. However we end up forgetting them. So every time you connect this procedure keeps repeating itself.

I fixed this as well, but for that you will need a bluetooth-next kernel where I enabled the management API for passive scanning and a modified bluetoothd that will then allow you a smooth experience. If the slave updates the connection parameters we remember them for devices using auto-connection. So once the connection is triggered via passive scanning the values will be remembered.

At the moment, I have one minor issue with the re-connection within bluetoothd and once that is fixed this should be pretty instant.

Regards

Marcel

