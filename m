Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4C907B25-D8E4-462C-89FA-AB312A27CBE9@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com>
 <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com>
 <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com> <969738CC-B335-4E2F-BF3C-441110279871@gmail.com>
 <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com>
 <F1876BDF-4DC0-4CB0-A20F-2E64E24A3B92@gmail.com> <CABBYNZ+R7dV5i+BQowigf5eddB4yxSki+xLeLFYBrN4Sfe8mJA@mail.gmail.com>
 <4AE62BC6-BD11-44C7-9A0E-BC3159ED80DF@gmail.com> <4C907B25-D8E4-462C-89FA-AB312A27CBE9@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 May 2017 21:14:30 +0300
Message-ID: <CABBYNZK04wxSH78f0maAMHtR-2ra8Kh_nQKkrAY1R8G19ba8TA@mail.gmail.com>
Subject: Re: How to use GattProfile1
To: Krasi Georgiev <krasi.root@gmail.com>
Cc: Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Krasi,

On Tue, May 23, 2017 at 8:55 PM, Krasi Georgiev <krasi.root@gmail.com> wrot=
e:
>
> Great talk from Szymon by the way I learned a lot combined with with read=
ing the docs.
> I really hope my question is not too stupid.
> I am stuck at this step in  my app and can=E2=80=99t continue.

Usually, once it is connected once it will automatically be added to
auto connect list, so perhaps the device is not advertising as
connectable? Note the very first you must connect manually as that is
what indicate to bluetoothd you want to use the device.

--=20
Luiz Augusto von Dentz
