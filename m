Return-Path: <cyrus@holtmann.org>
From: <timo.gienger@nokia.com>
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Fixed reading of on_mode in btd_adapter_get_mode
Date: Thu, 24 Nov 2011 09:21:50 +0000
Message-ID: <0C69A15F7ABD804C96CC783BB7B0FA5603741632@008-AM1MPN1-036.mgdnok.nokia.com>
References: <c594ae0af9ab028cb1d6e273cc8ae35b560f6fbb.1322040739.git.timo.gienger@nokia.com>
 <20111123141704.GA6456@fusion.localdomain>
In-Reply-To: <20111123141704.GA6456@fusion.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>The patch looks ok and I didn't find any issues when testing it either, so it's
>now pushed upstream. It'd be good if others test this too since the
>mode/on_mode logic with all various configuration combinations is far from
>simple.
I´ve tested overall 16 configuration possibilities (InitiallyPowered & RememberPowered + condition of BT state before bootup).

>Before applying I did have to fix your commit message though. Please pay
>attention to the following:
>- The form of the summary line is "Fix ...", not "Fixing..."
>- We don't use signed-off-by in the user-space git
>- D-Bus is written D-Bus, not DBUS
>- You can have longer lines than 60 characters in the commit message
>  body (72 is a good limit). Let your editor automate this for you (it
>  looked like you might have manually done the formating).
Thanks for the comments & pushing it upstream, I will pay attention to this the next time.

BR
Timo
