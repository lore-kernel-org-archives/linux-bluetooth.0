Return-Path: <cyrus@holtmann.org>
Message-id: <C9167C41115745E68D304248A55BA18E@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Marcel Holtmann <marcel@holtmann.org>,
 Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1365483029-4826-1-git-send-email-jaganath.k@samsung.com>
 <CE5C4F1D-3B5E-412E-82FF-8643CEF81ABA@holtmann.org>
 <4E4CB6B1AE284A2BA24660B364C1F901@sisodomain.com>
 <ACBCB96F-612C-487F-853E-5BBC2EEFEB49@holtmann.org>
In-reply-to: <ACBCB96F-612C-487F-853E-5BBC2EEFEB49@holtmann.org>
Subject: Re: [PATCH v1] Bluetooth: Fix incorrect ssp mode bit for non ssp
 devices
Date: Tue, 09 Apr 2013 11:11:39 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

--------------------------------------------------
From: "Marcel Holtmann" <marcel@holtmann.org>
Sent: Tuesday, April 09, 2013 10:58 AM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v1] Bluetooth: Fix incorrect ssp mode bit for non ssp 
devices

> Hi Jaganath,
>
>>>> Some devices send extended inquiry response where as it wont
>>>> support ssp in remote extended features. So when we recieve eir,
>>>> we set ssp bit in conn flag which we are not clearing in
>>>> remote ext features event. So eventually ssp in conn flag will be
>>>> incorrectly set.
>>>
>>> actually it is not allowed to use send EIR data when SSP is disabled. 
>>> That is not a Bluetooth 2.1 compliant device that you are having here. 
>>> Can you please list the faulty device in the commit message.
>>>
>>
>> It's a desktop software called MecApp and I have seen same behavior with
>> most of the 2.1 dongles when I use this software.
>> http://www.mecel.se/products/bluetooth/downloads/MecApp_download
>> So I will add software name (MecApp) in the commit message?
>
> I wonder why we are bothering with test software.
>
> If you really want to work with this broken piece of software that can not 
> even adhere to the Bluetooth 2.1 specification, then fine with me. However 
> I want a clear and detailed explanation in the commit message that 
> describes this. Since at the end of the day since is not valid behavior 
> for a 2.1 product. I bet that the qualification even has a test case for 
> ensuring that EIR is not used when SSP is disabled.
>
Ok, I will put detailed explanation in the commit message.

>>>> In hci_remote_ext_features_evt(), if ssp is not supported then
>>>> we should clear HCI_CONN_SSP_ENABLED in conn flag since it might
>>>> have set while initiating acl connection using eir.
>>>>
>>>> hcidump log
>>>> ----------
>>>>
>>>> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>>>>   type 0x01 (active)
>>>>   interval 11.250ms window 11.250ms
>>>>   own address: 0x00 (Public) policy: All
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>   LE Set Scan Parameters (0x08|0x000b) ncmd 1
>>>>   status 0x00
>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>   value 0x01 (scanning enabled)
>>>>   filter duplicates 0x01 (enabled)
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>   LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>   status 0x00
>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>   value 0x00 (scanning disabled)
>>>>   filter duplicates 0x00 (disabled)
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>   LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>   status 0x00
>
> And remove the LE scanning part of the hcidump. Since that is not 
> important anyway.
>

Ok.

Thanks,
Jaganath 
