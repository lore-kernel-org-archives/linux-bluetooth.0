Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 03/12] android/health: Add HDP definitions
Date: Fri, 27 Jun 2014 15:41:26 +0200
Message-ID: <3223275.HdhLqHhAxx@uw000953>
In-Reply-To: <1403868303-8129-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1403868303-8129-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 27 of June 2014 14:24:54 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/health.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/android/health.h b/android/health.h
> index 0b32fd3..ab7d478 100644
> --- a/android/health.h
> +++ b/android/health.h
> @@ -21,5 +21,13 @@
>   *
>   */
>  
> +#define HDP_MDEP_ECHO		0x00
> +#define HDP_MDEP_INITIAL	0x01
> +#define HDP_MDEP_FINAL		0x7F
> +
> +#define HDP_NO_PREFERENCE_DC	0x00
> +#define HDP_RELIABLE_DC		0x01
> +#define HDP_STREAMING_DC	0x02

Are those going to be used outside of health.c ?
Also last three are already defined in health.c.

> +
>  bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
>  void bt_health_unregister(void);
> 

-- 
Best regards, 
Szymon Janc
