Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
	<735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
	<CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
	<20140917051457.GA4671@t440s.P-661HNU-F1>
	<CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com>
	<20140917065252.GA5554@t440s.lan>
	<CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com>
	<8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org>
Date: Wed, 17 Sep 2014 22:58:29 -0700
Message-ID: <CAD0=r8xQzhizXo4umQ_mG_WMH7Akp4bji-9PNRGzqj-7HWnyNA@mail.gmail.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 17, 2014 at 7:03 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jakub,
>
>>>>>>> have you looked at the the Add Device management command with the
>>>>>>> 0x00 Action. That will just send out Device Found events for devices
>>>>>>> in range and uses passive scanning.
>>>>>>>
>>>>>>> In addition if you are paired with a device and actually want to
>>>>>>> connect to it, you can use Action 0x02 to allow for background
>>>>>>> connection. This is currently in use for LE HID devices.
>>>>>>
>>>>>> This still only sends one Device Found event though right? In Jakub's
>>>>>> case, a mgmt event is desired to let the userspace know every time a
>>>>>> new advertisement packet is received, with the updated RSSI and
>>>>>> TxPower and so on.
>>>>>
>>>>> It should send as many Device Found events as there are advertising
>>>>> reports from the controller. We're enabling duplicate filtering in the
>>>>> hci_req_add_le_passive_scan() function in hci_core.c so maybe that's
>>>>> your issue? Some HW (like Broadcom) tend to be more conservative in how
>>>>> many events they send when filtering is enabled whereas others (like
>>>>> CSR) will give you many more of them (at least one whenever RSSI
>>>>> changes).
>>>>
>>>> Why is duplicate filtering being enabled ? Does it filter packets that
>>>> have different advertisement content ? Can I turn it off ?
>>>
>>> At least in the HCI section of the core spec this parameter is quite
>>> vaguely defined. We've enabled it to save power by avoiding the
>>> controller waking up the host too often. With auto-connections it makes
>>> sense to have it enabled since we're really only interested in the first
>>> event which acts as a trigger to connect. Same goes for device discovery
>>> when you're interested in setting up a new device for use.
>>>
>>> Right now the filtering is hard-coded but we could consider making it
>>> conditional to whether there are any entries with action 0x00 ("scan but
>>> don't connect") and disable the filtering in that case.
>>>
>>>>>> I think this ties in with some of the previous conversations on the
>>>>>> list about adding a device scan API that is geared towards
>>>>>> applications (rather than OS UI). That is, not only a mgmt API that
>>>>>> enables these kinds of use cases but also (probably) a high-level API
>>>>>> exposed from bluetoothd that allows applications to scan for devices
>>>>>> filtered by service UUIDs, contents of the manufacturer data field,
>>>>>> and so on.
>>>>>>
>>>>>> As for the Add Device command, does bluetoothd currently use this somehow?
>>>>>
>>>>> Yes, this feature (action 0x02 for Add Device) takes over the entire LE
>>>>> background scanning and auto-connection mechanism from 3.17 kernel
>>>>> onwards since BlueZ 5.22 (which was mentioned in our release notes btw).
>>>>> This is much better than the active scanning based auto-connections that
>>>>> have until now been done using Start/Stop Discovery.
>>>>
>>>> Thanks for pointing that!
>>>> The release note says that:
>>>> "The kernel will even use the controller-side whitelist during
>>>> scanning (if no Resolvable Private Addresses are present), saving even
>>>> more power."
>>>> If I understand well, that mean that my peripheral device need to be
>>>> whitelisted in order for me to get advertisements ?
>>>
>>> The controller-side whitelist just means that the controller only wakes
>>> us up and gives us advertisements for entries in the whitelist. When not
>>> using the whitelist the kernel gets woken up and needs to do itself the
>>> filtering out of unknown devices. The kernel uses the controller-side
>>> whitelist whenever possible, but e.g. when we have resolvable private
>>> addresses in the list we can't use it as we can't know the address the
>>> remote device will use in advance.
>>>
>>>> My use case include scanning for non-paired, non-connected devices,
>>>> checking RSSI value and deciding about connection based on
>>>> advertisement content, so that won't work. Am I right ?
>>>
>>> If you know the bdaddr that you're interested in in advance we should be
>>> able to tweak the Add Device command to do what you want (e.g. disable
>>> duplicate filtering in the case of Action=0x00 entries). However, if
>>> what you need is general scanning for any devices (also previously
>>> unknown ones) then Add Device doesn't really fit in (since it takes a
>>> known bdaddr). For that we'd either need to consider allowing BDADDR_ANY
>>> as an accepted parameter or then we'd need to define a new mgmt command.
>>>
>>
>> Unfortunately my case include previously unknown devices. I decide
>> wether I should connect (without pairing) based on advertised service
>> and RSSI power only. BDADDR_ANY seems good solution. Or maybe we can
>> add some parameter that will force not using controller-side whitelist
>> for scan?
>
> actually BDADDR_ANY does not really look like a good solution. What we really want is to be able to define a list of UUIDs and maybe an RSSI range or threshold for this.

I think there should be option in mgmt api to capture all
advertisement packets, and later on application level decide what
property to filter on. I understand that this might be not energy
efficient, and that's why there is whitelisting and controller level
filtering.
Specifying list of UUIDs or RSSI value as parameter will be nice, but
controllers doesn't support this kind of complex filtering right now
anyway.
If you decide to allow UUID and RSSI filtering, maybe in a while
someone will come up with need to filter by something in advertisement
? Maybe it would be good to have this 'look for advertisements' API
very general.

>
> The real problem is that controllers behave so different when you talk about advertising event report. So even if you have duplicate filtering on or off they have different behaviors. And that is where the real challenge comes into play here. What works on one controller just fine, might turn into a huge battery drain on the other.
>

Thanks for pointing that out, I've already heard that argument from
Scott before, and it'll require more investigation.

> Get a few different controllers, Marvell, Intel, CSR and Broadcom and play with hcitool lescan to see the different behavior they provide. You can also write your own small little HCI program using the HCI User Channel feature we added in 3.13 and use src/shared/hci.c as helper for handling HCI commands. You really need to understand what you are getting yourself into here.

I've already implemented my functionality first using BLED112 dongle,
and then on linux using HCI api and tested it on two controllers, but
from what I understood MGMT is the  API of future. Also I want to make
it work for all controllers, not only those three.

>
> My main concern is battery drain. Once we figured out on how to avoid that, we can easily design a new mgmt command that allows you to do exactly what you want to do.

>From what I understand as long as controllers don't support
sophisticated filtering, that would be energy conuming. I would also
preffer to find a energy-friendly way, but is it better not to have
this functionality rather than have it in non-energy consuming way ?

>
> Regards
>
> Marcel
>
