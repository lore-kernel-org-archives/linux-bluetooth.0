Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8xDHvVq9QyCwo7_di_QRhbqEYdGJCKevQoEQ8WZRwA4dA@mail.gmail.com>
Date: Wed, 1 Oct 2014 07:27:56 +0200
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>
Message-Id: <93AC6768-49F3-43CC-8014-83DD3C0EA3D3@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com> <735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org> <CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com> <20140917051457.GA4671@t440s.P-661HNU-F1> <CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com> <20140917065252.GA5554@t440s.lan> <CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com> <8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org> <CAD0=r8xQzhizXo4umQ_mG_WMH7Akp4bji-9PNRGzqj-7HWnyNA@mail.gmail.com> <0EA633E6-A0F5-4F67-B421-9857466C1175@holtmann.org> <CAD0=r8w035mLnWTKtEfxZ7agzwTFRO9dsv+6qdafcBG7RYzYDQ@mail.gmail.com> <F673E928-258E-47F7-B71A-F32410974538@holtmann.org> <CAD0=r8xMcGP-Hjt8uCSY9Qx9VJLov5scSwRTvFr3PAaOXXbyzQ@mail.gmail.com> <CAD0=r8zcPCWKyTQLQeG68uA21_sEv+5wDKNB-GJzgS1+BcD+bQ@mail.gmail.com> <372D8399-BFC6-413F-924F-44CE79030516@holtmann.org> <CAD0=r8x2bub9E+ohicwfxK0AAykRTUSrrTjAD-tFv-aj7xGoww@mail.gmail.com> <CAD0=r8xYGQgGf+DKewk
 9hwFBSwUwnUuaNuBTe3A3vY0FkeiB1g@mail.gmail.com> <375944C8-4378-4589-A883-786F531EA291@holtmann.org> <CAD0=r8xDHvVq9QyCwo7_di_QRhbqEYdGJCKevQoEQ8WZRwA4dA@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>>> Ok, new updated version - we do only passive scan, and we send Device
>>> found event:
>>> 
>>> 
>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>> index 11e2490..3d03617 100644
>>> --- a/doc/mgmt-api.txt
>>> +++ b/doc/mgmt-api.txt
>>> @@ -2135,6 +2135,29 @@ Set Public Address Command
>>>                               Invalid Index
>>> 
>>> 
>>> +Start Passive LE Filtered Device Scan
>>> +=======================
>>> +
>>> +       Command Code:           0x003A
>>> +       Controller Index:       <controller id>
>>> +       Command Parameters:     UUID (16 Octets)
>>> +                    max_pathloss (1 octet)
>>> +
>>> +       Return Parameters:
>>> +
>>> +       This command starts passive LE scan, and filter received
>>> advertisements: if AD contains both TX power level and Service
>>> Solicitation, and UUID is contained in Service Solicitation and
>>> computed pathloss is smaller than max_pathloss parameter, then a
>>> Device Found event will be sent.
>> 
>> generally we tried to avoid to specific LE only commands. Our attempts with the kernel APIs where to make them as generic as possible. So I think something along the lines of adding and removing UUID filters should be something we should target at.
>> 
>> Add UUID Notification Filter
>> ============================
>> 
>>        Command Parameters:     Address_Type (1 Octet)
>>                                UUID (16 Octets)
>>                                Max_Pathloss (1 Octet)
>>        Return Parameters:      Address_Type (1 Octet)
>> 
>> 
>> Remove UUID Notification Filter
>> ===============================
>> 
>>        Command Parameters:     Address_Type (1 Octet)
>>                                UUID (16 Octets)
>>        Return Parameters:      Address_Type (1 Octet)
>> 
>> The Address_Type would be defined the same way as for Start Discovery command.
>> 
>> Now we can discuss if on the mgmt level we want to use pathloss or rather a range of RSSI. I have seen that RSSI is preferred and that the translation from RSSI and advertising data with TX power level is done in the daemon. So for kernel API it might be better to expose RSSI range.
>> 
>> Besides a RSSI range, we might also want to allow giving a RSSI threshold that defines how much the RSSI to change between events to be reported again.
> 
> Some mobile devices that I'm working can change power level for
> advertising, that makes raw RSSI filter useless. It must be pathloss,
> that's why I require TX power in advertisement.

you will still get it, but just have to do the math in the daemon. The only difference is that the daemon gets woken up for RSSI ranges that in the end you might filter out.

>> 
>> That said, the danger with a generic notification filter like this is that we can not implement it efficiently with current hardware without vendor commands. If you use duplicate filtering, then Broadcom and CSR chips behave fully different. Broadcom only filters on BD_ADDR and report devices once no matter what the RSSI, while CSR will report the same device again if the RSSI changes.
>> 
>> With that in mind, it might be safer to introduce a one-shot mgmt API that needs to be repeatedly called to keep scanning for new devices.
>> 
>> Start Service Discovery
>> =======================
>> 
>>        Command Parameters:     Address_Type (1 Octet)
>>                                Min_RSSI (1 Octet)
>>                                Max_RSSI (1 Octet)
>>                                Num_UUID (1 Octet)
>>                                UUID[i] (16 Octets)
>>        Return Parameters:      Address_Type (1 Octet)
>> 
>> Stop Service Discovery
>> ======================
>> 
>>        Command Parameters:     Address_Type (1 Octet)
>>        Return Parameters:      Address_Type (1 Octet)
>> 
>> Without having dedicated controller support for filtering, having such a dedicated discovery for services with a specific UUID seems to be more appropriate and more safe. Since we could always add controller based filtering for background scanning once there is controller support.
> 
> I preffer the "Add UUID Notification Filter" and "Remove UUID
> Notification Filter". For controllers like Broadcom that reports only
> one advertisement can we restart scan internally in kernel ? Why
> propagate that event higher ?

Personally I would prefer just adding another filter as well. However it might be better to start with something like a one-shot handling and see where that is taking us. It is a little bit less intrusive and you could also use active scanning. At the same time you could also easily make it work for BR/EDR. I am thinking here along the lines of something wanting to pair a mouse. You just give the HID UUID and start interleaved discovery for that service on both transports.

For the Broadcom vs CSR differences, yes, we can work out certain quirks on how to improve this situation. However we might need to work these out before adding any new API. We are using controller whitelist whenever we can to avoid having to deal with this difference. But yes, stopping and re-starting has been considered as a possible solution to work with Broadcom controllers. Just never implemented.

I would propose you start looking at how you can make different controllers work smoothly and start by adding a debugfs based API. That way we can toy with this upstream without having to commit to a new API just yet. If we are satisfied, then we turn the debugfs API into a mgmt API for general consumption. Start sending kernel patches that allows some sort UUID filtering in our background scanning handling.

Regards

Marcel

