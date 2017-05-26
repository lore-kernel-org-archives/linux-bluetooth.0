Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Unexpected SMP Command 0x0a
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E3B98393E6037849B63EA428240A651306125616@PGSMSX103.gar.corp.intel.com>
Date: Fri, 26 May 2017 13:42:24 -0700
Cc: "Wong, Mun choy" <mun.choy.wong@intel.com>,
        "Zulqarnain, Adam" <adam.zulqarnain@intel.com>,
        Avinash Kadam <avinashk@marvell.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <D631CDDE-4EA4-4BF2-855F-E3C23CB2B6A8@holtmann.org>
References: <E3B98393E6037849B63EA428240A651362A579@PGSMSX103.gar.corp.intel.com>
 <E3B98393E6037849B63EA428240A651306125351@PGSMSX103.gar.corp.intel.com>
 <753A4460-944B-47FA-9381-F5E4FE619B28@holtmann.org>
 <E3B98393E6037849B63EA428240A651306125616@PGSMSX103.gar.corp.intel.com>
To: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joshua,

>>> I would like to follow up with this issue.
>>> 
>>>>>>>>>> Yes, for secure connection the LTK is generated locally.
>>>>>>>>>> But issue here is observed that after Pairing is complete the
>>>>>>>>>> key distribution is not completed from Master.
>>>>>>>>>> 
>>>>>>>>>> i.e. After Slave sends the  "Signature key:" but Master doesn't
>>>>>>>>>> share any key.  Attached logs.
>>>>>>>>> I get that and that is clear from the logs. Something is
>>>>>>>>> stalling here and because of that, you run into the 30 seconds
>>>>>>>>> SMP
>>>> timeout.
>>>>>>>>> We just need to know if the 4.9 kernel is doing this correctly.
>>>>>>>>> If so, then you can bi-sect that patch that fixes. Without proof
>>>>>>>>> that
>>>>>>>>> 4.9 is also broken, nobody will even bother to chase this down.
>>>>>>>> 
>>>>>>>> I think the problem here is race between ACL data and HCI events
>>>>>>>> on USB dongle...  We get initial slave keys but those get dropped
>>>>>>>> due to encryption changed event not being received yet. Since
>>>>>>>> keys were silently dropped we later on get unexpected SMP PDU
>> and
>>>>>>>> ignoring remaining keys as well which eventually leads to SMP
>>>> timeout.
>>>>>>>> 
>>>>>>>> If this is USB dongle (using btusd) then only (AFAIK) solution
>>>>>>>> would be to have a workaround for this inside chip (it would
>>>>>>>> delay ACL data received right after encryption change giving host
>>>>>>>> time to handle encpryption
>>>>>> change event).
>>>>>>>> Bluetooth specification for USB transport is unfortunatelly kinda
>>>> broken.
>>>>>>>> 
>>>>>>>> --
>>>>>>>> pozdrawiam
>>>>>>>> Szymon Janc
>>>>>>> 
>>>>>>> Thank you for your reply. Your inputs are valuable to us in
>>>>>>> helping to debug the
>>>>>> issue. Yes, we are indeed using the btusb kernel module and it is
>>>>>> using a USB interface (Bluetooth over USB).
>>>>>>> 
>>>>>>> I noticed that when btmgmt settings are set to turn 'bredr off',
>>>>>>> the 'ssp' mode
>>>>>> also turns off. Is this behavior expected to occur?
>>>>>>> My current settings are 'powered connectable discoverable bondable
>>>>>>> le
>>>>>> secure-connâ
>>>>>> 
>>>>>> the SSP (Secure Simple Pairing) is a BR/EDR only feature. So when
>>>>>> you disable BR/EDR, it will be disabled as well.
>>>>> 
>>>>> Thank you for your reply. It looks like I have understood this
>>>>> incorrectly as initially I read somewhere that LE adopts the SSP
>>>>> model in v4.1. Looks like this is not the case.
>>>>> 
>>>>> From the specification, I noted that SSP was introduced in BR/EDR in
>>>>> v2.1 which makes it a BR/EDR only feature.
>>>>> 
>>>>> I finally understand why ssp mode is disabled when I turned bredr
>>>>> off via btmgmt. Thank you for your clarification!
>>>> 
>>> 
>>> I notice a strange behavior during the LE Secure Connection pairing. This
>> occurs at the LE Start Encryption event as seen in the following log:
>>> 
>>> 
>>> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28       [hci0]
>>> 55.230548
>>>        Handle: 128
>>>        Random number: 0x0000000000000000
>>>        Encrypted diversifier: 0x0000
>>>        Long term key: 0e01142be9ddab9e6e6cef545562adc4
>>>> HCI Event: Command Status (0x0f) plen 4                      [hci0] 55.234468
>>>      LE Start Encryption (0x08|0x0019) ncmd 1
>>>        Status: Success (0x00)
>>>> ACL Data RX: Handle 128 flags 0x02 dlen 21                   [hci0] 55.500569
>>>      SMP: Signing Information (0x0a) len 16
>>>        Signature key: 1d916d5951791a271416a161cda981d6
>>>> HCI Event: Encryption Change (0x08) plen 4                   [hci0] 55.513836
>>>        Status: Success (0x00)
>>>        Handle: 128
>>>        Encryption: Enabled with AES-CCM (0x01)
>>> 
>>> 
>>> As noticed from the logs above, the "SMP: Signing Information (0x0a)"
>>> command appears first before the "Encryption Change (0x08)" HCI event.
>> On a LE successful pairing, the encryption change should occur before the
>> signing information command as can be observed in the following log
>> below. I was able to successfully perform a LE pairing through forced trial.
>> The successful LE pairing only occurs 1 out of 10 times.
>> 
>> the problem is that we will need to wait for the Encryption Change before
>> we can accept any key distribution from the remote side. So is this on an
>> USB dongle? The over the air packet might be actually encrypted, but on the
>> USB HCI transport we see it as non-encrypted and drop it.
>> 
>> So what hardware is this actually? Do you happen to have newer firmware
>> for this hardware that fixes this race in the HCI lower transport.
> 
> Thank you for your inputs. We appreciate it very much.
> 
> The module we are using is a M.2 form factor (E-Key, 2230 package). The Bluetooth interface is USB 2.0. We are using a Marvell 88W8897 SoC running the pcie8897_uapsta.bin firmware version 7.p77. This is the latest firmware version and we do not have any newer firmware. The link to the firmware is as follows:
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/firmware/linux-firmware/+/05e2f3a4acf4174ec507a3464a374ecb1b4ec011
> 
> We are using kernel 4.1.27 on our system running the btusb driver.
> We have also tried the LE pairing on kernel 4.9 and kernel 4.10. In both of these kernels, the race condition occurs and the pairing fails.
> It looks like we will need to contact Marvell on the race condition in HCI lower transport. 

so this is an USB only problem. And now that you say you are seeing this on Marvell hardware, then it might be the case that they still have not addressed this issue in their firmware. I think they should be aware of it, but it is pretty much a firmware problem and Marvell needs to address.

> Apart from that, should the LE pairing work normally on other transports e.g. UART/SDIO?


So UART and SDIO are not affected since they are a single "endpoint" and fully sequential transport protocol for HCI. With USB the difference is that HCI events and HCI data is using two independent "endpoints". In USB, the firmware needs to make sure the the HCI event is delivered to the host (meaning the host polled the URBs) on the interrupt endpoint before it fills the bulk endpoints for the HCI data packets.

Regards

Marcel

