Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8xjG4opS5LdLJnsXWNLF6DHEzikAQK4NEcy9ZocF3uOLA@mail.gmail.com>
References: <5515ECE9.9080101@gmail.com>
	<0B4D986A-2913-46C0-8EB2-53EE29C67739@holtmann.org>
	<55164DEC.6070009@gmail.com>
	<E29758F5-D9B1-49AE-A35E-FE06CDD7835F@holtmann.org>
	<5516AD7C.3040401@gmail.com>
	<CAHrH25RbwtPDgLuRNVa92a=5+y5beMYgzrJLfwf19ut-T=cANA@mail.gmail.com>
	<55188985.80001@gmail.com>
	<2F40B83E-682C-47A4-A7A3-BF2CDE2DA4D5@holtmann.org>
	<CAD0=r8xjG4opS5LdLJnsXWNLF6DHEzikAQK4NEcy9ZocF3uOLA@mail.gmail.com>
Date: Mon, 30 Mar 2015 10:44:39 -0700
Message-ID: <CAHrH25ToJqmXQEo8dYbkUP2jtJCvAGZfj5NhQjm5XacTYDqp0A@mail.gmail.com>
Subject: Re: Multi-Advertising: implementation options, timing questions
From: Arman Uguray <armansito@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Florian Grandel <fgrandel@gmail.com>,
	Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> On Mon, Mar 30, 2015 at 10:23 AM, Jakub Pawlowski <jpawlowski@google.com>=
 wrote:
> On Sun, Mar 29, 2015 at 5:48 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> Hi Florian,
>>
>>> > Now that most of the logic for a single instance is in place it shoul=
d
>>>> be straightforward to extend it for multiple instances. I would start
>>>> by turning the adv_instance field of hci_dev into a list of
>>>> adv_instances and a way to determine and get a pointer to the
>>>> currently active instance.
>>>
>>> Yes, agreed. That's exactly where I started. Happy to hear that you got=
 the same procedure in mind. I experimented with a dynamically extended arr=
ay and a linked list. The latter seems to be the better choice as it allows=
 us to easily remove entries in the middle of the list.
>>>
>>>> You would then modify the code in
>>>> net/bluetooth/mgmt.c that accesses the instance 1 parameters to use
>>>> the new getter instead. Once all of that is done, the second step
>>>> would be a matter of inserting new elements into the advertising list
>>>> and handling the round-robin logic and the duration parameter.
>>>
>>> Agreed. That's what I had in mind, too.
>>>
>>>> If it makes things easier I can start tackling the first step which is
>>>> mostly refactoring my recent code to enable multiple instances. You
>>>> can then cleanly build the multiple instance logic on top of that.
>>>
>>> It's up to you. Just let me know so that I don't interfere with your wo=
rk. I don't want to block you as I'll certainly take much longer to get it =
right (newbie + evenings/weekends only). Today I just set up my dev env and=
 made the build + e2e-tests run on a vm with a minimal kernel. So not much =
done in the code, yet.
>>>
>>> Apart from that I got a few thoughts while familiarizing myself with th=
e source that you might be able to comment on:
>>>
>>> - Why do we have two flags to distinguish between multi- and single-ins=
tance advertising (HCI_ADVERTISING[_INSTANCE])? Doesn't that allow for inco=
nsistencies (=3Dboth true)? Wouldn't it be better to interpret one as "adve=
rtising generally en-/disabled" and the other as a switch between single an=
d multi adv mode? That would also allow us to keep track of the adv mode wh=
en advertising is temporarily disabled and then re-enabled. As Marcel comme=
nted this might be necessary for some controllers in multi-adv mode when ad=
v data cannot be changed on-the-fly.
>>
>> the HCI_ADVERTISING maps to the advertising setting. And it always takes=
 precedence. It is essentially instance 0. This fact is actually documented=
. So if both flags are true, then instance 0 is used and all the other ones=
 will be disabled.
