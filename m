Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: port bluez to android
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAG_=90coGsWxHreMy7Pr+j=XaXid+=3jCiEet43mppY9e2uoyg@mail.gmail.com>
Date: Wed, 16 Sep 2015 10:58:16 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7FC0F3C7-D97A-428D-984A-54C41EBECDB8@holtmann.org>
References: <CAG_=90cg-83gK0H=-NwyjJMWgqYtCK_vG4My0qvpm2W4BAwG9g@mail.gmail.com> <CAG_=90coGsWxHreMy7Pr+j=XaXid+=3jCiEet43mppY9e2uoyg@mail.gmail.com>
To: =?utf-8?B?5rWp5a6H6YOR?= <bjtyrael007@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>    I am a newbie to BlueZ. I want to port BlueZ to android 4.2.2, But
> when I copy the blueZ to external folder with glib, after compile,
> some error happend:
> 
> external/bluetooth/bluez/src/shared/mainloop.c:35:26: fatal error:
> sys/signalfd.h: No such file or directory
> 
> How do I solve it ? Thanks a lot.

follow our BlueZ for Android build instructions.

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/README

Regards

Marcel

