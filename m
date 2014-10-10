Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8A0217F1-C062-466F-8C04-38E324BDD55D@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
	<735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
	<CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
	<20140917051457.GA4671@t440s.P-661HNU-F1>
	<CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com>
	<20140917065252.GA5554@t440s.lan>
	<CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com>
	<8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org>
	<CAD0=r8xQzhizXo4umQ_mG_WMH7Akp4bji-9PNRGzqj-7HWnyNA@mail.gmail.com>
	<0EA633E6-A0F5-4F67-B421-9857466C1175@holtmann.org>
	<CAD0=r8w035mLnWTKtEfxZ7agzwTFRO9dsv+6qdafcBG7RYzYDQ@mail.gmail.com>
	<F673E928-258E-47F7-B71A-F32410974538@holtmann.org>
	<CAD0=r8xMcGP-Hjt8uCSY9Qx9VJLov5scSwRTvFr3PAaOXXbyzQ@mail.gmail.com>
	<CAD0=r8zcPCWKyTQLQeG68uA21_sEv+5wDKNB-GJzgS1+BcD+bQ@mail.gmail.com>
	<372D8399-BFC6-413F-924F-44CE79030516@holtmann.org>
	<CAD0=r8x2bub9E+ohicwfxK0AAykRTUSrrTjAD-tFv-aj7xGoww@mail.gmail.com>
	<375944C8-4378-4589-A883-786F531EA291@holtmann.org>
	<CAD0=r8xDHvVq9QyCwo7_di_QRhbqEYdGJCKevQoEQ8WZRwA4dA@mail.gmail.com>
	<93AC6768-49F3-43CC-8014-83DD3C0EA3D3@holtmann.org>
	<8A0217F1-C062-466F-8C04-38E324BDD55D@holtmann.org>
Date: Fri, 10 Oct 2014 08:49:12 -0700
Message-ID: <CAD0=r8wuVAB0H1sRghzsmm0Ak9+r2_f13541_dP6QCV1ZeogNw@mail.gmail.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Scott James Remnant <keybuk@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for info!

I'll look into that.

On Fri, Oct 10, 2014 at 3:52 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Jakub,
>
>>>>> Ok, new updated version - we do only passive scan, and we send Device
>>>>> found event:
>>>>>
>>>>>
>>>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>>>> index 11e2490..3d03617 100644
>>>>> --- a/doc/mgmt-api.txt
>>>>> +++ b/doc/mgmt-api.txt
>>>>> @@ -2135,6 +2135,29 @@ Set Public Address Command
>>>>>                              Invalid Index
>>>>>
>>>>>
>>>>> +Start Passive LE Filtered Device Scan
>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>>>> +
>>>>> +       Command Code:           0x003A
>>>>> +       Controller Index:       <controller id>
>>>>> +       Command Parameters:     UUID (16 Octets)
>>>>> +                    max_pathloss (1 octet)
>>>>> +
>>>>> +       Return Parameters:
>>>>> +
>>>>> +       This command starts passive LE scan, and filter received
>>>>> advertisements: if AD contains both TX power level and Service
>>>>> Solicitation, and UUID is contained in Service Solicitation and
>>>>> computed pathloss is smaller than max_pathloss parameter, then a
>>>>> Device Found event will be sent.
>>>>
>>>> generally we tried to avoid to specific LE only commands. Our attempts=
 with the kernel APIs where to make them as generic as possible. So I think=
 something along the lines of adding and removing UUID filters should be so=
mething we should target at.
>>>>
>>>> Add UUID Notification Filter
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>>
>>>>       Command Parameters:     Address_Type (1 Octet)
>>>>                               UUID (16 Octets)
>>>>                               Max_Pathloss (1 Octet)
>>>>       Return Parameters:      Address_Type (1 Octet)
>>>>
>>>>
>>>> Remove UUID Notification Filter
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>>       Command Parameters:     Address_Type (1 Octet)
>>>>                               UUID (16 Octets)
>>>>       Return Parameters:      Address_Type (1 Octet)
>>>>
>>>> The Address_Type would be defined the same way as for Start Discovery =
command.
>>>>
>>>> Now we can discuss if on the mgmt level we want to use pathloss or rat=
her a range of RSSI. I have seen that RSSI is preferred and that the transl=
ation from RSSI and advertising data with TX power level is done in the dae=
mon. So for kernel API it might be better to expose RSSI range.
>>>>
>>>> Besides a RSSI range, we might also want to allow giving a RSSI thresh=
old that defines how much the RSSI to change between events to be reported =
again.
>>>
>>> Some mobile devices that I'm working can change power level for
>>> advertising, that makes raw RSSI filter useless. It must be pathloss,
>>> that's why I require TX power in advertisement.
>>
>> you will still get it, but just have to do the math in the daemon. The o=
nly difference is that the daemon gets woken up for RSSI ranges that in the=
 end you might filter out.
>>
>>>>
>>>> That said, the danger with a generic notification filter like this is =
that we can not implement it efficiently with current hardware without vend=
or commands. If you use duplicate filtering, then Broadcom and CSR chips be=
have fully different. Broadcom only filters on BD_ADDR and report devices o=
nce no matter what the RSSI, while CSR will report the same device again if=
 the RSSI changes.
>>>>
>>>> With that in mind, it might be safer to introduce a one-shot mgmt API =
that needs to be repeatedly called to keep scanning for new devices.
>>>>
>>>> Start Service Discovery
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>>       Command Parameters:     Address_Type (1 Octet)
>>>>                               Min_RSSI (1 Octet)
>>>>                               Max_RSSI (1 Octet)
>>>>                               Num_UUID (1 Octet)
>>>>                               UUID[i] (16 Octets)
>>>>       Return Parameters:      Address_Type (1 Octet)
>>>>
>>>> Stop Service Discovery
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>>       Command Parameters:     Address_Type (1 Octet)
>>>>       Return Parameters:      Address_Type (1 Octet)
>>>>
>>>> Without having dedicated controller support for filtering, having such=
 a dedicated discovery for services with a specific UUID seems to be more a=
ppropriate and more safe. Since we could always add controller based filter=
ing for background scanning once there is controller support.
>>>
>>> I preffer the "Add UUID Notification Filter" and "Remove UUID
>>> Notification Filter". For controllers like Broadcom that reports only
>>> one advertisement can we restart scan internally in kernel ? Why
>>> propagate that event higher ?
>>
>> Personally I would prefer just adding another filter as well. However it=
 might be better to start with something like a one-shot handling and see w=
here that is taking us. It is a little bit less intrusive and you could als=
o use active scanning. At the same time you could also easily make it work =
for BR/EDR. I am thinking here along the lines of something wanting to pair=
 a mouse. You just give the HID UUID and start interleaved discovery for th=
at service on both transports.
>
> I send a proposal for doing an one-shot service discovery. So you can pro=
pose a RSSI Threshold and a list of possible UUIDs to look for.
>
> If RSSI Threshold is 127 or the Num_UUID is 0, then it will behave the sa=
me way as Start Discovery. I think this is how we should get started to tac=
kle this problem.
>
> Regards
>
> Marcel
>
