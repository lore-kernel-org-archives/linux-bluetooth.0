Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jason Flanagan <jason@bitcircle.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothctl Segmentation Fault on confirm
Date: Fri, 03 Apr 2015 12:51:24 +0200
Message-ID: <10129831.UNLGbbm0e3@leonov>
In-Reply-To: <551D879B.7020409@bitcircle.com>
References: <551D879B.7020409@bitcircle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jason,

On Thursday 02 of April 2015 14:16:59 Jason Flanagan wrote:
> The issue that i'm currently having with BlueZ 5.29 is that when i say
> no to confirming a passkey i get a "Segmentation Fault". I've tried
> multiple times on multiple devices and i get the same result.
> 
> bluetoothctl
> [bluetooth]#agent on
> [bluetooth]#default-agent
> [bluetooth]# pair XX:XX:XX:XX:XX:XX
> Attempting to pair with XX:XX:XX:XX:XX:XX
> [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> Request confirmation
> [agent] Confirm passkey 080443 (yes/no): no
> Segmentation fault

I'm not able to reproduce this. Could you try running bluetoothctl under 
valgrind or gdb and provide full backtrace of crash?

-- 
BR
Szymon Janc
