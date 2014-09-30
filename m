Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8xMcGP-Hjt8uCSY9Qx9VJLov5scSwRTvFr3PAaOXXbyzQ@mail.gmail.com>
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
Date: Tue, 30 Sep 2014 09:44:05 -0700
Message-ID: <CAD0=r8zcPCWKyTQLQeG68uA21_sEv+5wDKNB-GJzgS1+BcD+bQ@mail.gmail.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Scott James Remnant <keybuk@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 11e2490..1c78f1c 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2135,6 +2135,34 @@ Set Public Address Command
  Invalid Index


+Start LE Filtered Device Scan
+=======================
+
+ Command Code: 0x003A
+ Controller Index: <controller id>
+ Command Parameters: UUID (16 Octets)
+             max_pathloss (1 octet)
+             is_active (1 octet)
+
+ Return Parameters:
+
+ This command starts LE scan, and filter received advertisements: if
AD contains both TX power level and Service Solicitation, and UUID is
contained in Service Solicitation and computed pathloss is smaller
than max_pathloss parameter, then a Advertisement Received event will
be sent.
+
+ Possible values for the is_active parameter:
+ 0 Start passive scan
+ 1 Start active scan
+
+ This command can only be used when the controller is powered.
+
+ This command generates a Command Complete event on success or failure.
+
+ Possible errors: Busy
+ Not Supported
+ Invalid Parameters
+ Not Powered
+ Invalid Index
+
+
 Command Complete Event
 ======================

@@ -2851,3 +2879,44 @@ New Configuration Options Event

  This event indicates that one or more of the options for the
  controller configuration has changed.
+
+
+Advertisement Received Event
+==============================
+
+ Event Code: 0x0020
+ Controller Index: <controller id>
+ Event Parameters: Address (6 Octets)
+ Address_Type (1 Octet)
+ RSSI (1 Octet)
+ Flags (4 Octets)
+ AD_Data_Length (2 Octets)
+ AD_Data (0-65535 Octets)
+
+
+ This event indicates that we received event during LE Filtered Device Scan
+
+ Possible values for the Address_Type parameter:
+ 0 Reserved (not in use)
+ 1 LE Public
+ 2 LE Random
+
+ The following bits are defined for the Flags parameter:
+ 0 Reserved (not in use)
+ 1 Legacy Pairing
+ 2 Not Connectable
+
+ AD_Data contains AD if we're in passive scan mode, or EIR if we're
in active scan mode.
+
+ The Legacy Pairing flag indicates that Legacy Pairing is likely
+ to occur when pairing with this device. An application could use
+ this information to optimize the pairing process by locally
+ pre-generating a PIN code and thereby eliminate the risk of
+ local input timeout when pairing. Note that there is a risk of
+ false-positives for this flag so user space should be able to
+ handle getting something else as a PIN Request when pairing.
+
+ The Not Connectable flag indicates that the device will not
+ accept any connections. This can be indicated by Low Energy
+ devices that are in broadcaster role.
+
-- 
2.1.0.rc2.206.gedb03e5


