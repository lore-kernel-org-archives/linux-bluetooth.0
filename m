Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/5] android/tester: move bthost.h include to tester-main.h
Date: Wed, 10 Dec 2014 13:45:36 +0100
Message-ID: <7505525.rtnczLme6q@leonov>
In-Reply-To: <1418034908-1742-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418034908-1742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1418034908-1742-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 08 of December 2014 11:35:07 Grzegorz Kolodziejczyk wrote:
> bthost.h is used by all testers.
> ---
>  android/tester-a2dp.c      | 1 -
>  android/tester-avrcp.c     | 1 -
>  android/tester-bluetooth.c | 1 -
>  android/tester-gatt.c      | 1 -
>  android/tester-hdp.c       | 1 -
>  android/tester-hidhost.c   | 1 -
>  android/tester-main.c      | 1 -
>  android/tester-main.h      | 1 +
>  android/tester-pan.c       | 1 -
>  android/tester-socket.c    | 1 -
>  10 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
> index 837477e..a2e7325 100644
> --- a/android/tester-a2dp.c
> +++ b/android/tester-a2dp.c
> @@ -17,7 +17,6 @@
> 
>  #include <stdbool.h>
> 
> -#include "emulator/bthost.h"
>  #include "src/shared/util.h"
> 
>  #include "tester-main.h"
> diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
> index 41a5fd3..3bda390 100644
> --- a/android/tester-avrcp.c
> +++ b/android/tester-avrcp.c
> @@ -17,7 +17,6 @@
> 
>  #include <stdbool.h>
> 
> -#include "emulator/bthost.h"
>  #include "src/shared/util.h"
> 
>  #include "tester-main.h"
> diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
> index 2be824d..6586a54 100644
> --- a/android/tester-bluetooth.c
> +++ b/android/tester-bluetooth.c
> @@ -16,7 +16,6 @@
>   */
>  #include <stdbool.h>
> 
> -#include "emulator/bthost.h"
>  #include "tester-main.h"
> 
>  static struct queue *list; /* List of bluetooth test cases */
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index de2a7a7..d8021d7 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -17,7 +17,6 @@
> 
>  #include <stdbool.h>
> 
> -#include "emulator/bthost.h"
>  #include "tester-main.h"
>  #include "src/shared/util.h"
> 
> diff --git a/android/tester-hdp.c b/android/tester-hdp.c
> index ab7666d..195171d 100644
> --- a/android/tester-hdp.c
> +++ b/android/tester-hdp.c
> @@ -17,7 +17,6 @@
> 
>  #include <stdbool.h>
> 
> -#include "emulator/bthost.h"
>  #include "tester-main.h"
>  #include "android/utils.h"
> 
> diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
> index 95befd9..6214b4f 100644
> --- a/android/tester-hidhost.c
> +++ b/android/tester-hidhost.c
> @@ -17,7 +17,6 @@
> 
>  #include <stdbool.h>
> 
> -#include "emulator/bthost.h"
>  #include "tester-main.h"
> 
>  #include "android/utils.h"
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 6339b3a..06730d2 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -17,7 +17,6 @@
>  #include <stdbool.h>
> 
>  #include "src/shared/util.h"
> -#include "emulator/bthost.h"
>  #include "tester-main.h"
> 
>  #include "monitor/bt.h"
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 474afbb..ae65d72 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -41,6 +41,7 @@
>  #include "src/shared/mgmt.h"
>  #include "src/shared/queue.h"
>  #include "emulator/hciemu.h"
> +#include "emulator/bthost.h"
> 
>  #include <hardware/hardware.h>
>  #include <hardware/audio.h>
> diff --git a/android/tester-pan.c b/android/tester-pan.c
> index aff1980..1d07b22 100644
> --- a/android/tester-pan.c
> +++ b/android/tester-pan.c
> @@ -17,7 +17,6 @@
> 
>  #include <stdbool.h>
> 
> -#include "emulator/bthost.h"
>  #include "tester-main.h"
>  #include "android/utils.h"
> 
> diff --git a/android/tester-socket.c b/android/tester-socket.c
> index c70d753..bd0260c 100644
> --- a/android/tester-socket.c
> +++ b/android/tester-socket.c
> @@ -18,7 +18,6 @@
>  #include <fcntl.h>
>  #include <stdbool.h>
> 
> -#include "emulator/bthost.h"
>  #include "tester-main.h"
> 
>  static struct queue *list; /* List of socket test cases */

We should do opposite. I'd prefer headers to not include other headers if 
possible. C files should include what is needed for compilation (especially 
when it is internal header).

-- 
BR
Szymon Janc
