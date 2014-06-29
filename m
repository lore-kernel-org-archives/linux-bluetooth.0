Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: LE mouse reconnect problem
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140629052949.GA32130@t440s>
Date: Sun, 29 Jun 2014 11:43:32 +0200
Cc: Ryan Press <ryan@presslab.us>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E8C350F2-6B3C-4ECD-A281-DDC25C339489@holtmann.org>
References: <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com> <CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com> <CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com> <CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com> <CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com> <CABx3TkW-PhVeD2=Nr2pj5iL2uUm8T0B+w+WFB2EwaeW7OtChtQ@mail.gmail.com> <CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com> <CABx3TkU+JvmekRYBS1iYuriJaprMznH=g6vw2MVYi+2Vqc7Y5w@mail.gmail.com> <CABx3TkXsRXUNG4RudXnYifyN4Tq4MssVGXZE6uQtPtxU34bw7A@mail.gmail.com> <20140629051442.GA31085@t440s.P-661HNU-F1> <20140629052949.GA32130@t440s>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>> It looks like Bluez is using random address and hcitool lescan is
>>>> using public address.  I don't know why to use random or public.
>>>> 
>>>> hcitool lescan:
>>>>   own address: 0x00 (Public) policy: All
>>>> bluetoothd:
>>>>   own address: 0x01 (Random) policy: All
>>>> 
>>>> And the advertise address from the mouse is the same.
>>>> 
>>>> hcitool:
>>>>   bdaddr C5:8C:97:E9:9C:81 (Random)
>>>> bluetoothctl:
>>>> [NEW] Device C5:8C:97:E9:9C:81 Arc Touch Mouse SE
>>>> 
>>>> 
>>>> Thanks.
>>>> Ryan
>>> 
>>> Hi Luiz,
>>> 
>>> I realized that 3.15+ kernel had the LE Privacy support, so I tried
>>> 3.14 and my mouse reconnects just fine.  So somehow my mouse does not
>>> work with the new LE Privacy in the kernel.
>>> 
>>> I couldn't find any way to disable this.  It seems that bluetoothd
>>> just uses the default setting which is LE Privacy enabled.  And I
>>> couldn't find any way in the kernel to disable it via a module option
>>> or sysfs.  Is there some other way I can disable this?
>> 
>> What the kernel does is it actually uses a non-resolvable private
>> address when doing active scanning. You should still be able to get
>> advertising indications even though you don't get scan responses (as the
>> remote can only choose to not send you the latter based on your
>> address). So it's a bit strange you just get complete silence when doing
>> active scanning with a non-resolvable private address.
>> 
>> It'd be interesting to know whether passive scanning discovers the
>> device (it should). This is what we should be using, but as the kernel
>> interface for it is not yet ready we're reusing the Start Discovery mgmt
>> command which uses active instead of passive scanning.
>> 
>> Btw, it would be *much* better if you used btmon instead of hcidump for
>> your investigation. It has much more complete decoding of all the
>> various commands and events. Now we have to guess part of the parameters
>> that you posted since hcidump doesn't show them.
> 
> One part I missed: it seems the mouse is using directed advertising:
> 
> 2014-06-28 12:54:01.425141 > HCI Event: LE Meta Event (0x3e) plen 12
>   LE Advertising Report
>     ADV_DIRECT_IND - Connectable directed advertising (1)
>     bdaddr C5:8C:97:E9:9C:81 (Random)
>     RSSI: -35
> 
> It's possible that this makes your local controller filter out even the
> indications as they don't match the local address.

that is pretty much the issue here. The controller will filter out any ADV_DIRECT_IND that are not directed to the own address that it is currently using. That is mainly the reason why nobody today is using direct advertising since it broken for non-resolvable and resolvable private addresses. This is the first LE device using advertising that I have seen so far.

So when the mouse is discoverable and ready for pairing with a host, you will see these:

