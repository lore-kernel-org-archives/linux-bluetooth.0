Return-Path: <beaufort.francois@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9F8DCC04-EF7A-499D-A39E-2C04C906C056@holtmann.org>
References: <CAEZxfGNdtXFznY_D-HLnkFBtQsHaqGbn65ZhmcKkgoh9em5L3g@mail.gmail.com>
 <9F8DCC04-EF7A-499D-A39E-2C04C906C056@holtmann.org>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Fri, 24 Jun 2016 15:03:37 +0200
Message-ID: <CAEZxfGM-XxdN7TCdQBp6v+4Niz-N4HG+Dq-UUU27c8cKoxsq+g@mail.gmail.com>
Subject: Re: Caching device name in different connectable state
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Thank your Marcel for the clarification.

As Luiz mentioned previously though, as random static addresses can be
used by other devices, it may makes sense to avoid caching their name.
Would you agree?

On Thu, Jun 23, 2016 at 3:29 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Francois,
>
>> I have a bluetooth beacon device that advertises a name depending on
>> its configuration (connectable or not).
>> Sadly, in Bluez, the first time it sees it while advertising its name,
>> it caches it which is nice for future discovery.
>> Except it doesn't because I don't want to see this name while it
>> advertises in non-connectable state as it is "not" the same device
>> anymore (sort of).
>> I guess what I'm asking is if we can make Device name aware of the
>> connectable state and only use it if it matches state when it was
>> cached.
>
> yikes, this is super tricky. If the device uses the same address, then it=
 is the same device. If it is not the same device, then it should use two d=
ifferent addresses (sort of a dual personality).
>
> Please keep in mind that a lot of device identity is based around either =
the public address or the static random address. We even clarified that as =
identity address in the latest specification. The mode has nothing to do wi=
th it. It makes it even more complicated since a device can be in broadcast=
er and peripheral role at the same time. It is just a matter of instantiati=
ng a second link layer state machine. However even in that case my advise i=
s two use two different addresses if they are independent.
>
> Regards
>
> Marcel
>
