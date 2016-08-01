Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 1 Aug 2016 18:12:01 +0200 (CEST)
From: Serge van den Boom <serge@vdboom.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Registering profile or making discoverable resets adapter
 class
In-Reply-To: <CABBYNZJMMSrgRO8EsZ78yOv0R5cwfpz65EQ+-zSV67mX2ee4Dw@mail.gmail.com>
Message-ID: <alpine.BSF.2.00.1608011632330.96508@toad.stack.nl>
References: <alpine.BSF.2.00.1608011427420.69212@toad.stack.nl> <CABBYNZJMMSrgRO8EsZ78yOv0R5cwfpz65EQ+-zSV67mX2ee4Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks for the reply.

On Mon, 1 Aug 2016, Luiz Augusto von Dentz wrote:
> This is a classical problem of using hci* tools along with bluetoothd,
> they both are trying to control the same thing and then you got a
> conflict, it shall be one or the other but not both. If you are
> curious to look at the bluetoothd source code you will see that the we
> derive the class of the device from the registered services so there
> is no point in doing anything with hcitool.

That is interesting, because if I don't set the class explicitly, it
always shows up as 0x100000 when I inspect it. And more relevantly,
if I don't explicitly set the class, the (HID) device that I am
implementing won't be discovered.

I haven't been able to find the part of the bluetoothd code that you are
referring to, so far. I would appreciate it if you could point me in the
right direction.


Thanks,

Serge