>>
>>> - What do you think of the idea to handle "set adv" and multi-adv more =
uniformly? I have the following in mind:
>>> 1) whenever an adv mode switch occurs, all current adv instances will b=
e canceled and destroyed
>>> 2) "set adv" will add/replace a single instance to the list
>>> 3) "add adv" will add instances up to max_instances
>>> This would probably dry up the code and duplicate memory structures qui=
te a bit and also remove some logic quirks.
>>
>> See comment above, we can not really change legacy API. It has to stay a=
round for backwards compatibility. And that is why set advertising takes pr=
ecedence over anything added by add advertising.
>>
>>> - Instances are currently being identified by an integer "adv_info.inst=
ance". When we add instances more dynamically would it not be better to pas=
s pointers around and get rid of that integer? That would remove the necess=
ity to keep track of, synchronize and verify instance ids.
>>
>> What are you planning to verify here. The instance id is coming from use=
rspace.
>>
>>> - The mgmt_rp_read_adv_features structure contains an unused instance[0=
]. Seems to be redundant and could be removed, right?
>>
>> Read up on what instance[0] actually does in a struct. We have used thes=
e constructs before. I am sensing that you misunderstood what this is for.
>
> Sorry for my late response, but I wanted to raise a concern about how
> you want to rotate advertisement data.
>
> When you advertise, you probably want someone to scan and find your
> device. That might be hard, because filtered LE scan is widely used,
> i.e. BlueZ uses filtered LE scan, that's restarted every 10 seconds.
> That means, that during those 10 seconds your remote device will be
> reported once, and changes you're making to advertised data will not
> be visible. I think same is true for Windows (you can currently scan
> only from control panel), and Mac (you can configure it to do
> non-filtered scan in your app)
>
> When you just modify advertisement data, device that's doing filtered
> LE scan will report one MAC address only once during this scan (except
> for CSR, which reports RSSI changes).
> I recently wrote MGMT_OP_START_SERVICE_DISCOVERY, but it also uses
> filtered scan, and restarts the scan, but only if device with proper
> UUID was found. It assumes that UUID was there when device started
> advertising.
>
>
> There are two propertiary solutions I know:
> - one is used in iOS devices, they have special 'overflow' data, that
> only other iOS device can see (not even MAC), so they can advertise
> more in one MAC address. I think it's described here but I'm not 100%
> sure, only for members:
> https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=3D28445=
1
> . To use that you need a special chip that would properly handle this
> data.
> - second is used in Android phones (currently only Nexus 6) that can
> advertise as multiple MAC addresses, each having different adv data at
> the same time (it might be same thing that broadcom propertiary
> solution you were discussing). It uses multiple MAC addresses to
> advertise more, so filtered scan will find those devices  and report
> them properly.
>
>
> There's command that rotates mac address:
> HCI_LE_Set_Resolvable_Private_Address_Timeout, but there's no way to
> go back to 'previous' mac in order to have something like 'round
> ribbon'. I'm also not sure whether that would have any effect on
> currently estabilished connections, I think all devices connected to
> private address get disconnected when it rotates, but I'm not 100%
> sure. Also when you rotate MAC, controller will not respond to connect
> event to old address.
>
> The other problem is that rotating advertisement will cause slow discover=
y.
>
> So I think rotating only adv data is not good idea. Maybe we can have
> different mechanism that decide what gets advertised ? I.e.
> application that's in foreground is deciding what gets advertised. Or
> applications register their advertisements, and user can pick from
> system menu what is currently being advertised ?
>

I think you're overthinking what this API does. At the mgmt layer we
don't have a concept of a "foreground app". We simply have a way for
userspace to enter new advertising instances. If there's some special
magic in hardware this code can take advantage of that in the future
using some driver interface, otherwise it just reprograms the
controller in software, so the round robin is managed in the kernel.
That's all there is to this API. How the userspace wants to manage
this is up to the daemon.

>
>
>>
>> Regards
>>
>> Marcel
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
