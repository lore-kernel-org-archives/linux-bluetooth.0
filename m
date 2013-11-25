Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Nov 2013 23:12:34 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/13] sixaxis support
Message-Id: <20131125231234.7c39878413e9661d57d5ce10@studenti.unina.it>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 25 Nov 2013 22:15:39 +0000
Szymon Janc <szymon.janc@gmail.com> wrote:

> Hi All,
> 
> This is yet another attempt to get PS3 controller support into BlueZ upstream.
> 
> I based my work on Fedora out-of-tree patch (hence copyright info) and tried
> to take into consideration comments from previous upstreaming attempt.
>

Hi Szymon, JFYI the latest patch for my playstation-peripheral plugin
is here:
http://ao2.it/tmp/playstation-peripheral-pugin-v5.x-2013-11-13.patch

Only two patches to BlueZ should be needed with this code.

Basically the only show-stopper was a way to add a device to the
database before it ever connects, I went for this
"btd_create_stored_device(everything_we_know)" but BlueZ devs didn't
like this "kitchen sink" function.

>From my POV the problem here was:
  "Add a known device to the device database before it ever connects"

However it looks like I didn't get to solve it in an acceptable way.

> I find sixaxis name short and neat so I sticked with it.
>

I was using playstation-peripheral thinking to the PS Move and
possibly other devices which may work slightly different.

> I didn't really like the idea of hardcoding SDP records so I took different
> approach of doing reverse SDP search while cable associated device first
> connects. This is done before authorizing incoming HID connection.
>

I think ideally we should avoid making BlueZ aware of sixaxis in
input.c.

> Some functions unavailable to exteral plugins were renamed with btd_ prefix
> (or explicitly marked in bletooth.ver) to export them (patch 1-8).
>
> Patch 9-10 add sixaxis external plugin that depends on udev. This plugin is
> responsible for preparing newly USB connected PS3 sixaxis device and creating
> btd_device with proper PNP information.
> 
> Patch 12 adds support for handling first connection of sixaxis device in input
> plugin itself. This is something I would like to get comments and suggestions.
> Currently this is rather sixaxis oriented, but could be made more generic (some
> hooks registration) if desired.
>
> This serie is not implemententing any LED (or other features) setting support.
> I have an impression that those should not be handled by BlueZ but some other
> entity (util tools or driver itself perhabs?) as this is not related to
> transport itself and should be set/used on USB connection as well.
>

Setting LEDs will need to be done by some code using udev anyway, as we
want the LED to match the X in the created /dev/input/jsX, so I thought
it may just go in the bluez plugin which is using udev already.

The kernel driver is at HID/input level in linux which is not aware of
the joystick layer, so it cannot know the joystick number, and
besides kernel driver should not be too smart anyway.

We cannot just count devices in the sixaxis kernel driver either,
consider this scenario:
 - Connect a PS3 controller (js0, LED1)
 - Connect some other joystick (js1)
 - Connect another PS3 controller (js2, LED3)

> This was tested with Dualshock3 and seems to be working nicely here.
> 
> Comments are welcome.
> 

See above, but I don't think I am qualified to comment on your patches
12 and 13.

BTW considering that up to now I failed to have this merged I am not
going be picky, if BlueZ devs are happy with your approach, let's go
for it :)

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
