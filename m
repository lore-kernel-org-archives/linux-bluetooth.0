Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/init: Update init script with proper selinux domain label
Date: Tue, 25 Nov 2014 14:16:31 +0100
Message-ID: <2625784.YzjpYWiJ5O@leonov>
In-Reply-To: <1416578301-11341-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416578301-11341-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 21 of November 2014 14:58:21 Jakub Tyszkowski wrote:
> This is to get rid of SEPolicy complain about service running without
> defined policies.
> ---
>  android/init.bluetooth.rc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/init.bluetooth.rc b/android/init.bluetooth.rc
> index af62121..1815fac 100644
> --- a/android/init.bluetooth.rc
> +++ b/android/init.bluetooth.rc
> @@ -25,6 +25,7 @@ service bluetoothd /system/bin/logwrapper
> /system/bin/bluetoothd class main
>      # init does not yet support setting capabilities so run as root,
>      # bluetoothd drop uid to bluetooth with the right linux capabilities
> +    seclabel u:r:bluetoothd:s0
>      group bluetooth
>      disabled
>      oneshot
> @@ -33,6 +34,7 @@ service bluetoothd-snoop /system/bin/logwrapper
> /system/bin/bluetoothd-snoop class main
>      # init does not yet support setting capabilities so run as root,
>      # bluetoothd-snoop drops unneeded linux capabilities
> +    seclabel u:r:bluetoothd:s0
>      group nobody
>      disabled
>      oneshot

I think we should have separate policy for snoop service as it requires far 
less permissions to run.

-- 
BR
Szymon Janc
