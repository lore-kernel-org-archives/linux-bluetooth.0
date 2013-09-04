Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Sep 2013 16:08:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [BUG bluetoothd] reconnecting input devices results in
 org.bluez.Error.NotAvailable
Message-ID: <20130904130832.GA23776@x220.p-661hnu-f1>
References: <CANq1E4ThsLwpWKs2VR+2DT41cDfV+_XX+DdLDF7Yo+Sm+t1ryw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANq1E4ThsLwpWKs2VR+2DT41cDfV+_XX+DdLDF7Yo+Sm+t1ryw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Sep 04, 2013, David Herrmann wrote:
> I run the following commands in bluetoothctl on bluez-5.7-1 (but I
> know this bug since I started using bluetoothctl (probably 5.0 or
> 5.1), just didn't get around reporting it, yet. Sorry.):
>   [bluetooth]# power on
>     [CHG] Controller 00:25:00:50:C4:C9 Class: 0x00010c
>     Changing power on succeeded
>     [CHG] Controller 00:25:00:50:C4:C9 Powered: yes
>   [bluetooth]# connect 00:1E:35:3B:7E:6D
>     Attempting to connect to 00:1E:35:3B:7E:6D
>     Connection successful
>     [CHG] Device 00:1E:35:3B:7E:6D Connected: yes
> 
> Works just fine. Then I disconnect the device by removing its
> batteries. bluez notices this and removes the connection:
>     [CHG] Device 00:1E:35:3B:7E:6D Connected: no
> 
> However, a following connect always fails immediately:
>   [bluetooth]# connect 00:1E:35:3B:7E:6D
>     Attempting to connect to 00:1E:35:3B:7E:6D
>     Failed to connect: org.bluez.Error.NotAvailable
> 
> Any following commands, whether "connect" or "info" on the given
> device result in:
>   [bluetooth]# info  00:1E:35:3B:7E:6D
>     Device  00:1E:35:3B:7E:6D not available
> 
> power off -> power on doesn't help. I need to restart bluetoothd to
> make it work again. The related debug log is appended below. Any hints
> where to start debugging is welcome.
> 
> I tested this with two HIDP devices.

I fixed a few issues like this for 5.8. Could you try with that (or even
better with latest git) before we proceed further with this.

Johan
