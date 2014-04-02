Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] android: Fix minor typo
Date: Wed, 02 Apr 2014 23:19:24 +0200
Message-ID: <1640887.xUBCZiluM7@athlon>
In-Reply-To: <1396472817-7314-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1396472817-7314-1-git-send-email-claudio.takahasi@openbossa.org> <1396472817-7314-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wednesday 02 April 2014 18:06:57 Claudio Takahasi wrote:
> ---
>  android/hardware/bt_gatt_server.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/hardware/bt_gatt_server.h
> b/android/hardware/bt_gatt_server.h index 1a5a400..751d852 100644
> --- a/android/hardware/bt_gatt_server.h
> +++ b/android/hardware/bt_gatt_server.h
> @@ -172,4 +172,4 @@ typedef struct {
> 
>  __END_DECLS
> 
> -#endif /* ANDROID_INCLUDE_BT_GATT_CLIENT_H */
> +#endif /* ANDROID_INCLUDE_BT_GATT_SERVER_H */

This is imported from Android and I'd prefer to keep this unmodified (and 
other headers from android/hardware). Only exception would be fixing 
compilation issue on Linux.

-- 
Szymon K. Janc
szymon.janc@gmail.com
