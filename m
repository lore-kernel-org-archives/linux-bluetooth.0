Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0E17FE1B-B7E3-458A-AA3E-0FE81715856D@holtmann.org>
References: <5515ECE9.9080101@gmail.com>
	<0B4D986A-2913-46C0-8EB2-53EE29C67739@holtmann.org>
	<55164DEC.6070009@gmail.com>
	<E29758F5-D9B1-49AE-A35E-FE06CDD7835F@holtmann.org>
	<5516AD7C.3040401@gmail.com>
	<CAHrH25RbwtPDgLuRNVa92a=5+y5beMYgzrJLfwf19ut-T=cANA@mail.gmail.com>
	<55188985.80001@gmail.com>
	<2F40B83E-682C-47A4-A7A3-BF2CDE2DA4D5@holtmann.org>
	<CAD0=r8xjG4opS5LdLJnsXWNLF6DHEzikAQK4NEcy9ZocF3uOLA@mail.gmail.com>
	<0E17FE1B-B7E3-458A-AA3E-0FE81715856D@holtmann.org>
Date: Mon, 30 Mar 2015 15:26:22 -0700
Message-ID: <CAD0=r8x8dgn4vSz8D_8jWuW6wkzZePQsVjJstOZRrLC-kXRzpQ@mail.gmail.com>
Subject: Re: Multi-Advertising: implementation options, timing questions
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Florian Grandel <fgrandel@gmail.com>, Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 30, 2015 at 2:57 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Jakub,
>
>>>>> Now that most of the logic for a single instance is in place it shoul=
d
>>>>> be straightforward to extend it for multiple instances. I would start
>>>>> by turning the adv_instance field of hci_dev into a list of
>>>>> adv_instances and a way to determine and get a pointer to the
>>>>> currently active instance.
>>>>
>>>> Yes, agreed. That's exactly where I started. Happy to hear that you go=
t the same procedure in mind. I experimented with a dynamically extended ar=
ray and a linked list. The latter seems to be the better choice as it allow=
s us to easily remove entries in the middle of the list.
>>>>
>>>>> You would then modify the code in
>>>>> net/bluetooth/mgmt.c that accesses the instance 1 parameters to use
>>>>> the new getter instead. Once all of that is done, the second step
>>>>> would be a matter of inserting new elements into the advertising list
>>>>> and handling the round-robin logic and the duration parameter.
>>>>
>>>> Agreed. That's what I had in mind, too.
>>>>
>>>>> If it makes things easier I can start tackling the first step which i=
s
>>>>> mostly refactoring my recent code to enable multiple instances. You
>>>>> can then cleanly build the multiple instance logic on top of that.
>>>>
>>>> It's up to you. Just let me know so that I don't interfere with your w=
ork. I don't want to block you as I'll certainly take much longer to get it=
 right (newbie + evenings/weekends only). Today I just set up my dev env an=
d made the build + e2e-tests run on a vm with a minimal kernel. So not much=
 done in the code, yet.
>>>>
>>>> Apart from that I got a few thoughts while familiarizing myself with t=
he source that you might be able to comment on:
>>>>
>>>> - Why do we have two flags to distinguish between multi- and single-in=
stance advertising (HCI_ADVERTISING[_INSTANCE])? Doesn't that allow for inc=
onsistencies (=3Dboth true)? Wouldn't it be better to interpret one as "adv=
ertising generally en-/disabled" and the other as a switch between single a=
nd multi adv mode? That would also allow us to keep track of the adv mode w=
hen advertising is temporarily disabled and then re-enabled. As Marcel comm=
ented this might be necessary for some controllers in multi-adv mode when a=
dv data cannot be changed on-the-fly.
>>>
>>> the HCI_ADVERTISING maps to the advertising setting. And it always take=
s precedence. It is essentially instance 0. This fact is actually documente=
d. So if both flags are true, then instance 0 is used and all the other one=
s will be disabled.
>>>
>>>> - What do you think of the idea to handle "set adv" and multi-adv more=
 uniformly? I have the following in mind:
>>>> 1) whenever an adv mode switch occurs, all current adv instances will =
be canceled and destroyed
>>>> 2) "set adv" will add/replace a single instance to the list
>>>> 3) "add adv" will add instances up to max_instances
>>>> This would probably dry up the code and duplicate memory structures qu=
ite a bit and also remove some logic quirks.
>>>
>>> See comment above, we can not really change legacy API. It has to stay =
around for backwards compatibility. And that is why set advertising takes p=
recedence over anything added by add advertising.
>>>
>>>> - Instances are currently being identified by an integer "adv_info.ins=
tance". When we add instances more dynamically would it not be better to pa=
ss pointers around and get rid of that integer? That would remove the neces=
sity to keep track of, synchronize and verify instance ids.
>>>
>>> What are you planning to verify here. The instance id is coming from us=
erspace.
>>>
>>>> - The mgmt_rp_read_adv_features structure contains an unused instance[=
0]. Seems to be redundant and could be removed, right?
>>>
>>> Read up on what instance[0] actually does in a struct. We have used the=
se constructs before. I am sensing that you misunderstood what this is for.
>>
>> Sorry for my late response, but I wanted to raise a concern about how
>> you want to rotate advertisement data.
>>
>> When you advertise, you probably want someone to scan and find your
>> device. That might be hard, because filtered LE scan is widely used,
>> i.e. BlueZ uses filtered LE scan, that's restarted every 10 seconds.
>> That means, that during those 10 seconds your remote device will be
>> reported once, and changes you're making to advertised data will not
>> be visible. I think same is true for Windows (you can currently scan
>> only from control panel), and Mac (you can configure it to do
>> non-filtered scan in your app)
>
> I heard about the Windows limitations that you can not scan from your app=
lication at all. That is so different compared to any other operating syste=
ms. I think Windows really has to fix things in that area.

