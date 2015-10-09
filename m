Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLAD6embCViBCAHx+_dvBHoM=AJ1JSW7eVqGPSOv24HXw@mail.gmail.com>
References: <CAD0=r8x7hEkGZG+ocE1E+ezF8C+4mFoWuROry=xsf_OfPY+_AA@mail.gmail.com>
	<CABBYNZLAD6embCViBCAHx+_dvBHoM=AJ1JSW7eVqGPSOv24HXw@mail.gmail.com>
Date: Fri, 9 Oct 2015 12:57:29 -0700
Message-ID: <CAD0=r8xaEZ5mdu=419D+FHQJa7G_esBpWj=4jQ+tpTuT7M2ryQ@mail.gmail.com>
Subject: Re: [BlueZ] Difference profiles, dbus profiles and plugins ?
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Oct 9, 2015 at 12:32 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Fri, Oct 9, 2015 at 6:14 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Hi,
>>
>> Can someone please explain the difference between profiles from
>> 'profiles' directory, and DBus profiles, i.e. 'test/test-profile' and
>> 'test/test-gatt-profile' ? How they're supposed to be used, and how do
>> they map to Bluetooth Profiles ?
>
> There are 2 categories of profiles if one need to categorize them:
>
> - Internal: Those implemented by plugins/driver which are run in the
> context of bluetoothd, this includes profiles under profiles/
> directory. It recommended for profiles that require system
> integration, that access needs to restricted. These sometimes
> implement specific D-Bus interface to interact with the profile.
> - External: Those implemented by D-Bus clients, recommended for
> profiles of general use, currently there are 2 subcategories of it:
>   - GATT Profiles: Those registered with GATT Manager, as the name
> imply it should be used for GATT only profiles.
>   - Classic Profiles: Those registered with Profile Manager, this is
> for classic only.
>
> Note that the usage model of GATT is a little bit different than it is
> for classic profile since GATT offers attributes it is much easier to
> write external profiles/services than it is with classic where almost
> every profile uses a different protocol.
>
>> Are those from "profiles" directory somehow special, or deprecated?
>> Does DBus profiles also work for LE devices somehow (ones from test
>> directory look like BT Classic ones)
>> profiles from "profile" directory can expose functionality through
>> DBus (like heart rate profile), can same be achieved through DBus
>> services ?
>
> Almost all BLE profiles not implemented using src/shared should be
> considered deprecated, the only exception is HoG but even that will
> need changing, Heart Rate should probably be implemented as an
> external profile.
>
>> I have some issues with devices that expose service with 0xFFFD UUID,
>> that is Universal Second Factor Authenticator Service (U2F). I need to
>> disable auto connect for LE devices that have exclusively three
>> services: Device Info, GAS, and U2F. Shall I use profile, DBus
>> profile, or maybe plugin ? What are plugins for ?
>
> It depends on the usage mode of U2F, I suppose you could use it and
> then once done call Disconnect which would disable auto-connect flag,
> but the connect again you would have to use Connect which essentially
> means it will never auto connect. Regarding Device Info and GAS, those
> should probably not set auto-connect flag, if they do we might need to
> fix them.

Deviceinfo triggers auto connect (that's probably bug):

in deviceinfo.c (all calls are unconditional)
deviceinfo_driver_probe -> deviceinfo_register ->
btd_device_add_attio_callback -> device_set_auto_connect(device,
TRUE);

Shall I add "bool set_auto_connect" param to btd_device_add_attio_callback  ?


Other services triggering auto_connect now ("git grep
btd_device_add_attio_callback")
alert, cyclingspeed, deviceinfo, heartrate, input, proximity,
scanparam, thermometer


>
>> When these three services are on device, it's single-purpose
>> authenticator device. It's used to authenticate transactions, and
>> might be used between multiple machines (laptop, workstation, phone),
>> but support one connection at a time. Having linux auto connect to it
>> all the time makes it unable to connect to other nearby devices that
>> might try to authenticate transaction. If other services are exposed,
>> it might be multi-purpose device (i.e. phone that also acts as
>> authenticator) and default auto connect rules shall apply.
>
> By the description it looks like the client will always initiate the
> connection, you only need to connect if you need to authenticate
> something, in that case having auto_connect flag set is probably
> useless and as you said it may interfere with other device that may
> have some authentication pending.
>
>> I've looked through "plugins" directory and seen that there's a
>> disable auto connect field that can be set. Would writing u2f plugin
>> be proper way to solve that?
>
> I guess U2F should be done as external profile, but you probably
> should _not_ use GattManager1.RegisterProfiles because that would set
> auto_connect flag.
>
>
> --
> Luiz Augusto von Dentz
