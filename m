Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: M Ren <itux.ren@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: question about no responds to my bluetooth keyboard
Date: Mon, 26 Jan 2015 16:31:01 +0100
Message-ID: <2117138.dNls5RaiQz@leonov>
In-Reply-To: <CACw_oNeRd1nv0TFFdCrxEPtvcfhOdDiFY7TtYY2EGz9dUU2SkA@mail.gmail.com>
References: <CACw_oNeRd1nv0TFFdCrxEPtvcfhOdDiFY7TtYY2EGz9dUU2SkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 26 of January 2015 10:09:00 M Ren wrote:
> [bluetooth]# connect 01:02:03:04:05:06
> 
> Hi,
> 
> The issue I met is simple:
> I use bluetoothctl connect to a bluetooth keyboard on my dev board,
> follow this instruction
> https://wiki.archlinux.org/index.php/Bluetooth_keyboard [bluetooth]# power
> on
> [bluetooth]# agent KeyboardOnly

Just use "agent on" instead of "agent KeyboardOnly".

> [bluetooth]# pairable on
> [bluetooth]# pair 01:02:03:04:05:06
> [bluetooth]# trust 01:02:03:04:05:06
> [bluetooth]# connect 01:02:03:04:05:06
> [bluetooth]# quit
> output shows "Connection successful"
> 
> But dev board didn't respond to any keypress.
> What maybe the reason ?
> appreciate any advices, if some log is needed, please tell me.
> 
> BTW, keyboard on pc works ok.


PS
You may want to point to Arch Wiki guys to fix this.

-- 
BR
Szymon Janc
