Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: 5.41 - Authentication Failed with kernel 4.2.0
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160810113012.GA25012@t440s.lan>
Date: Wed, 10 Aug 2016 21:15:51 +0200
Cc: Kropf Johannes <Johannes.Kropf@ait.ac.at>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <F7CF570F-5AC4-48AE-A532-DECEE8AD9F04@holtmann.org>
References: <E92610C73D6DE84EB154DC52F5ECCE541D74740E@S0MSMAIL111.arc.local> <20160808094255.GA8136@t440s.lan> <E92610C73D6DE84EB154DC52F5ECCE541D7479B6@S0MSMAIL111.arc.local> <20160809143212.GA10222@t440s.P-661HNU-F1> <E92610C73D6DE84EB154DC52F5ECCE541D748ADC@S0MSMAIL111.arc.local> <20160810113012.GA25012@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> Here is the whole log:
> 
> Thanks. I'll filter it so only the relevant stuff (SMP) is present:
> 
>>> ACL Data RX: Handle 70 flags 0x02 dlen 6                     [hci0] 28.145172
>>      SMP: Security Request (0x0b) len 1
>>        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses (0x01)
>> < ACL Data TX: Handle 70 flags 0x00 dlen 11                    [hci0] 28.209526
>>      SMP: Pairing Request (0x01) len 6
>>        IO capability: NoInputNoOutput (0x03)
>>        OOB data: Authentication data not present (0x00)
>>        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>>        Max encryption key size: 16
>>        Initiator key distribution: EncKey Sign LinkKey (0x0d)
>>        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)

actually this might be some fun that secure connection and cross-transport key derivation is causing because of RFU bits. Essentially the peripheral already told us that it does not support SC. So why do we try it and why do we try to use CT as well.

I think if we get a Security Request with legacy pairing auth requirements, we should treat the device as legacy. And not try to even negotiate secure connections in the first place.

>>> ACL Data RX: Handle 70 flags 0x02 dlen 11                    [hci0] 28.348460
>>      SMP: Pairing Response (0x02) len 6
>>        IO capability: NoInputNoOutput (0x03)
>>        OOB data: Authentication data not present (0x00)
>>        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses (0x01)
>>        Max encryption key size: 16
>>        Initiator key distribution: EncKey Sign (0x05)
>>        Responder key distribution: EncKey IdKey Sign (0x07)
>> < ACL Data TX: Handle 70 flags 0x00 dlen 21                    [hci0] 28.348510
>>      SMP: Pairing Confirm (0x03) len 16
>>        Confim value: 12bd199ba4739a017395109cfa4621b3
>>> ACL Data RX: Handle 70 flags 0x02 dlen 21                    [hci0] 28.488508
>>      SMP: Pairing Confirm (0x03) len 16
>>        Confim value: 41f5f7a6212356d0eefa268f7994844a
>> < ACL Data TX: Handle 70 flags 0x00 dlen 21                    [hci0] 28.488545
>>      SMP: Pairing Random (0x04) len 16
>>        Random value: 4e8d532caf34ab845ff243acf6a0a681
>>> ACL Data RX: Handle 70 flags 0x02 dlen 6                     [hci0] 28.628456
>>      SMP: Pairing Failed (0x05) len 1
>>        Reason: Confirm value failed (0x04)
>> < HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 28.628506
>>        Handle: 70
>>        Reason: Authentication Failure (0x05)
>> @ Authentication Failed: 5C:31:3E:5E:54:5E (1) status 0x05
> 
> That "Confirm value failed" response still looks like something strange
> is happening on the remote side - maybe a bug there. Unfortunately I
> don't really have any other ideas except going for raw bisecting here if
> you have a kernel version this did work with.
> 
> The inputs to the function that generates the confirm value are the
> local and remote public keys and the random number that was sent over
> the air, so there's not much that can go wrong there - also nothing I
> can remember that would have changed on the Linux side regarding this
> for a long time. This of course assumes that the remote device is using
> this error code correctly and doesn't send it for some other condition.

I bet that the peripheral side wrongly clears some RFU bits. Which leads to wrong values for confirm values.

Regards

Marcel