> HCI Event: LE Meta Event (0x3e) plen 43
     LE Advertising Report (0x02)
       Num reports: 1
       Event type: Connectable undirected - ADV_IND (0x00)
       Address type: Random (0x01)
       Address: E7:AD:BC:AA:1A:3B (Static)
       Data length: 31
       Name (complete): Arc Touch Mouse SE
       Appearance: Mouse (0x03c2)
       Flags: 0x05
         LE Limited Discoverable Mode
         BR/EDR Not Supported
       16-bit Service UUIDs (complete): 1 entry
         Human Interface Device (0x1812)
       RSSI: -57 dBm (0xc7)
> HCI Event: LE Meta Event (0x3e) plen 12
     LE Advertising Report (0x02)
       Num reports: 1
       Event type: Scan response - SCAN_RSP (0x04)
       Address type: Random (0x01)
       Address: E7:AD:BC:AA:1A:3B (Static)
       Data length: 0
       RSSI: -57 dBm (0xc7)

However once you are paired and you switch it one, you will only see these:

> HCI Event: LE Meta Event (0x3e) plen 12
     LE Advertising Report (0x02)
       Num reports: 1
       Event type: Connectable directed - ADV_DIRECT_IND (0x01)
       Address type: Random (0x01)
       Address: E7:AD:BC:AA:1A:3B (Static)
       Data length: 0
       RSSI: -53 dBm (0xcb)

And for some reason the address also keeps changing if you pair multiple times. The 4th octet (AA) keeps changing when you are pairing the mouse again. It seems a bit like that for every pairing, the mouse generates a new static random address and might actually remember the old one. I have seen direct advertising with the old address as well. So that is an interesting behavior.

The biggest problem here is that even if you are trying to be private and doing everything right, the mouse will broadcast your public address every time it tries to reconnect. So thank you Microsoft for forcing us to be trackable.

At least when we are using resolvable private addresses, we can distribute our IRK to the mouse:

< ACL Data TX: Handle 64 flags 0x00 dlen 11
     SMP: Pairing Request (0x01) len 6
       IO capability: DisplayYesNo (0x01)
       OOB data: Authentication data not present (0x00)
       Authentication requirement: Bonding - MITM (0x05)
       Max encryption key size: 16
       Initiator key distribution: EncKey IdKey Sign (0x07)
       Responder key distribution: EncKey IdKey Sign (0x07)
> ACL Data RX: Handle 64 flags 0x02 dlen 11
     SMP: Pairing Response (0x02) len 6
       IO capability: NoInputNoOutput (0x03)
       OOB data: Authentication data not present (0x00)
       Authentication requirement: Bonding - No MITM (0x01)
       Max encryption key size: 16
       Initiator key distribution: IdKey Sign (0x06)
       Responder key distribution: EncKey (0x01)

< ACL Data TX: Handle 64 flags 0x00 dlen 21
     SMP: Identity Information (0x08) len 16
       Identity resolving key: ba0583710e172dee8e8e8eb70e15d232
< ACL Data TX: Handle 64 flags 0x00 dlen 12
     SMP: Identity Address Information (0x09) len 7
       Address type: Public (0x00)
       Address: 00:02:A2:CC:10:04

The problem with that however is that we will still not get ADV_DIRECT_IND since the mouse will never know with resolvable private address we are using at the moment. So it might use an outdated address and then the controller will filter it out like it will filter it out with non-resolvable private addresses.

In conclusion, we have one clear bug with our experimental passive scanning support. Since passive scanning is not sending SCAN_REQ, we should just scan with our current identity address (public or static random). We tried to be extra safe when doing background scanning, but we forgot to take direct advertising into account.

The takeaway here is that active scanning (discovery) should be done using non-resolvable or resolvable private addresses, while passive scanning (background) should be done using identity address or resolvable private address.

Now the biggest problem is that with 3.15 and 3.16-rcX kernels we would need to go back to using our identity address for discovery. This means active scanning and it means we are broadcasting our identity address to everybody when trying to find this mouse. I rather not do that.

Regards

Marcel

