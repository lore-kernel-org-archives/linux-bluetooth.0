Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tom Harada <tomharada@lnihealth.com>
Subject: Re: Changing authentication requirements in older kernel
To: Juha Kuikka <juha.kuikka@gmail.com>
References: <346b1f21-e4f8-fd90-ed08-8cd5614fde7d@lnihealth.com>
 <CAKvrXUpKs2MP9fP3X3hUUt2FniM_WXcK5+vX=OE6EZuYbh1v8A@mail.gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Message-ID: <2d12034e-0033-baef-41a8-040f2a9e452a@lnihealth.com>
Date: Tue, 3 Jan 2017 16:46:21 -0500
MIME-Version: 1.0
In-Reply-To: <CAKvrXUpKs2MP9fP3X3hUUt2FniM_WXcK5+vX=OE6EZuYbh1v8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juha,

On 12/22/2016 09:39 PM, Juha Kuikka wrote:
> Hi Tom,
>
> I cannot be sure without a full log but I had a very similar problem
> with the Microsoft Folding Keyboard and kernel v3.8.
>
> This kernel patch was a fix for my case.
> https://patchwork.kernel.org/patch/5165761/
>
> It sets the pending security level to high, which means encryption +
> MITM if the Security Request indicated a need for MITM. This in turn
> forces the MITM bit to be sent in the Pairing Request.

Thanks for the suggestion. This doesn't seem to affect the pairing
request in my case. I'm not familiar with the code, but it looks like
the patch affects a method that gets called following the pairing
response. However, my device disconnects and refuses to send the pairing
response if it doesn't like the pairing request.

Below is the HCI log produced from attempting to pair with the device.

< HCI Command: LE Create Connection (0x08|0x000d) plen 25                                        [hci0] 57.890229
         Scan interval: 60.000 msec (0x0060)
         Scan window: 30.000 msec (0x0030)
         Filter policy: White list is not used (0x00)
         Peer address type: Public (0x00)
         Peer address: F4:5E:AB:A8:08:79 (OUI F4-5E-AB)
         Own address type: Public (0x00)
         Min connection interval: 50.00 msec (0x0028)
         Max connection interval: 70.00 msec (0x0038)
         Connection latency: 0x0000
         Supervision timeout: 420 msec (0x002a)
         Min connection length: 0.000 msec (0x0000)
         Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                        [hci0] 57.891433
       LE Create Connection (0x08|0x000d) ncmd 1
         Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                                        [hci0] 57.916417
       LE Connection Complete (0x01)
         Status: Success (0x00)
         Handle: 64
         Role: Master (0x00)
         Peer address type: Public (0x00)
         Peer address: F4:5E:AB:A8:08:79 (OUI F4-5E-AB)
         Connection interval: 67.50 msec (0x0036)
         Connection latency: 0.00 msec (0x0000)
         Supervision timeout: 420 msec (0x002a)
         Master clock accuracy: 0x05
@ Device Connected: F4:5E:AB:A8:08:79 (1) flags 0x0000
< ACL Data TX: Handle 64 flags 0x00 dlen 11                                                      [hci0] 57.930427
       ATT: Read By Group Type Request (0x10) len 6
         Handle range: 0x0001-0xffff
         Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                                                      [hci0] 57.933196
       SMP: Pairing Request (0x01) len 6
         IO capability: KeyboardOnly (0x02)
         OOB data: Authentication data not present (0x00)
         Authentication requirement: Bonding, No MITM, Legacy, No Keypresses (0x01)
         Max encryption key size: 16
         Initiator key distribution: <none> (0x00)
         Responder key distribution: EncKey (0x01)
> HCI Event: Number of Completed Packets (0x13) plen 5                                           [hci0] 57.937446
         Num handles: 1
         Handle: 64
         Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 6                                                       [hci0] 58.002693
       SMP: Pairing Failed (0x05) len 1
         Reason: Authentication requirements (0x03)
@ Authentication Failed: F4:5E:AB:A8:08:79 (1) status 0x05
> ACL Data RX: Handle 64 flags 0x02 dlen 24                                                      [hci0] 58.003450
       ATT: Read By Group Type Response (0x11) len 19
         Attribute data length: 6
         Attribute group list: 3 entries
         Handle range: 0x0001-0x0005
         UUID: Generic Access Profile (0x1800)
         Handle range: 0x0006-0x0013
         UUID: Glucose (0x1808)
         Handle range: 0x0014-0x0022
         UUID: Device Information (0x180a)
< HCI Command: Disconnect (0x01|0x0006) plen 3                                                   [hci0] 60.050653
         Handle: 64
         Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                                                        [hci0] 60.051712
       Disconnect (0x01|0x0006) ncmd 1
         Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                                                   [hci0] 60.095699
         Status: Success (0x00)
         Handle: 64
         Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: F4:5E:AB:A8:08:79 (1) reason 2

>
> Hope it helps!
>
> Cheers,
>  - Juha
>
> On Thu, Dec 22, 2016 at 1:47 PM, Tom Harada <tomharada@lnihealth.com> wrote:
>> Hi all,
>>
>> I have a BLE device that is unusually picky about the pairing requests it
>> receives. As far as I can tell, it will not pair if the MITM bit in the
>> authentication requirements is not set, or if the initiator key distribution
>> field is not set. It will not pair with BlueZ running under kernel 3.10.17,
>> where the pairing request looks like this:
>>
>> < ACL Data TX: Handle 64 flags 0x00 dlen 11
>>       SMP: Pairing Request (0x01) len 6
>>         IO capability: KeyboardOnly (0x02)
>>         OOB data: Authentication data not present (0x00)
>>         Authentication requirement: Bonding, No MITM, Legacy, No Keypresses
>> (0x01)
>>         Max encryption key size: 16
>>         Initiator key distribution: <none> (0x00)
>>         Responder key distribution: EncKey (0x01)
>>
>> It will pair under kernel 4.4.11, where the pairing request looks like this:
>>
>> < ACL Data TX: Handle 64 flags 0x00 dlen 11
>>       SMP: Pairing Request (0x01) len 6
>>         IO capability: KeyboardOnly (0x02)
>>         OOB data: Authentication data not present (0x00)
>>         Authentication requirement: Bonding - MITM (0x05)
>>         Max encryption key size: 16
>>         Initiator key distribution: EncKey IdKey Sign (0x07)
>>         Responder key distribution: EncKey IdKey Sign (0x07)
>>
>> I would like to make the older kernel's handling of pairing requests match
>> the newer one's. I'm having some success using newer Bluetooth kernel
>> modules from backports (3.15.9-1 appears to give the desired behavior), but
>> I don't know if this is a good long-term solution since the target system is
>> not using a mainline kernel. Is it possible to change the authentication
>> requirements and/or initiator key distribution in user space?
>>
>> Thanks,
>> Tom Harada

Thanks,
Tom
