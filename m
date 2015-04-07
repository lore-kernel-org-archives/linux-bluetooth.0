Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jason Flanagan <jason@bitcircle.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothctl Segmentation Fault on confirm
Date: Tue, 07 Apr 2015 20:54:34 +0200
Message-ID: <8658927.JRclqFpaYF@leonov>
In-Reply-To: <55240848.9000408@bitcircle.com>
References: <551D879B.7020409@bitcircle.com> <10129831.UNLGbbm0e3@leonov> <55240848.9000408@bitcircle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jason,

On Tuesday 07 of April 2015 12:39:36 Jason Flanagan wrote:
> Sorry for the wait, I just heard back from my supervisor that the error
> only occurs when we cross compile with the uClibc library.
> (libuClibc-0.9.33.2)
> The actual error message is
> 
> bluetoothctl[2545]: segfault at 0 ip b7564efd sp bff77324 error 4 in
> libuClibc-0.9.33.2.so[b753f000+4f000]

OK, I was able to reproduce this with musl C library.

PS please don't top post on ML

> On 04/03/2015 06:51 AM, Szymon Janc wrote:
> > Hi Jason,
> > 
> > On Thursday 02 of April 2015 14:16:59 Jason Flanagan wrote:
> >> The issue that i'm currently having with BlueZ 5.29 is that when i say
> >> no to confirming a passkey i get a "Segmentation Fault". I've tried
> >> multiple times on multiple devices and i get the same result.
> >> 
> >> bluetoothctl
> >> [bluetooth]#agent on
> >> [bluetooth]#default-agent
> >> [bluetooth]# pair XX:XX:XX:XX:XX:XX
> >> Attempting to pair with XX:XX:XX:XX:XX:XX
> >> [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> >> Request confirmation
> >> [agent] Confirm passkey 080443 (yes/no): no
> >> Segmentation fault
> > 
> > I'm not able to reproduce this. Could you try running bluetoothctl under
> > valgrind or gdb and provide full backtrace of crash?

-- 
BR
Szymon Janc
