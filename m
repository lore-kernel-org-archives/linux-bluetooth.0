Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5CDE162E-4828-4485-BF95-50C67DB93B77@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com>
 <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com>
 <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com> <969738CC-B335-4E2F-BF3C-441110279871@gmail.com>
 <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com>
 <F1876BDF-4DC0-4CB0-A20F-2E64E24A3B92@gmail.com> <CABBYNZ+R7dV5i+BQowigf5eddB4yxSki+xLeLFYBrN4Sfe8mJA@mail.gmail.com>
 <4AE62BC6-BD11-44C7-9A0E-BC3159ED80DF@gmail.com> <4C907B25-D8E4-462C-89FA-AB312A27CBE9@gmail.com>
 <CABBYNZK04wxSH78f0maAMHtR-2ra8Kh_nQKkrAY1R8G19ba8TA@mail.gmail.com> <5CDE162E-4828-4485-BF95-50C67DB93B77@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 May 2017 15:02:21 +0300
Message-ID: <CABBYNZKkodmXy+4eRXh_4RA9yci25cEtaNMoywEUk9XZ+GL4LQ@mail.gmail.com>
Subject: Re: How to use GattProfile1
To: Krasi Georgiev <krasi.root@gmail.com>
Cc: Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Krasi,

On Tue, May 23, 2017 at 10:36 PM, Krasi Georgiev <krasi.root@gmail.com> wro=
te:
> Are you sure about this? I am a bit confused. I have manually connected t=
o few devices but none will auto-connect when I switch it off/on or remove =
if from the range  and than bring back in.
>
> Szymon=E2=80=99s video suggests that I need to create an object that impl=
ements a  Gatt  profile
> https://youtu.be/VMDyebKT5c4?t=3D1439
> minute 24
>
> I tried but can=E2=80=99t find out the correct dbus calls sequence.
>
> If anyone can give me a simple example (using dbus calls) that would be a=
mazing.

Have you actually tried using bluetoothctl? Do you have the bluetoothd
logs when connecting to these devices?

--=20
Luiz Augusto von Dentz
