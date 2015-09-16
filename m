Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <ext.szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?utf-8?B?5rWp5a6H6YOR?= <bjtyrael007@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: port bluez to android
Date: Wed, 16 Sep 2015 11:08:27 +0200
Message-ID: <1975130.LmbEBdcIud@leonov>
In-Reply-To: <7FC0F3C7-D97A-428D-984A-54C41EBECDB8@holtmann.org>
References: <CAG_=90cg-83gK0H=-NwyjJMWgqYtCK_vG4My0qvpm2W4BAwG9g@mail.gmail.com> <CAG_=90coGsWxHreMy7Pr+j=XaXid+=3jCiEet43mppY9e2uoyg@mail.gmail.com> <7FC0F3C7-D97A-428D-984A-54C41EBECDB8@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wednesday 16 of September 2015 10:58:16 Marcel Holtmann wrote:
> Hi,
> 
> >    I am a newbie to BlueZ. I want to port BlueZ to android 4.2.2, But
> > 
> > when I copy the blueZ to external folder with glib, after compile,
> > some error happend:
> > 
> > external/bluetooth/bluez/src/shared/mainloop.c:35:26: fatal error:
> > sys/signalfd.h: No such file or directory
> > 
> > How do I solve it ? Thanks a lot.
> 
> follow our BlueZ for Android build instructions.
> 
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/README

Also note that we support only Android 4.4 and newer.

Android 4.2.2 might is missing required functionality in bionic and due to 
backward incompatible changes in BT HAL API our library will not compile 
against Android 4.2.

So if you really want to use that on Android 4.2 you must be prepared for some 
patching (both BLueZ and Bionic, and possibly other Android components).

-- 
BR
Szymon Janc
