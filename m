Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] tools: Fix btmon-logger service unit
Date: Fri, 27 Jul 2018 14:02:46 +0200
Message-ID: <11440093.tTZBN5NDfc@ix>
In-Reply-To: <20180723203158.12264-1-andrzej.kaczmarek@codecoup.pl>
References: <20180723203158.12264-1-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Monday, 23 July 2018 22:31:58 CEST Andrzej Kaczmarek wrote:
> Bluetooth sockets can be only created in initial network namespace thus
> btmon-logger will fail to open monitor socket with PrivateNetwork=true
> since this sets up new network namespace for created process.
> ---
>  tools/bluetooth-logger.service.in | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/bluetooth-logger.service.in
> b/tools/bluetooth-logger.service.in index 210bf59ac..026a2f130 100644
> --- a/tools/bluetooth-logger.service.in
> +++ b/tools/bluetooth-logger.service.in
> @@ -12,7 +12,6 @@ ProtectHome=true
>  ProtectSystem=full
>  PrivateTmp=true
>  PrivateDevices=true
> -PrivateNetwork=true
> 
>  [Install]
>  WantedBy=bluetooth.target

Patch applied, thanks.

-- 
pozdrawiam
Szymon Janc


