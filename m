Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Request for BLE server applications and documents - BLUEZ
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <CABBYNZJK20KwkcxFzhds8c+E1YsDFcOFhn3veTWzvumhbJLQyQ@mail.gmail.com>
Date: Tue, 17 May 2016 10:33:43 -0700
Message-Id: <DB8A8A19-2F0C-474D-8E60-67AFE937D31A@gmail.com>
References: <57397128.8080208@redpinesignals.com> <CABBYNZLb99QkEggXOiOye+VPp+UXK8i9bSZ0m=Vv2Mc_davLCw@mail.gmail.com> <573ACC64.60502@redpinesignals.com> <CABBYNZJK20KwkcxFzhds8c+E1YsDFcOFhn3veTWzvumhbJLQyQ@mail.gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On May 17, 2016, at 1:14 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
<snip>
> Regarding the actual problem it is probably because experimental
> interfaces are not enabled by default, you can do enable that by
> passing -E to bluetoothd.

If you’re using systemd, the file you’ll want to tweak is 

/lib/systemd/system/bluetooth.service

Modify your ExecStart line to include the -E option. Mine currently looks like:

ExecStart=/usr/lib/bluetooth/bluetoothd -d -E --noplugin=*

The -d is indispensable and took my a while to stumble upon. Any python error you have that is fired by dbus callbacks will not show up on the stdout/stderr of you program (e.g. an error downstream of a WriteValue() callback). Rather it will show up in the debug output of the bluetooth daemon. So I pretty much always have

journalctl -flu bluetooth

running when I’m changing things, so I can see those errors reported there.

By default, you get a whole bunch of stuff in your dbus namespace from older stuff. The —noplugin=* flag gets rid of all of those, so you’ll only see your own stuff in the dbus tree. 