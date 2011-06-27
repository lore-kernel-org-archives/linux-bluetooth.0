Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: "thilo@cestona.ro" <thilo@cestona.ro>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 27 Jun 2011 14:26:57 -0400
Subject: Re: Support for 0489:e031 Foxconn / Hon Hai
Message-ID: <1309199217.2143.23.camel@THOR>
References: <44c0c13.6e1d3014b80fb8f0331e4275187e6b1d@1oca1host.de>
In-Reply-To: <44c0c13.6e1d3014b80fb8f0331e4275187e6b1d@1oca1host.de>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2011-06-27 at 10:57 -0400, thilo@cestona.ro wrote:
> Hey again,
> 
> >>As Virtualbox does a direct usb passthrough to the client I could install the bluetooth adapter in windows with the original broadcom bluetooth driver.
> >>Once I opened the settings there and "saved" theses, the adapter finds bluetooth devices nicely under windows AND linux.
> >>
> >>Sadly I have no idea what the broadcom driver did to "activate" the adapter.
....
> I still have no idea how I might figure out what is done during the init of the windows driver. Since I need to unload the btusb module so windows can use the device, I have no chance to use hcidump.
> Any ideas what I should try?

There are several decent usb sniffers for windows - although I've never
tried them in a vm.  This is a tough route to go though - even with a
complete device capture, separating what's relevant to your problem will
be *very* difficult.

Peter