Yes, Windows allows only for scans from Control Panel, and that's
single filtered scan. If they fix that, they might let you do filtered
scan from your app (just like BlueZ does right now), and it still
won't work right with round ribbon, example below.

>
>> When you just modify advertisement data, device that's doing filtered
>> LE scan will report one MAC address only once during this scan (except
>> for CSR, which reports RSSI changes).
>> I recently wrote MGMT_OP_START_SERVICE_DISCOVERY, but it also uses
>> filtered scan, and restarts the scan, but only if device with proper
>> UUID was found. It assumes that UUID was there when device started
>> advertising.
>
> But it also runs for a certain amount of time from the kernel perspective=
. And then userspace has to restart it again if it really wants to scan aga=
in. So that means you will see the new advertising data then.
>

Real world example of how that might go wrong and make you not see
your advertisement:

Machine A run interleaved discovery without simuleanous quirk, using
org.bluez.StartDiscovery. That's 5s LE scan (L), then 5s BREDR inquiry
(B), then 5s delay from BlueZ daemon (D).

Machine B advertises 3 BLE devices, 5s each in round-ribbon, (A, B, C).

If both started perfectly at same time, here's what they do:
LLLLLBBBBBDDDDDLLLLLBBBBBDDDDD
AAAAABBBBBCCCCCAAAAABBBBBCCCCC








>> There are two propertiary solutions I know:
>> - one is used in iOS devices, they have special 'overflow' data, that
>> only other iOS device can see (not even MAC), so they can advertise
>> more in one MAC address. I think it's described here but I'm not 100%
>> sure, only for members:
>> https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=3D2844=
51
>
> That is something different. One is a new Bluetooth SIG specification and=
 the other is some Broadcom vendor specific behavior that Apple relies on. =
Unreleased Bluetooth SIG specification are also off limit on this mailing l=
ist. They are Bluetooth SIG confidential.
>
>> . To use that you need a special chip that would properly handle this
>> data.
>> - second is used in Android phones (currently only Nexus 6) that can
>> advertise as multiple MAC addresses, each having different adv data at
>> the same time (it might be same thing that broadcom propertiary
>> solution you were discussing). It uses multiple MAC addresses to
>> advertise more, so filtered scan will find those devices  and report
>> them properly.
>
> I was considering advertising as multiple random addresses, but that has =
the problem that connection handling becomes really complicated. In the end=
 you would run multiple instances of you stack that the chip that multiplex=
es with different addresses. However that has the problem that connection h=
andling is super complicated and this really needs special handling in the =
controller. Otherwise you end up with the simple case that your LE HID devi=
ce can not reconnect. This is something we want to avoid.
>
> However judging from the Android HAL, it has to actually advertise with t=
he same address. At least there is not provision that found quickly that al=
lows to change the address. For some stupid reason it can restrict the chan=
nel map, but I have no idea why you would do that anyway. Except for making=
 it easier for sniffers to trace you.
>
>> There's command that rotates mac address:
>> HCI_LE_Set_Resolvable_Private_Address_Timeout, but there's no way to
>> go back to 'previous' mac in order to have something like 'round
>> ribbon'. I'm also not sure whether that would have any effect on
>> currently estabilished connections, I think all devices connected to
>> private address get disconnected when it rotates, but I'm not 100%
>> sure. Also when you rotate MAC, controller will not respond to connect
>> event to old address.
>
> That is for LE Privacy when using RPAs. That is a different thing. And th=
e previously connected devices do not get disconnected. It is perfectly fin=
e to have device A connected to RPA1 and device B connected to RPA2. The co=
ntrollers are actually capable of handling this.
>
> If you would be using LE Privacy, then yes, once you rotate the advertisi=
ng data, you should change the RPA as well. Actually we can do that easily =
in the kernel actually. You just set the HCI_RPA_EXPIRED flag and the core =
will take care of the rest. We already do that once an encryption attempt f=
ails so that a new address is used the next time around.
>
>> The other problem is that rotating advertisement will cause slow discove=
ry.
>>
>> So I think rotating only adv data is not good idea. Maybe we can have
>> different mechanism that decide what gets advertised ? I.e.
>> application that's in foreground is deciding what gets advertised. Or
>> applications register their advertisements, and user can pick from
>> system menu what is currently being advertised ?
>
> That is up to bluetoothd. If it chooses to only utilize a single instance=
, then that is fine. That is a policy decision that does not belong into th=
e kernel.
>
> Regards
>
> Marcel
>
