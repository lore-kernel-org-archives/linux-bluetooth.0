Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5D01EC8C-E51B-4F89-8F9B-5D7946674116@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com>
 <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com>
 <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com> <969738CC-B335-4E2F-BF3C-441110279871@gmail.com>
 <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com>
 <F1876BDF-4DC0-4CB0-A20F-2E64E24A3B92@gmail.com> <CABBYNZ+R7dV5i+BQowigf5eddB4yxSki+xLeLFYBrN4Sfe8mJA@mail.gmail.com>
 <4AE62BC6-BD11-44C7-9A0E-BC3159ED80DF@gmail.com> <4C907B25-D8E4-462C-89FA-AB312A27CBE9@gmail.com>
 <CABBYNZK04wxSH78f0maAMHtR-2ra8Kh_nQKkrAY1R8G19ba8TA@mail.gmail.com>
 <5CDE162E-4828-4485-BF95-50C67DB93B77@gmail.com> <CABBYNZKkodmXy+4eRXh_4RA9yci25cEtaNMoywEUk9XZ+GL4LQ@mail.gmail.com>
 <758C2FAB-DBF1-4B88-866D-F036B23B3C95@gmail.com> <CABBYNZLVjXXmbfTb2Uo9KvE2D83c1PU7f2p=t6JawfeyUfN2+w@mail.gmail.com>
 <3290BB41-234F-4D7B-BF37-0CC2966CB416@gmail.com> <CABBYNZKoACnV5rOQ1dJH56Uien-CdMy7CUfgvZEGdJvuLXKBgQ@mail.gmail.com>
 <5D01EC8C-E51B-4F89-8F9B-5D7946674116@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 May 2017 14:16:57 +0300
Message-ID: <CABBYNZ+P8fzQP_v5dtWTHhXthE7JhsJeLBts4+_eweVDBMZpSQ@mail.gmail.com>
Subject: Re: How to use GattProfile1
To: Krasi Georgiev <krasi.root@gmail.com>
Cc: Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Krasi,

On Thu, May 25, 2017 at 11:37 AM, Krasi Georgiev <krasi.root@gmail.com> wrote:
> ok I will try on another debian machine.
>
> Ideally I would like to make it work on the raspberry pi as well.
>
> Would it be too much hassle to give me an example how can I register this object mentioned in the video using dbus calls?
>

Take a look at the fix I just send, that should enable you to register
UUIDs with register-application command.


-- 
Luiz Augusto von Dentz
