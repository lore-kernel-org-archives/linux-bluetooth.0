Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 20 Dec 2016 12:38:43 +0000
From: Dario Teixeira <dario.teixeira@nleyten.com>
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Data exchange between two bluetooth devices
In-Reply-To: <CAAu3APawTJPdFbiSWCDR0AdYp=_QFYJe=uGW0CabmsbsFWdU=w@mail.gmail.com>
References: <af00d3e489c2ea42ad03636143e3cb36@nleyten.com>
 <CAAu3APawTJPdFbiSWCDR0AdYp=_QFYJe=uGW0CabmsbsFWdU=w@mail.gmail.com>
Message-ID: <9523f746188f8ab683da6a9c2e995b5b@nleyten.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thanks a lot for your prompt reply -- it was very helpful!

> Using BlueZ as a peripheral is still behind the --experimental flag so
> you will need to read up on that.

I'm unsure whether I'll need to compile the latest version of Bluez
or if the version packaged for my distro has all the functionality
I need. This brings two related questions:

a) How do I query the bluetooth daemon to find out if the required
    functionality is available, and what should I look for?
    (I reckon I'll need to build a GATT server at least)

b) If the functionality is compiled into the binary, but requires
    the --experimental flag for activation, what's the standard way
    to enable it?  I can always modify the bluetooth.service file
    so that bluetoothd starts with the option, but I reckon there
    should be a standard config option, no? (I couldn't find any
    mention of "experimental" in the /etc/bluetooth files)

Thanks again for your time!
Best regards,
Dario Teixeira

