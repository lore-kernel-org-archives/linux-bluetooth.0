Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Adjust uinput permissions
Date: Thu, 13 Mar 2014 21:39:15 +0100
Message-ID: <1832213.AdQL97zugQ@athlon>
In-Reply-To: <1394705115-20738-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1394705115-20738-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thursday 13 March 2014 11:05:15 Andrzej Kaczmarek wrote:
> We need to make sure /dev/uinput accessible for BlueZ in order for
> AVRCP to work properly. On some devices (e.g. Nexus 7 a.k.a. flo)
> permissions are set by default to 'system net_bt_stack' as thus we
> need to change group to 'bluetooth'.
> ---
>  android/init.bluetooth.rc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/init.bluetooth.rc b/android/init.bluetooth.rc
> index 8be869a..af62121 100644
> --- a/android/init.bluetooth.rc
> +++ b/android/init.bluetooth.rc
> @@ -2,6 +2,7 @@
>  on boot
>      chown bluetooth bluetooth /data/misc/bluetooth
>      chown bluetooth bluetooth /dev/uhid
> +    chown system    bluetooth /dev/uinput
> 
>  # services
>  on property:bluetooth.start=daemon

Pushed, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
