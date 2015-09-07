Return-Path: <cyrus@holtmann.org>
Subject: Re: iOS 8 can't discover device
To: Kyle Shneider <shneiderkyle@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <CAMib2GZpa=FgsNKXThWnNZ=m=nQgLJj8j1bYd8v12vb1dwOLNg@mail.gmail.com>
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
Message-ID: <55ED3BFA.206@ubnt.com>
Date: Mon, 7 Sep 2015 10:25:46 +0300
MIME-Version: 1.0
In-Reply-To: <CAMib2GZpa=FgsNKXThWnNZ=m=nQgLJj8j1bYd8v12vb1dwOLNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kyle,

On 09/06/2015 05:23 PM, Kyle Shneider wrote:
> Hello again.
> 
> I'm testing bluez 5.33 on raspberry pi. After successfully launching
> bluetoothd, powering hci-device up and setting it 'Discoverable' (done
> through DBus API) iPad mini can't see it. In other way shitty android
> 4.1.1 tablet finds raspberry in a moment.
> Have i missed something?
iOS will only show you devices which implement at least one of the Bluetooth profiles supported by iOS (https://support.apple.com/en-us/HT204387).
So you need to have appropriate SDP record with supported profile. I would suggest to start with org.bluez.ProfileManager1 D-Bus interface.
> Did anyone have successful experience of pairing apple devices and
> latest versions of bluez?
> BTW ble adapter: cambridge silicon radio.
> 
