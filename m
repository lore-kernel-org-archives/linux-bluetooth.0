Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJT5=LMZHecjKYJNVvMn-F4LgJuanqRv6Xoy2sCmsH5qA@mail.gmail.com>
References: <CAAu3APaeS_7xnuTW_JgdJKkAcfY1x4zU=3VxTkSHqEZYsSkY_A@mail.gmail.com>
	<CABBYNZJT5=LMZHecjKYJNVvMn-F4LgJuanqRv6Xoy2sCmsH5qA@mail.gmail.com>
Date: Mon, 8 Feb 2016 12:22:49 +0000
Message-ID: <CAAu3APbR=nBzNpZhPNC3ga0de1OTm9kgOyhh+9GcE465LatCtA@mail.gmail.com>
Subject: Re: Error 133 (0x85): GATT ERROR
From: Barry Byford <31baz66@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

On 8 February 2016 at 10:13, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Barry,
>
> On Sat, Feb 6, 2016 at 10:30 PM, Barry Byford <31baz66@gmail.com> wrote:
>> Any suggestions as to what is wrong?
> Perhaps if you can take the HCI and bluetoothd it should help to see
> where is the problem.
I think you are suggesting I take a look at the logs. A good
suggestion although a couple of newbie questions about this.
My assumption is I would start bluetoothd with '-nEd' to get the
information from that. Correct?
How do I get the log information from HCI?


> Btw, it could be that Android is attempting to
> connect over BR/EDR or did you configure your adapter to as BLE only?
Is it possible to do this with the DBus API?

Thanks,
Barry
