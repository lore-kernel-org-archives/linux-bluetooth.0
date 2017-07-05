Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c9a595e3-b09b-04ae-7040-d85aba5ec2ea@scs.ch>
References: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com> <c9a595e3-b09b-04ae-7040-d85aba5ec2ea@scs.ch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Jul 2017 13:57:13 +0300
Message-ID: <CABBYNZ+GjRc7OhzYNU=0v3oFSAr4HV7RyrPq-USMqLo9G-y3UQ@mail.gmail.com>
Subject: Re: DBUS API: Retrieve current MTU used by remote device
To: Felix Schulthess <felix.schulthess@scs.ch>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 5, 2017 at 10:44 AM, Felix Schulthess
<felix.schulthess@scs.ch> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Dear all, dear Oliver,
>
> On 05.07.2017 00:45, Olivier MARTIN wrote:
>
>> I looked into the Bluez DBUS API documentation but I have not found
>> a way to retrieve the MTU size used for the connection between
>> Bluez and a Bluetooth device.
>
> I am also trying to solve this Problem. Cf. my mail earlier on this
> list. I suppose that you, Oliver, did not receive it, so I quote:

Usually you don't need to know the ATT MTU size since method like
WriteValue will fragment the data if necessary, in case of server the
prepare writes will also be reassembled before pushed over D-Bus.

For byte stream emulation please check the set that introduces
AcquireWrite and AcquireNotify:

[PATCH v2 00/10] gatt: Add AcquireWrite and AcquireNotify

>> I am trying to figure out the MTU of a BLE connection while it is
>> active. If I understand the Core Specification correctly, this can
>> be accomplished with the "Exchange MTU Request" as specified in
>> Vol. 3, Part F, Section 3.4.2.
>>
>> 1. I know one can send HCI commands with the hcitool. Is it also
>> possible to issue the request specified above using any of the
>> existing hciconfig, hcitool, hciXXX tools to find the MTU?
>>
>> 2. There is a connection of which I know that its MTU is 512.
>> Still, running 'hciconfig hci0 dev' reports 'ACL MTU: 310:10'. Why
>> is that so?
>
> If you figure out how to determine the MTU, I would definitely be
> interested. Keep me (i.e. the list) posted.

These are HCI buffer sizes, they have nothing to do with MTU in ATT/GATT.
