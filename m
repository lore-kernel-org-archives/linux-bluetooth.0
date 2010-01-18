Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] Implement Bluetooth Wacom tablet's mode change in
 the kernel
From: Bastien Nocera <hadess@hadess.net>
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input <linux-input@vger.kernel.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	bgunn@solekai.com
In-Reply-To: <167e8a331001181144u54cefd15m65a5a63ca8c4c4b6@mail.gmail.com>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <167e8a331001181144u54cefd15m65a5a63ca8c4c4b6@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 18 Jan 2010 21:35:56 +0000
Message-ID: <1263850557.20565.3204.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2010-01-18 at 11:44 -0800, Ping Cheng wrote:
> On Mon, Jan 18, 2010 at 8:49 AM, Bastien Nocera <hadess@hadess.net>
> wrote:
>         Heya,
>         
>         Here's a patch to do the Bluetooth Wacom tablet's mode setting
>         in the
>         kernel. In the past, it was done in a patch in bluetootd.
>         
>         The first patch is probably completely wrong. Right now,
>         hid_output_raw_report is done on the intr socket, instead of
>         the ctrl
>         socket. If it's correct to do it on the intr socket, we'd need
>         to add
>         some API as a way to select the ctrl socket instead for use in
>         that
>         driver.
> 
> I can not make a comment on the above patch since I know nothing about
> Bluetooth.

I'll let Marcel and Jiri be the judges of the value of this patch. In
the worst case, it'll need a change of API for hid-core.

>         I still have the exact same problems as with the user-space
>         patch in
>         that an error occurs sending the second blob of data to the
>         tablet, the
>         first time the driver is initialised. Ping, any ideas about
>         that?
> 
> I am not sure if your issue is similar to what we see with USB devices
> or not.  In order to properly set the device to Wacom mode, we had to
> call usb_set_report more than once (up to 5 times for older kernels,
> and up to 3 times for newer kernels) to get it right.  Please call:
> 
> hdev->hid_output_raw_report again when ret is less than 0.  Try up to
> three times to see what you get.  

That's pretty straight forward, I'll try and do that.

> You need to check if (ret < 0) before calling dev_err() with the
> second hid_output_raw_report() call, right?

Copy/paste stupidness all around there (as you can see, it's indented
properly already ;)

Cheers


