Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140917065252.GA5554@t440s.lan>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
	<735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
	<CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
	<20140917051457.GA4671@t440s.P-661HNU-F1>
	<CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com>
	<20140917065252.GA5554@t440s.lan>
Date: Wed, 17 Sep 2014 00:19:10 -0700
Message-ID: <CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>, Arman Uguray <armansito@chromium.org>,
	Marcel Holtmann <marcel@holtmann.org>, BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 16, 2014 at 11:52 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Tue, Sep 16, 2014, Jakub Pawlowski wrote:
>> On Tue, Sep 16, 2014 at 10:14 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> > Hi Arman,
>> >
>> > On Tue, Sep 16, 2014, Arman Uguray wrote:
>> >> > have you looked at the the Add Device management command with the
>> >> > 0x00 Action. That will just send out Device Found events for devices
>> >> > in range and uses passive scanning.
>> >> >
>> >> > In addition if you are paired with a device and actually want to
>> >> > connect to it, you can use Action 0x02 to allow for background
>> >> > connection. This is currently in use for LE HID devices.
>> >>
>> >> This still only sends one Device Found event though right? In Jakub's
>> >> case, a mgmt event is desired to let the userspace know every time a
>> >> new advertisement packet is received, with the updated RSSI and
>> >> TxPower and so on.
>> >
>> > It should send as many Device Found events as there are advertising
>> > reports from the controller. We're enabling duplicate filtering in the
>> > hci_req_add_le_passive_scan() function in hci_core.c so maybe that's
>> > your issue? Some HW (like Broadcom) tend to be more conservative in how
>> > many events they send when filtering is enabled whereas others (like
>> > CSR) will give you many more of them (at least one whenever RSSI
>> > changes).
>>
>> Why is duplicate filtering being enabled ? Does it filter packets that
>> have different advertisement content ? Can I turn it off ?
>
> At least in the HCI section of the core spec this parameter is quite
> vaguely defined. We've enabled it to save power by avoiding the
> controller waking up the host too often. With auto-connections it makes
> sense to have it enabled since we're really only interested in the first
> event which acts as a trigger to connect. Same goes for device discovery
> when you're interested in setting up a new device for use.
>
> Right now the filtering is hard-coded but we could consider making it
> conditional to whether there are any entries with action 0x00 ("scan but
> don't connect") and disable the filtering in that case.
>
>> >> I think this ties in with some of the previous conversations on the
>> >> list about adding a device scan API that is geared towards
>> >> applications (rather than OS UI). That is, not only a mgmt API that
>> >> enables these kinds of use cases but also (probably) a high-level API
>> >> exposed from bluetoothd that allows applications to scan for devices
>> >> filtered by service UUIDs, contents of the manufacturer data field,
>> >> and so on.
>> >>
>> >> As for the Add Device command, does bluetoothd currently use this somehow?
>> >
>> > Yes, this feature (action 0x02 for Add Device) takes over the entire LE
>> > background scanning and auto-connection mechanism from 3.17 kernel
>> > onwards since BlueZ 5.22 (which was mentioned in our release notes btw).
>> > This is much better than the active scanning based auto-connections that
>> > have until now been done using Start/Stop Discovery.
>>
>> Thanks for pointing that!
>> The release note says that:
>> "The kernel will even use the controller-side whitelist during
>> scanning (if no Resolvable Private Addresses are present), saving even
>> more power."
>> If I understand well, that mean that my peripheral device need to be
>> whitelisted in order for me to get advertisements ?
>
> The controller-side whitelist just means that the controller only wakes
> us up and gives us advertisements for entries in the whitelist. When not
> using the whitelist the kernel gets woken up and needs to do itself the
> filtering out of unknown devices. The kernel uses the controller-side
> whitelist whenever possible, but e.g. when we have resolvable private
> addresses in the list we can't use it as we can't know the address the
> remote device will use in advance.
>
>> My use case include scanning for non-paired, non-connected devices,
>> checking RSSI value and deciding about connection based on
>> advertisement content, so that won't work. Am I right ?
>
> If you know the bdaddr that you're interested in in advance we should be
> able to tweak the Add Device command to do what you want (e.g. disable
> duplicate filtering in the case of Action=0x00 entries). However, if
> what you need is general scanning for any devices (also previously
> unknown ones) then Add Device doesn't really fit in (since it takes a
> known bdaddr). For that we'd either need to consider allowing BDADDR_ANY
> as an accepted parameter or then we'd need to define a new mgmt command.
>

Unfortunately my case include previously unknown devices. I decide
wether I should connect (without pairing) based on advertised service
and RSSI power only. BDADDR_ANY seems good solution. Or maybe we can
add some parameter that will force not using controller-side whitelist
for scan?

> Johan
