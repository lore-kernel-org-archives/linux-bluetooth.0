Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/README: Update with implementation status summary
Date: Wed, 12 Feb 2014 14:00:59 +0100
Message-ID: <2902202.eLTXuOKvvK@leonov>
In-Reply-To: <1392115207-14297-1-git-send-email-szymon.janc@tieto.com>
References: <1392115207-14297-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tuesday 11 of February 2014 11:40:07 Szymon Janc wrote:
> This will give a better overview of implemented features.
> ---
>  android/README | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/android/README b/android/README
> index e3c314f..b987dc9 100644
> --- a/android/README
> +++ b/android/README
> @@ -132,15 +132,43 @@ automatically on HAL library initialization. To
> deinitialize HAL library and stop daemon type 'bluetooth cleanup'. Type
> 'help' for more information. Tab completion is also supported.
> 
> +=====================
> +Implementation status
> +=====================
> +
> +Summary of HALs implementation status.
> +
> +complete    - implementation is feature complete and Android Framework is
> able +              to use it normally
> +partial     - implementation is in progress and not all required features
> are +              present, Android Framework is able to use some of
> features +initial     - only initial implementations is present, Android
> Framework is +              able to initialize but most likely not able to
> use it +not started - no implementation, Android Framework is not able to
> initialize it +
> +Profile ID    HAL header         Status
> +---------------------------------------
> +core          bluetooth.h        complete
> +a2dp          bt_av.h            complete
> +gatt          bt_gatt.h          not started
> +              bt_gatt_client.h   not started
> +              bt_gatt_server.h   not started
> +handsfree     bt_hf.h            initial
> +hidhost       bt_hh.h            complete
> +health        bt_hl.h            not started
> +pan           bt_pan.h           complete
> +avrcp         bt_rc.h            partial
> +socket        bt_sock.h          partial
> +
>  ===========================
>  Implementation shortcomings
>  ===========================
> 
> -It is possible that some of HAL functionality is missing implementation due
> to -reasons like feature feasibility or necessity for latest Android
> Framework. -This sections provides list of such deficiencies. Note that HAL
> library is -always expected to fully implement HAL API so missing
> implementation might -happen only in daemon.
> +It is possible that some of HAL functionality (although being marked as
> +complete) is missing implementation due to reasons like feature feasibility
> or +necessity for latest Android Framework. This sections provides list of
> such +deficiencies. Note that HAL library is always expected to fully
> implement HAL +API so missing implementation might happen only in daemon.
> 
>  HAL Bluetooth
>  =============

Pushed.

-- 
BR
Szymon Janc
