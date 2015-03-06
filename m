Return-Path: <cyrus@holtmann.org>
Message-ID: <54F9E9C3.3060700@ubnt.com>
Date: Fri, 06 Mar 2015 19:54:11 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: DBus API for LTK OOB keys
References: <54F8584D.6020301@ubnt.com> <20150305134024.GA20862@t440s> <54F862A3.80400@ubnt.com> <8EB5FD2F-4C46-41F8-95BA-4ACBEF0BCDE4@holtmann.org> <54F8B881.4050506@ubnt.com> <280B8CCC-6E98-477A-B805-D91966220207@holtmann.org>
In-Reply-To: <280B8CCC-6E98-477A-B805-D91966220207@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 2015.03.06. 00:08, Marcel Holtmann wrote:
> Hi Andrejs,
>
>>>>>>      There is a MGMT "Load Long Term Keys Command" to feed keys to=
 the Kernel
>>>>>> which are stored in the BlueZ settings storage file and read durin=
g adapter
>>>>>> init (load_devices->load_ltks). I searched through the code and co=
uldn't
>>>>>> find any means to feed LTK keys from "the outside", for example th=
rough DBus
>>>>>> API. This is needed for an LE OOB pairing scheme, when key is know=
n in
>>>>>> advance by both parties and is not derived from pairing procedure.=
 Is there
>>>>>> a standardized way to add LTK keys "manually" or this is not suppo=
rted-yet
>>>>>> feature? According to setting storage rules "Direct access to the =
storage
>>>>>> outside from bluetoothd is highly discouraged".
>>>>> Are the keys provisioned beforehand or is this something that can h=
appen
>>>>> at any time when bluetoothd is already running? If it's the former =
then
>>>>> a custom bluetoothd plugin that gives bluetoothd core an extra set =
of
>>>>> keys could be one way to go. If it's the latter, then things get tr=
icky
>>>>> since the mgmt command wipes all existing keys away before adding n=
ew
>>>>> ones.
>>>> In my particular scenario, the OOB key is provisioned only once and =
beforehand and used to connect with multiple LE devices. LE devices get t=
his key via some proprietary mechanism. So it is kind of "global master k=
ey". As such, it is not a problem to restart the BlueZ daemon after the k=
ey is (re-)provisioned.
>>> using the same LTK for multi devices is a really bad idea. This is no=
t how Bluetooth LE security was designed. My advise would be strictly aga=
inst doing that in any product.
>> Beg your pardon, I mixed up OOB and LTK, my bad. The proper question i=
s to how to feed OOB Datafor OOB pairing, which in turn used to generate =
STK and then unique per-device LTK as you have described below. Actually,=
 I have found a way - btd_adapter_add_remote_oob_data() which is exactly =
what I need. But, in order for OOB Pairing to be started, the "SMP Pairin=
g Request (0x01)" should indicate the presence of OOB Data. In kernel 3.1=
8.6 it does not happening simply because the macro SMP_OOB_PRESENT is not=
 used at all. In latest kernel 3.19 some changes were made in regard to O=
OB Data and macro is now used (see build_pairing_cmd) but only if local d=
evice and authreq from remote party both support "Secure Connections" whi=
ch is in turn BT Core 4.2 feature. But OOB pairing is supported also in B=
T Core 4.0, isn't it? So my question boils down to the following (it is a=
ll about LE bearers only):
>> 1. Is LE OOB Pairing not supported before kernel 3.19 ? (see SMP_OOB_P=
RESENT macro which is not used)
>> 2. Is LE OOB Pairing is still broken in 3.19, because it works only wh=
en both sides support "Secure Connections" thus are 4.2 version devices?
> we still have a problem with LE OOB pairing in the sense of giving the =
kernel enough information. That will be fixed hopefully pretty soon. The =
proposal on how to do that is in mgmt-api.txt. I think Johan is working o=
n it.
Thanks a lot for your support, now it is clear. I analyzed kernel=20
sources and obviously something is missing. I tried to do some quick=20
hacks here and there to feed OOB data into TK and even managed to start=20
LE OOB pairing data exchange, but it failed with confirmation mismatch.=20
Most probably, I got some bad mix of legacy and SC procedures :) So I'd=20
better wait for the proper implementation of "LE OOB Legacy Pairing" in=20
upstream. I hope the term is now correct and unambiguous.
>
> The main problem is that we can currently only get OOB information for =
BR/EDR side of things. The missing part is to the get the LE OOB informat=
ion. And of course there is a difference between LE Legacy Pairing and LE=
 Secure Connections.
>
>>>>> If your OOB scheme is this latter "non-pre-provisioned" one I'd won=
der
>>>>> why you're not using the standard OOB mechanism provided by LE SMP,=

>>>>> since for that we do have at least partial support.
>>>> I'm now confused a bit. Indeed, I want to use OOB mechanism provided=
 by LE SMP, but in order to start OOB pairing, the OOB key itself should =
be known to both sides (central and peripheral). For the peripheral I hav=
e my own ways to do it (proprietary), but the main question it how to giv=
e the key value to the central which is BlueZ in this case.
>>> When using LE OOB pairing (Legacy Pairing and Secure Connections), th=
en at least you get a sense of key strength that is guaranteed based on h=
ow LE security is designed. So doing LE OOB pairing is a good idea. You f=
eed different information into OOB pairing. You share and OOB secret betw=
een two devices and based on that they can pair. However they need to be =
in range to actually use that OOB secret to pair. Pairing requires a conn=
ection. The advantage with pairing is that you get a proper key with a pr=
oper strength.
> So LE Legacy Pairing needs the Security Manager TK value and LE Secure =
Connections needs the Confirmation and Random values. However right now, =
we can not get these ones from the kernel.
>
> As a side note, I added tools/oobtest utility where you can test this b=
etween two controllers attached to the same host.
>
> Regards
>
> Marcel
>
