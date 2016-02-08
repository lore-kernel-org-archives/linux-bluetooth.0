Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APaeS_7xnuTW_JgdJKkAcfY1x4zU=3VxTkSHqEZYsSkY_A@mail.gmail.com>
References: <CAAu3APaeS_7xnuTW_JgdJKkAcfY1x4zU=3VxTkSHqEZYsSkY_A@mail.gmail.com>
Date: Mon, 8 Feb 2016 12:13:06 +0200
Message-ID: <CABBYNZJT5=LMZHecjKYJNVvMn-F4LgJuanqRv6Xoy2sCmsH5qA@mail.gmail.com>
Subject: Re: Error 133 (0x85): GATT ERROR
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Sat, Feb 6, 2016 at 10:30 PM, Barry Byford <31baz66@gmail.com> wrote:
> Hello,
>
> I'm trying to get the Raspberry Pi to advertise itself as a peripheral
> so I've started by taking the example-gatt-server and
> example-advertisement to get something running.
>
> The code I have running can be found at:
> https://github.com/ukBaz/python-bluezero/blob/master/examples/battery_service.py
>
> When I run the above code with Bluez 5.37 then I can connect and read
> values from it on another Raspberry Pi using bluetoothctl.
> However when I try to connect with various apps on my phone then I'm
> not able to successfully connect.
> On the Nordic nRF Master Control Panel (BLE) app I can see in the log
> 'Error 133 (0x85): GATT ERROR)' I've done various searches on this
> error message but nothing actionable has turned up.
>
> Any suggestions as to what is wrong?

Perhaps if you can take the HCI and bluetoothd it should help to see
where is the problem. Btw, it could be that Android is attempting to
connect over BR/EDR or did you configure your adapter to as BLE only?

-- 
Luiz Augusto von Dentz
