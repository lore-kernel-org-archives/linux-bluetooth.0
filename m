Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9523f746188f8ab683da6a9c2e995b5b@nleyten.com>
References: <af00d3e489c2ea42ad03636143e3cb36@nleyten.com> <CAAu3APawTJPdFbiSWCDR0AdYp=_QFYJe=uGW0CabmsbsFWdU=w@mail.gmail.com>
 <9523f746188f8ab683da6a9c2e995b5b@nleyten.com>
From: Barry Byford <31baz66@gmail.com>
Date: Tue, 20 Dec 2016 15:11:55 +0000
Message-ID: <CAAu3APb76nyhngBkb=3HXbv4M-RkrhResLx+-hGJcHNmZLkNNg@mail.gmail.com>
Subject: Re: Data exchange between two bluetooth devices
To: Dario Teixeira <dario.teixeira@nleyten.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Dario,

On 20 December 2016 at 12:38, Dario Teixeira <dario.teixeira@nleyten.com> wrote:
> Hi,
>
> Thanks a lot for your prompt reply -- it was very helpful!
Good to hear. Thanks!

>
>> Using BlueZ as a peripheral is still behind the --experimental flag so
>> you will need to read up on that.
>
>
> I'm unsure whether I'll need to compile the latest version of Bluez
> or if the version packaged for my distro has all the functionality
> I need. This brings two related questions:
>
> a) How do I query the bluetooth daemon to find out if the required
>    functionality is available, and what should I look for?
>    (I reckon I'll need to build a GATT server at least)

I am not sure I have a scientific answer for you on this. Maybe one of
the developers can offer better guidance on this if you share the
version in your distro.
My gut feeling on this is that if you read the release notes at
http://www.bluez.org/ then you will see that the GATT D-Bus API gets
mentioned as being updated in recent releases. Unless you have a very
recent version in your distro, I'd upgrade.


>
> b) If the functionality is compiled into the binary, but requires
>    the --experimental flag for activation, what's the standard way
>    to enable it?  I can always modify the bluetooth.service file
>    so that bluetoothd starts with the option, but I reckon there
>    should be a standard config option, no? (I couldn't find any
>    mention of "experimental" in the /etc/bluetooth files)

It is in bluetooth.service that I would normally enable this.
The binary will need to have been built with experimental enabled.
I would think it unlikely that your distro has done that so again
would suggest you need to build from source.

>
> Thanks again for your time!
> Best regards,
> Dario Teixeira
>