On Fri, Sep 19, 2014 at 9:29 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> On Fri, Sep 19, 2014 at 5:35 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Jakub,
>>
>>> >>>>>>>> have you looked at the the Add Device management command with the
>>> >>>>>>>> 0x00 Action. That will just send out Device Found events for
>>> >>>>>>>> devices
>>> >>>>>>>> in range and uses passive scanning.
>>> >>>>>>>>
>>> >>>>>>>> In addition if you are paired with a device and actually want to
>>> >>>>>>>> connect to it, you can use Action 0x02 to allow for background
>>> >>>>>>>> connection. This is currently in use for LE HID devices.
>>> >>>>>>>
>>> >>>>>>> This still only sends one Device Found event though right? In
>>> >>>>>>> Jakub's
>>> >>>>>>> case, a mgmt event is desired to let the userspace know every time
>>> >>>>>>> a
>>> >>>>>>> new advertisement packet is received, with the updated RSSI and
>>> >>>>>>> TxPower and so on.
>>> >>>>>>
>>> >>>>>> It should send as many Device Found events as there are advertising
>>> >>>>>> reports from the controller. We're enabling duplicate filtering in
>>> >>>>>> the
>>> >>>>>> hci_req_add_le_passive_scan() function in hci_core.c so maybe
>>> >>>>>> that's
>>> >>>>>> your issue? Some HW (like Broadcom) tend to be more conservative in
>>> >>>>>> how
>>> >>>>>> many events they send when filtering is enabled whereas others
>>> >>>>>> (like
>>> >>>>>> CSR) will give you many more of them (at least one whenever RSSI
>>> >>>>>> changes).
>>> >>>>>
>>> >>>>> Why is duplicate filtering being enabled ? Does it filter packets
>>> >>>>> that
>>> >>>>> have different advertisement content ? Can I turn it off ?
>>> >>>>
>>> >>>> At least in the HCI section of the core spec this parameter is quite
>>> >>>> vaguely defined. We've enabled it to save power by avoiding the
>>> >>>> controller waking up the host too often. With auto-connections it
>>> >>>> makes
>>> >>>> sense to have it enabled since we're really only interested in the
>>> >>>> first
>>> >>>> event which acts as a trigger to connect. Same goes for device
>>> >>>> discovery
>>> >>>> when you're interested in setting up a new device for use.
>>> >>>>
>>> >>>> Right now the filtering is hard-coded but we could consider making it
>>> >>>> conditional to whether there are any entries with action 0x00 ("scan
>>> >>>> but
>>> >>>> don't connect") and disable the filtering in that case.
>>> >>>>
>>> >>>>>>> I think this ties in with some of the previous conversations on
>>> >>>>>>> the
>>> >>>>>>> list about adding a device scan API that is geared towards
>>> >>>>>>> applications (rather than OS UI). That is, not only a mgmt API
>>> >>>>>>> that
>>> >>>>>>> enables these kinds of use cases but also (probably) a high-level
>>> >>>>>>> API
>>> >>>>>>> exposed from bluetoothd that allows applications to scan for
>>> >>>>>>> devices
>>> >>>>>>> filtered by service UUIDs, contents of the manufacturer data
>>> >>>>>>> field,
>>> >>>>>>> and so on.
>>> >>>>>>>
>>> >>>>>>> As for the Add Device command, does bluetoothd currently use this
>>> >>>>>>> somehow?
>>> >>>>>>
>>> >>>>>> Yes, this feature (action 0x02 for Add Device) takes over the
>>> >>>>>> entire LE
>>> >>>>>> background scanning and auto-connection mechanism from 3.17 kernel
>>> >>>>>> onwards since BlueZ 5.22 (which was mentioned in our release notes
>>> >>>>>> btw).
>>> >>>>>> This is much better than the active scanning based auto-connections
>>> >>>>>> that
>>> >>>>>> have until now been done using Start/Stop Discovery.
>>> >>>>>
>>> >>>>> Thanks for pointing that!
>>> >>>>> The release note says that:
>>> >>>>> "The kernel will even use the controller-side whitelist during
>>> >>>>> scanning (if no Resolvable Private Addresses are present), saving
>>> >>>>> even
>>> >>>>> more power."
>>> >>>>> If I understand well, that mean that my peripheral device need to be
>>> >>>>> whitelisted in order for me to get advertisements ?
>>> >>>>
>>> >>>> The controller-side whitelist just means that the controller only
>>> >>>> wakes
>>> >>>> us up and gives us advertisements for entries in the whitelist. When
>>> >>>> not
>>> >>>> using the whitelist the kernel gets woken up and needs to do itself
>>> >>>> the
>>> >>>> filtering out of unknown devices. The kernel uses the controller-side
>>> >>>> whitelist whenever possible, but e.g. when we have resolvable private
>>> >>>> addresses in the list we can't use it as we can't know the address
>>> >>>> the
>>> >>>> remote device will use in advance.
>>> >>>>
>>> >>>>> My use case include scanning for non-paired, non-connected devices,
>>> >>>>> checking RSSI value and deciding about connection based on
>>> >>>>> advertisement content, so that won't work. Am I right ?
>>> >>>>
>>> >>>> If you know the bdaddr that you're interested in in advance we should
>>> >>>> be
>>> >>>> able to tweak the Add Device command to do what you want (e.g.
>>> >>>> disable
>>> >>>> duplicate filtering in the case of Action=0x00 entries). However, if
>>> >>>> what you need is general scanning for any devices (also previously
>>> >>>> unknown ones) then Add Device doesn't really fit in (since it takes a
>>> >>>> known bdaddr). For that we'd either need to consider allowing
>>> >>>> BDADDR_ANY
>>> >>>> as an accepted parameter or then we'd need to define a new mgmt
>>> >>>> command.
>>> >>>>
>>> >>>
>>> >>> Unfortunately my case include previously unknown devices. I decide
>>> >>> wether I should connect (without pairing) based on advertised service
>>> >>> and RSSI power only. BDADDR_ANY seems good solution. Or maybe we can
>>> >>> add some parameter that will force not using controller-side whitelist
>>> >>> for scan?
>>> >>
>>> >> actually BDADDR_ANY does not really look like a good solution. What we
>>> >> really want is to be able to define a list of UUIDs and maybe an RSSI range
>>> >> or threshold for this.
>>> >
>>> > I think there should be option in mgmt api to capture all
>>> > advertisement packets, and later on application level decide what
>>> > property to filter on. I understand that this might be not energy
>>> > efficient, and that's why there is whitelisting and controller level
>>> > filtering.
>>> > Specifying list of UUIDs or RSSI value as parameter will be nice, but
>>> > controllers doesn't support this kind of complex filtering right now
>>> > anyway.
>>> > If you decide to allow UUID and RSSI filtering, maybe in a while
>>> > someone will come up with need to filter by something in advertisement
>>> > ? Maybe it would be good to have this 'look for advertisements' API
>>> > very general.
>>>
>>> we can always extend the mgmt API with a new command for filtering
>>> something new. And yes, the Bluetooth SIG will define a new AD element type
>>> and then it is not supported. There are also many new Bluetooth
>>> specifications in progress and also planned (which I will not iterate here
>>> since they are Buetooth SIG confidential) which extend LE advertising in
>>> various form and shapes.
>>>
>>> For me it is important that we can do certain things in the kernel so that
>>> userspace can keep sleeping. And we really can just add extra mgmt commands
>>> to allow for this. Remember that kernel will have to disable certain
>>> "background" behavior anymore. An active discovery always comes first. An
>>> active connection establishment from a socket comes first. Pairing a device
>>> comes first. So all these major events that are driven by an user action
>>> will be prioritized. We have to do that since otherwise you end up with bad
>>> user experience. But then again, draining the battery is also bad user
>>> experience. So we need to find a balance here.
>>
>>
>> I will be very happy with mgmt api method that will filter by serice uuid
>> and RSSI value, and that's enough for me. From my use case it looks like the
>> user is going to be in this scan state for short time - few seconds, maximum
>> minute.
>>
>>
>> that is then something different. That is more like "scan for this UUID
>> within this RSSI range for x amount of seconds, if any results, report them,
>> and otherwise go back to idle".
>>
>> We can talk about this one-shot kind of API. I would need to think about it
>> a little bit more. However one thing that you might want to consider is
>> using pathloss instead of RSSI. Especially if the advertisement contains the
>> TX power. That way you get a way better idea of how close or far the device
>> is.
>>
>
> Yay! Thanks!
> Yes, pathloss will be much better, I was using it before.
>
>> If it would be possible to also add general le scan method that would return
>> all advertisements, marked as "only for development", and "not for use in
>> production", and "behaves differently for different controllers" and maybe
>> somehow disabled by default and you need to set some special flag to enable
>> it on your developer machine then it would be awsome for developers that
>> want to play with it, but it's not my requirement.
>>
>>
>> The mgmt API will never contain any development methods. It is an official
>> API and we are committed to stable API promise here. Any kind of testing API
>> has to go via debugfs.
>>
>> Regards
>>
>> Marcel
>>
