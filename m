Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 30 Mar 2015 15:37:51 -0700
Message-ID: <CAD0=r8wG4SZNDDNzeCx3xUB0ji8Xi0_f8=OrirQ-x4keLTv9JA@mail.gmail.com>
Subject: Re: Multi-Advertising: implementation options, timing questions
From: Jakub Pawlowski <jpawlowski@google.com>
To: Florian Grandel <fgrandel@gmail.com>,
	Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Sorry for previous message, I've sent only part of response by mistake.
On Mon, Mar 30, 2015 at 2:57 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jakub,
>
>>>>> Now that most of the logic for a single instance is in place it should
>>>>> be straightforward to extend it for multiple instances. I would start
>>>>> by turning the adv_instance field of hci_dev into a list of
>>>>> adv_instances and a way to determine and get a pointer to the
>>>>> currently active instance.
>>>>
>>>> Yes, agreed. That's exactly where I started. Happy to hear that you got the same procedure in mind. I experimented with a dynamically extended array and a linked list. The latter seems to be the better choice as it allows us to easily remove entries in the middle of the list.
>>>>
>>>>> You would then modify the code in
>>>>> net/bluetooth/mgmt.c that accesses the instance 1 parameters to use
>>>>> the new getter instead. Once all of that is done, the second step
>>>>> would be a matter of inserting new elements into the advertising list
>>>>> and handling the round-robin logic and the duration parameter.
>>>>
>>>> Agreed. That's what I had in mind, too.
>>>>
>>>>> If it makes things easier I can start tackling the first step which is
>>>>> mostly refactoring my recent code to enable multiple instances. You
>>>>> can then cleanly build the multiple instance logic on top of that.
>>>>
>>>> It's up to you. Just let me know so that I don't interfere with your work. I don't want to block you as I'll certainly take much longer to get it right (newbie + evenings/weekends only). Today I just set up my dev env and made the build + e2e-tests run on a vm with a minimal kernel. So not much done in the code, yet.
>>>>
>>>> Apart from that I got a few thoughts while familiarizing myself with the source that you might be able to comment on:
>>>>
>>>> - Why do we have two flags to distinguish between multi- and single-instance advertising (HCI_ADVERTISING[_INSTANCE])? Doesn't that allow for inconsistencies (=both true)? Wouldn't it be better to interpret one as "advertising generally en-/disabled" and the other as a switch between single and multi adv mode? That would also allow us to keep track of the adv mode when advertising is temporarily disabled and then re-enabled. As Marcel commented this might be necessary for some controllers in multi-adv mode when adv data cannot be changed on-the-fly.
>>>
>>> the HCI_ADVERTISING maps to the advertising setting. And it always takes precedence. It is essentially instance 0. This fact is actually documented. So if both flags are true, then instance 0 is used and all the other ones will be disabled.
>>>
>>>> - What do you think of the idea to handle "set adv" and multi-adv more uniformly? I have the following in mind:
>>>> 1) whenever an adv mode switch occurs, all current adv instances will be canceled and destroyed
>>>> 2) "set adv" will add/replace a single instance to the list
>>>> 3) "add adv" will add instances up to max_instances
>>>> This would probably dry up the code and duplicate memory structures quite a bit and also remove some logic quirks.
>>>
>>> See comment above, we can not really change legacy API. It has to stay around for backwards compatibility. And that is why set advertising takes precedence over anything added by add advertising.
>>>
>>>> - Instances are currently being identified by an integer "adv_info.instance". When we add instances more dynamically would it not be better to pass pointers around and get rid of that integer? That would remove the necessity to keep track of, synchronize and verify instance ids.
>>>
>>> What are you planning to verify here. The instance id is coming from userspace.
>>>
>>>> - The mgmt_rp_read_adv_features structure contains an unused instance[0]. Seems to be redundant and could be removed, right?
>>>
>>> Read up on what instance[0] actually does in a struct. We have used these constructs before. I am sensing that you misunderstood what this is for.
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
> I heard about the Windows limitations that you can not scan from your application at all. That is so different compared to any other operating systems. I think Windows really has to fix things in that area.

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
> But it also runs for a certain amount of time from the kernel perspective. And then userspace has to restart it again if it really wants to scan again. So that means you will see the new advertising data then.
>

Real world example of how that might go wrong and make you not see
your advertisement:

Machine A run interleaved discovery without simuleanous quirk, using
org.bluez.StartDiscovery. That's 5s LE scan (L), then 5s BREDR inquiry
(B), then 5s delay from BlueZ daemon (D).

Machine B advertises 3 BLE devices, 5s each in round-ribbon, (X, Y, Z).

If both started perfectly at same time, here's what they do:
LLLLLBBBBBDDDDDLLLLLBBBBBDDDDD - machine A
XXXXXYYYYYZZZZZXXXXXYYYYYZZZZZ -machine B

So machine A will see only advertisement X from machine B

if machine B will start in different moment, A will se only Y, or Z.

Picking bad timing might also cause device to be detected once every
very long peroid,
i.e. if we have 3 advertisements, for 5,5 and 4 seconds.

We don't know what's the restart peroid on other platforms, but it
would be realy hard to calibrate that to work good everywhere.


>> There are two propertiary solutions I know:
>> - one is used in iOS devices, they have special 'overflow' data, that
>> only other iOS device can see (not even MAC), so they can advertise
>> more in one MAC address. I think it's described here but I'm not 100%
>> sure, only for members:
>> https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=284451
>
> That is something different. One is a new Bluetooth SIG specification and the other is some Broadcom vendor specific behavior that Apple relies on. Unreleased Bluetooth SIG specification are also off limit on this mailing list. They are Bluetooth SIG confidential.
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
> I was considering advertising as multiple random addresses, but that has the problem that connection handling becomes really complicated. In the end you would run multiple instances of you stack that the chip that multiplexes with different addresses. However that has the problem that connection handling is super complicated and this really needs special handling in the controller. Otherwise you end up with the simple case that your LE HID device can not reconnect. This is something we want to avoid.
>
> However judging from the Android HAL, it has to actually advertise with the same address. At least there is not provision that found quickly that allows to change the address. For some stupid reason it can restrict the channel map, but I have no idea why you would do that anyway. Except for making it easier for sniffers to trace you.

I have Nexus 6 on my desk for tests, and it advertises at up to 5 MAC
addresses at same time for sure. You can also connect to it on each of
that addresses.

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
> That is for LE Privacy when using RPAs. That is a different thing. And the previously connected devices do not get disconnected. It is perfectly fine to have device A connected to RPA1 and device B connected to RPA2. The controllers are actually capable of handling this.
>
> If you would be using LE Privacy, then yes, once you rotate the advertising data, you should change the RPA as well. Actually we can do that easily in the kernel actually. You just set the HCI_RPA_EXPIRED flag and the core will take care of the rest. We already do that once an encryption attempt fails so that a new address is used the next time around.
>
>> The other problem is that rotating advertisement will cause slow discovery.
>>
>> So I think rotating only adv data is not good idea. Maybe we can have
>> different mechanism that decide what gets advertised ? I.e.
>> application that's in foreground is deciding what gets advertised. Or
>> applications register their advertisements, and user can pick from
>> system menu what is currently being advertised ?
>
> That is up to bluetoothd. If it chooses to only utilize a single instance, then that is fine. That is a policy decision that does not belong into the kernel.
>
> Regards
>
> Marcel
>
